// A small Gherkin reader: features, tags, backgrounds, scenarios, steps,
// data tables and doc strings. Enough for the regelrecht scenario language.

export function parseFeature(text, origin = '') {
  const lines = String(text).replace(/\r\n?/g, '\n').split('\n');
  const feature = { name: '', tags: [], description: [], background: null, scenarios: [], origin };
  let tags = [];
  let current = null; // background or scenario receiving steps
  let lastStep = null;
  let inDoc = null;
  for (let n = 0; n < lines.length; n++) {
    const raw = lines[n];
    const line = raw.trim();
    if (inDoc) {
      if (line === inDoc.fence) {
        lastStep.docString = inDoc.lines.join('\n');
        inDoc = null;
      } else inDoc.lines.push(raw.slice(Math.min(inDoc.indent, raw.length - raw.trimStart().length)));
      continue;
    }
    if (line === '' || line.startsWith('#')) continue;
    if (line.startsWith('@')) {
      tags.push(...line.split(/\s+/).filter((t) => t.startsWith('@')));
      continue;
    }
    let m;
    if ((m = /^Feature:\s*(.*)$/.exec(line))) {
      feature.name = m[1];
      feature.tags = tags;
      tags = [];
      current = null;
      continue;
    }
    if ((m = /^Background:\s*(.*)$/.exec(line))) {
      current = feature.background = { name: m[1], steps: [], line: n + 1 };
      tags = [];
      continue;
    }
    if ((m = /^(Scenario|Example|Scenario Outline|Scenario Template):\s*(.*)$/.exec(line))) {
      current = { name: m[2], tags: [...feature.tags, ...tags], steps: [], line: n + 1, outline: m[1] !== 'Scenario' && m[1] !== 'Example', examples: [] };
      feature.scenarios.push(current);
      tags = [];
      continue;
    }
    if (/^(Examples|Scenarios):/.test(line)) {
      if (current) current.examples.push({ tags, rows: [] });
      tags = [];
      lastStep = null;
      continue;
    }
    if ((m = /^(Given|When|Then|And|But|\*)\s+(.*)$/.exec(line))) {
      if (!current) throw new Error(`${origin}:${n + 1}: step outside a scenario`);
      lastStep = { keyword: m[1], text: m[2], line: n + 1, table: null, docString: null };
      current.steps.push(lastStep);
      continue;
    }
    if (line.startsWith('|')) {
      const cells = splitRow(line);
      const ex = current?.examples?.[current.examples.length - 1];
      if (ex && !lastStep) ex.rows.push(cells);
      else if (lastStep) (lastStep.table ||= []).push(cells);
      continue;
    }
    if (line.startsWith('"""') || line.startsWith('```')) {
      inDoc = { fence: line.slice(0, 3), lines: [], indent: raw.length - raw.trimStart().length };
      continue;
    }
    if (!current) feature.description.push(line);
  }
  // Expand scenario outlines.
  const scenarios = [];
  for (const s of feature.scenarios) {
    if (!s.outline) {
      scenarios.push(s);
      continue;
    }
    for (const ex of s.examples) {
      const [head, ...rows] = ex.rows;
      for (const row of rows) {
        const sub = (t) => t.replace(/<([^>]+)>/g, (all, k) => (head.includes(k) ? row[head.indexOf(k)] : all));
        scenarios.push({
          ...s,
          name: sub(s.name),
          tags: [...s.tags, ...ex.tags],
          steps: s.steps.map((st) => ({ ...st, text: sub(st.text), table: st.table?.map((r) => r.map(sub)) || null })),
        });
      }
    }
  }
  feature.scenarios = scenarios;
  return feature;
}

function splitRow(line) {
  const cells = [];
  let cur = '';
  const body = line.trim().replace(/^\|/, '');
  for (let i = 0; i < body.length; i++) {
    const c = body[i];
    if (c === '\\' && i + 1 < body.length) {
      const nx = body[i + 1];
      cur += nx === 'n' ? '\n' : nx;
      i++;
    } else if (c === '|') {
      cells.push(cur.trim());
      cur = '';
    } else cur += c;
  }
  return cells;
}
