// One-way conversion of the public regelrecht data contract to Prolog facts.
// Control flow is defined in knowledge/runtime.pl and executed by eyelang.
import { parse } from '../vendor/eyelang/language.js';
import { Expression, toTerm, fromTerm, termSource, predicate, text, compound } from './prolog-values.js';
import { Unknown } from './values.js';
import { Dec } from './decimal.js';
import { MAX_DEPTH } from './operations.js';

const primitiveFields = {
  ADD: ['values'], SUBTRACT: ['values'], MULTIPLY: ['values'], DIVIDE: ['values'], MIN: ['values'], MAX: ['values'],
  EQUALS: ['subject', 'value'], NOT_EQUALS: ['subject', 'value'], GREATER_THAN: ['subject', 'value'],
  LESS_THAN: ['subject', 'value'], GREATER_THAN_OR_EQUAL: ['subject', 'value'], LESS_THAN_OR_EQUAL: ['subject', 'value'],
  NOT: ['value'], IS_NULL: ['subject'], NOT_NULL: ['subject'], IN: ['subject', 'values'], NOT_IN: ['subject', 'values'],
  ROUND: ['value', 'precision'], CEIL: ['value', 'precision'], FLOOR: ['value', 'precision'],
  AGE: ['date_of_birth', 'reference_date'], DATE_ADD: ['date', 'years', 'months', 'weeks', 'days'],
  DATE: ['year', 'month', 'day'], DAY_OF_WEEK: ['date'], DATE_DIFF: ['from', 'to', 'in'],
  DATE_PART: ['date'], START_OF: ['date'],
};

export function compileExpression(node, prefix = 'expression') {
  const facts = [];
  let next = 0;
  function add(name, ...args) { facts.push(predicate(name, ...args)); }
  function visit(node, depth = 0) {
    const id = text(`${prefix}/${++next}`);
    if (depth > MAX_DEPTH) { add('ee_invalid', id, text('MaxDepthExceeded'), text(`Maximum operation depth exceeded: ${MAX_DEPTH} levels`)); return id; }
    if (node === null || node === undefined || typeof node !== 'object' || node instanceof Dec || node instanceof Unknown) {
      if (typeof node === 'string' && node.startsWith('$')) add('ee_reference', id, text(node.slice(1)));
      else add('ee_literal', id, toTerm(node));
    } else if (Array.isArray(node)) {
      add('ee_arguments', id, { list: node.map(item => visit(item, depth + 1)) });
      add('ee_primitive', id, text('LIST'), toTerm({ operation: 'LIST', fields: ['items'] }));
    } else if (typeof node.operation !== 'string') {
      add('ee_arguments', id, { list: Object.values(node).map(item => visit(item, depth + 1)) });
      add('ee_primitive', id, text('RECORD'), toTerm({ operation: 'RECORD', keys: Object.keys(node) }));
    } else {
      const op = node.operation === 'SWITCH' ? 'IF' : node.operation;
      if (op === 'IF') {
        add('ee_conditional', id, { list: (node.cases || []).map(c => compound('case', visit(c.when, depth + 1), visit(c.then, depth + 1))) }, visit(node.default, depth + 1));
      } else if (op === 'AND' || op === 'OR') {
        add('ee_logical', id, text(op), { list: (node.conditions || []).map(c => visit(c, depth + 1)) });
      } else if (op === 'FOREACH') {
        add('ee_foreach', id, visit(node.collection, depth + 1), visit(node.filter === undefined ? true : node.filter, depth + 2),
          visit(node.body, depth + 2), text(node.as || 'item'), toTerm(node.combine || null));
      } else if (op === 'LIST') {
        add('ee_arguments', id, { list: (node.items || []).map(item => visit(item, depth + 1)) });
        add('ee_primitive', id, text('LIST'), toTerm({ operation: 'LIST', fields: ['items'] }));
      } else {
        const fields = [...(primitiveFields[op] || [])];
        if ((op === 'IN' || op === 'NOT_IN') && node.values === undefined) fields[1] = 'value';
        if ((op === 'IS_NULL' || op === 'NOT_NULL') && node.subject === undefined) fields[0] = 'value';
        const args = [];
        const shape = [];
        for (const field of fields) {
          const defaultValue = field === 'precision' || ['years', 'months', 'weeks', 'days'].includes(field) ? 0 : null;
          if (['values'].includes(field)) {
            const values = node[field] || [];
            shape.push({ field, count: values.length });
            args.push(...values.map(v => visit(v, depth + 1)));
          } else {
            shape.push({ field, count: null });
            args.push(visit(node[field] === undefined ? defaultValue : node[field], depth + 1));
          }
        }
        const staticFields = Object.fromEntries(Object.entries(node).filter(([field]) => !fields.includes(field)));
        add('ee_arguments', id, { list: args });
        add('ee_primitive', id, text(op), toTerm({ operation: op, shape, staticFields, missingValue: !('value' in node) }));
      }
    }
    return id;
  }
  const root = visit(node);
  return { id: root.text, facts };
}

