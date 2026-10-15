// eyelee engine: executes machine-readable Dutch law (the regelrecht format).
//
// A rulework is a Prolog file per version of a regulation. Each article may carry
// a machine_readable section with parameters (what the caller supplies), inputs
// (what other laws or registers supply), open terms (what a lower regulation
// fills in), outputs and the actions that compute them. The engine selects
// the version in force on the calculation date, resolves every input of an
// article, runs its actions in dependency order, fires the hooks a decision
// triggers, applies overrides from the laws in the execution chain, and keeps
// a derivation tree so that every answer can be explained.

import { compileRulework, readRulework } from './prolog-compiler.js';
import { evaluateExpression as evaluate } from './reasoner.js';
import { Dec } from './decimal.js';
import { LawError } from './operations.js';
import { Unknown, isUnknown, isRecord, toValue, referenceDate, show, isIsoDate } from './values.js';

export { LawError };

// Lex superior: the higher the rank, the higher the regulation.
const LAYER_RANK = {
  GRONDWET: 100,
  VERDRAG: 96,
  EU_VERORDENING: 95,
  EU_RICHTLIJN: 94,
  WET: 90,
  AMVB: 80,
  KONINKLIJK_BESLUIT: 75,
  MINISTERIELE_REGELING: 70,
  PROVINCIALE_VERORDENING: 60,
  WATERSCHAPS_VERORDENING: 55,
  GEMEENTELIJKE_VERORDENING: 50,
  BELEIDSREGEL: 40,
  UITVOERINGSBELEID: 30,
};

// Codes that bind a decentral regulation to the authority it was made by;
// an implementation only applies where the execution scope names that code.
const SCOPE_CODES = ['gemeente_code', 'provincie_code', 'waterschap_code'];

export const UNTRANSLATABLE_MODES = ['error', 'propagate', 'warn', 'ignore'];

const MAX_CROSS_LAW_DEPTH = 20;

// Marks a required parameter the caller did not pass.
const MISSING = Symbol('missing required parameter');

// ---------------------------------------------------------------------------
// Errors (the wording carries the facts a caller needs; RFC-036, RFC-019)
// ---------------------------------------------------------------------------

const err = {
  lawNotFound: (id) => new LawError('LawNotFound', `Law not found: ${id}`),
  notYetInForce: (id, date) => new LawError('LawNotYetInForce', `No version of law '${id}' in force on ${date} (not yet in force)`),
  ended: (id, date, to) => new LawError('LawEnded', `No version of law '${id}' in force on ${date}; last in force until ${to}`),
  outputNotFound: (id, output) => new LawError('OutputNotFound', `Output '${output}' not found in law '${id}'`),
  variableNotFound: (name) => new LawError('VariableNotFound', `Variable not found: ${name}`),
  circular: (what) => new LawError('CircularReference', `Circular reference detected: ${what}`),
  nullForNonNullable: (law, field, origin) => new LawError(
    'NullForNonNullable',
    `${origin} delivered null for '${field}' of ${law}, which the law declares as never absent; declare the field nullable if absence is a legitimate value (RFC-036)`,
  ),
  nullOutput: (law, output) => new LawError(
    'NullOutput',
    `output '${output}' of ${law} evaluated to null (absent) but is not declared nullable; add a default or declare the output nullable (RFC-036)`,
  ),
  missingParameter: (law, name, value) => new LawError(
    'MissingParameter',
    `parameter '${name}' of ${law} is ${value}: a law cannot be evaluated for nobody, and a parameter that is not declared nullable never takes null`,
  ),
  requiredParameter: (law, name) => new LawError('MissingParameter', `Required parameter '${name}' of ${law} was not provided`),
  untranslatable: (law, article, u) => new LawError(
    'Untranslatable',
    `Untranslatable construct in ${law} article ${article}: ${u.construct ?? u.about} — ${u.reason}`,
  ),
  voided: (law, output, by, article, grounds) => new LawError(
    'OutputVoided',
    `Output '${output}' of law '${law}' does not arise: ${grounds} (${by} article ${article})`,
  ),
  openTerm: (law, article, id, date) => new LawError(
    'ResolutionError',
    `Resolution error: no regulation in force on ${date} fills open term '${id}' of ${law} article ${article}, and the term has no default`,
  ),
  depth: () => new LawError('MaxDepthExceeded', `Maximum cross-law depth exceeded: ${MAX_CROSS_LAW_DEPTH} levels`),
};

