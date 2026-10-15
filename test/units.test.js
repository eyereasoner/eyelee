// Unit checks for the parts eyelee builds on: YAML, decimals, dates, the
// two kinds of nothing, and the Answer/Reason/Check command line.

import { test } from 'node:test';
import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { importRuleworkYaml } from '../src/import-yaml.js';
import { parseYaml } from '../src/yaml.js';
import { Dec } from '../src/decimal.js';
import { Engine } from '../src/engine.js';
import { Unknown, toPlain } from '../src/values.js';
import { resolveNote } from '../src/notes.js';

const here = path.dirname(fileURLToPath(import.meta.url));

test('yaml: block structures, scalars and flow collections', () => {
  const doc = parseYaml(`---
# a comment
$id: test
number: '3a'
when: 2025-01-01
items:
- a
- b: 1
  c: [1, 2.5, "x y"]
text: >-
  folded
  text

  para
lit: |
  line 1
  line 2
empty: {}
quoted: "tab\\there"
anchor: &a {k: v}
alias: *a
`);
  assert.deepEqual(doc, {
    $id: 'test',
    number: '3a',
    when: '2025-01-01',
    items: ['a', { b: 1, c: [1, 2.5, 'x y'] }],
    text: 'folded text\npara',
    lit: 'line 1\nline 2\n',
    empty: {},
    quoted: 'tab\there',
    anchor: { k: 'v' },
    alias: { k: 'v' },
  });
});

test('yaml: core schema keeps 5:20 and dates as text', () => {
  assert.deepEqual(parseYaml('a: 5:20\nb: yes\nc: ~\nd: -0.5e1'), { a: '5:20', b: 'yes', c: null, d: -5 });
});

test('decimal: exact arithmetic and explicit rounding', () => {
  assert.equal(Dec.parse('0.1').add(Dec.parse('0.2')).toString(), '0.3');
  assert.equal(Dec.parse('1').div(Dec.parse('3')).mul(Dec.parse('3')).round(10, 'half_up').toString(), '1');
  assert.equal(Dec.parse('2.675').round(2, 'half_up').toString(), '2.68');
  assert.equal(Dec.parse('-2.5').round(0, 'half_up').toString(), '-3');
  assert.equal(Dec.parse('-2.5').round(0, 'floor').toString(), '-3');
  assert.equal(Dec.parse('-2.5').round(0, 'ceil').toString(), '-2');
  assert.equal(Dec.parse('12345').round(-2, 'half_up').toString(), '12300');
});

function law(actions, extra = '') {
  const e = new Engine();
  e.loadLaw(importRuleworkYaml(`$id: t
regulatory_layer: WET
publication_date: '2025-01-01'
articles:
  - number: '1'
    text: test
    machine_readable:
      execution:
${extra}
        output:
          - name: r
            type: number
            nullable: true
        actions:
          - output: r
            value: ${JSON.stringify(actions)}
`));
  return (params = {}) => toPlain(e.evaluate('t', ['r'], params, '2025-01-01').outputs.r);
}

test('dates: clamping, signed differences, ages, weekdays', () => {
  assert.equal(law({ operation: 'DATE_ADD', date: '2024-01-31', months: 1 })(), '2024-02-29');
  assert.equal(law({ operation: 'DATE_ADD', date: '2023-01-31', months: 1 })(), '2023-02-28');
  assert.equal(law({ operation: 'DATE_DIFF', from: '2025-07-01', to: '2025-01-01', in: 'days' })(), -181);
  assert.equal(law({ operation: 'AGE', date_of_birth: '2000-02-29', reference_date: '2021-02-28' })(), 21);
  assert.equal(law({ operation: 'AGE', date_of_birth: '2000-03-01', reference_date: '2021-02-28' })(), 20);
  assert.equal(law({ operation: 'DAY_OF_WEEK', date: '2025-01-06' })(), 0);
  assert.equal(law({ operation: 'DATE', year: 2025, month: 2, day: 28 })(), '2025-02-28');
  assert.throws(() => law({ operation: 'DATE', year: 2025, month: 2, day: 29 })(), /calendar date/);
});

test('unknown propagates and names what is missing; null is refused', () => {
  const params = `        parameters:
          - name: x
            type: number
          - name: y
            type: number
            nullable: true`;
  const add = law({ operation: 'ADD', values: ['$x', 1] }, params);
  assert.deepEqual(add(), { unknown: ['x'] });
  assert.equal(add({ x: 2 }), 3);
  const or = law({ operation: 'OR', conditions: [{ operation: 'GREATER_THAN', subject: '$x', value: 1 }, true] }, params);
  assert.equal(or(), true);
  const sum = law({ operation: 'ADD', values: ['$y', 1] }, params);
  assert.throws(() => sum({ y: null }), /ADD: operand is null/);
});

test('notes: exact, fuzzy and orphaned anchors', () => {
  const articles = [{ number: '2', text: 'heeft de verzekerde recht op een zorgtoeslag ter grootte van het verschil' }];
  assert.equal(resolveNote({ exact: 'recht op een zorgtoeslag' }, articles).matches[0].confidence, 1);
  const fuzzy = resolveNote({ exact: 'aanspraak op een zorgtoeslag', prefix: 'heeft de verzekerde ', suffix: ' ter grootte van dat verschil' }, articles);
  assert.equal(fuzzy.status, 'found');
  assert.ok(fuzzy.matches[0].confidence < 1);
  assert.equal(resolveNote({ exact: 'voorschot op aanvraag' }, articles).status, 'orphaned');
});

test('cli: Answer, Reason and Check', () => {
  const out = execFileSync(process.execPath, [
    path.join(here, '..', 'eyelee.js'),
    path.join(here, '..', 'knowledge', 'regelrecht', 'regulation'),
    '--law', 'vreemdelingenwet_2000', '--output', 'minister_is_bevoegd', '--date', '2026-01-01',
  ], { encoding: 'utf8' });
  assert.match(out, /^# Answer\nminister_is_bevoegd = true/);
  assert.match(out, /bezwaartermijn_weken = 4 {2}\(override\)/);
  assert.match(out, /# Reason\n.*article 14/);
  assert.match(out, /overridden by vreemdelingenwet_2000 article 69/);
  assert.match(out, /# Check\n✓/);
  assert.ok(new Unknown(['a']).missing.includes('a'));
});

test('the playground manifest is up to date', async () => {
  const fs = await import('node:fs');
  const { manifest } = await import('../scripts/manifest.js');
  const onDisk = JSON.parse(fs.readFileSync(path.join(here, '..', 'knowledge', 'manifest.json'), 'utf8'));
  assert.deepEqual(onDisk, manifest(), 'run: node scripts/manifest.js');
});