export function compileRulework(doc) {
  let expression = 0;
  const facts = [];
  const prefix = `${doc.$id || 'law'}@${doc.valid_from || 'undated'}`;
  const compile = node => {
    const result = compileExpression(node, `${prefix}/expression${++expression}`);
    facts.push(...result.facts);
    return new Expression(result.id);
  };
  const action = source => {
    const result = { ...source };
    if (source.operation) {
      const { output, legal_basis, ...node } = source;
      return { output, ...(legal_basis === undefined ? {} : { legal_basis }), value: compile(node) };
    }
    if ('value' in result) result.value = compile(result.value);
    return result;
  };
  function machineReadable(source) {
    if (!source) return source;
    const result = { ...source };
    if (source.definitions) result.definitions = Object.fromEntries(Object.entries(source.definitions).map(([name, value]) => [name,
      value && typeof value === 'object' && !Array.isArray(value) && 'value' in value ? { ...value, value: compile(value.value) } : compile(value)]));
    if (source.execution) {
      result.execution = { ...source.execution };
      if (source.execution.actions) result.execution.actions = source.execution.actions.map(action);
      if (source.execution.input) result.execution.input = source.execution.input.map(input => ({ ...input,
        ...(input.source?.parameters ? { source: { ...input.source, parameters: Object.fromEntries(Object.entries(input.source.parameters).map(([name, value]) => [name, compile(value)])) } } : {}),
      }));
    }
    if (source.open_terms) result.open_terms = source.open_terms.map(term => ({ ...term,
      ...(term.default?.actions ? { default: { ...term.default, actions: term.default.actions.map(action) } } : {}),
    }));
    return result;
  }
  const result = { ...doc, articles: (doc.articles || []).map(article => ({ ...article,
    ...(article.machine_readable ? { machine_readable: machineReadable(article.machine_readable) } : {}),
  })) };
  if (doc.preamble?.machine_readable) result.preamble = { ...doc.preamble, machine_readable: machineReadable(doc.preamble.machine_readable) };
  const lines = [`% ${doc.$id || 'Rulework'}${doc.valid_from ? `, in force from ${doc.valid_from}` : ''}.`,
    '% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.', ''];
  const emit = (name, ...values) => lines.push(`${name}(${values.map(value => prettyTerm(toTerm(value))).join(', ')}).`);
  emit('law', result.$id);
  for (const [name, value] of Object.entries(result)) if (!['$id', 'articles'].includes(name)) emit('law_property', name, value);
  for (const article of result.articles) {
    emit('article', String(article.number), article.text || '');
    for (const [name, value] of Object.entries(article)) if (!['number', 'text', 'machine_readable'].includes(name)) emit('article_property', String(article.number), name, value);
    const mr = article.machine_readable || {};
    for (const [name, value] of Object.entries(mr)) {
      if (name === 'definitions') for (const [key, definition] of Object.entries(value)) emit('definition', String(article.number), key, definition);
      else if (name === 'execution') for (const [key, field] of Object.entries(value)) emit('execution_property', String(article.number), key, field);
      else emit('article_rule', String(article.number), name, value);
    }
    lines.push('');
  }
  for (const goal of facts) lines.push(`${goal.relation.slice('predicate:'.length, goal.relation.lastIndexOf('/'))}(${goal.terms.map(termSource).join(', ')}).`);
  return lines.join('\n') + '\n';
}

