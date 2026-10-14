#!/usr/bin/env node
// eyelee: executable Dutch law, with Answer, Reason and Check.

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Engine } from './src/engine.js';
import { loadCorpus, loadLawFile, walk } from './src/corpus.js';
import { loadGrammar, runFeature, inferValue } from './src/scenarios.js';
import { renderArc, renderAnswer, renderReason, renderChecks } from './src/explain.js';
import { toPlain } from './src/values.js';

const here = path.dirname(fileURLToPath(import.meta.url));
const DEFAULT_GRAMMAR = path.join(here, 'conformance', 'regelrecht', 'bdd', 'grammar.yaml');

const USAGE = `Usage: eyelee [options] <law.yaml | scenario.feature | directory> ...

Laws (.yaml) are loaded; a directory loads every law under it and runs every
scenario (.feature) under it. Scenarios given on the command line are run.

Evaluate a law:
  --law <id>               the law to evaluate
  --output <a,b,...>       the outputs to compute
  --date <YYYY-MM-DD>      the calculation date (default: today)
  --param <name=value>     a parameter (repeatable); values are typed like a
                           scenario cell: true, false, null, numbers, JSON, text
  --data <file.json>       data sources: [{name, key, law?, records: [...]}]
  --query <file.json>      a whole question: {law, outputs, date, parameters, data}
  --json                   print the result as JSON instead of Answer/Reason/Check

Options:
  --untranslatable <mode>  error (default), propagate, warn or ignore
  --grammar <file>         the scenario vocabulary (default: bundled grammar.yaml)
  --verbose                list every scenario, not only the ones that fail
  --help                   show this help`;

function main(argv) {
  const opts = { params: {}, inputs: [], data: [], verbose: false, json: false };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    const next = () => {
      if (i + 1 >= argv.length) die(`${a} needs a value`);
      return argv[++i];
    };
    if (a === '--help' || a === '-h') {
      console.log(USAGE);
      return 0;
    } else if (a === '--law') opts.law = next();
    else if (a === '--output') opts.outputs = next().split(',').map((s) => s.trim()).filter(Boolean);
    else if (a === '--date') opts.date = next();
    else if (a === '--param') {
      const p = next();
      const eq = p.indexOf('=');
      if (eq < 0) die(`--param expects name=value, got ${p}`);
      opts.params[p.slice(0, eq)] = inferValue(p.slice(eq + 1));
    } else if (a === '--data') opts.data.push(next());
    else if (a === '--query') {
      const q = JSON.parse(fs.readFileSync(next(), 'utf8'));
      opts.law = q.law;
      opts.outputs = q.outputs;
      opts.date = q.date;
      for (const [k, v] of Object.entries(q.parameters || {})) opts.params[k] = v;
      opts.dataSources = q.data || [];
    }
    else if (a === '--untranslatable') opts.untranslatable = next();
    else if (a === '--grammar') opts.grammar = next();
    else if (a === '--verbose' || a === '-v') opts.verbose = true;
    else if (a === '--json') opts.json = true;
    else if (a.startsWith('-')) die(`unknown option ${a}\n\n${USAGE}`);
    else opts.inputs.push(a);
  }
  if (!opts.inputs.length) {
    console.log(USAGE);
    return 2;
  }

  const engine = new Engine();
  const features = [];
  const problems = [];
  for (const input of opts.inputs) {
    if (!fs.existsSync(input)) die(`no such file or directory: ${input}`);
    if (fs.statSync(input).isDirectory()) {
      problems.push(...loadCorpus(engine, input).problems);
      if (!opts.law) features.push(...walk(input, ['.feature']));
    } else if (input.endsWith('.feature')) features.push(input);
    else {
      const r = loadLawFile(engine, input);
      if (r.error) problems.push({ file: input, error: r.error });
    }
  }
  for (const p of problems) console.error(`warning: ${p.file}: ${p.error}`);
  if (opts.untranslatable) engine.setUntranslatableMode(opts.untranslatable);

  if (opts.law) return evaluateLaw(engine, opts);
  if (features.length) return runScenarios(engine, features, opts);
  console.log(`# Answer\nloaded ${engine.lawIds().length} laws: ${engine.lawIds().join(', ')}`);
  return 0;
}

function evaluateLaw(engine, opts) {
  if (!opts.outputs?.length) die('--law needs --output');
  for (const src of opts.dataSources || []) engine.setDataSource(src);
  for (const file of opts.data) {
    for (const src of JSON.parse(fs.readFileSync(file, 'utf8'))) engine.setDataSource(src);
  }
  const date = opts.date || new Date().toISOString().slice(0, 10);
  let result;
  try {
    result = engine.evaluate(opts.law, opts.outputs, opts.params, date);
  } catch (e) {
    if (opts.json) console.log(JSON.stringify({ error: e.message, kind: e.kind || 'Error' }, null, 2));
    else console.log(`# Answer\nno answer: ${e.message}`);
    return 1;
  }
  // Reproducibility: the same question on the same law gives the same answer.
  const again = engine.evaluate(opts.law, opts.outputs, opts.params, date);
  const same = JSON.stringify(toPlain(again.outputs)) === JSON.stringify(toPlain(result.outputs));
  result.checks.push(same ? 'a second, independent evaluation gives the same answer' : 'FAILED: a second evaluation gives a different answer');
  if (!same) process.exitCode = 1;
  if (opts.json) {
    console.log(JSON.stringify({
      law: result.law,
      version: result.version,
      date: result.date,
      outputs: toPlain(result.outputs),
      provenance: result.provenance,
      tainted: result.tainted,
      voided: result.voided,
      checks: result.checks,
    }, null, 2));
  } else console.log(renderArc(result));
  return 0;
}

function runScenarios(engine, files, opts) {
  const grammar = loadGrammar(fs.readFileSync(opts.grammar || DEFAULT_GRAMMAR, 'utf8'));
  const all = [];
  for (const file of files) {
    for (const r of runFeature(engine, grammar, fs.readFileSync(file, 'utf8'), file)) all.push({ ...r, file });
  }
  const passed = all.filter((r) => r.status === 'passed');
  const failed = all.filter((r) => r.status === 'failed');
  const skipped = all.filter((r) => r.status === 'skipped');
  const out = ['# Answer'];
  out.push(`${passed.length} scenarios passed, ${failed.length} failed, ${skipped.length} skipped (${files.length} feature files, ${engine.lawIds().length} laws)`);
  out.push('', '# Reason');
  for (const r of all) {
    if (r.status === 'passed' && !opts.verbose) continue;
    const mark = r.status === 'passed' ? '✓' : r.status === 'failed' ? '✗' : '-';
    out.push(`${mark} ${path.relative(process.cwd(), r.file)}:${r.line} ${r.name}${r.status === 'skipped' ? ` (${r.message})` : ''}`);
    if (r.status === 'failed') out.push(`    ${r.message}`);
  }
  if (!failed.length && !opts.verbose) out.push('every scenario ran to the outcome its Then steps assert');
  out.push('', '# Check');
  out.push(failed.length ? `✗ ${failed.length} scenario(s) failed` : `✓ all ${passed.length} executed scenarios hold`);
  console.log(out.join('\n'));
  return failed.length ? 1 : 0;
}

function die(msg) {
  console.error(`eyelee: ${msg}`);
  process.exit(2);
}

process.exitCode = main(process.argv.slice(2));

export { renderAnswer, renderReason, renderChecks };
