// Loading ruleworks and scenarios from the file system (Node only).

import fs from 'node:fs';
import path from 'node:path';

export function walk(dir, exts) {
  const out = [];
  const visit = (d) => {
    for (const e of fs.readdirSync(d, { withFileTypes: true }).sort((a, b) => a.name.localeCompare(b.name))) {
      const p = path.join(d, e.name);
      if (e.isDirectory()) visit(p);
      else if (exts.some((x) => e.name.endsWith(x))) out.push(p);
    }
  };
  visit(dir);
  return out;
}

// Load runtime knowledge from .pl files. Upstream YAML is an import fixture.
export function loadCorpus(engine, dir) {
  const loaded = [];
  const problems = [];
  for (const file of walk(dir, ['.pl'])) {
    const result = loadLawFile(engine, file);
    if (result.id) loaded.push(result.id);
    else if (result.error) problems.push({ file, error: result.error });
  }
  return { loaded, problems };
}

export function loadLawFile(engine, file) {
  if (!file.endsWith('.pl')) return { error: 'Use a .pl rulework. Import upstream YAML with node scripts/import-regelrecht.js.' };
  try { return { id: engine.loadLaw(fs.readFileSync(file, 'utf8'), file) }; }
  catch (error) { return { error: error.message }; }
}
