// Executes Prolog expression dependencies with the pinned eyelang reasoner.
// Host replies are scoped register lookups and grounded exact-domain primitives.
import { parse, infer, say } from 'eyelang/src/language.js';
import { runtimeSource } from './runtime-program.js';
import { Expression, toTerm, fromTerm, text, integer, predicate, compound } from './prolog-values.js';
import { compileExpression } from './prolog-compiler.js';
import { applyPrimitive, conditionValue, combineValues, LawError, MAX_COLLECTION } from './operations.js';
import { isUnknown, isRecord } from './values.js';

const runtime = parse(runtimeSource);
let nextExpression = 0;

function expressionProgram(source) {
  if (source instanceof Expression) return { id: source.id, program: source.program };
  const result = compileExpression(source, `inline${++nextExpression}`);
  const compiled = { id: result.id, program: { facts: result.facts, rules: [], questions: [], checks: [] } };
  return compiled;
}

export function evaluateExpression(source, scope) {
  const { id, program } = expressionProgram(source);
  if (!program) throw new LawError('LoadError', `Expression '${id}' has no Prolog program.`);
  const contexts = new Map([['1', scope]]);
  const replies = [];
  const provenance = new Map();
  const answered = new Set();
  const computations = [];
  const root = text(id);
  const context = integer(1);
  const facts = [...runtime.facts, ...program.facts, predicate('ee_need', root, context)];
  if (source instanceof Expression) for (const name of source.bindings) facts.push(predicate('binding', context, text(name), toTerm(scope.resolve(name))));
  const questions = [{ goal: predicate('ee_value', root, context, { variable: 'Result' }) }];
  function respond(record) {
    const [key, context, request] = record.goal.terms;
    const scope = contexts.get(context);
    if (!scope) throw new LawError('ReasonerError', 'A Prolog request named an unknown evaluation scope.');
    let value;
    let encoded;
    const values = request.args?.map(arg => fromTerm(arg)) || [];
    switch (request.functor) {
      case 'reference': value = scope.resolve(values[0]); break;
      case 'error': throw new LawError(values[0], values[1]);
      case 'condition':
        value = conditionValue(values[0], values[1]);
        computations.push({ operation: `${values[0]} condition`, operands: [values[1]], value });
        break;
      case 'collection': {
        let [collection, as] = values;
        if (isUnknown(collection)) { value = collection; break; }
        if (collection === null) collection = [];
        else if (!Array.isArray(collection)) collection = [collection];
        if (collection.length > MAX_COLLECTION) throw new LawError('InvalidOperation', `Invalid operation: FOREACH over ${collection.length} elements exceeds the limit of ${MAX_COLLECTION}`);
        const entries = collection.map(item => {
          const locals = new Map(isRecord(item) ? Object.entries(item) : []);
          locals.set(as, item);
          const child = String(contexts.size + 1);
          contexts.set(child, scope.withLocals(locals));
          return child;
        });
        encoded = compound('entries', { list: entries });
        break;
      }
      case 'combine': value = combineValues(values[0], values[1].reverse(), values[2]); break;
      case 'primitive': {
        const [operation, metadata, reversed] = values;
        const operands = reversed.reverse();
        if (operation === 'RECORD') value = Object.fromEntries(metadata.keys.map((key, index) => [key, operands[index]]));
        else if (operation === 'LIST') value = operands;
        else {
          const node = { ...metadata.staticFields, operation };
          let position = 0;
          for (const { field, count } of metadata.shape) {
            if (count === null) node[field] = operands[position++];
            else { node[field] = operands.slice(position, position + Number(count.toString())); position += Number(count.toString()); }
          }
          if (metadata.missingValue && ['EQUALS', 'NOT_EQUALS', 'GREATER_THAN', 'LESS_THAN', 'GREATER_THAN_OR_EQUAL', 'LESS_THAN_OR_EQUAL'].includes(operation)) delete node.value;
          value = applyPrimitive(operation, node);
        }
        computations.push({ operation, operands, value });
        break;
      }
      default: throw new LawError('ReasonerError', `Unsupported domain request '${request.functor}'.`);
    }
    const reply = predicate('ee_response', key, context, encoded || toTerm(value));
    replies.push(reply);
    provenance.set(JSON.stringify(reply), { request: record, kind: request.functor });
  }
  // Every round consumes all newly requested grounded work. Branches are only
  // exposed after the reasoner derives the corresponding control-flow premise.
  for (let round = 0; round < 1000; round++) {
    const records = infer({ facts: [...facts, ...replies], rules: [...runtime.rules, ...program.rules], questions, checks: [] });
    const answers = records.filter(record => record.goal.relation === 'predicate:ee_value/3' &&
      record.goal.terms[0].text === id && record.goal.terms[1] === context);
    if (answers.length > 1) throw new LawError('AmbiguousResult', `Expression '${id}' derived more than one value.`);
    if (answers.length) {
      const answer = answers[0];
      const proof = proofOf(answer, provenance);
      const value = fromTerm(answer.goal.terms[2]);
      scope.traceReasoner?.({ expression: id, native: id.startsWith('native:'), conclusion: say(answer.goal), proof, computations, value });
      return value;
    }
    const requests = records.filter(record => record.goal.relation === 'predicate:ee_request/3' && !answered.has(JSON.stringify(record.goal.terms)));
    if (!requests.length) throw new LawError('ReasonerError', `The Prolog knowledge gives no value for expression '${id}'.`);
    for (const request of requests) { answered.add(JSON.stringify(request.goal.terms)); respond(request); }
  }
  throw new LawError('MaxDepthExceeded', 'Maximum Prolog evaluation rounds exceeded: 1000');
}

function proofOf(root, provenance) {
  const seen = new Set();
  const result = [];
  const pending = [root];
  while (pending.length) {
    const record = pending.pop();
    const key = JSON.stringify(record.goal);
    if (seen.has(key)) continue;
    seen.add(key);
    const domain = provenance.get(key);
    result.push({ goal: say(record.goal), rule: record.rule?.text || null,
      comparison: !!record.comparison, calculations: record.calculations || [], domain: domain?.kind || null });
    if (domain) pending.push(domain.request);
    pending.push(...record.premises);
  }
  return result;
}