// ---------------------------------------------------------------------------
// Laws
// ---------------------------------------------------------------------------

class Law {
  constructor(doc, origin) {
    if (!doc || typeof doc !== 'object' || !Array.isArray(doc.articles)) {
      throw new LawError('LoadError', `Not a rulework${origin ? ` (${origin})` : ''}: no articles`);
    }
    this.raw = doc;
    this.origin = origin || null;
    this.id = doc.$id || null;
    this.name = typeof doc.name === 'string' ? doc.name : null;
    this.layer = doc.regulatory_layer || null;
    this.validFrom = doc.valid_from == null ? null : String(doc.valid_from);
    this.validTo = doc.valid_to == null ? null : String(doc.valid_to);
    this.scope = {};
    for (const c of SCOPE_CODES) if (doc[c] != null) this.scope[c] = String(doc[c]);
    this.articles = [];
    if (doc.preamble?.machine_readable) {
      this.articles.push({ number: 'preamble', text: doc.preamble.text, mr: doc.preamble.machine_readable });
    }
    for (const a of doc.articles) {
      this.articles.push({ number: String(a.number), text: a.text, url: a.url, mr: a.machine_readable || null });
    }
    this.outputs = new Map();
    this.definitions = new Map();
    for (const a of this.articles) {
      for (const o of a.mr?.execution?.output || []) if (!this.outputs.has(o.name)) this.outputs.set(o.name, a);
      for (const [k, v] of Object.entries(a.mr?.definitions || {})) if (!this.definitions.has(k)) this.definitions.set(k, v);
    }
  }

  article(number) {
    return this.articles.find((a) => a.number === String(number)) || null;
  }

  get label() {
    return this.validFrom ? `${this.id} (${this.validFrom})` : this.id;
  }
}

function definitionValue(def) {
  if (isRecord(def) && 'value' in def) return def.value;
  return def;
}

// ---------------------------------------------------------------------------
// Data sources: registers that answer `source: {}` inputs, keyed on a field
// ---------------------------------------------------------------------------

class DataSource {
  constructor({ name, key, records, law = null, priority = 10 }) {
    this.name = name;
    this.key = String(key).toLowerCase();
    this.law = law;
    this.priority = priority;
    this.index = new Map();
    for (const rec of records || []) {
      const r = {};
      for (const [k, v] of Object.entries(rec)) r[k.toLowerCase()] = toValue(v);
      if (!(this.key in r)) continue;
      const kv = r[this.key];
      if (kv === null || isUnknown(kv)) continue;
      this.index.set(canon(kv), r);
    }
  }
}

function canon(v) {
  if (v instanceof Dec) return 'n:' + v.toString();
  if (typeof v === 'string') return Dec.isNumericLiteral(v) ? 'n:' + Dec.parse(v).toString() : 's:' + v;
  return 'j:' + JSON.stringify(v);
}

function canonParams(params) {
  return [...params.entries()].sort(([a], [b]) => (a < b ? -1 : a > b ? 1 : 0)).map(([k, v]) => `${k}=${show(v)}`).join('&');
}

// ---------------------------------------------------------------------------
// The engine
// ---------------------------------------------------------------------------

export class Engine {
  constructor(options = {}) {
    this.versions = new Map(); // law id -> [Law] sorted by valid_from
    this.sources = [];
    this.untranslatableMode = options.untranslatableMode || 'error';
    this.indexes = null;
  }

  // Load one Prolog rulework (or compile a data object to Prolog). Returns its id.
  loadLaw(source, origin) {
    const { doc } = readRulework(typeof source === 'string' ? source : compileRulework(source));
    const law = new Law(doc, origin);
    if (!law.id) throw new LawError('LoadError', `Rulework without $id${origin ? ` (${origin})` : ''} cannot be referred to`);
    const list = this.versions.get(law.id) || [];
    const same = list.findIndex((l) => l.validFrom === law.validFrom);
    if (same >= 0) list[same] = law;
    else list.push(law);
    list.sort((a, b) => (a.validFrom || '').localeCompare(b.validFrom || ''));
    this.versions.set(law.id, list);
    this.indexes = null;
    return law.id;
  }

  hasLaw(id) {
    return this.versions.has(id);
  }

