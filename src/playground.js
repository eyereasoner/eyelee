// The browser playground: the same engine, loaded from the same files.

import { Engine } from './engine.js';
import { loadGrammar, runFeature, inferValue } from './scenarios.js';
import { renderArc } from './explain.js';

const $ = (id) => document.getElementById(id);
const engine = new Engine();
let grammar = null;
let manifest = null;

async function text(url) {
  const r = await fetch(url);
  if (!r.ok) throw new Error(`${url}: ${r.status}`);
  return r.text();
}

function status(msg, state = '') {
  $('status').textContent = msg;
  $('status').dataset.state = state;
}

function show(out, error = false) {
  $('output').textContent = out;
  $('output').classList.toggle('error', error);
}

async function boot() {
  try {
    manifest = JSON.parse(await text('conformance/regelrecht/manifest.json'));
    const texts = await Promise.all(manifest.laws.map((p) => text(p).then((t) => [p, t])));
    for (const [p, t] of texts) {
      try {
        engine.loadLaw(t, p);
      } catch {
        /* not a rulework */
      }
    }
    grammar = loadGrammar(await text(manifest.grammar));
  } catch (e) {
    $('serve-hint').hidden = false;
    status(`Could not load the corpus: ${e.message}`, 'error');
    return;
  }
  for (const id of engine.lawIds()) $('law').add(new Option(id, id));
  for (const p of manifest.scenarios) $('feature-file').add(new Option(p.replace('conformance/regelrecht/', ''), p));
  for (const p of manifest.examples) $('example').add(new Option(p.replace(/^examples\/|\.json$/g, ''), p));
  $('date').value = new Date().toISOString().slice(0, 10);
  $('law').value = 'wet_op_de_zorgtoeslag';
  refreshOutputs();
  status(`${engine.lawIds().length} laws loaded`, 'success');
  await loadExample('examples/zorgtoeslag-2025.json');
  evaluateNow();
}

function selectedLaw() {
  const id = $('law').value;
  try {
    return engine.select(id, $('date').value || new Date().toISOString().slice(0, 10));
  } catch {
    const list = engine.versions.get(id) || [];
    return list[list.length - 1];
  }
}

function refreshOutputs(checked = []) {
  const law = selectedLaw();
  const box = $('outputs');
  box.replaceChildren();
  if (!law) return;
  $('version-note').textContent = law.validFrom ? `version ${law.validFrom}` : 'undated version';
  for (const name of law.outputs.keys()) {
    const l = document.createElement('label');
    const c = document.createElement('input');
    c.type = 'checkbox';
    c.value = name;
    c.checked = checked.includes(name);
    l.append(c, name);
    box.append(l);
  }
  if (!box.querySelector('input:checked')) box.querySelector('input')?.click();
}

async function loadExample(path) {
  if (!path) return;
  const q = JSON.parse(await text(path));
  $('example').value = path;
  $('example-note').textContent = q.description || '';
  $('law').value = q.law;
  $('date').value = q.date;
  refreshOutputs(q.outputs);
  $('params').value = Object.entries(q.parameters || {}).map(([k, v]) => `${k} = ${typeof v === 'string' ? v : JSON.stringify(v)}`).join('\n');
  $('data').value = JSON.stringify(q.data || [], null, 2);
}

function evaluateNow() {
  try {
    const params = {};
    for (const line of $('params').value.split('\n')) {
      if (!line.trim() || line.trim().startsWith('#')) continue;
      const eq = line.indexOf('=');
      if (eq < 0) throw new Error(`parameter line without '=': ${line}`);
      params[line.slice(0, eq).trim()] = inferValue(line.slice(eq + 1).trim());
    }
    engine.clearDataSources();
    for (const src of JSON.parse($('data').value || '[]')) engine.setDataSource(src);
    engine.setUntranslatableMode($('mode').value);
    const outputs = [...$('outputs').querySelectorAll('input:checked')].map((c) => c.value);
    const t0 = performance.now();
    const result = engine.evaluate($('law').value, outputs, params, $('date').value);
    show(renderArc(result));
    status(`answered in ${(performance.now() - t0).toFixed(1)} ms`, 'success');
  } catch (e) {
    show(`# Answer\nno answer: ${e.message}`, true);
    status(e.kind || 'error', 'error');
  }
}

async function loadFeature(path) {
  $('feature').value = await text(path);
}

function scenarioNow() {
  const results = runFeature(engine, grammar, $('feature').value, $('feature-file').value);
  const failed = results.filter((r) => r.status === 'failed');
  const passed = results.filter((r) => r.status === 'passed');
  const skipped = results.filter((r) => r.status === 'skipped');
  const lines = ['# Answer', `${passed.length} scenarios passed, ${failed.length} failed, ${skipped.length} skipped`, '', '# Reason'];
  for (const r of results) {
    lines.push(`${r.status === 'passed' ? '✓' : r.status === 'failed' ? '✗' : '-'} line ${r.line}: ${r.name}${r.status === 'skipped' ? ` (${r.message})` : ''}`);
    if (r.status === 'failed') lines.push(`    ${r.message}`);
  }
  lines.push('', '# Check', failed.length ? `✗ ${failed.length} scenario(s) failed` : `✓ all ${passed.length} executed scenarios hold`);
  show(lines.join('\n'), failed.length > 0);
  status(failed.length ? 'scenarios failed' : 'scenarios hold', failed.length ? 'error' : 'success');
}

function mode(m) {
  $('evaluate-panel').hidden = m !== 'evaluate';
  $('scenario-panel').hidden = m !== 'scenario';
  $('mode-evaluate').setAttribute('aria-pressed', m === 'evaluate');
  $('mode-scenario').setAttribute('aria-pressed', m === 'scenario');
  if (m === 'scenario' && !$('feature').value && manifest) loadFeature($('feature-file').value);
}

$('mode-evaluate').onclick = () => mode('evaluate');
$('mode-scenario').onclick = () => mode('scenario');
$('law').onchange = () => refreshOutputs();
$('date').onchange = () => refreshOutputs([...$('outputs').querySelectorAll('input:checked')].map((c) => c.value));
$('example').onchange = () => loadExample($('example').value).then(evaluateNow);
$('feature-file').onchange = () => loadFeature($('feature-file').value);
$('run-evaluate').onclick = evaluateNow;
$('run-scenario').onclick = scenarioNow;
document.addEventListener('keydown', (e) => {
  if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) {
    e.preventDefault();
    if ($('scenario-panel').hidden) evaluateNow();
    else scenarioNow();
  }
});

boot();
