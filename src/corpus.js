// Loading ruleworks and scenarios from the file system (Node only).

import fs from 'node:fs';
import path from 'node:path';
import { parseYaml } from './yaml.js';

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

// Load every rulework under `dir`. YAML files that are not ruleworks (no
// `articles`) are passed over; a rulework that does not load is reported.
export function loadCorpus(engine, dir) {
  const loaded = [];
  const problems = [];
  for (const file of walk(dir, ['.yaml', '.yml'])) {
    const r = loadLawFile(engine, file);
    if (r.id) loaded.push(r.id);
    else if (r.error) problems.push({ file, error: r.error });
  }
  return { loaded, problems };
}

export function loadLawFile(engine, file) {
  let doc;
  try {
    doc = parseYaml(fs.readFileSync(file, 'utf8'));
  } catch (e) {
    return { error: e.message };
  }
  if (!doc || typeof doc !== 'object' || !Array.isArray(doc.articles)) return {};
  try {
    return { id: engine.loadLaw(doc, file) };
  } catch (e) {
    return { error: e.message };
  }
}