  lawIds() {
    return [...this.versions.keys()].sort();
  }

  setUntranslatableMode(mode) {
    if (!UNTRANSLATABLE_MODES.includes(mode)) throw new Error(`Invalid untranslatable mode '${mode}' (one of ${UNTRANSLATABLE_MODES.join(', ')})`);
    this.untranslatableMode = mode;
  }

  // Register a data source (a list of records keyed on one field). A source
  // bound to a law answers only while that law's inputs are resolved.
  setDataSource(spec) {
    const src = new DataSource(spec);
    this.sources = this.sources.filter((s) => !(s.name === src.name && s.law === src.law));
    this.sources.push(src);
    // Highest priority first; at equal priority the law-bound source wins.
    this.sources.sort((a, b) => b.priority - a.priority || (b.law ? 1 : 0) - (a.law ? 1 : 0));
  }

  clearDataSources() {
    this.sources = [];
  }

  // The version of a law in force on `date` (valid_from <= date <= valid_to).
  // An ended law does not fall back to an older version.
  select(id, date) {
    const list = this.versions.get(id);
    if (!list) throw err.lawNotFound(id);
    const started = list.filter((l) => {
      if (l.validFrom === null) return true;
      if (!isIsoDate(l.validFrom)) return false;
      return l.validFrom <= date;
    });
    if (!started.length) throw err.notYetInForce(id, date);
    const law = started[started.length - 1];
    if (law.validTo && date > law.validTo) throw err.ended(id, date, law.validTo);
    return law;
  }

  tryselect(id, date) {
    try {
      return this.select(id, date);
    } catch {
      return null;
    }
  }

  buildIndexes() {
    if (this.indexes) return this.indexes;
    const implementations = new Map(); // law#article#term -> [{id, article}]
    const hooks = []; // {id, article, hook}
    const overrides = new Map(); // law#article#output -> [{id, article, override}]
    const overriding = new Set();
    for (const [id, list] of this.versions) {
      const seen = new Set();
      for (const law of list) {
        for (const a of law.articles) {
          const mr = a.mr || {};
          for (const im of mr.implements || []) {
            const k = `${im.law}#${im.article}#${im.open_term}`;
            const tag = `i|${k}|${a.number}`;
            if (seen.has(tag)) continue;
            seen.add(tag);
            if (!implementations.has(k)) implementations.set(k, []);
            implementations.get(k).push({ id, article: a.number });
          }
          for (const h of mr.hooks || []) {
            const tag = `h|${a.number}|${JSON.stringify(h)}`;
            if (seen.has(tag)) continue;
            seen.add(tag);
            hooks.push({ id, article: a.number });
          }
          for (const o of mr.overrides || []) {
            const k = `${o.law}#${o.article}#${o.output}`;
            const tag = `o|${k}|${a.number}`;
            if (seen.has(tag)) continue;
            seen.add(tag);
            if (!overrides.has(k)) overrides.set(k, []);
            overrides.get(k).push({ id, article: a.number });
            overriding.add(id);
          }
        }
      }
    }
    this.indexes = { implementations, hooks: dedupe(hooks), overrides, overriding };
    return this.indexes;
  }

  // Evaluate outputs of a law. `params` is a plain object or a Map.
  evaluate(lawId, outputs, params = {}, date, options = {}) {
    if (!date || !isIsoDate(String(date))) throw new LawError('InvalidDate', `Invalid date format: calculation date '${date}'`);
    const names = Array.isArray(outputs) ? outputs : [outputs];
    const run = new Run(this, String(date), options);
    const law = this.select(lawId, run.date);
    run.inForce(law);
    const p = new Map();
    for (const [k, v] of params instanceof Map ? params : Object.entries(params)) p.set(k, toValue(v));
    const byArticle = new Map();
    for (const name of names) {
      const a = law.outputs.get(name);
      if (!a) throw err.outputNotFound(law.id, name);
      if (!byArticle.has(a)) byArticle.set(a, []);
      byArticle.get(a).push(name);
    }
    const result = {
      law: law.id,
      version: law.validFrom,
      date: run.date,
      outputs: {},
      provenance: {},
      tainted: [],
      voided: {},
      trace: [],
      checks: [],
    };
    for (const [article, wanted] of byArticle) {
      const r = run.execArticle(law, article, p, { depth: 0, caller: null, chain: [], held: new Set(), top: true });
      result.trace.push(r.node);
      for (const name of new Set([...wanted, ...r.outputs.keys(), ...r.provenance.keys()])) addOutput(result, name, r, 'direct');
      for (const h of r.hooks) for (const name of h.outputs.keys()) addOutput(result, name, h, 'reactive');
    }
    result.checks = run.summary();
    return result;
  }
}

