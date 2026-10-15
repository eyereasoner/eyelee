// Runs regelrecht scenarios (Gherkin) against the eyelee engine.
//
// The step vocabulary is not hard-coded: it is read from the canonical
// grammar (knowledge/regelrecht/grammar.pl), which maps each sentence to a semantic action.
// This module implements those actions, so any scenario written for the
// upstream engine runs here unchanged.

import { parse } from 'eyelang/src/language.js';
import { fromTerm } from './prolog-values.js';
import { parseFeature } from './gherkin.js';
import { Dec } from './decimal.js';
import { Unknown, isUnknown, isDec, toValue, show } from './values.js';
import { resolveNote } from './notes.js';

export const SUPPORTED_TIERS = ['core', 'provenance', 'untranslatable', 'notes'];

export function loadGrammar(text) {
  const facts = parse(text).facts.filter(goal => goal.relation === 'predicate:grammar/1');
  if (facts.length !== 1) throw new Error('A .pl grammar needs exactly one grammar(Metadata) fact.');
  const g = fromTerm(facts[0].terms[0], null, true);
  const steps = (g.steps || []).map((s) => {
    const args = s.args || [];
    let pattern = '';
    const order = [];
    const re = /"\{(\w+)\}"|\{(\w+)\}/g;
    let last = 0;
    let m;
    while ((m = re.exec(s.text))) {
      pattern += escapeRe(s.text.slice(last, m.index));
      if (m[1]) {
        pattern += '"([^"]*)"';
        order.push({ name: m[1], quoted: true });
      } else {
        pattern += '(-?\\d+(?:\\.\\d+)?)';
        order.push({ name: m[2], quoted: false });
      }
      last = m.index + m[0].length;
    }
    pattern += escapeRe(s.text.slice(last));
    return {
      id: s.id,
      action: s.action,
      tier: s.tier || 'core',
      regex: new RegExp(`^${pattern}$`),
      order,
      types: Object.fromEntries(args.map((a) => [a.name, a.type])),
      literals: s.literals || [],
      datatable: !!s.datatable,
    };
  });
  return { steps, typing: g.value_typing || { quoted: 'inferred', bare: 'number', table_cell: 'inferred' } };
}