function prettyTerm(value, depth = 0) {
  if (value.list?.length) {
    const pad = '  '.repeat(depth + 1);
    return `[\n${pad}${value.list.map(item => prettyTerm(item, depth + 1)).join(`,\n${pad}`)}\n${'  '.repeat(depth)}]`;
  }
  if (value.functor) return `${value.functor}(${value.args.map(arg => prettyTerm(arg, depth)).join(', ')})`;
  return termSource(value);
}

export function readRulework(source) {
  const program = parse(source);
  if (program.questions.length || program.checks.length) throw new Error('A rulework defines knowledge; pass the question to Engine.evaluate.');
  const facts = name => program.facts.filter(goal => goal.relation === `predicate:${name}`).map(goal => goal.terms);
  const decode = term => fromTerm(term, program, true);
  const identity = facts('law/1');
  if (identity.length !== 1) throw new Error('A .pl rulework needs exactly one law(Id) fact.');
  const doc = { $id: decode(identity[0][0]), articles: [] };
  const set = (object, key, value) => Object.defineProperty(object, key, { value, writable: true, configurable: true, enumerable: true });
  for (const [name, value] of facts('law_property/2')) set(doc, decode(name), decode(value));
  const articles = new Map();
  for (const [number, text] of facts('article/2')) {
    const id = String(decode(number));
    if (articles.has(id)) throw new Error(`Duplicate article '${id}'.`);
    const article = { number: id, text: decode(text) };
    articles.set(id, article); doc.articles.push(article);
  }
  const article = number => {
    const id = String(decode(number));
    if (!articles.has(id)) throw new Error(`Metadata refers to undeclared article '${id}'.`);
    return articles.get(id);
  };
  const mr = number => article(number).machine_readable ||= {};
  const execution = number => mr(number).execution ||= {};
  for (const [number, name, value] of facts('article_property/3')) set(article(number), decode(name), decode(value));
  for (const [number, name, value] of facts('article_rule/3')) set(mr(number), decode(name), decode(value));
  for (const [number, name, value] of facts('definition/3')) set(mr(number).definitions ||= {}, decode(name), decode(value));
  for (const [number, name, value] of facts('execution_property/3')) set(execution(number), decode(name), decode(value));
  for (const [number, name, type, required, nullable] of facts('parameter/5')) {
    (execution(number).parameters ||= []).push({ name: decode(name), type: decode(type), required: decode(required), nullable: decode(nullable) });
  }
  for (const [number, name, type, nullable] of facts('output/4')) {
    (execution(number).output ||= []).push({ name: decode(name), type: decode(type), nullable: decode(nullable) });
  }
  let native = 0;
  for (const [number, name, predicateName, bindings] of facts('rule/4')) {
    const id = `native:${String(decode(number))}:${decode(name)}:${++native}`;
    const expression = new Expression(id, program, decode(bindings));
    if (!Array.isArray(expression.bindings) || !expression.bindings.every(name => typeof name === 'string')) throw new Error('rule/4 requires a list of input reference names.');
    const predicateSource = termSource({ atom: decode(predicateName) });
    const idSource = termSource(text(id));
    const wrapper = parse(`ee_value(${idSource}, Scope, Value) :- ee_need(${idSource}, Scope), ${predicateSource}(Scope, Value).`);
    program.rules.push(...wrapper.rules);
    (execution(number).actions ||= []).push({ output: decode(name), value: expression });
  }
  return { doc, program };
}
