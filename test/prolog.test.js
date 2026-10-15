import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { createRequire } from 'node:module';
import { Engine } from '../src/engine.js';
import { evaluateExpression } from '../src/reasoner.js';
import { compileRulework, readRulework } from '../src/prolog-compiler.js';
import { importRuleworkYaml } from '../src/import-yaml.js';
import { Dec } from '../src/decimal.js';
import { Unknown, toPlain } from '../src/values.js';
import { loadCorpus, walk } from '../src/corpus.js';
import { parseYaml } from '../src/yaml.js';
import { runtimeSource } from '../src/runtime-program.js';
import { renderArc } from '../src/explain.js';

const root = new URL('../', import.meta.url);
const read = path => readFileSync(new URL(path, root), 'utf8');
const native = read('knowledge/examples/illustrative-benefit.pl');
function engine(source = native) { const result = new Engine(); result.loadLaw(source); return result; }
function scope(values = {}, trace = []) {
  return {
    resolve(name) { if (!(name in values)) throw new Error(`Unexpected reference: ${name}`); return values[name]; },
    withLocals(locals) { return scope({ ...values, ...Object.fromEntries(locals) }, trace); },
    traceReasoner(proof) { trace.push(proof); },
  };
}

const doc = value => ({ $id: 'test', articles: [{ number: '1', text: 'A test, not a legal entitlement.', machine_readable: {
  execution: { output: [{name:'result',nullable:true}], actions:[{output:'result',value}] },
} }] });

test('ordinary Prolog clauses derive native law outputs and leave concrete proof evidence', () => {
  const result = engine().evaluate('illustrative_benefit', ['eligible','amount'], {income:Dec.parse('187654.32')}, '2025-01-01');
  assert.equal(result.outputs.eligible,true);
  assert.equal(result.outputs.amount.toString(),'12345.68');
  const proofs = result.trace[0].derivations;
  assert.ok(proofs.every(proof=>proof.proof.some(step=>step.rule)));
  assert.ok(proofs[0].proof.some(step=>step.rule?.startsWith('eligibility(')));
  assert.match(renderArc(result),/checked 18765432 < 20000000/);
  assert.ok(result.checks.some(check=>check.includes('derived by eyelang')));
});

test('editing a native Prolog clause changes the answer without a JavaScript rule change', () => {
  const before=engine().evaluate('illustrative_benefit',['amount'],{income:190000},'2025-01-01');
  const after=engine(native.replaceAll('200000','210000')).evaluate('illustrative_benefit',['amount'],{income:190000},'2025-01-01');
  assert.equal(before.outputs.amount.toString(),'10000');
  assert.equal(after.outputs.amount.toString(),'20000');
});

test('native Prolog answers retain exact integers and scaled decimals beyond binary64 precision', () => {
  const source=native.replaceAll('200000','90071992547409930000');
  const result=engine(source).evaluate('illustrative_benefit',['amount'],{income:Dec.parse('90071992547409929999.99')},'2025-01-01');
  assert.equal(result.outputs.amount.toString(),'0.01');
});

test('compiled .pl knowledge handles exact decimals and domain division with unequal scales', () => {
  for(const [value,expected] of [
    [{operation:'ADD',values:[0.1,0.2]},'0.3'],
    [{operation:'MULTIPLY',values:[2.3,4.5]},'10.35'],
    [{operation:'DIVIDE',values:[0.1,2]},'0.05'],
    [{operation:'DIVIDE',values:[1,0.2]},'5'],
    [{operation:'DIVIDE',values:[-0.01,2]},'-0.005'],
    [{operation:'ROUND',value:2.675,precision:2},'2.68'],
  ]) {
    const e=engine(compileRulework(doc(value)));
    assert.equal(e.evaluate('test',['result'],{},'2025-01-01').outputs.result.toString(),expected);
  }
});

test('Prolog IF and AND/OR do not request unreachable branches or references', () => {
  assert.equal(evaluateExpression({operation:'IF',cases:[{when:true,then:7}],default:'$unreachable'},scope()).toString(),'7');
  assert.equal(evaluateExpression({operation:'OR',conditions:[true,'$unreachable']},scope()),true);
  assert.equal(evaluateExpression({operation:'AND',conditions:[false,'$unreachable']},scope()),false);
  const unknown = evaluateExpression({operation:'IF',cases:[{when:'$missing',then:'$unreachable'}],default:'$unreachable'},scope({missing:new Unknown(['missing'])}));
  assert.deepEqual(unknown.missing,['missing']);
});

