// Golden cases from regelrecht (generated from its earlier Python engine):
// a law, parameters, a date and the expected outputs or failure.

import { test } from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Engine } from '../src/engine.js';
import { toPlain } from '../src/values.js';

const dir = path.join(path.dirname(fileURLToPath(import.meta.url)), '..', 'conformance', 'regelrecht', 'fixtures');

function close(a, b) {
  if (typeof a === 'number' && typeof b === 'number') return Math.abs(a - b) < 1e-9;
  return JSON.stringify(a) === JSON.stringify(b);
}

for (const file of fs.readdirSync(dir).filter((f) => f.endsWith('.json')).sort()) {
  const suite = JSON.parse(fs.readFileSync(path.join(dir, file), 'utf8'));
  for (const tc of suite.test_cases) {
    test(`${file}: ${tc.id} — ${tc.description}`, { skip: tc.generator_error ? 'generator error' : false }, () => {
      const engine = new Engine();
      if (tc.law_yaml) engine.loadLaw(tc.law_yaml);
      for (const l of tc.laws || []) engine.loadLaw(l.yaml);
      const run = () => engine.evaluate(tc.law_id, [tc.output_name], tc.parameters || {}, tc.calculation_date);
      if (!tc.expected.success) {
        assert.throws(run, (e) => !tc.expected.error_type || e.kind === tc.expected.error_type);
        return;
      }
      const result = run();
      for (const [name, want] of Object.entries(tc.expected.outputs || {})) {
        const got = toPlain(result.outputs[name]);
        assert.ok(close(got, want), `${name}: got ${JSON.stringify(got)}, expected ${JSON.stringify(want)}`);
      }
      if (tc.expected.article_number) {
        assert.equal(result.trace[0].article, String(tc.expected.article_number));
      }
    });
  }
}
