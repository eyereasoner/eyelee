// Reproduce the runtime Prolog knowledge from the unchanged upstream fixtures.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { walk } from '../src/corpus.js';
import { parseYaml } from '../src/yaml.js';
import { compileRulework } from '../src/prolog-compiler.js';
import { importGrammarYaml } from '../src/import-yaml.js';
import { manifest } from './manifest.js';

const root = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');
const upstream = path.join(root, 'conformance', 'regelrecht');
const destination = path.join(root, 'knowledge', 'regelrecht');
export function importRegelrecht() {
  let count = 0;
  for (const file of walk(path.join(upstream, 'regulation'), ['.yaml'])) {
    const doc = parseYaml(fs.readFileSync(file, 'utf8'));
    if (!doc || !Array.isArray(doc.articles)) continue;
    const output = path.join(destination, path.relative(upstream, file)).replace(/\.yaml$/, '.pl');
    fs.mkdirSync(path.dirname(output), { recursive: true });
    fs.writeFileSync(output, compileRulework(doc));
    count++;
  }
  fs.copyFileSync(path.join(upstream, 'LICENSE.EUPL-1.2.txt'), path.join(destination, 'LICENSE.EUPL-1.2.txt'));
  fs.writeFileSync(path.join(destination, 'grammar.pl'), importGrammarYaml(fs.readFileSync(path.join(upstream, 'bdd', 'grammar.yaml'), 'utf8')));
  fs.writeFileSync(path.join(root, 'src', 'runtime-program.js'), '// Generated from knowledge/runtime.pl by scripts/import-regelrecht.js.\nexport const runtimeSource = ' + JSON.stringify(fs.readFileSync(path.join(root, 'knowledge', 'runtime.pl'), 'utf8')) + ';\n');
  fs.writeFileSync(path.join(root, 'knowledge', 'manifest.json'), JSON.stringify(manifest(), null, 2) + '\n');
  return count;
}
if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) console.log(`Imported ${importRegelrecht()} Prolog ruleworks. Upstream fixtures were left unchanged.`);