test('absent and unknown remain distinct across expression, collection, and native boundaries', () => {
  assert.throws(()=>evaluateExpression({operation:'ADD',values:['$absent',1]},scope({absent:null})),/ADD: operand is null/);
  assert.deepEqual(toPlain(evaluateExpression({operation:'ADD',values:['$missing',1]},scope({missing:new Unknown(['income'])}))),{unknown:['income']});
  const output=engine(native.replace('number, true, false','number, false, false')).evaluate('illustrative_benefit',['amount'],{income:new Unknown(['income'])},'2025-01-01');
  assert.deepEqual(toPlain(output.outputs.amount),{unknown:['income']});
  assert.throws(()=>engine().evaluate('illustrative_benefit',['amount'],{income:null},'2025-01-01'),/cannot be evaluated for nobody/);
});

test('FOREACH keeps duplicates, skips rejected bodies, and scopes every element separately',()=>{
  const node={operation:'FOREACH',collection:[2,2,1],as:'entry',filter:{operation:'GREATER_THAN',subject:'$entry',value:1},body:'$entry',combine:'ADD'};
  assert.equal(evaluateExpression(node,scope()).toString(),'4');
  const rejected={operation:'FOREACH',collection:[1],filter:false,body:'$unreachable'};
  assert.deepEqual(evaluateExpression(rejected,scope()),[]);
  assert.throws(()=>evaluateExpression({operation:'FOREACH',collection:'$items',body:1},scope({items:Array(1001).fill(new Dec(1n))})),/limit of 1000/);
});

test('dates, law versions, hooks, and overrides execute from the Prolog corpus',()=>{
  const e=new Engine();
  const corpus=loadCorpus(e,new URL('../knowledge/regelrecht/regulation/',import.meta.url).pathname);
  assert.equal(corpus.loaded.length,38); assert.deepEqual(corpus.problems,[]);
  assert.equal(e.lawIds().length,33);
  const result=e.evaluate('vreemdelingenwet_2000',['minister_is_bevoegd'],{},'2026-01-01');
  assert.equal(result.outputs.minister_is_bevoegd,true);
  assert.equal(result.outputs.motivering_vereist,true);
  assert.equal(result.outputs.bezwaartermijn_weken.toString(),'4');
  assert.equal(result.provenance.bezwaartermijn_weken,'override');
});

test('ruleworks require valid Prolog metadata and a single deterministic output',()=>{
  assert.throws(()=>engine('$id: old\narticles: []'),/Line 1:/);
  assert.throws(()=>engine('law(a). law(b).'),/exactly one law/);
  assert.throws(()=>engine('law(a). execution_property("1", "output", []).'),/undeclared article/);
  assert.throws(()=>readRulework('law(a). ?- law(X).'),/defines knowledge/);
  const ambiguous=native+'\nallowance(Scope, decimal(1,0)) :- binding(Scope,"income",Value).\n';
  assert.throws(()=>engine(ambiguous).evaluate('illustrative_benefit',['amount'],{income:1000},'2025-01-01'),/more than one value/);
});

test('all imported laws reproduce the unchanged upstream contract as .pl source',()=>{
  const base=new URL('../conformance/regelrecht/regulation/',import.meta.url).pathname;
  let count=0;
  for(const path of walk(base,['.yaml'])) {
    const source=readFileSync(path,'utf8'); const object=parseYaml(source);
    if(!Array.isArray(object?.articles))continue;
    const relative=path.slice(base.length);
    assert.equal(read(`knowledge/regelrecht/regulation/${relative.replace(/\.yaml$/,'.pl')}`),importRuleworkYaml(source));
    count++;
  }
  assert.equal(count,38);
});

test('the embedded runtime matches Prolog source and eyelang is installed at the locked version',()=>{
  assert.equal(runtimeSource,read('knowledge/runtime.pl'));
  const pkg=JSON.parse(read('package.json'));
  const lock=JSON.parse(read('package-lock.json'));
  const installed=JSON.parse(readFileSync(createRequire(import.meta.url).resolve('eyelang/package.json'),'utf8'));
  assert.equal(installed.version,pkg.dependencies.eyelang);
  assert.equal(lock.packages['node_modules/eyelang'].version,installed.version);
  assert.match(lock.packages['node_modules/eyelang'].integrity,/^sha512-/);
});