function dedupe(list) {
  const seen = new Set();
  return list.filter((x) => {
    const k = `${x.id}#${x.article}`;
    if (seen.has(k)) return false;
    seen.add(k);
    return true;
  });
}

function addOutput(result, name, r, kind) {
  const prov = r.provenance.get(name);
  if (prov?.voided) {
    result.voided[name] = prov.voided;
    result.provenance[name] = 'voided';
    return;
  }
  result.outputs[name] = r.outputs.get(name);
  result.provenance[name] = prov?.override ? 'override' : kind;
  if (r.tainted && !result.tainted.includes(name)) result.tainted.push(name);
}

// ---------------------------------------------------------------------------
// One evaluation: memoizes article executions and guards against cycles
// ---------------------------------------------------------------------------

class Run {
  constructor(engine, date, options) {
    this.engine = engine;
    this.date = date;
    this.options = options;
    this.cache = new Map();
    this.active = new Set();
    this.facts = { laws: new Map(), params: new Set(), boundaries: 0, outputs: new Set(), untranslatables: new Set(), articles: new Set() };
    this.indexes = engine.buildIndexes();
  }

  inForce(law) {
    this.facts.laws.set(law.id, law);
  }

  select(id) {
    const law = this.engine.select(id, this.date);
    this.inForce(law);
    return law;
  }

  // What was verified along the way, as Check statements.
  summary() {
    const f = this.facts;
    const out = [];
    const laws = [...f.laws.values()].map((l) => (l.validFrom ? `${l.id} (${l.validFrom}${l.validTo ? ` to ${l.validTo}` : ''})` : `${l.id} (undated)`));
    out.push(`${laws.length} law version(s) in force on ${this.date}: ${laws.join(', ')}`);
    out.push(`${f.articles.size} article execution(s), each with every input and open term resolved before deciding`);
    if (f.params.size) out.push(`parameters match their declarations in ${f.params.size} article(s)`);
    if (f.boundaries) out.push(`${f.boundaries} value(s) crossed into an article and respected its nullable declarations`);
    const expressions = [...this.cache.values()].reduce((count, result) => count + result.node.derivations.length, 0);
    if (expressions) out.push(`${expressions} expression result(s) derived by eyelang, each with supporting rule evidence`);
    if (f.outputs.size) out.push(`every output declared never absent has a value, in ${f.outputs.size} article(s)`);
    for (const u of f.untranslatables) out.push(u);
    return out;
  }

  // Evaluate one output of a law, as a cross-law reference does.
  evalOutput(lawId, output, params, ctx) {
    const law = this.select(lawId);
    const article = law.outputs.get(output);
    if (!article) throw err.outputNotFound(law.id, output);
    return this.articleOutput(law, article, output, params, ctx);
  }

  articleOutput(law, article, output, params, ctx) {
    const r = this.execArticle(law, article, params, ctx);
    const prov = r.provenance.get(output);
    if (prov?.voided) throw err.voided(law.id, output, prov.voided.law, prov.voided.article, prov.voided.grounds);
    if (!r.outputs.has(output)) throw err.outputNotFound(law.id, output);
    return { value: r.outputs.get(output), tainted: r.tainted, node: r.node };
  }

  execArticle(law, article, params, ctx) {
    if (ctx.depth > MAX_CROSS_LAW_DEPTH) throw err.depth();
    const relevant = ctx.chain.filter((id) => this.indexes.overriding.has(id));
    const key = [
      law.id, law.validFrom, article.number, canonParams(params),
      [...new Set(relevant)].sort().join(','), [...ctx.held].sort().join(','), ctx.top ? 'top' : '',
    ].join('|');
    if (this.cache.has(key)) {
      const hit = this.cache.get(key);
      return hit;
    }
    if (this.active.has(key)) throw err.circular(`${law.id} article ${article.number}`);
    this.active.add(key);
    try {
      const frame = new Frame(this, law, article, params, ctx);
      const result = frame.execute();
      this.cache.set(key, result);
      return result;
    } finally {
      this.active.delete(key);
    }
  }

