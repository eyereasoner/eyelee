import test from 'node:test';
import assert from 'node:assert/strict';
import { request } from 'node:http';
import { mkdtemp, readFile, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { createPlaygroundServer } from '../src/playground-server.js';
import { preparePages } from '../scripts/prepare-pages.js';

test('the playground serves Prolog knowledge, its grammar, and the pinned reasoner',async t=>{
  const server=createPlaygroundServer();
  await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
  t.after(()=>new Promise(resolve=>server.close(resolve)));
  const get=path=>new Promise((resolve,reject)=>{
    const req=request({host:'127.0.0.1',port:server.address().port,path,agent:false},response=>{
      let body='';response.setEncoding('utf8');response.on('data',chunk=>body+=chunk);
      response.on('end',()=>resolve({status:response.statusCode,type:response.headers['content-type'],body}));
    });req.on('error',reject);req.end();
  });
  const manifest=JSON.parse((await get('/knowledge/manifest.json')).body);
  assert.ok(manifest.laws.length===39);
  assert.ok(manifest.laws.every(path=>path.endsWith('.pl')));
  assert.ok(manifest.grammar.endsWith('.pl'));
  for(const path of [manifest.grammar,...manifest.laws,'src/reasoner.js','src/runtime-program.js','vendor/eyelang/language.js']){
    const response=await get('/'+path);assert.equal(response.status,200,path);assert.ok(response.body.length,path);
  }
  assert.equal((await get('/knowledge/examples/illustrative-benefit.pl')).type,'text/plain; charset=utf-8');
  assert.equal((await get('/conformance/regelrecht/bdd/grammar.yaml')).status,404);
  assert.equal((await get('/knowledge/../package.json')).status,404);
});

test('Pages stages all Prolog dependencies under /eyelee/, /playground/, and /SEMANTICS/',async t=>{
  const destination=await mkdtemp(join(tmpdir(),'eyelee-prolog-pages-'));
  t.after(()=>rm(destination,{recursive:true,force:true}));
  await preparePages(destination,'/eyelee');
  const manifest=JSON.parse(await readFile(join(destination,'knowledge/manifest.json'),'utf8'));
  for(const entry of ['playground.html','playground/']){
    const html=await readFile(join(destination,entry.endsWith('/')?entry+'index.html':entry),'utf8');
    const url=new URL(entry,'https://example.org/eyelee/');
    const base=new URL(/<base href="([^"]+)"/.exec(html)?.[1]||'.',url);
    assert.equal(new URL('.',base).pathname,'/eyelee/');
    for(const path of [manifest.grammar,...manifest.laws,'src/playground.js','src/reasoner.js','src/runtime-program.js','vendor/eyelang/language.js']){
      const deployed=new URL(path,base);assert.ok(deployed.pathname.startsWith('/eyelee/'));
      assert.ok((await readFile(join(destination,deployed.pathname.slice('/eyelee/'.length)),'utf8')).length);
    }
    for(const href of ['./','playground/','SEMANTICS/'])assert.ok(html.includes(`href="${href}"`));
  }
  assert.ok((await readFile(join(destination,'SEMANTICS/index.md'),'utf8')).includes('Prolog knowledge and reasoner boundary'));
  assert.ok((await readFile(join(destination,'index.md'),'utf8')).includes('**Prolog `.pl` files**'));
});
