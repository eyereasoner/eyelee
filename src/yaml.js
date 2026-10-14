// A small, dependency-free YAML reader for rulework files.
//
// It covers the part of YAML that law files use: block mappings and
// sequences (including a sequence at the same indentation as its key),
// plain, single- and double-quoted scalars (also across lines), literal and
// folded block scalars with chomping indicators, flow collections, comments
// and document markers. Scalars resolve by the YAML 1.2 core schema: null,
// booleans, integers and floats; everything else, dates included, stays text.

export function parseYaml(text) {
  return new YamlReader(text).document();
}

class YamlError extends Error {}

class YamlReader {
  constructor(text) {
    this.lines = String(text).replace(/^﻿/, '').replace(/\r\n?/g, '\n').split('\n');
    this.i = 0;
    this.anchors = new Map();
  }

  // Split a leading `&anchor` / `!tag` off a value; returns [anchor, rest].
  props(s) {
    let anchor = null;
    let rest = s.trim();
    for (;;) {
      const m = /^([!&])([^\s]*)(\s+|$)/.exec(rest);
      if (!m) break;
      if (m[1] === '&') anchor = m[2];
      rest = rest.slice(m[0].length);
    }
    return [anchor, rest];
  }

  alias(rest) {
    const name = rest.slice(1).trim();
    if (!this.anchors.has(name)) this.fail(`unknown alias *${name}`);
    return this.anchors.get(name);
  }

  fail(msg) {
    throw new YamlError(`YAML line ${this.i + 1}: ${msg}`);
  }

  document() {
    this.skipBlank();
    if (this.i < this.lines.length && /^---(\s|$)/.test(this.lines[this.i])) {
      const rest = this.lines[this.i].slice(3).trim();
      if (rest && !rest.startsWith('#')) this.lines[this.i] = '    ' + rest;
      else this.i++;
    }
    const value = this.node(-1);
    this.skipBlank();
    if (this.i < this.lines.length && !/^(\.\.\.|---)(\s|$)/.test(this.lines[this.i])) {
      this.fail(`unexpected content: ${this.lines[this.i].trim()}`);
    }
    return value === undefined ? null : value;
  }

  // Skip empty and comment-only lines.
  skipBlank() {
    while (this.i < this.lines.length) {
      const t = this.lines[this.i].trim();
      if (t === '' || t.startsWith('#')) this.i++;
      else break;
    }
  }

  // Parse the node that starts at the next content line, provided it is
  // indented more than `parent`.
  node(parent) {
    this.skipBlank();
    if (this.i >= this.lines.length) return undefined;
    const line = this.lines[this.i];
    if (/^(---|\.\.\.)(\s|$)/.test(line)) return undefined;
    const ind = indentOf(line);
    if (ind <= parent) return undefined;
    const t = line.slice(ind);
    if (t === '-' || t.startsWith('- ')) return this.sequence(ind);
    if (keySplit(t)) return this.mapping(ind);
    return this.scalarLines(ind, parent);
  }

  sequence(ind) {
    const out = [];
    for (;;) {
      this.skipBlank();
      if (this.i >= this.lines.length) break;
      const line = this.lines[this.i];
      if (indentOf(line) !== ind) break;
      const t = line.slice(ind);
      if (!(t === '-' || t.startsWith('- '))) break;
      const rest = t.slice(1).trimStart();
      if (rest === '' || rest.startsWith('#')) {
        this.i++;
        const v = this.node(ind);
        out.push(v === undefined ? null : v);
      } else {
        // Re-read the item content as if it stood on its own at its column.
        const col = ind + 1 + (t.length - 1 - rest.length);
        this.lines[this.i] = ' '.repeat(col) + rest;
        const v = this.node(ind);
        out.push(v === undefined ? null : v);
      }
    }
    return out;
  }