  // Look a field up in the data sources that answer for this law.
  lookupData(lawId, field, frame) {
    const f = field.toLowerCase();
    for (const src of this.engine.sources) {
      if (src.law && src.law !== lawId) continue;
      const kv = frame.keyValue(src.key);
      if (kv === undefined || kv === null || isUnknown(kv)) continue;
      const rec = src.index.get(canon(kv));
      if (!rec || !(f in rec)) continue;
      return { value: rec[f], source: src.name };
    }
    return null;
  }
}

// ---------------------------------------------------------------------------
// The execution of one article
// ---------------------------------------------------------------------------

class Frame {
  constructor(run, law, article, params, ctx) {
    this.run = run;
    this.law = law;
    this.article = article;
    this.mr = article.mr || {};
    this.exec = this.mr.execution || {};
    this.params = params; // everything the caller passed
    this.ctx = ctx;
    this.paramDecls = new Map((this.exec.parameters || []).map((p) => [p.name, p]));
    this.inputDecls = new Map((this.exec.input || []).map((i) => [i.name, i]));
    this.outputDecls = new Map((this.exec.output || []).map((o) => [o.name, o]));
    this.openDecls = new Map((this.mr.open_terms || []).map((t) => [t.id, t]));
    this.bound = new Map();
    this.inputs = new Map();
    this.openTerms = new Map();
    this.outputs = new Map();
    this.provenance = new Map();
    this.state = new Map();
    this.tainted = false;
    this.hooks = [];
    this.node = {
      law: law.id,
      version: law.validFrom,
      article: article.number,
      top: !!ctx.top,
      params: [],
      inputs: [],
      openTerms: [],
      outputs: [],
      hooks: { pre: [], post: [] },
      notes: [],
      derivations: [],
    };
    this.scope = new Scope(this, null);
  }

  execute() {
    const { run, law, article } = this;
    this.checkUntranslatables();
    this.bindParameters();
    // Every input and open term is resolved before the article decides.
    for (const name of this.inputDecls.keys()) this.input(name);
    for (const id of this.openDecls.keys()) this.openTerm(id);
    if (this.ctx.top) this.fireHooks('pre_actions');
    for (const a of this.exec.actions || []) this.output(a.output);
    for (const [name, decl] of this.outputDecls) {
      if (!this.outputs.has(name) && !this.provenance.get(name)?.voided) this.output(name);
      if (this.outputs.get(name) === null && !decl.nullable && !this.provenance.get(name)?.voided) {
        throw err.nullOutput(law.id, name);
      }
    }
    if (this.outputDecls.size) run.facts.outputs.add(`${law.id}#${article.number}`);
    run.facts.articles.add(`${law.id}#${article.number}`);
    if (this.ctx.top) this.fireHooks('post_actions');
    for (const [name, value] of this.outputs) {
      this.node.outputs.push({ name, value, override: this.provenance.get(name)?.override || null });
    }
    for (const [name, p] of this.provenance) if (p.voided) this.node.outputs.push({ name, voided: p.voided });
    this.node.tainted = this.tainted;
    return { outputs: this.outputs, provenance: this.provenance, tainted: this.tainted, hooks: this.hooks, node: this.node };
  }

  checkUntranslatables() {
    const items = [...(this.mr.untranslatables || []), ...(this.mr.markings || [])];
    if (!items.length) return;
    const mode = this.run.engine.untranslatableMode;
    for (const u of items) {
      const accepted = u.accepted === true;
      if (!accepted && (mode === 'error' || mode === 'ignore')) throw err.untranslatable(this.law.id, this.article.number, u);
      if (!accepted && mode === 'warn') this.node.notes.push(`warning: untranslatable construct '${u.construct ?? u.about}' executed with partial logic`);
    }
    if (mode === 'propagate') {
      this.tainted = true;
      this.node.notes.push(`tainted: the article carries ${items.length} untranslatable construct(s)`);
    } else {
      this.run.facts.untranslatables.add(`untranslatable constructs of ${this.law.id} article ${this.article.number} are accepted (mode ${mode})`);
    }
  }

