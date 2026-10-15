// Migration/conformance adapter. Runtime ruleworks are Prolog source.
import { parseYaml } from './yaml.js';
import { compileRulework } from './prolog-compiler.js';
import { toTerm, termSource } from './prolog-values.js';

export function importRuleworkYaml(source) {
  const doc = parseYaml(source);
  if (!doc || !Array.isArray(doc.articles)) throw new Error('Not a rulework: no articles.');
  return compileRulework(doc);
}

export function importGrammarYaml(source) {
  return `% Scenario vocabulary imported from the unchanged regelrecht contract.\ngrammar(${termSource(toTerm(parseYaml(source)))}).\n`;
}
