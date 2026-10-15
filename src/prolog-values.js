// Values shared by Prolog ruleworks, the reasoner, and the domain boundary.
import { Dec } from './decimal.js';
import { Unknown } from './values.js';

export const atom = value => ({ atom: value });
export const compound = (functor, ...args) => ({ functor, args });
export const predicate = (name, ...terms) => ({ relation: `predicate:${name}/${terms.length}`, terms });
export const text = value => ({ text: value });
export const integer = value => BigInt(value).toString();

export class Expression {
  constructor(id, program = null, bindings = []) {
    this.id = id;
    this.program = program;
    this.bindings = bindings;
  }
}

export function toTerm(value) {
  if (value instanceof Expression) return compound('expression', text(value.id));
  if (value === null || value === undefined) return atom('null');
  if (typeof value === 'boolean') return atom(value ? 'true' : 'false');
  if (value instanceof Dec || typeof value === 'number' || typeof value === 'bigint') {
    const n = Dec.from(value);
    return compound('decimal', integer(n.m), integer(n.s));
  }
  if (value instanceof Unknown) return compound('unknown', { list: value.missing.map(text) });
  if (typeof value === 'string') return text(value);
  if (Array.isArray(value)) return { list: value.map(toTerm) };
  if (typeof value === 'object') return compound('record', { list: Object.entries(value).map(([key, item]) => compound('field', text(key), toTerm(item))) });
  throw new Error(`Cannot encode a Prolog value of type ${typeof value}.`);
}

export function fromTerm(value, program = null, metadata = false) {
  if (typeof value === 'string') return metadata && Number.isSafeInteger(Number(value)) ? Number(value) : new Dec(BigInt(value));
  if (value.real !== undefined) throw new Error('Ruleworks use decimal(Mantissa, Scale), never binary64 real literals.');
  if (value.text !== undefined) return value.text;
  if (value.atom !== undefined) {
    if (value.atom === 'true') return true;
    if (value.atom === 'false') return false;
    if (value.atom === 'null') return null;
    return value.atom;
  }
  if (value.list) {
    if (value.tail) throw new Error('A rulework data value must be a closed list.');
    return value.list.map(item => fromTerm(item, program, metadata));
  }
  if (value.functor === 'decimal' && value.args.length === 2) {
    if (!value.args.every(arg => typeof arg === 'string' && /^-?\d+$/.test(arg)) || !Number.isSafeInteger(Number(value.args[1])) || Number(value.args[1]) < 0) throw new Error('decimal/2 needs an integer mantissa and a nonnegative safe integer scale.');
    const result = new Dec(BigInt(value.args[0]), Number(value.args[1]));
    return metadata ? result.toNumber() : result;
  }
  if (value.functor === 'unknown' && value.args.length === 1) return new Unknown(fromTerm(value.args[0]));
  if (value.functor === 'expression' && value.args.length === 1) return new Expression(fromTerm(value.args[0]), program);
  if (value.functor === 'record' && value.args.length === 1) {
    const result = {};
    for (const field of value.args[0].list || []) {
      if (field.functor !== 'field' || field.args.length !== 2) throw new Error('A record needs field(Name, Value) entries.');
      const key = fromTerm(field.args[0]);
      if (typeof key !== 'string') throw new Error('A record field name must be text.');
      Object.defineProperty(result, key, { value: fromTerm(field.args[1], program, metadata), enumerable: true, configurable: true, writable: true });
    }
    return result;
  }
  throw new Error(`Unsupported rulework value: ${value.functor || 'variable'}.`);
}

export function termSource(value) {
  if (typeof value === 'string') return value;
  if (value.text !== undefined) return JSON.stringify(value.text);
  if (value.atom !== undefined) return /^[a-z][A-Za-z0-9_]*$/.test(value.atom) ? value.atom : `'${value.atom.replaceAll('\\', '\\\\').replaceAll("'", "''")}'`;
  if (value.variable) return value.variable;
  if (value.list) return `[${value.list.map(termSource).join(', ')}]`;
  return `${value.functor}(${value.args.map(termSource).join(', ')})`;
}
