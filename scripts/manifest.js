// Writes knowledge/manifest.json: the ruleworks, scenarios and
// grammar the browser playground loads (a browser cannot list directories).

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { walk } from '../src/corpus.js';

const root = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');
const base = path.join(root, 'conformance', 'regelrecht');
const rel = (f) => path.relative(root, f).split(path.sep).join('/');

export function manifest() {
  return {
    grammar: 'knowledge/regelrecht/grammar.pl',
    laws: [...walk(path.join(root, 'knowledge', 'regelrecht', 'regulation'), ['.pl']), ...walk(path.join(root, 'knowledge', 'examples'), ['.pl'])].map(rel),
    scenarios: [
      ...walk(path.join(base, 'bdd', 'conformance'), ['.feature']),
      ...walk(path.join(base, 'regulation'), ['.feature']),
    ].map(rel),
    examples: fs.readdirSync(path.join(root, 'examples')).filter((f) => f.endsWith('.json')).sort().map((f) => `examples/${f}`),
  };
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  fs.writeFileSync(path.join(root, 'knowledge', 'manifest.json'), JSON.stringify(manifest(), null, 2) + '\n');
  console.log('wrote knowledge/manifest.json');
}
