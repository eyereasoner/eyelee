// Keeps the playground's version marker equal to package.json (run by `npm version`).

import { readFile, writeFile } from 'node:fs/promises';
import { resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

export async function syncVersion(root = fileURLToPath(new URL('../', import.meta.url))) {
  const { version } = JSON.parse(await readFile(resolve(root, 'package.json'), 'utf8'));
  const path = resolve(root, 'playground.html');
  const source = await readFile(path, 'utf8');
  const pattern = /<span id="version">[^<]+<\/span>/g;
  if ([...source.matchAll(pattern)].length !== 1) throw new Error('Expected one version marker in playground.html.');
  await writeFile(path, source.replace(pattern, `<span id="version">v${version}</span>`));
}

if (process.argv[1] && pathToFileURL(process.argv[1]).href === import.meta.url) {
  await syncVersion();
}
