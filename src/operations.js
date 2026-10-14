// Evaluation of operation trees.
//
// The rules for the two kinds of "nothing" (RFC-036) are applied here, per
// operation:
//   - null is absence. EQUALS and IN compare it structurally; calculating,
//     ordering or deciding on it is an error the law has to resolve.
//   - Unknown is a fact nobody has. It propagates and names what is missing;
//     a definite false still decides an AND, a definite true an OR.

import { Dec } from './decimal.js';
import {
  Unknown, isUnknown, isDec, isRecord, deepUnknown, toValue, dateOf, ymd, fmtDate,
  daysInMonth, dayNumber, fromDayNumber, addMonths, wholeMonths, isIsoDate,
} from './values.js';

export class LawError extends Error {
  constructor(kind, message) {
    super(message);
    this.kind = kind;
  }
}

export const MAX_DEPTH = 100;
export const MAX_COLLECTION = 1000;

const ALIASES = {
  SWITCH: 'IF',
};

export function absentOperand(op) {
  return new LawError(
    'AbsentOperand',
    `${op}: operand is null (absent); a law does not calculate with or decide on 'geen' without saying so — test for absence first (EQUALS … null)`,
  );
}

function typeMismatch(op, expected, v) {
  return new LawError('TypeMismatch', `${op}: type mismatch: expected ${expected}, got ${describe(v)}`);
}

function describe(v) {
  if (v === null) return 'null';
  if (isDec(v)) return `number ${v}`;
  if (Array.isArray(v)) return 'array';
  if (isRecord(v)) return 'object';
  return `${typeof v} ${JSON.stringify(v)}`;
}

// Evaluate any operand: a $reference, a literal, a list literal or an operation.
export function evaluate(node, scope, depth = 0) {
  if (depth > MAX_DEPTH) throw new LawError('MaxDepthExceeded', `Maximum operation depth exceeded: ${MAX_DEPTH} levels`);
  if (node === null || node === undefined) return null;
  if (typeof node === 'string') {
    if (node.startsWith('$')) return scope.resolve(node.slice(1));
    return node;
  }
  if (typeof node === 'number' || typeof node === 'bigint') return Dec.from(node);
  if (typeof node === 'boolean') return node;
  if (node instanceof Dec || node instanceof Unknown) return node;
  if (Array.isArray(node)) return node.map((n) => evaluate(n, scope, depth + 1));
  if (typeof node === 'object') {
    if (typeof node.operation === 'string') return operation(node, scope, depth + 1);
    const o = {};
    for (const [k, v] of Object.entries(node)) o[k] = evaluate(v, scope, depth + 1);
    return o;
  }
  return toValue(node);
}

function operation(node, scope, depth) {
  const op = ALIASES[node.operation] || node.operation;
  const ev = (n) => evaluate(n, scope, depth);
  const fn = OPS[op];
  if (!fn) throw new LawError('InvalidOperation', `Invalid operation: unknown operation '${node.operation}'`);
  const value = fn(node, ev, scope, depth, op);
  scope.traceOp?.(op, node, value);
  return value;
}

// ---------------------------------------------------------------------------
// Operand helpers
// ---------------------------------------------------------------------------

// Split operands into an unknown (if any) or definite values; null is an error.
function definite(op, values) {
  for (const v of values) if (v === null) throw absentOperand(op);
  const missing = [];
  for (const v of values) {
    const m = deepUnknown(v);
    if (m) missing.push(...m);
  }
  return missing.length ? new Unknown(missing) : null;
}

function num(op, v) {
  if (isDec(v)) return v;
  if (typeof v === 'boolean') return new Dec(v ? 1n : 0n);
  throw typeMismatch(op, 'number', v);
}

function bool(op, v) {
  if (typeof v === 'boolean') return v;
  throw typeMismatch(op, 'boolean', v);
}

function date(op, v) {
  const d = dateOf(v);
  if (d === null) {
    if (typeof v === 'string') throw new LawError('InvalidDate', `Invalid date format: ${op}: '${v}' is not a date in canonical YYYY-MM-DD form`);
    throw typeMismatch(op, 'date', v);
  }
  return d;
}

function int(op, v) {
  const n = num(op, v);
  if (!n.isInteger()) throw typeMismatch(op, 'whole number', v);
  return Number(n.toString());
}