  mapping(ind) {
    const out = {};
    for (;;) {
      this.skipBlank();
      if (this.i >= this.lines.length) break;
      const line = this.lines[this.i];
      if (/^(---|\.\.\.)(\s|$)/.test(line)) break;
      if (indentOf(line) !== ind) break;
      const t = line.slice(ind);
      if (t === '-' || t.startsWith('- ')) break;
      const kv = keySplit(t);
      if (!kv) this.fail(`expected a mapping key: ${t}`);
      const key = kv.key;
      const [anchor, rest] = this.props(kv.rest);
      let value;
      if (rest.startsWith('*')) {
        this.i++;
        value = this.alias(stripComment(rest));
      } else if (rest === '' || rest.startsWith('#')) {
        this.i++;
        this.skipBlank();
        let v;
        if (this.i < this.lines.length) {
          const nl = this.lines[this.i];
          const nt = nl.slice(indentOf(nl));
          // A block sequence may sit at the same indentation as its key.
          if (indentOf(nl) === ind && (nt === '-' || nt.startsWith('- '))) v = this.sequence(ind);
          else v = this.node(ind);
        }
        value = v === undefined ? null : v;
      } else {
        value = this.inlineValue(rest, ind);
      }
      if (anchor) this.anchors.set(anchor, value);
      if (key === '<<' && value && typeof value === 'object') {
        for (const src of Array.isArray(value) ? value : [value]) {
          for (const [k, v] of Object.entries(src)) if (!(k in out)) out[k] = v;
        }
      } else out[key] = value;
    }
    return out;
  }

