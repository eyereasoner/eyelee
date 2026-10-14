// Anchoring a note to legal text (W3C TextQuoteSelector, RFC-005 / RFC-018).
//
// A note selects an exact quote with optional prefix and suffix context. It
// follows the text, not the article number: it is found wherever the text
// is, survives renumbering, and survives small wording changes through a
// fuzzy match scored by normalised Levenshtein similarity.
//
// 1. Exact: every occurrence of the quote whose surroundings match the
//    prefix and suffix (whitespace-tolerant). One is found, several are
//    ambiguous.
// 2. Fuzzy: windows of the quote's length +-30% that share a significant
//    word with it, scored exact*0.5 + prefix*0.25 + suffix*0.25; at least
//    0.7 counts. Overlapping candidates collapse to the best; a single one,
//    or one more than 0.1 ahead of the runner-up, is found.
// 3. Nothing is orphaned. A hint never decides: the text does.

export const FUZZY_THRESHOLD = 0.7;
const WINDOW_TOLERANCE = 0.3;
const TIEBREAK_MARGIN = 0.1;

const norm = (s) => s.replace(/\s+/g, ' ');

export function resolveNote(selector, articles, threshold = FUZZY_THRESHOLD) {
  const exact = [];
  for (const a of articles) exact.push(...exactMatches(a, selector));
  if (exact.length === 1) return { status: 'found', matches: exact };
  if (exact.length > 1) return { status: 'ambiguous', matches: exact };
  const fuzzy = [];
  for (const a of articles) fuzzy.push(...fuzzyMatches(a, selector, threshold));
  const kept = dedupe(fuzzy);
  if (!kept.length) return { status: 'orphaned', matches: [] };
  if (kept.length === 1 || kept[0].confidence - kept[1].confidence > TIEBREAK_MARGIN) {
    return { status: 'found', matches: [kept[0]] };
  }
  return { status: 'ambiguous', matches: kept };
}

function exactMatches(article, { exact, prefix = '', suffix = '' }) {
  const text = article.text || '';
  const out = [];
  if (!exact) return out;
  const p = norm(prefix).trim();
  const s = norm(suffix).trim();
  for (let i = text.indexOf(exact); i >= 0; i = text.indexOf(exact, i + 1)) {
    const before = norm(text.slice(0, i)).trimEnd();
    const after = norm(text.slice(i + exact.length)).trimStart();
    if (p && !before.endsWith(p)) continue;
    if (s && !after.startsWith(s)) continue;
    out.push({ article: article.number, start: i, end: i + exact.length, confidence: 1 });
  }
  return out;
}

function fuzzyMatches(article, { exact, prefix = '', suffix = '' }, threshold) {
  const text = article.text || '';
  const out = [];
  const n = exact.length;
  if (!n) return out;
  const words = significantWords(exact);
  const lower = text.toLowerCase();
  const minLen = Math.max(1, Math.floor(n * (1 - WINDOW_TOLERANCE)));
  const maxLen = Math.ceil(n * (1 + WINDOW_TOLERANCE));
  for (let start = 0; start < text.length; start++) {
    for (let len = minLen; len <= maxLen && start + len <= text.length; len++) {
      const window = lower.slice(start, start + len);
      if (words.length && !words.some((w) => window.includes(w))) continue;
      const se = similarity(exact.toLowerCase(), window);
      if (se * 0.5 + 0.5 < threshold) continue;
      const sp = prefix ? similarity(prefix.toLowerCase(), lower.slice(Math.max(0, start - prefix.length), start)) : 1;
      const ss = suffix ? similarity(suffix.toLowerCase(), lower.slice(start + len, start + len + suffix.length)) : 1;
      const score = se * 0.5 + sp * 0.25 + ss * 0.25;
      if (score >= threshold) out.push({ article: article.number, start, end: start + len, confidence: Math.min(score, 0.999999) });
    }
  }
  return out;
}

function dedupe(cands) {
  const sorted = [...cands].sort((a, b) => b.confidence - a.confidence);
  const kept = [];
  for (const c of sorted) {
    if (kept.some((k) => k.article === c.article && c.start < k.end && k.start < c.end)) continue;
    kept.push(c);
  }
  return kept;
}

function significantWords(s) {
  return s.toLowerCase().split(/[^\p{L}\p{N}]+/u).filter((w) => w.length > 3);
}

export function similarity(a, b) {
  const m = Math.max(a.length, b.length);
  if (m === 0) return 1;
  return 1 - levenshtein(a, b) / m;
}

function levenshtein(a, b) {
  let prev = Array.from({ length: b.length + 1 }, (_, j) => j);
  for (let i = 1; i <= a.length; i++) {
    const cur = [i];
    for (let j = 1; j <= b.length; j++) {
      cur[j] = Math.min(prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + (a[i - 1] === b[j - 1] ? 0 : 1));
    }
    prev = cur;
  }
  return prev[b.length];
}