// Structural equality, with numbers compared by value and a date string
// equal to the {iso, ...} form of the same date.
export function equal(a, b) {
  if (a === null || b === null) return a === b;
  if (isDec(a) && isDec(b)) return a.eq(b);
  const da = dateOf(a);
  const db = dateOf(b);
  if (da !== null && db !== null && (typeof a === 'string' || typeof b === 'string')) return da === db;
  if (Array.isArray(a) && Array.isArray(b)) return a.length === b.length && a.every((x, i) => equal(x, b[i]));
  if (isRecord(a) && isRecord(b)) {
    const ka = Object.keys(a);
    const kb = Object.keys(b);
    return ka.length === kb.length && ka.every((k) => k in b && equal(a[k], b[k]));
  }
  return a === b;
}

function compare(op, a, b) {
  const da = dateOf(a);
  const db = dateOf(b);
  if (da !== null && db !== null) return da < db ? -1 : da > db ? 1 : 0;
  if (isDec(a) && isDec(b)) return a.cmp(b);
  if (typeof a === 'string' && typeof b === 'string') {
    throw typeMismatch(op, 'numbers or dates', a);
  }
  return num(op, a).cmp(num(op, b));
}

// The flattened operand list of MIN / MAX / ADD.
function flatten(values) {
  const out = [];
  for (const v of values) {
    if (Array.isArray(v)) out.push(...flatten(v));
    else out.push(v);
  }
  return out;
}

// Combine definite numbers (or strings / arrays for ADD).
function add(op, vals) {
  if (vals.length && vals.every((v) => typeof v === 'string')) return vals.join('');
  if (vals.some((v) => Array.isArray(v))) return flatten(vals);
  let acc = new Dec(0n);
  for (const v of vals) acc = acc.add(num(op, v));
  return acc;
}

function extreme(op, vals, sign) {
  if (vals.length === 0) return null;
  let best = vals[0];
  for (const v of vals.slice(1)) if (compare(op, v, best) * sign > 0) best = v;
  if (dateOf(best) === null) num(op, best);
  return best;
}

// ---------------------------------------------------------------------------
// Operations
// ---------------------------------------------------------------------------

function arithmetic(node, ev, scope, depth, op) {
  const values = (node.values || []).map(ev);
  const u = definite(op, op === 'MIN' || op === 'MAX' || op === 'ADD' ? flatten(values) : values);
  if (u) return u;
  switch (op) {
    case 'ADD':
      return add(op, values);
    case 'SUBTRACT': {
      if (values.length === 0) return new Dec(0n);
      let acc = num(op, values[0]);
      for (const v of values.slice(1)) acc = acc.sub(num(op, v));
      return acc;
    }
    case 'MULTIPLY': {
      let acc = new Dec(1n);
      for (const v of values) acc = acc.mul(num(op, v));
      return acc;
    }
    case 'DIVIDE': {
      if (values.length === 0) throw new LawError('InvalidOperation', 'Invalid operation: DIVIDE needs operands');
      let acc = num(op, values[0]);
      for (const v of values.slice(1)) {
        const d = num(op, v);
        if (d.isZero()) throw new LawError('DivisionByZero', 'Division by zero');
        acc = acc.div(d);
      }
      return acc;
    }
    case 'MIN':
      return extreme(op, flatten(values), -1);
    case 'MAX':
      return extreme(op, flatten(values), 1);
  }
  return null;
}

function comparison(node, ev, scope, depth, op) {
  if (!('value' in node)) throw new LawError('InvalidOperation', `Invalid operation: ${op} needs both 'subject' and 'value'`);
  const s = ev(node.subject);
  const v = ev(node.value);
  if (op === 'EQUALS' || op === 'NOT_EQUALS') {
    const ms = deepUnknown(s);
    const mv = deepUnknown(v);
    if (ms || mv) return new Unknown([...(ms || []), ...(mv || [])]);
    const eq = equal(s, v);
    return op === 'EQUALS' ? eq : !eq;
  }
  const u = definite(op, [s, v]);
  if (u) return u;
  const c = compare(op, s, v);
  switch (op) {
    case 'GREATER_THAN': return c > 0;
    case 'LESS_THAN': return c < 0;
    case 'GREATER_THAN_OR_EQUAL': return c >= 0;
    case 'LESS_THAN_OR_EQUAL': return c <= 0;
  }
  return null;
}

function logical(node, ev, scope, depth, op) {
  const decisive = op === 'OR';
  const missing = [];
  for (const c of node.conditions || []) {
    const v = ev(c);
    if (v === null) throw absentOperand(op);
    if (isUnknown(v)) {
      missing.push(...v.missing);
      continue;
    }
    if (bool(op, v) === decisive) return decisive;
  }
  return missing.length ? new Unknown(missing) : !decisive;
}

function not(node, ev, scope, depth, op) {
  const v = ev(node.value);
  if (v === null) throw absentOperand(op);
  if (isUnknown(v)) return v;
  return !bool(op, v);
}