  bindParameters() {
    for (const [name, decl] of this.paramDecls) {
      if (this.params.has(name)) {
        const v = this.params.get(name);
        if (v === null && !decl.nullable) {
          if (this.ctx.depth === 0) throw err.missingParameter(this.law.id, name, 'null');
          throw err.nullForNonNullable(this.law.id, name, `parameter from ${this.ctx.caller}`);
        }
        if (isUnknown(v) && decl.required === true && this.ctx.depth === 0) throw err.missingParameter(this.law.id, name, 'unknown');
        this.bound.set(name, v);
        this.node.params.push({ name, value: v });
      } else if (this.inputDecls.has(name)) {
        // The input of the same name supplies it.
      } else if (decl.required === true) {
        // Only an error when the law actually reads it.
        this.bound.set(name, MISSING);
      } else {
        this.bound.set(name, new Unknown([name]));
        this.node.params.push({ name, value: this.bound.get(name), note: 'optional, not passed' });
      }
    }
    if (this.paramDecls.size) this.run.facts.params.add(`${this.law.id}#${this.article.number}`);
  }

  // The value of a key field for a data-source lookup.
  keyValue(key) {
    for (const [k, v] of this.params) if (k.toLowerCase() === key) return v;
    for (const [k, v] of this.bound) if (k.toLowerCase() === key && v !== MISSING) return v;
    for (const [k, v] of this.inputs) if (k.toLowerCase() === key) return v;
    return undefined;
  }

  enter(kind, name) {
    const k = `${kind}:${name}`;
    if (this.state.get(k) === 'busy') throw err.circular(`${kind} '${name}' of ${this.law.id} article ${this.article.number}`);
    this.state.set(k, 'busy');
    return () => this.state.set(k, 'done');
  }

  boundary(name, value, decl, origin) {
    if (value === null && !decl.nullable) throw err.nullForNonNullable(this.law.id, name, origin);
    this.run.facts.boundaries++;
  }

  input(name) {
    if (this.inputs.has(name)) return this.inputs.get(name);
    const decl = this.inputDecls.get(name);
    const done = this.enter('input', name);
    let value;
    let via;
    let child = null;
    if (this.params.has(name)) {
      value = this.params.get(name);
      via = this.ctx.depth === 0 ? 'parameter from caller' : `parameter from ${this.ctx.caller}`;
    } else {
      const ds = this.run.lookupData(this.law.id, name, this);
      const src = decl.source || {};
      if (ds) {
        value = ds.value;
        via = `source ${ds.source}`;
      } else if (src.output) {
        ({ value, via, child } = this.callSource(name, src));
      } else {
        value = new Unknown([name]);
        via = 'no data source has it';
      }
    }
    this.boundary(name, value, decl, via);
    this.inputs.set(name, value);
    this.node.inputs.push({ name, value, via, child });
    done();
    return value;
  }

  // Resolve an input from an output of another (or this) law.
  callSource(name, src) {
    const targetId = src.regulation || this.law.id;
    const passed = new Map();
    const explicit = !!src.parameters || targetId !== this.law.id;
    if (src.parameters && typeof src.parameters === 'object') {
      for (const [k, expr] of Object.entries(src.parameters)) passed.set(k, evaluate(expr, this.scope));
    } else if (targetId === this.law.id) {
      for (const [k, v] of this.params) passed.set(k, v);
    }
    const target = this.run.select(targetId);
    const article = target.outputs.get(src.output);
    if (!article) throw err.outputNotFound(target.id, src.output);
    // A required parameter that names nobody does not run the other law,
    // unless that law declares it can decide on nobody (nullable).
    for (const p of article.mr?.execution?.parameters || []) {
      // An explicit call must pass what the other law requires: a misspelled
      // key may never quietly turn into an unknown outcome.
      if (p.required === true && !passed.has(p.name) && explicit) throw err.requiredParameter(target.id, p.name);
      if (p.required !== true) continue;
      const v = passed.get(p.name);
      if (v === null && !p.nullable) return { value: null, via: `skipped call to ${targetId}`, child: null };
      if (isUnknown(v)) return { value: v, via: `skipped call to ${targetId} (${p.name} unknown)`, child: null };
    }
    const res = this.run.articleOutput(target, article, src.output, passed, this.childCtx());
    if (res.tainted) this.taint(`input '${name}' is tainted`);
    return { value: res.value, via: `${targetId}.${src.output}`, child: res.node };
  }

