// Rendering an evaluation as Answer, Reason and Check.
//
// The Reason is the derivation tree the engine kept: which article of which
// version decided each output, where every input came from (the caller, a
// register, another law), which regulation filled an open term, which hooks
// fired and which override replaced a value.

import { show } from './values.js';

export function renderAnswer(result) {
  const lines = [];
  for (const [name, value] of Object.entries(result.outputs)) {
    const tags = [];
    if (result.provenance[name] && result.provenance[name] !== 'direct') tags.push(result.provenance[name]);
    if (result.tainted.includes(name)) tags.push('tainted as untranslatable');
    lines.push(`${name} = ${show(value)}${tags.length ? `  (${tags.join(', ')})` : ''}`);
  }
  for (const [name, v] of Object.entries(result.voided)) {
    lines.push(`${name} does not arise: ${v.grounds} (${v.law} article ${v.article})`);
  }
  return lines;
}

export function renderReason(result) {
  const lines = [];
  const seen = new Set();
  for (const node of result.trace) article(node, 0, lines, seen);
  return lines;
}

function where(node) {
  return `${node.law}${node.version ? ` (${node.version})` : ''} article ${node.article}`;
}

function article(node, depth, lines, seen) {
  const pad = '  '.repeat(depth);
  const id = `${node.law}|${node.version}|${node.article}|${JSON.stringify(node.params.map((p) => [p.name, show(p.value)]))}`;
  const outs = node.outputs.filter((o) => !o.voided).map((o) => `${o.name} = ${show(o.value)}`).join(', ');
  lines.push(`${pad}${where(node)} gives ${outs || 'nothing'}`);
  if (seen.has(id)) {
    lines.push(`${pad}  (derived as shown above)`);
    return;
  }
  seen.add(id);
  for (const p of node.params) {
    lines.push(p.note ? `${pad}  parameter ${p.name} is not passed, so unknown (optional)` : `${pad}  parameter ${p.name} = ${show(p.value)}`);
  }
  for (const i of node.inputs) {
    lines.push(`${pad}  input ${i.name} = ${show(i.value)} from ${i.via}`);
    if (i.child) article(i.child, depth + 2, lines, seen);
  }
  for (const t of node.openTerms) {
    lines.push(`${pad}  open term ${t.id} = ${show(t.value)} ${t.via}`);
    if (t.child) article(t.child, depth + 2, lines, seen);
  }
  for (const h of node.hooks.pre) {
    lines.push(`${pad}  before deciding, hook ${h.law} article ${h.article} fires`);
    article(h.child, depth + 2, lines, seen);
  }
  const calculations = new Set();
  for (const derivation of node.derivations || []) for (const computation of derivation.computations) {
    if (['LIST', 'RECORD'].includes(computation.operation)) continue;
    const text = `${computation.operation}(${computation.operands.map(show).join(', ')}) = ${show(computation.value)}`;
    if (!calculations.has(text)) { lines.push(`${pad}  ${text}`); calculations.add(text); }
  }
  for (const derivation of node.derivations || []) if (derivation.native) {
    const evidence = new Set();
    for (const step of derivation.proof) {
      for (const calculation of step.calculations) if (!evidence.has(calculation)) {
        lines.push(`${pad}  ${calculation}`); evidence.add(calculation);
      }
      if (step.comparison && !step.goal.includes(' is ') && !evidence.has(step.goal)) {
        lines.push(`${pad}  checked ${step.goal}`); evidence.add(step.goal);
      }
    }
  }
  for (const o of node.outputs) {
    if (o.override) {
      lines.push(`${pad}  ${o.name} is overridden by ${o.override.law} article ${o.override.article} (lex specialis)`);
      article(o.override.node, depth + 2, lines, seen);
    }
    if (o.voided) lines.push(`${pad}  ${o.name} does not arise: ${o.voided.grounds} (${o.voided.law} article ${o.voided.article})`);
  }
  for (const h of node.hooks.post) {
    lines.push(`${pad}  after deciding, hook ${h.law} article ${h.article} fires`);
    article(h.child, depth + 2, lines, seen);
  }
  for (const n of node.notes) lines.push(`${pad}  ${n}`);
}

export function renderChecks(result) {
  return result.checks.map((c) => `✓ ${c}`);
}

export function renderArc(result) {
  return [
    '# Answer',
    ...renderAnswer(result),
    '',
    '# Reason',
    ...renderReason(result),
    '',
    '# Check',
    ...renderChecks(result),
  ].join('\n');
}