function nullTest(node, ev, scope, depth, op) {
  const v = ev(node.subject !== undefined ? node.subject : node.value);
  if (isUnknown(v)) return v;
  return op === 'IS_NULL' ? v === null : v !== null;
}

function conditional(node, ev, scope, depth, op) {
  for (const c of node.cases || []) {
    const w = ev(c.when);
    if (w === null) throw absentOperand(op);
    // An unknown condition takes neither its branch nor the default: the
    // branch might have applied.
    if (isUnknown(w)) return w;
    if (bool(op, w)) return ev(c.then);
  }
  return 'default' in node ? ev(node.default) : null;
}

function membership(node, ev, scope, depth, op) {
  const s = ev(node.subject);
  let list;
  if (node.values !== undefined) list = node.values.map(ev);
  else {
    const v = ev(node.value);
    if (isUnknown(v)) return Unknown.of(v, deepUnknown(s) || []);
    list = v === null ? [] : Array.isArray(v) ? v : [v];
  }
  const elemMissing = [];
  for (const el of list) {
    const m = deepUnknown(el);
    if (m) elemMissing.push(...m);
  }
  const ms = deepUnknown(s);
  if (ms) return new Unknown([...ms, ...elemMissing]);
  for (const el of list) if (!deepUnknown(el) && equal(s, el)) return op === 'IN';
  if (elemMissing.length) return new Unknown(elemMissing);
  return op !== 'IN';
}

function list(node, ev) {
  return (node.items || []).map(ev);
}

function foreach(node, ev, scope, depth, op) {
  let coll = ev(node.collection);
  if (isUnknown(coll)) return coll;
  if (coll === null) coll = [];
  else if (!Array.isArray(coll)) coll = [coll];
  if (coll.length > MAX_COLLECTION) {
    throw new LawError('InvalidOperation', `Invalid operation: FOREACH over ${coll.length} elements exceeds the limit of ${MAX_COLLECTION}`);
  }
  const as = node.as || 'item';
  const combine = node.combine;
  const results = [];
  const missing = [];
  let skipped = 0;
  for (const el of coll) {
    // A child scope starts empty: only this element is bound (and, for a
    // record, its fields), so one iteration cannot leak into the next and
    // an outer binding reaches an inner iteration only through `collection`.
    const locals = new Map();
    if (isRecord(el)) for (const [k, v] of Object.entries(el)) locals.set(k, v);
    locals.set(as, el);
    const child = scope.withLocals(locals);
    if (node.filter !== undefined) {
      const f = evaluate(node.filter, child, depth + 1);
      if (f === null) throw absentOperand(`${op} filter`);
      if (isUnknown(f)) {
        missing.push(...f.missing);
        continue;
      }
      if (!bool(`${op} filter`, f)) {
        skipped++;
        continue;
      }
    }
    results.push(evaluate(node.body, child, depth + 1));
  }
  scope.traceForeach?.(coll.length, skipped);
  if (!combine) return missing.length ? new Unknown(missing) : results;
  if (combine === 'AND' || combine === 'OR') {
    const decisive = combine === 'OR';
    for (const r of results) {
      if (r === null) throw absentOperand(`${op} ${combine}`);
      if (isUnknown(r)) missing.push(...r.missing);
      else if (bool(`${op} ${combine}`, r) === decisive) return decisive;
    }
    return missing.length ? new Unknown(missing) : !decisive;
  }
  for (const r of results) if (r === null) throw absentOperand(`${op} ${combine}`);
  for (const r of results) {
    const m = deepUnknown(r);
    if (m) missing.push(...m);
  }
  if (missing.length) return new Unknown(missing);
  switch (combine) {
    case 'ADD': return results.length ? add(`${op} ADD`, results) : new Dec(0n);
    case 'MIN': return extreme(`${op} MIN`, results, -1);
    case 'MAX': return extreme(`${op} MAX`, results, 1);
  }
  throw new LawError('InvalidOperation', `Invalid operation: unknown FOREACH combine '${combine}'`);
}

function rounding(node, ev, scope, depth, op) {
  const v = ev(node.value);
  const p = node.precision === undefined ? new Dec(0n) : ev(node.precision);
  const u = definite(op, [v, p]);
  if (u) return u;
  const mode = op === 'ROUND' ? 'half_up' : op === 'CEIL' ? 'ceil' : 'floor';
  return num(op, v).round(int(op, p), mode);
}

function age(node, ev, scope, depth, op) {
  const b = ev(node.date_of_birth);
  const r = ev(node.reference_date);
  const u = definite(op, [b, r]);
  if (u) return u;
  const from = date(op, b);
  const to = date(op, r);
  const months = to >= from ? wholeMonths(from, to) : -wholeMonths(to, from);
  return new Dec(BigInt(Math.trunc(months / 12)));
}

