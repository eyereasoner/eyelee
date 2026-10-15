// regelrecht's scenario suites, run unchanged against eyelee:
//   bucket B: bdd/conformance (engine conformance, every tier)
//   bucket A: the law-validation scenarios next to the laws in the corpus

import { test } from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Engine } from '../src/engine.js';
import { loadCorpus, walk } from '../src/corpus.js';
import { loadGrammar, runFeature } from '../src/scenarios.js';

const root = path.join(path.dirname(fileURLToPath(import.meta.url)), '..', 'conformance', 'regelrecht');
const engine = new Engine();
const { problems } = loadCorpus(engine, path.join(root, '..', '..', 'knowledge', 'regelrecht', 'regulation'));
const grammar = loadGrammar(fs.readFileSync(path.join(root, '..', '..', 'knowledge', 'regelrecht', 'grammar.pl'), 'utf8'));

test('every rulework in the corpus loads', () => {
  assert.deepEqual(problems, []);
});

const buckets = {
  'engine conformance': walk(path.join(root, 'bdd', 'conformance'), ['.feature']),
  'law validation': walk(path.join(root, 'regulation'), ['.feature']),
};

for (const [bucket, files] of Object.entries(buckets)) {
  for (const file of files) {
    const rel = path.relative(root, file);
    for (const r of runFeature(engine, grammar, fs.readFileSync(file, 'utf8'), rel)) {
      test(`${bucket}: ${rel}:${r.line} ${r.name}`, { skip: r.status === 'skipped' ? r.message : false }, () => {
        assert.equal(r.status, 'passed', r.message);
      });
    }
  }
}
