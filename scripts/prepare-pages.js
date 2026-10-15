// Assembles the GitHub Pages site in _pages: README as the home page,
// SEMANTICS, and the playground with the engine and the corpus it loads.

import { cp, mkdir, readFile, writeFile, rm } from 'node:fs/promises';
import { createRequire } from 'node:module';
import { dirname, resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const root = fileURLToPath(new URL('../', import.meta.url));

export async function preparePages(destination, basePath = '/eyelee') {
  await rm(destination, { recursive: true, force: true });
  await mkdir(destination, { recursive: true });
  for (const file of ['src', 'knowledge', 'examples', 'conformance', 'README.md', 'SEMANTICS.md', 'LICENSE.md']) {
    await cp(resolve(root, file), resolve(destination, file), { recursive: true });
  }
  const eyelangSource = createRequire(import.meta.url).resolve('eyelang/src/language.js');
  await mkdir(resolve(destination, 'assets/eyelang'), { recursive: true });
  await cp(eyelangSource, resolve(destination, 'assets/eyelang/language.js'));
  await cp(resolve(dirname(eyelangSource), '../LICENSE.md'), resolve(destination, 'assets/eyelang/LICENSE.md'));
  const write = (file, text) => writeFile(resolve(destination, file), text);
  await mkdir(resolve(destination, 'playground'), { recursive: true });
  await mkdir(resolve(destination, 'SEMANTICS'), { recursive: true });
  await mkdir(resolve(destination, '_layouts'), { recursive: true });

  const playground = (await readFile(resolve(root, 'playground.html'), 'utf8'))
    .replace('href="README.md"', 'href="./"')
    .replace('href="playground.html"', 'href="playground/"')
    .replace('href="SEMANTICS.md"', 'href="SEMANTICS/"');
  await write('playground.html', playground);
  await write('playground/index.html', playground.replace('<head>', '<head>\n  <base href="../">'));

  const readme = (await readFile(resolve(root, 'README.md'), 'utf8')).replaceAll('(SEMANTICS.md)', '(SEMANTICS/)');
  const semantics = await readFile(resolve(root, 'SEMANTICS.md'), 'utf8');
  await write('index.md', `---\nlayout: default\ntitle: eyelee\n---\n\n${readme}`);
  await write('SEMANTICS/index.md', `---\nlayout: default\ntitle: eyelee semantics\n---\n\n${semantics}`);
  await write('_config.yml', JSON.stringify({
    title: 'eyelee', baseurl: basePath, markdown: 'kramdown',
    kramdown: { input: 'GFM', auto_ids: true },
  }, null, 2));
  await cp(resolve(root, 'scripts/pages-layout.html'), resolve(destination, '_layouts/default.html'));
}

if (process.argv[1] && pathToFileURL(process.argv[1]).href === import.meta.url) {
  await preparePages(resolve(root, '_pages'), process.env.PAGES_BASE_PATH ?? '/eyelee');
  console.log('Website prepared in _pages. Render with Jekyll to produce _site.');
}