  childCtx(extraHeld) {
    const held = new Set(this.ctx.held);
    if (extraHeld) held.add(extraHeld);
    return { depth: this.ctx.depth + 1, caller: this.law.id, chain: [...this.ctx.chain, this.law.id], held, top: false };
  }

  taint(reason) {
    if (!this.tainted) this.node.notes.push(`tainted: ${reason}`);
    this.tainted = true;
  }

  openTerm(id) {
    if (this.openTerms.has(id)) return this.openTerms.get(id);
    const decl = this.openDecls.get(id);
    const done = this.enter('open term', id);
    const { run, law, article } = this;
    const candidates = [];
    for (const c of run.indexes.implementations.get(`${law.id}#${article.number}#${id}`) || []) {
      const impl = run.engine.tryselect(c.id, run.date);
      if (!impl) continue;
      const implArticle = impl.article(c.article);
      if (!implArticle || !(implArticle.mr?.implements || []).some((im) => im.law === law.id && String(im.article) === article.number && im.open_term === id)) continue;
      // A decentral regulation applies only to its own territory.
      const outOfScope = Object.entries(impl.scope).some(([k, code]) => {
        const v = this.keyValue(k);
        return v === undefined || v === null || isUnknown(v) || String(v instanceof Dec ? v.toString() : v) !== code;
      });
      if (outOfScope) continue;
      const heldKey = `impl:${impl.id}#${implArticle.number}#${id}`;
      if (this.ctx.held.has(heldKey)) continue;
      candidates.push({ impl, implArticle, heldKey });
    }
    // Lex superior first, then lex posterior.
    candidates.sort((a, b) => (LAYER_RANK[b.impl.layer] || 0) - (LAYER_RANK[a.impl.layer] || 0)
      || (b.impl.validFrom || '').localeCompare(a.impl.validFrom || ''));
    let value = null;
    let via = null;
    let child = null;
    for (const c of candidates) {
      run.inForce(c.impl);
      const res = run.articleOutput(c.impl, c.implArticle, id, new Map(this.params), this.childCtx(c.heldKey));
      if (res.value === null) continue; // the regulation is silent here
      value = res.value;
      via = `implemented by ${c.impl.id} article ${c.implArticle.number}`;
      child = res.node;
      if (res.tainted) this.taint(`open term '${id}' is tainted`);
      break;
    }
    if (via === null) {
      const actions = (decl.default?.actions || []).filter((a) => a.output === id);
      if (actions.length) {
        for (const a of actions) value = this.action(a);
        via = candidates.length ? 'default of the open term (the implementing regulation is silent)' : 'default of the open term (no implementing regulation)';
      } else if (decl.required === false) {
        value = null;
        via = 'not filled (optional open term)';
      } else {
        throw err.openTerm(law.id, article.number, id, run.date);
      }
    }
    this.openTerms.set(id, value);
    this.node.openTerms.push({ id, value, via, child });
    done();
    return value;
  }

  action(a) {
    if (a.operation) {
      const { output, legal_basis, ...op } = a;
      return evaluate(op, this.scope);
    }
    if ('value' in a) return evaluate(a.value, this.scope);
    if (a.resolve) throw new LawError('InvalidOperation', `Invalid operation: 'resolve' actions are not supported (output '${a.output}')`);
    return null;
  }

  output(name) {
    if (this.outputs.has(name)) return this.outputs.get(name);
    const prov = this.provenance.get(name);
    if (prov?.voided) throw err.voided(this.law.id, name, prov.voided.law, prov.voided.article, prov.voided.grounds);
    const done = this.enter('output', name);
    let value = null;
    for (const a of this.exec.actions || []) if (a.output === name) value = this.action(a);
    const ovr = this.override(name);
    if (ovr?.voided) {
      this.provenance.set(name, { voided: ovr.voided });
      done();
      throw err.voided(this.law.id, name, ovr.voided.law, ovr.voided.article, ovr.voided.grounds);
    }
    if (ovr) {
      value = ovr.value;
      this.provenance.set(name, { override: ovr.override });
    } else this.provenance.set(name, {});
    this.outputs.set(name, value);
    done();
    return value;
  }

