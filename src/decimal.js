// Exact decimal arithmetic for law values.
//
// Amounts in law must not drift the way binary floats do, and rounding is only
// ever applied where the law says so. A Dec is mantissa * 10^-scale with a
// BigInt mantissa; addition, subtraction and multiplication are exact, and
// division is carried to DIV_SCALE decimal places.

const DIV_SCALE = 28;

export class Dec {
  constructor(m, s = 0) {
    this.m = m;
    this.s = s;
  }

  static from(x) {
    if (x instanceof Dec) return x;
    if (typeof x === 'bigint') return new Dec(x, 0);
    if (typeof x === 'number') {
      if (!Number.isFinite(x)) throw new Error(`Not a finite number: ${x}`);
      if (Number.isInteger(x) && Math.abs(x) <= Number.MAX_SAFE_INTEGER) return new Dec(BigInt(x), 0);
      return Dec.parse(String(x));
    }
    if (typeof x === 'string') return Dec.parse(x);
    throw new Error(`Cannot convert to decimal: ${x}`);
  }

  static parse(str) {
    const t = String(str).trim();
    const m = /^([+-]?)(\d*)(?:\.(\d*))?(?:[eE]([+-]?\d+))?$/.exec(t);
    if (!m || (m[2] === '' && (m[3] === undefined || m[3] === ''))) return null;
    const sign = m[1] === '-' ? -1n : 1n;
    const intPart = m[2] || '0';
    const frac = m[3] || '';
    let scale = frac.length - (m[4] ? parseInt(m[4], 10) : 0);
    let mant = BigInt(intPart + frac) * sign;
    if (scale < 0) {
      mant *= 10n ** BigInt(-scale);
      scale = 0;
    }
    return new Dec(mant, scale).normalize();
  }

  static isNumericLiteral(str) {
    return /^[+-]?(\d+\.?\d*|\.\d+)([eE][+-]?\d+)?$/.test(String(str).trim());
  }

  normalize() {
    let { m, s } = this;
    while (s > 0 && m % 10n === 0n) {
      m /= 10n;
      s -= 1;
    }
    return new Dec(m, s);
  }

  static align(a, b) {
    if (a.s === b.s) return [a.m, b.m, a.s];
    if (a.s > b.s) return [a.m, b.m * 10n ** BigInt(a.s - b.s), a.s];
    return [a.m * 10n ** BigInt(b.s - a.s), b.m, b.s];
  }

  add(o) {
    const [x, y, s] = Dec.align(this, o);
    return new Dec(x + y, s).normalize();
  }

  sub(o) {
    const [x, y, s] = Dec.align(this, o);
    return new Dec(x - y, s).normalize();
  }

  mul(o) {
    return new Dec(this.m * o.m, this.s + o.s).normalize();
  }

  div(o) {
    if (o.m === 0n) throw new Error('Division by zero');
    // (a / 10^sa) / (b / 10^sb), scaled by 10^K: a * 10^(K + sb - sa) / b.
    const shift = DIV_SCALE + o.s - this.s;
    let num = this.m;
    let den = o.m;
    if (shift >= 0) num *= 10n ** BigInt(shift);
    else den *= 10n ** BigInt(-shift);
    const q = roundDiv(num, den, 'half_up');
    return new Dec(q, DIV_SCALE).normalize();
  }

  neg() {
    return new Dec(-this.m, this.s);
  }

  cmp(o) {
    const [x, y] = Dec.align(this, o);
    return x < y ? -1 : x > y ? 1 : 0;
  }

  eq(o) {
    return this.cmp(o) === 0;
  }

  isZero() {
    return this.m === 0n;
  }

  isInteger() {
    return this.normalize().s <= 0;
  }

  // Round to `precision` decimal places (negative precision rounds to tens,
  // hundreds, ...). mode: half_up (ties away from zero), ceil, floor.
  round(precision, mode) {
    const p = Number(precision);
    if (this.s <= p) return this;
    const drop = BigInt(this.s - p);
    const q = roundDiv(this.m, 10n ** drop, mode);
    if (p >= 0) return new Dec(q, p).normalize();
    return new Dec(q * 10n ** BigInt(-p), 0);
  }

  toNumber() {
    return Number(this.toString());
  }

  toString() {
    const n = this.normalize();
    const neg = n.m < 0n;
    let digits = (neg ? -n.m : n.m).toString();
    if (n.s === 0) return (neg ? '-' : '') + digits;
    if (digits.length <= n.s) digits = '0'.repeat(n.s - digits.length + 1) + digits;
    const i = digits.length - n.s;
    return (neg ? '-' : '') + digits.slice(0, i) + '.' + digits.slice(i);
  }

  toJSON() {
    return this.toNumber();
  }
}

// Integer division of BigInts with an explicit rounding mode.
function roundDiv(num, den, mode) {
  if (den < 0n) {
    num = -num;
    den = -den;
  }
  let q = num / den; // truncates toward zero
  const r = num - q * den;
  if (r === 0n) return q;
  const positive = num > 0n;
  if (mode === 'floor') return positive ? q : q - 1n;
  if (mode === 'ceil') return positive ? q + 1n : q;
  // half_up: ties away from zero
  const twice = (r < 0n ? -r : r) * 2n;
  if (twice >= den) q += positive ? 1n : -1n;
  return q;
}