function escapeRe(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

// What a Gherkin cell or quoted capture means once it reaches the engine:
// true/false, null (absence), JSON arrays/objects, numbers, else text.
export function inferValue(raw) {
  const t = String(raw).trim();
  if (t === 'true') return true;
  if (t === 'false') return false;
  if (t === 'null' || t === '') return null;
  if (t.startsWith('[') || t.startsWith('{')) {
    try {
      return toValue(JSON.parse(t));
    } catch {
      return t;
    }
  }
  if (/^[+-]?\d+(\.\d+)?$/.test(t)) return Dec.parse(t);
  return t;
}

function valuesEqual(a, b) {
  if (isDec(a) && isDec(b)) {
    const d = a.sub(b);
    return d.cmp(Dec.parse('0.000000001')) < 0 && d.cmp(Dec.parse('-0.000000001')) > 0;
  }
  if (a === null || b === null || typeof a !== 'object' || typeof b !== 'object') return a === b;
  return JSON.stringify(a) === JSON.stringify(b);
}

class StepFailure extends Error {}

const fail = (msg) => {
  throw new StepFailure(msg);
};

// Per-scenario state.
class World {
  constructor(engine, grammar) {
    this.engine = engine;
    this.grammar = grammar;
    this.date = '2024-01-01';
    this.params = new Map();
    this.result = null;
    this.error = null;
    this.note = { articles: [], selector: null, result: null };
    engine.clearDataSources();
    engine.setUntranslatableMode('error');
  }

  typed(raw, quoted) {
    const rule = quoted ? this.grammar.typing.quoted : this.grammar.typing.bare;
    if (quoted) return rule === 'literal' ? raw : inferValue(raw);
    return Dec.parse(raw);
  }

  cell(raw) {
    return this.grammar.typing.table_cell === 'literal' ? String(raw).trim() : inferValue(raw);
  }

  records(table) {
    if (!table || table.length < 2) return [];
    const [head, ...rows] = table;
    return rows.map((row, i) => {
      if (row.length !== head.length) fail(`data table row ${i + 1} has ${row.length} cells, header row has ${head.length}`);
      const rec = {};
      head.forEach((h, k) => {
        if (String(row[k]).trim() !== '') rec[h.trim()] = this.cell(row[k]);
      });
      return rec;
    });
  }

  evaluateNow(law, outputs) {
    try {
      this.result = this.engine.evaluate(law, outputs, this.params, this.date);
      this.error = null;
    } catch (e) {
      if (e instanceof StepFailure) throw e;
      this.result = null;
      this.error = e;
    }
  }

  output(name) {
    if (!this.result) fail(`expected successful execution, got error: ${this.error?.message}`);
    if (!(name in this.result.outputs)) fail(`output '${name}' not found. Available outputs: ${Object.keys(this.result.outputs).join(', ')}`);
    return this.result.outputs[name];
  }

  dispatch(action, args, table) {
    switch (action) {
      case 'set_calculation_date':
        this.date = args[0];
        return;
      case 'load_law':
        if (!this.engine.hasLaw(args[0])) fail(`law '${args[0]}' is not loaded`);
        return;
      case 'set_parameter':
        this.params.set(args[0], args[1]);
        return;
      case 'set_parameters_table':
        for (const row of table || []) {
          if (row.length >= 2 && String(row[1]).trim() !== '') this.params.set(row[0].trim(), this.cell(row[1]));
        }
        return;
      case 'set_data_source': {
        const records = this.records(table);
        if (records.length) this.engine.setDataSource({ name: args[0], key: args[1], records });
        return;
      }
      case 'set_data_source_for_law': {
        const records = this.records(table);
        if (records.length) this.engine.setDataSource({ name: args[0], key: args[1], records, law: args[2] });
        return;
      }
      case 'set_parameter_collection':
        this.params.set(args[0], this.records(table));
        return;
      case 'evaluate':
        this.evaluateNow(args[1], [args[0]]);
        return;
      case 'evaluate_outputs':
        this.evaluateNow(args[1], String(args[0]).split(',').map((s) => s.trim()));
        return;
      case 'assert_succeeds':
        if (!this.result) fail(`expected success, got ${this.error?.message}`);
        return;
      case 'assert_fails':
        if (!this.error) fail(`expected failure, but succeeded with ${JSON.stringify(this.result?.outputs)}`);
        return;
      case 'assert_fails_with': {
        const msg = (this.error?.message || '').toLowerCase();
        if (!msg.includes(String(args[0]).toLowerCase())) fail(`error ${JSON.stringify(this.error?.message ?? null)} does not contain ${JSON.stringify(args[0])}`);
        return;
      }
      case 'assert_boolean': {
        const v = this.output(args[0]);
        if (v !== args[1]) fail(`output ${args[0]} = ${show(v)}, expected ${args[1]}`);
        return;
      }
      case 'assert_equals': {
        const v = this.output(args[0]);
        if (!valuesEqual(v, args[1])) fail(`output ${args[0]} = ${show(v)}, expected ${show(args[1])}`);
        return;
      }
      case 'assert_null': {
        const v = this.output(args[0]);
        if (v !== null) fail(`output ${args[0]} = ${show(v)}, expected absent`);
        return;
      }
      case 'assert_unknown': {
        const v = this.output(args[0]);
        if (!isUnknown(v)) fail(`output ${args[0]} = ${show(v)}, expected unknown`);
        return;
      }
      case 'assert_unknown_for': {
        const v = this.output(args[0]);
        if (!isUnknown(v)) fail(`output ${args[0]} = ${show(v)}, expected unknown for lack of ${args[1]}`);
        if (!v.missing.includes(args[1])) fail(`output ${args[0]} is unknown for lack of ${v.missing.join(', ')}, not ${args[1]}`);
        return;
      }
      case 'assert_contains': {
        const v = this.output(args[0]);
        if (typeof v !== 'string') fail(`output ${args[0]} is ${show(v)}, not a string`);
        if (!v.toLowerCase().includes(String(args[1]).toLowerCase())) fail(`${JSON.stringify(v)} does not contain ${JSON.stringify(args[1])}`);
        return;
      }
      case 'assert_exact_outputs': {
        if (!this.result) fail(`expected successful execution, got error: ${this.error?.message}`);
        const want = String(args[0]).split(',').map((s) => s.trim()).sort();
        const got = Object.keys(this.result.outputs).sort();
        if (JSON.stringify(want) !== JSON.stringify(got)) fail(`outputs ${got.join(', ')}, expected exactly ${want.join(', ')}`);
        return;
      }
      case 'assert_provenance': {
        if (!this.result) fail(`expected successful execution, got error: ${this.error?.message}`);
        const p = this.result.provenance[args[0]];
        if (p !== args[1]) fail(`expected '${args[0]}' to have ${args[1]} provenance, got ${p}`);
        return;
      }
      case 'set_untranslatable_mode':
        this.engine.setUntranslatableMode(args[0]);
        return;
      case 'assert_tainted':
        this.output(args[0]);
        if (!this.result.tainted.includes(args[0])) fail(`output ${args[0]} is not tainted as untranslatable`);
        return;
      // ----- notes tier -----
      case 'set_note_articles': {
        const [head, ...rows] = table || [];
        const ni = head?.indexOf('number');
        const ti = head?.indexOf('text');
        if (ni < 0 || ti < 0) fail(`article table needs 'number' and 'text' columns; header is ${head}`);
        this.note.articles = rows.map((r) => ({ number: r[ni].trim(), text: r[ti].trim() }));
        return;
      }
      case 'set_note_selector_exact':
        this.note.selector = { exact: args[0], prefix: '', suffix: '', hint: null };
        return;
      case 'set_note_selector_context':
        this.note.selector = { exact: args[0], prefix: args[1], suffix: args[2], hint: null };
        return;
      case 'set_note_hint_article':
        this.note.selector.hint = { article: args[0] };
        return;
      case 'set_note_hint_position':
        this.note.selector.hint = { article: args[0], start: Number(args[1].toString()), end: Number(args[2].toString()) };
        return;
      case 'resolve_note':
        this.note.result = resolveNote(this.note.selector, this.note.articles);
        return;
      case 'assert_note_resolves': {
        const r = this.note.result;
        if (r.status !== 'found') fail(`expected found, got ${r.status} (${r.matches.length} matches)`);
        if (r.matches[0].article !== args[0]) fail(`note resolves to article ${r.matches[0].article}, expected ${args[0]}`);
        return;
      }
      case 'assert_note_exact_match': {
        const r = this.note.result;
        if (r.status !== 'found' || r.matches[0].confidence !== 1) fail(`expected an exact match, got ${r.status} ${r.matches[0]?.confidence}`);
        return;
      }
      case 'assert_note_fuzzy_match': {
        const r = this.note.result;
        if (r.status !== 'found' || !(r.matches[0].confidence < 1)) fail(`expected a fuzzy match, got ${r.status} ${r.matches[0]?.confidence}`);
        return;
      }
      case 'assert_note_orphaned':
        if (this.note.result.status !== 'orphaned') fail(`expected orphaned, got ${this.note.result.status}`);
        return;
      case 'assert_note_ambiguous':
        if (this.note.result.status !== 'ambiguous') fail(`expected ambiguous, got ${this.note.result.status}`);
        return;
      default:
        fail(`unknown action '${action}'`);
    }
  }
}

function featureTiers(feature) {
  const tiers = feature.tags.filter((t) => t.startsWith('@tier:')).map((t) => t.slice(6));
  return tiers.length ? tiers : ['core'];
}

// Run all scenarios of one feature. Returns [{name, status, message, line}].
export function runFeature(engine, grammar, text, origin = '', options = {}) {
  const feature = parseFeature(text, origin);
  const tiers = featureTiers(feature);
  const supported = options.tiers || SUPPORTED_TIERS;
  const results = [];
  for (const sc of feature.scenarios) {
    if (sc.tags.includes('@wip') || sc.tags.includes('@skip') || sc.tags.includes('@ignore')) {
      results.push({ feature: feature.name, name: sc.name, line: sc.line, status: 'skipped', message: 'work in progress (@wip)' });
      continue;
    }
    const unsupported = tiers.filter((t) => !supported.includes(t));
    if (unsupported.length) {
      results.push({ feature: feature.name, name: sc.name, line: sc.line, status: 'skipped', message: `tier ${unsupported.join(', ')} not supported` });
      continue;
    }
    const world = new World(engine, grammar);
    const steps = [...(feature.background?.steps || []), ...sc.steps];
    let status = 'passed';
    let message = '';
    let at = sc.line;
    for (const st of steps) {
      at = st.line;
      try {
        runStep(world, grammar, st);
      } catch (e) {
        status = 'failed';
        message = `${st.keyword} ${st.text}\n    ${e instanceof StepFailure ? e.message : `engine error: ${e.stack || e.message}`}`;
        break;
      }
    }
    results.push({ feature: feature.name, name: sc.name, line: status === 'failed' ? at : sc.line, status, message });
  }
  return results;
}

function runStep(world, grammar, st) {
  for (const s of grammar.steps) {
    const m = s.regex.exec(st.text);
    if (!m) continue;
    const args = s.order.map((o, i) => {
      const raw = m[i + 1];
      const type = s.types[o.name];
      if (type === 'number') return world.typed(raw, false);
      if (type === 'value' || (type === 'string' && s.action === 'set_parameter') || (type === 'string' && s.action === 'assert_equals')) {
        return world.typed(raw, o.quoted);
      }
      return raw;
    });
    args.push(...s.literals);
    world.dispatch(s.action, args, st.table);
    return;
  }
  throw new StepFailure(`no step in the grammar matches: ${st.text}`);
}