  // Lex specialis: an override from a law in the execution chain (or from
  // this very law) replaces or voids the output.
  override(name) {
    const { run, law, article } = this;
    for (const o of run.indexes.overrides.get(`${law.id}#${article.number}#${name}`) || []) {
      if (o.id !== law.id && !this.ctx.chain.includes(o.id)) continue;
      const heldKey = `ovr:${o.id}#${o.article}#${name}`;
      if (this.ctx.held.has(heldKey)) continue;
      const over = run.engine.tryselect(o.id, run.date);
      const overArticle = over?.article(o.article);
      if (!overArticle) continue;
      const decl = (overArticle.mr?.overrides || []).find((x) => x.law === law.id && String(x.article) === article.number && x.output === name);
      if (!decl) continue;
      if (decl.voids) {
        return { voided: { law: over.id, article: overArticle.number, grounds: decl.legal_text_excerpt || 'voided' } };
      }
      const res = run.articleOutput(over, overArticle, name, new Map(this.params), this.childCtx(heldKey));
      if (res.tainted) this.taint(`output '${name}' is overridden by a tainted value`);
      return { value: res.value, override: { law: over.id, article: overArticle.number, node: res.node } };
    }
    return null;
  }

  // Hooks fire on what the article produces (a beschikking, an aanvraag).
  fireHooks(point) {
    const produces = this.exec.produces;
    if (!produces) return;
    const { run } = this;
    for (const h of run.indexes.hooks) {
      const law = run.engine.tryselect(h.id, run.date);
      const article = law?.article(h.article);
      if (!article) continue;
      for (const hook of article.mr?.hooks || []) {
        if (hook.hook_point !== point || !hookApplies(hook.applies_to || {}, produces)) continue;
        if (law.id === this.law.id && article.number === this.article.number) continue;
        run.inForce(law);
        const r = run.execArticle(law, article, new Map(this.params), this.childCtx());
        this.hooks.push(r);
        this.node.hooks[point === 'pre_actions' ? 'pre' : 'post'].push({ law: law.id, article: article.number, child: r.node });
      }
    }
  }

  // Name resolution inside the article.
  lookup(name) {
    if (name === 'referencedate') return referenceDate(this.run.date);
    if (this.paramDecls.has(name) && this.params.has(name)) return this.bound.get(name);
    if (this.inputDecls.has(name)) return this.input(name);
    if (this.openDecls.has(name)) return this.openTerm(name);
    if (this.bound.has(name)) {
      const v = this.bound.get(name);
      if (v === MISSING) throw err.requiredParameter(this.law.id, name);
      return v;
    }
    if (this.outputDecls.has(name) || (this.exec.actions || []).some((a) => a.output === name)) return this.output(name);
    const defs = this.mr.definitions || {};
    if (name in defs) return evaluate(definitionValue(defs[name]), this.scope);
    if (this.law.definitions.has(name)) return evaluate(definitionValue(this.law.definitions.get(name)), this.scope);
    if (this.params.has(name)) return this.params.get(name);
    throw err.variableNotFound(name);
  }
}

function hookApplies(applies, produces) {
  if (applies.submission) {
    return produces.submission?.kind === applies.submission;
  }
  if (!applies.legal_character || applies.legal_character !== produces.legal_character) return false;
  if (applies.decision_type && applies.decision_type !== produces.decision_type) return false;
  // A plain evaluation is the decision itself: the BESLUIT stage of the Awb
  // procedure. Later stages (BEKENDMAKING, ...) need a stage-aware run.
  if (applies.stage && applies.stage !== 'BESLUIT') return false;
  return true;
}

// Variable scope: the article frame plus FOREACH locals.
class Scope {
  constructor(frame, locals) {
    this.frame = frame;
    this.locals = locals;
  }

  traceReasoner(derivation) {
    this.frame.node.derivations.push(derivation);
  }

  withLocals(locals) {
    return new Scope(this.frame, locals);
  }

  resolve(path) {
    const parts = path.split('.');
    let v = this.locals && this.locals.has(parts[0]) ? this.locals.get(parts[0]) : this.frame.lookup(parts[0]);
    for (let i = 1; i < parts.length; i++) {
      if (v === null || isUnknown(v)) return v; // a field of an absent record is absent
      if (isRecord(v)) {
        v = parts[i] in v ? v[parts[i]] : new Unknown([parts.slice(0, i + 1).join('.')]);
      } else throw new LawError('TypeMismatch', `Type mismatch: '$${parts.slice(0, i).join('.')}' is not an object, cannot read '${parts[i]}'`);
    }
    return v === undefined ? null : v;
  }
}
