// Serves the playground and the files it loads, on 127.0.0.1 only.

import { createServer } from 'node:http';
import { readFile } from 'node:fs/promises';
import { pathToFileURL } from 'node:url';

const root = new URL('../', import.meta.url);
const allowed = [
  /^playground\.html$/,
  /^(README|SEMANTICS)\.md$/,
  /^src\/[a-z-]+\.js$/,
  /^vendor\/eyelang\/language\.js$/,
  /^knowledge\/manifest\.json$/,
  /^knowledge\/(?:[A-Za-z0-9_./-]+)\.pl$/,
  /^examples\/[a-z0-9-]+\.json$/,
  /^conformance\/regelrecht\/(regulation|bdd\/conformance)\/[A-Za-z0-9_./-]+\.feature$/,
];
const types = { html: 'text/html', js: 'text/javascript', json: 'application/json', md: 'text/markdown', pl: 'text/plain', feature: 'text/plain' };

export function createPlaygroundServer() {
  return createServer(async (request, response) => {
    response.setHeader('X-Content-Type-Options', 'nosniff');
    response.setHeader('Cache-Control', 'no-store');
    if (!['GET', 'HEAD'].includes(request.method)) {
      response.writeHead(405, { Allow: 'GET, HEAD' }).end('Use GET or HEAD.');
      return;
    }
    let path;
    try {
      path = decodeURIComponent(new URL(request.url, 'http://localhost').pathname).slice(1) || 'playground.html';
    } catch {
      response.writeHead(400).end('Invalid URL.');
      return;
    }
    if (path.includes('..') || !allowed.some((re) => re.test(path))) {
      response.writeHead(404).end('File not found.');
      return;
    }
    try {
      const content = await readFile(new URL(path, root));
      response.writeHead(200, { 'Content-Type': `${types[path.split('.').pop()] || 'text/plain'}; charset=utf-8` });
      response.end(request.method === 'HEAD' ? undefined : content);
    } catch {
      response.writeHead(404).end('File not found.');
    }
  });
}

if (process.argv[1] && pathToFileURL(process.argv[1]).href === import.meta.url) {
  const server = createPlaygroundServer();
  server.on('error', (error) => {
    console.error(`Couldn't start the playground: ${error.message}`);
    process.exitCode = 1;
  });
  server.listen(Number(process.env.PORT ?? 8000), '127.0.0.1', () => {
    console.log(`Open http://127.0.0.1:${server.address().port}/playground.html`);
    console.log('Press Ctrl+C to stop the server.');
  });
}