  // A value that starts on the same line as its key (or dash).
  inlineValue(rest, ind) {
    const c = rest[0];
    if (c === '|' || c === '>') {
      this.i++;
      return this.blockScalar(rest, ind);
    }
    if (c === '[' || c === '{') return this.flowLines(rest);
    if (c === '"' || c === "'") return this.quotedLines(rest, ind);
    // Plain scalar, possibly continued on more-indented lines.
    this.i++;
    let text = stripComment(rest);
    if (!/\s#/.test(rest)) text = this.plainContinuation(text, ind);
    return resolvePlain(text);
  }

  // A scalar that is a node by itself (e.g. a sequence item `- text`).
  scalarLines(ind, parent) {
    const line = this.lines[this.i];
    const [anchor, t] = this.props(line.slice(ind));
    if (anchor) {
      let v;
      if (t === '' || t.startsWith('#')) {
        this.i++;
        v = this.node(parent);
      } else {
        this.lines[this.i] = ' '.repeat(ind) + t;
        v = this.node(parent);
      }
      v = v === undefined ? null : v;
      this.anchors.set(anchor, v);
      return v;
    }
    if (t.startsWith('*')) {
      this.i++;
      return this.alias(stripComment(t));
    }
    const c = t[0];
    if (c === '|' || c === '>') {
      this.i++;
      return this.blockScalar(t, parent);
    }
    if (c === '[' || c === '{') return this.flowLines(t);
    if (c === '"' || c === "'") return this.quotedLines(t, parent);
    this.i++;
    let text = stripComment(t);
    if (!/\s#/.test(t)) text = this.plainContinuation(text, parent);
    return resolvePlain(text);
  }

  plainContinuation(text, ind) {
    let result = text;
    let pendingBreaks = 0;
    while (this.i < this.lines.length) {
      const line = this.lines[this.i];
      const t = line.trim();
      if (t === '') {
        pendingBreaks++;
        this.i++;
        continue;
      }
      if (indentOf(line) <= ind || t.startsWith('#')) break;
      if (keySplit(t) || t === '-' || t.startsWith('- ')) break;
      result += pendingBreaks ? '\n'.repeat(pendingBreaks) : ' ';
      pendingBreaks = 0;
      result += stripComment(t);
      this.i++;
      if (/\s#/.test(t)) break;
    }
    if (pendingBreaks) {
      // Blank lines after the scalar belong to no one; step back over them.
      this.i -= pendingBreaks;
    }
    return result;
  }

  quotedLines(first, ind) {
    const q = first[0];
    let buf = first;
    let start = this.i;
    for (;;) {
      const end = findQuoteEnd(buf, q);
      if (end >= 0) {
        const after = buf.slice(end + 1).trim();
        if (after.startsWith(':')) this.fail('quoted mapping key in value position');
        this.i++;
        return q === "'" ? foldQuoted(buf.slice(1, end), false) : foldQuoted(buf.slice(1, end), true);
      }
      this.i++;
      if (this.i >= this.lines.length) {
        this.i = start;
        this.fail('unterminated quoted scalar');
      }
      buf += '\n' + this.lines[this.i];
    }
  }

  flowLines(first) {
    let buf = first;
    const start = this.i;
    for (;;) {
      const end = flowEnd(buf);
      if (end >= 0) {
        this.i++;
        const p = new FlowParser(buf.slice(0, end + 1));
        const v = p.value();
        return v;
      }
      this.i++;
      if (this.i >= this.lines.length) {
        this.i = start;
        this.fail('unterminated flow collection');
      }
      buf += '\n' + stripComment(this.lines[this.i].trim());
    }
  }

  blockScalar(header, parentIndent) {
    const m = /^([|>])([+-]?)(\d?)([+-]?)\s*(#.*)?$/.exec(header.trim());
    if (!m) this.fail(`bad block scalar header: ${header}`);
    const literal = m[1] === '|';
    const chomp = m[2] || m[4] || '';
    const explicit = m[3] ? parseInt(m[3], 10) : 0;
    let blockIndent = explicit ? Math.max(parentIndent, 0) + explicit : -1;
    const raw = [];
    while (this.i < this.lines.length) {
      const line = this.lines[this.i];
      if (line.trim() === '') {
        raw.push('');
        this.i++;
        continue;
      }
      const ind = indentOf(line);
      if (blockIndent < 0) {
        if (ind <= parentIndent) break;
        blockIndent = ind;
      }
      if (ind < blockIndent) break;
      raw.push(line.slice(blockIndent));
      this.i++;
    }
    // Trailing blank lines are part of the chomping decision, not content.
    let trailing = 0;
    while (raw.length && raw[raw.length - 1] === '') {
      raw.pop();
      trailing++;
    }
    let body;
    if (literal) {
      body = raw.join('\n');
    } else {
      body = '';
      let prevMore = false;
      for (let k = 0; k < raw.length; k++) {
        const l = raw[k];
        const more = l.startsWith(' ') || l.startsWith('\t');
        if (k === 0) body = l;
        else if (l === '') body += '\n';
        else if (raw[k - 1] === '') body += (more || prevMore ? '\n' : '') + l;
        else body += (more || prevMore ? '\n' : ' ') + l;
        if (l !== '') prevMore = more;
      }
    }
    if (raw.length === 0) return chomp === '+' ? '\n'.repeat(trailing) : '';
    if (chomp === '-') return body;
    if (chomp === '+') return body + '\n' + '\n'.repeat(trailing);
    return body + '\n';
  }
}

function indentOf(line) {
  let n = 0;
  while (n < line.length && line[n] === ' ') n++;
  return n;
}

function stripComment(s) {
  const m = /(^|\s)#/.exec(s);
  return (m ? s.slice(0, m.index) : s).trim();
}

// Split `key: rest` when the line is a mapping entry. Returns null otherwise.
function keySplit(t) {
  if (t.startsWith('#')) return null;
  let key;
  let pos;
  if (t[0] === '"' || t[0] === "'") {
    const end = findQuoteEnd(t, t[0]);
    if (end < 0) return null;
    const after = t.slice(end + 1);
    const m = /^\s*:(\s|$)/.exec(after);
    if (!m) return null;
    key = foldQuoted(t.slice(1, end), t[0] === '"');
    pos = end + 1 + m[0].length;
    return { key, rest: t.slice(pos).trim() };
  }
  if (t[0] === '[' || t[0] === '{') return null;
  const m = /:(\s|$)/.exec(t);
  if (!m) return null;
  key = t.slice(0, m.index).trim();
  if (key === '' || /\s#/.test(key)) return null;
  return { key, rest: t.slice(m.index + 1).trim() };
}

function findQuoteEnd(s, q) {
  for (let k = 1; k < s.length; k++) {
    const c = s[k];
    if (q === '"' && c === '\\') {
      k++;
      continue;
    }
    if (c === q) {
      if (q === "'" && s[k + 1] === "'") {
        k++;
        continue;
      }
      return k;
    }
  }
  return -1;
}

// Fold the line breaks of a quoted scalar and process its escapes.
function foldQuoted(body, double) {
  const parts = body.split('\n');
  let out = '';
  for (let k = 0; k < parts.length; k++) {
    let p = parts[k];
    if (k > 0) p = p.trimStart();
    if (k < parts.length - 1) p = p.trimEnd();
    if (k === 0) out = p;
    else if (p === '' && k < parts.length - 1) out += '\n';
    else out += (out.endsWith('\n') ? '' : ' ') + p;
  }
  if (!double) return out.replace(/''/g, "'");
  return out.replace(/\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|U[0-9a-fA-F]{8}|.)/g, (_, e) => {
    switch (e[0]) {
      case 'n': return '\n';
      case 't': return '\t';
      case 'r': return '\r';
      case '0': return '\0';
      case '"': return '"';
      case '\\': return '\\';
      case '/': return '/';
      case ' ': return ' ';
      case 'x': case 'u': case 'U': return String.fromCodePoint(parseInt(e.slice(1), 16));
      default: return e;
    }
  });
}

// Index of the bracket that closes the flow collection opening at 0, or -1.
function flowEnd(s) {
  let depth = 0;
  for (let k = 0; k < s.length; k++) {
    const c = s[k];
    if (c === '"' || c === "'") {
      const end = findQuoteEnd(s.slice(k), c);
      if (end < 0) return -1;
      k += end;
    } else if (c === '[' || c === '{') depth++;
    else if (c === ']' || c === '}') {
      depth--;
      if (depth === 0) return k;
    } else if (c === '#' && (k === 0 || /\s/.test(s[k - 1]))) {
      const nl = s.indexOf('\n', k);
      if (nl < 0) return -1;
      k = nl;
    }
  }
  return -1;
}

class FlowParser {
  constructor(s) {
    this.s = s;
    this.p = 0;
  }

  ws() {
    while (this.p < this.s.length && /\s/.test(this.s[this.p])) this.p++;
  }

  value() {
    this.ws();
    const c = this.s[this.p];
    if (c === '[') return this.seq();
    if (c === '{') return this.map();
    if (c === '"' || c === "'") {
      const end = findQuoteEnd(this.s.slice(this.p), c);
      const v = foldQuoted(this.s.slice(this.p + 1, this.p + end), c === '"');
      this.p += end + 1;
      return v;
    }
    const start = this.p;
    while (this.p < this.s.length) {
      const ch = this.s[this.p];
      if (ch === ',' || ch === ']' || ch === '}') break;
      if (ch === ':' && /[\s,\]}]/.test(this.s[this.p + 1] || ' ')) break;
      this.p++;
    }
    return resolvePlain(this.s.slice(start, this.p).replace(/\s+/g, ' ').trim());
  }

  seq() {
    this.p++;
    const out = [];
    for (;;) {
      this.ws();
      if (this.s[this.p] === ']') {
        this.p++;
        return out;
      }
      const v = this.value();
      this.ws();
      if (this.s[this.p] === ':') {
        // single-pair mapping inside a sequence
        this.p++;
        out.push({ [String(v)]: this.value() });
        this.ws();
      } else out.push(v);
      if (this.s[this.p] === ',') this.p++;
      else if (this.s[this.p] !== ']') throw new YamlError(`flow sequence: unexpected '${this.s[this.p]}'`);
    }
  }

  map() {
    this.p++;
    const out = {};
    for (;;) {
      this.ws();
      if (this.s[this.p] === '}') {
        this.p++;
        return out;
      }
      const k = this.value();
      this.ws();
      let v = null;
      if (this.s[this.p] === ':') {
        this.p++;
        this.ws();
        v = this.s[this.p] === ',' || this.s[this.p] === '}' ? null : this.value();
      }
      out[String(k)] = v;
      this.ws();
      if (this.s[this.p] === ',') this.p++;
      else if (this.s[this.p] !== '}') throw new YamlError(`flow mapping: unexpected '${this.s[this.p]}'`);
    }
  }
}

function resolvePlain(t) {
  if (t === '' || t === '~' || t === 'null' || t === 'Null' || t === 'NULL') return null;
  if (t === 'true' || t === 'True' || t === 'TRUE') return true;
  if (t === 'false' || t === 'False' || t === 'FALSE') return false;
  if (/^[-+]?[0-9]+$/.test(t)) {
    const n = Number(t);
    return Number.isSafeInteger(n) ? n : t;
  }
  if (/^0x[0-9a-fA-F]+$/.test(t)) return parseInt(t, 16);
  if (/^[-+]?(\.[0-9]+|[0-9]+(\.[0-9]*)?)([eE][-+]?[0-9]+)?$/.test(t)) return Number(t);
  if (/^[-+]?\.(inf|Inf|INF)$/.test(t)) return t.startsWith('-') ? -Infinity : Infinity;
  if (/^\.(nan|NaN|NAN)$/.test(t)) return NaN;
  return t;
}
