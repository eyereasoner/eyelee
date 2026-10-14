// The value model of executable law.
//
// A value is one of: null (absent: the register says there is none), a
// boolean, a string (dates are ISO 'YYYY-MM-DD' strings), a Dec (exact
// number), an array, a plain object (a record), or an Unknown: a fact nobody
// has yet, carrying the names of the missing facts so a caller can ask for
// exactly those.

import { Dec } from './decimal.js';

export class Unknown {
  constructor(missing) {
    this.missing = [...new Set(missing)];
  }

  static of(...sources) {
    const names = [];
    for (const s of sources) {
      if (s instanceof Unknown) names.push(...s.missing);
      else if (Array.isArray(s)) names.push(...s);
      else if (typeof s === 'string') names.push(s);
    }
    return new Unknown(names);
  }

  toString() {
    return `unknown (for lack of ${this.missing.join(', ')})`;
  }

  toJSON() {
    return { unknown: this.missing };
  }
}

export const isUnknown = (v) => v instanceof Unknown;
export const isDec = (v) => v instanceof Dec;
export const isRecord = (v) => v !== null && typeof v === 'object' && !Array.isArray(v) && !(v instanceof Dec) && !(v instanceof Unknown);

// Every missing fact anywhere inside a value (a list holding an unknown is
// not a definite list). Returns null when the value is fully known.
export function deepUnknown(v) {
  if (v instanceof Unknown) return v.missing;
  let names = null;
  const visit = (x) => {
    const m = deepUnknown(x);
    if (m) names = (names || []).concat(m);
  };
  if (Array.isArray(v)) v.forEach(visit);
  else if (isRecord(v)) Object.values(v).forEach(visit);
  return names;
}

// Convert parsed YAML / JSON data into engine values.
export function toValue(x) {
  if (x === null || x === undefined) return null;
  if (x instanceof Dec || x instanceof Unknown) return x;
  if (typeof x === 'number') return Dec.from(x);
  if (typeof x === 'bigint') return Dec.from(x);
  if (Array.isArray(x)) return x.map(toValue);
  if (typeof x === 'object') {
    const o = {};
    for (const [k, v] of Object.entries(x)) o[k] = toValue(v);
    return o;
  }
  return x;
}

// Convert an engine value into plain JSON data.
export function toPlain(v) {
  if (v instanceof Dec) return v.toNumber();
  if (v instanceof Unknown) return { unknown: v.missing };
  if (Array.isArray(v)) return v.map(toPlain);
  if (isRecord(v)) {
    const o = {};
    for (const [k, x] of Object.entries(v)) o[k] = toPlain(x);
    return o;
  }
  return v;
}

// A compact human-readable rendering, used in explanations.
export function show(v) {
  if (v === null) return 'absent';
  if (v === undefined) return 'undefined';
  if (v instanceof Dec) return v.toString();
  if (v instanceof Unknown) return v.toString();
  if (typeof v === 'string') return JSON.stringify(v);
  if (Array.isArray(v)) return '[' + v.map(show).join(', ') + ']';
  if (isRecord(v)) return '{' + Object.entries(v).map(([k, x]) => `${k}: ${show(x)}`).join(', ') + '}';
  return String(v);
}

// ---------------------------------------------------------------------------
// Dates
// ---------------------------------------------------------------------------

const ISO = /^(\d{4})-(\d{2})-(\d{2})$/;

export function isIsoDate(s) {
  if (typeof s !== 'string') return false;
  const m = ISO.exec(s);
  if (!m) return false;
  const [y, mo, d] = [+m[1], +m[2], +m[3]];
  return mo >= 1 && mo <= 12 && d >= 1 && d <= daysInMonth(y, mo);
}

// A date operand: an ISO string or the {iso, year, month, day} object form.
export function dateOf(v) {
  if (typeof v === 'string' && isIsoDate(v)) return v;
  if (isRecord(v) && typeof v.iso === 'string' && isIsoDate(v.iso)) return v.iso;
  return null;
}

export function ymd(iso) {
  const m = ISO.exec(iso);
  return [+m[1], +m[2], +m[3]];
}

export function fmtDate(y, m, d) {
  if (y < 0 || y > 9999) throw new Error(`Invalid date format: year ${y} out of range`);
  return `${String(y).padStart(4, '0')}-${String(m).padStart(2, '0')}-${String(d).padStart(2, '0')}`;
}

export function daysInMonth(y, m) {
  return [31, isLeap(y) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][m - 1];
}

function isLeap(y) {
  return (y % 4 === 0 && y % 100 !== 0) || y % 400 === 0;
}

export function dayNumber(iso) {
  const [y, m, d] = ymd(iso);
  return Math.round(Date.UTC(y, m - 1, d) / 86400000);
}

export function fromDayNumber(n) {
  const dt = new Date(n * 86400000);
  return fmtDate(dt.getUTCFullYear(), dt.getUTCMonth() + 1, dt.getUTCDate());
}

// Add months with the Dutch "corresponding numbered day" rule: the day is
// clamped to the last day of the target month (31 January + 1 month = 28/29
// February).
export function addMonths(iso, n) {
  const [y, m, d] = ymd(iso);
  const total = y * 12 + (m - 1) + n;
  const ny = Math.floor(total / 12);
  const nm = (total % 12 + 12) % 12 + 1;
  return fmtDate(ny, nm, Math.min(d, daysInMonth(ny, nm)));
}

// Complete calendar months from `from` to `to` (to >= from), using the same
// clamping as addMonths: 31 January to 28 February is one whole month.
export function wholeMonths(from, to) {
  const [fy, fm] = ymd(from);
  const [ty, tm] = ymd(to);
  let n = (ty - fy) * 12 + (tm - fm);
  while (n > 0 && addMonths(from, n) > to) n--;
  return n;
}

export function referenceDate(iso) {
  const [y, m, d] = ymd(iso);
  return { iso, year: new Dec(BigInt(y)), month: new Dec(BigInt(m)), day: new Dec(BigInt(d)) };
}