function dateAdd(node, ev, scope, depth, op) {
  const d = ev(node.date);
  const parts = ['years', 'months', 'weeks', 'days'].map((k) => (node[k] === undefined ? new Dec(0n) : ev(node[k])));
  const u = definite(op, [d, ...parts]);
  if (u) return u;
  const [years, months, weeks, days] = parts.map((p) => int(op, p));
  let iso = date(op, d);
  if (years || months) iso = addMonths(iso, years * 12 + months);
  if (weeks || days) iso = fromDayNumber(dayNumber(iso) + weeks * 7 + days);
  return iso;
}

function dateConstruct(node, ev, scope, depth, op) {
  const vals = [ev(node.year), ev(node.month), ev(node.day)];
  const u = definite(op, vals);
  if (u) return u;
  const [y, m, d] = vals.map((v) => int(op, v));
  if (m < 1 || m > 12 || d < 1 || d > daysInMonth(y, m)) {
    throw new LawError('InvalidDate', `Invalid date format: ${op}: ${y}-${m}-${d} is not a calendar date`);
  }
  return fmtDate(y, m, d);
}

function dayOfWeek(node, ev, scope, depth, op) {
  const d = ev(node.date);
  const u = definite(op, [d]);
  if (u) return u;
  const n = dayNumber(date(op, d)); // day 0 = 1970-01-01, a Thursday
  return new Dec(BigInt((((n + 3) % 7) + 7) % 7)); // 0 = Monday
}

function dateDiff(node, ev, scope, depth, op) {
  const f = ev(node.from);
  const t = ev(node.to);
  const unit = typeof node.in === 'string' && node.in.startsWith('$') ? ev(node.in) : node.in;
  const u = definite(op, [f, t, unit]);
  if (u) return u;
  const from = date(op, f);
  const to = date(op, t);
  switch (unit) {
    case 'days':
      return new Dec(BigInt(dayNumber(to) - dayNumber(from)));
    case 'months':
    case 'years': {
      const months = to >= from ? wholeMonths(from, to) : -wholeMonths(to, from);
      return new Dec(BigInt(unit === 'months' ? months : Math.trunc(months / 12)));
    }
  }
  throw new LawError('InvalidOperation', `Invalid operation: ${op} 'in' must be one of days, months, years; got '${unit}'`);
}

function datePart(node, ev, scope, depth, op) {
  const d = ev(node.date);
  const u = definite(op, [d]);
  if (u) return u;
  const [y, m, day] = ymd(date(op, d));
  const part = { year: y, month: m, day }[node.in];
  if (part === undefined) {
    throw new LawError('InvalidOperation', `Invalid operation: ${op} 'in' must be one of year, month, day; got '${node.in}'`);
  }
  return new Dec(BigInt(part));
}

function startOf(node, ev, scope, depth, op) {
  const d = ev(node.date);
  const u = definite(op, [d]);
  if (u) return u;
  const [y, m] = ymd(date(op, d));
  if (node.in === 'year') return fmtDate(y, 1, 1);
  if (node.in === 'month') return fmtDate(y, m, 1);
  throw new LawError('InvalidOperation', `Invalid operation: ${op} 'in' must be one of year, month; got '${node.in}'`);
}

const OPS = {
  ADD: arithmetic,
  SUBTRACT: arithmetic,
  MULTIPLY: arithmetic,
  DIVIDE: arithmetic,
  MIN: arithmetic,
  MAX: arithmetic,
  EQUALS: comparison,
  NOT_EQUALS: comparison,
  GREATER_THAN: comparison,
  LESS_THAN: comparison,
  GREATER_THAN_OR_EQUAL: comparison,
  LESS_THAN_OR_EQUAL: comparison,
  AND: logical,
  OR: logical,
  NOT: not,
  IS_NULL: nullTest,
  NOT_NULL: nullTest,
  IF: conditional,
  IN: membership,
  NOT_IN: membership,
  LIST: list,
  FOREACH: foreach,
  ROUND: rounding,
  CEIL: rounding,
  FLOOR: rounding,
  AGE: age,
  DATE_ADD: dateAdd,
  DATE: dateConstruct,
  DAY_OF_WEEK: dayOfWeek,
  DATE_DIFF: dateDiff,
  DATE_PART: datePart,
  START_OF: startOf,
};

export const OPERATIONS = Object.keys(OPS).filter((k) => !['NOT_EQUALS', 'IS_NULL', 'NOT_NULL', 'NOT_IN'].includes(k));
export { isIsoDate };
