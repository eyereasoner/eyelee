# eyelee

[Repository](https://github.com/eyereasoner/eyelee) ·
[Playground](https://eyereasoner.github.io/eyelee/playground) ·
[Semantics](SEMANTICS.md)

eyelee executes laws written in the [regelrecht](https://github.com/MinBZK/regelrecht)
format: one YAML file per version of a regulation, with the logic of each
article next to its text. It was built from that format's public contract
(the schema, the documentation, the scenario grammar and the conformance
cases), not from the reference engine's code. Two engines that reach the same
answers from the same text are evidence that the format means what it says.
Where they would differ, [SEMANTICS.md](SEMANTICS.md) says what eyelee chose.

## Answer, Reason, Check

```sh
node eyelee.js conformance/regelrecht/regulation \
  --law vreemdelingenwet_2000 --output minister_is_bevoegd --date 2026-01-01
```

```text
# Answer
minister_is_bevoegd = true
motivering_vereist = true  (reactive)
bezwaartermijn_weken = 4  (override)

# Reason
vreemdelingenwet_2000 (2000-11-23) article 14 gives minister_is_bevoegd = true
  before deciding, hook algemene_wet_bestuursrecht article 3:46 fires
    algemene_wet_bestuursrecht (1994-01-01) article 3:46 gives motivering_vereist = true
  after deciding, hook algemene_wet_bestuursrecht article 6:7 fires
    algemene_wet_bestuursrecht (1994-01-01) article 6:7 gives bezwaartermijn_weken = 4
      bezwaartermijn_weken is overridden by vreemdelingenwet_2000 article 69 (lex specialis)
        vreemdelingenwet_2000 (2000-11-23) article 69 gives bezwaartermijn_weken = 4

# Check
✓ 2 law version(s) in force on 2026-01-01: vreemdelingenwet_2000 (2000-11-23), algemene_wet_bestuursrecht (1994-01-01)
✓ 4 article execution(s), each with every input and open term resolved before deciding
✓ every output declared never absent has a value, in 4 article(s)
✓ a second, independent evaluation gives the same answer
```

The Vreemdelingenwet takes a decision (a *beschikking*), so the General
Administrative Law Act fires on its own: Awb 3:46 requires a motivation, and
Awb 6:7 sets the objection period. Article 69 of the Vreemdelingenwet departs
from Awb 6:7, and the Reason shows it doing so. This is
[ARC: Answer, Reason, Check](https://josd.github.io/arc/).

Run it with Node.js 18 or later. No packages to install.

## Examples

Each file in `examples/` is a whole question: law, outputs, date, parameters
and register data.

```sh
node eyelee.js conformance/regelrecht/regulation --query examples/zorgtoeslag-2025.json
```

| Example | What it shows |
|---------|---------------|
| `zorgtoeslag-2025` | A chain across five laws, registers, a ministerial regulation filling an open term, Awb hooks |
| `bezwaartermijn-vreemdelingenwet` | Hooks and an override (lex specialis) |
| `erfgrens-amsterdam` | A municipal ordinance filling a term of the Civil Code, only within Amsterdam |
| `bijstand-diemen` | Co-government: Diemen's reduction of social assistance |
| `unknown-facts` | Absent versus unknown: missing facts are named, never guessed |

Or ask your own question:

```sh
node eyelee.js conformance/regelrecht/regulation --law burgerlijk_wetboek_boek_5 \
  --output minimale_afstand_cm --date 2024-06-01 \
  --param gemeente_code=GM0363 --param type_beplanting=boom --param postcode=1012
```

`--json` prints the result as JSON. `--untranslatable propagate` runs articles
with untranslatable constructs and taints what they produce.

## Scenarios

Given a directory, eyelee loads every law under it and runs every scenario
(`.feature`) under it:

```sh
node eyelee.js conformance/regelrecht/regulation conformance/regelrecht/bdd/conformance
```

```text
# Answer
177 scenarios passed, 0 failed, 1 skipped (19 feature files, 33 laws)
```

These are regelrecht's own suites, run unchanged:

| Suite | Scenarios | Result |
|-------|-----------|--------|
| Engine conformance (`bdd/conformance`, all four tiers) | 101 | all pass |
| Law validation (the scenarios next to the real laws) | 77 | 76 pass, 1 skipped (tagged `@wip` upstream) |
| Golden cases (`fixtures/*.json`) | 56 | all pass |

The step sentences are not copied into eyelee: they are read at run time from
regelrecht's `bdd/grammar.yaml`, the vocabulary every engine is meant to speak.

## Playground

```sh
node src/playground-server.js
```

Open http://127.0.0.1:8000/playground.html, choose an example or a law, and
press **Evaluate** (or Ctrl/⌘ + Enter). **Run a scenario** runs any of the
scenario files, edited or not. The engine runs in the browser.

## As a library

```js
import { Engine } from './src/index.js';

const engine = new Engine();
engine.loadLaw(yamlText);                      // once per law version
engine.setDataSource({ name: 'brp', key: 'bsn', records: [{ bsn: '999993653', leeftijd: 35 }] });
const result = engine.evaluate('participatiewet', ['uitkering_bedrag'], { bsn: '999993653' }, '2025-01-01');
result.outputs;      // values: exact decimals, booleans, text, dates, or Unknown
result.provenance;   // direct, reactive, override or voided, per output
result.trace;        // the derivation tree behind the Reason
```

## What it covers

- All 28 operations of schema v0.8.0 with exact decimal arithmetic, plus the
  compatibility aliases.
- Version selection by date, including laws that have ended (`valid_to`).
- Cross-law and same-law references, with skipping when a required parameter
  names nobody.
- Delegation and co-government: open terms, `implements`, territorial scope,
  lex superior and lex posterior, defaults.
- Hooks on decisions and applications; overrides that replace or void.
- Absent versus unknown (RFC-036), with nullability enforced where values cross
  a boundary.
- Untranslatables and markings in `error`, `propagate`, `warn` and `ignore`
  modes.
- Registers bound to one law or to all.
- Note anchoring to legal text (exact and fuzzy).

Not yet: unit checking, stage-by-stage Awb procedures, and receipts. See
[SEMANTICS.md](SEMANTICS.md).

## Layout

| Path | Contents |
|------|----------|
| `eyelee.js` | The command line |
| `src/engine.js` | Laws, versions, articles, inputs, open terms, hooks, overrides |
| `src/operations.js` | The operations and the rules for absent and unknown |
| `src/decimal.js` · `src/values.js` | Exact decimals; values and dates |
| `src/yaml.js` · `src/gherkin.js` | The readers for rulework and scenario files |
| `src/scenarios.js` · `src/notes.js` | The scenario actions; note anchoring |
| `src/explain.js` | Answer, Reason and Check |
| `conformance/regelrecht/` | regelrecht's corpus, grammar, scenarios and golden cases (EUPL-1.2) |
| `test/` | `npm test` runs all of the above with `node --test` |

## License

MIT, see [LICENSE.md](LICENSE.md). The material in `conformance/regelrecht/`
comes from regelrecht and keeps its EUPL-1.2 license.
