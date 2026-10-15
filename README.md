# eyelee

[Repository](https://github.com/eyereasoner/eyelee) ·
[Playground](https://eyereasoner.github.io/eyelee/playground) ·
[Semantics](SEMANTICS.md)

eyelee evaluates Dutch-law knowledge written in **Prolog `.pl` files** using the
[eyelang](https://github.com/eyereasoner/eyelang) reasoner. It returns Answer,
Reason and Check, preserving exact decimal amounts, unknown and absent values,
law versions, references, hooks, and overrides.

The bundled knowledge is imported from regelrecht's public contract and tested
against its unchanged scenarios and golden cases. Native Prolog clauses can also
express a rule directly. A rulework is an interpretation of the law, not the law;
these examples do not establish legal validity.

## Run a question

Node.js 18 or later is required. No packages to install or build step:

```sh
node eyelee.js knowledge/regelrecht/regulation \
  --law vreemdelingenwet_2000 --output minister_is_bevoegd --date 2026-01-01
```

```text
# Answer
minister_is_bevoegd = true
motivering_vereist = true  (reactive)
bezwaartermijn_weken = 4  (override)
```

The Reason shows the deciding article, Awb hooks, and the Vreemdelingenwet's
exception to the ordinary objection period. The Check reports selected versions,
resolved inputs, nullability checks, and expression results with eyelang evidence.

For a complete question with parameters and registers:

```sh
node eyelee.js knowledge/regelrecht/regulation --query examples/zorgtoeslag-2025.json
node eyelee.js knowledge/regelrecht/regulation --law burgerlijk_wetboek_boek_5 \
  --output minimale_afstand_cm --date 2024-06-01 \
  --param gemeente_code=GM0363 --param type_beplanting=boom --param postcode=1012
```

`--json` prints structured results. `--untranslatable propagate` runs partial
articles and taints their results. JSON example files hold questions, not the law's
logic; the declarative knowledge is in `knowledge/**/*.pl`.

## Write a native Prolog rule

This is a complete illustrative rulework, with a threshold in eurocents:

```prolog
law(illustrative_rule).
law_property("valid_from", "2025-01-01").
article("1", "Illustrative income threshold, not a real entitlement.").
parameter("1", "income", number, true, false).
output("1", "eligible", boolean, false).
rule("1", "eligible", eligibility, ["income"]).

eligibility(Scope, true) :-
    binding(Scope, "income", decimal(Mantissa, Scale)),
    Limit is 200000 * 10^Scale,
    Mantissa < Limit.
eligibility(Scope, false) :-
    binding(Scope, "income", decimal(Mantissa, Scale)),
    Limit is 200000 * 10^Scale,
    Mantissa >= Limit.
```

`rule(Article, Output, Predicate, Inputs)` connects an article output to an ordinary
Prolog predicate taking the evaluation scope and result. Its named inputs become
`binding(Scope, Name, Value)` facts. The scope keeps separate calls and collection
elements apart. Numbers use `decimal(Mantissa, Scale)`, meaning
`Mantissa × 10^(-Scale)`; integer arithmetic stays exact.

The [native example](knowledge/examples/illustrative-benefit.pl) also calculates
an amount and handles unknown input:

```sh
node eyelee.js knowledge/examples --query examples/prolog-benefit.json
```

It derives `eligible = true` and `amount = 12345.68`. Changing its Prolog threshold
changes those answers. See [SEMANTICS.md](SEMANTICS.md) for metadata predicates,
the value model, and the supported eyelang subset.

## Examples

| Question in `examples/` | What it shows |
| --- | --- |
| `zorgtoeslag-2025.json` | Five-law chain, registers, an open term, and Awb hooks |
| `bezwaartermijn-vreemdelingenwet.json` | Hooks and an override (lex specialis) |
| `erfgrens-amsterdam.json` | A municipality filling a term only within its territory |
| `bijstand-diemen.json` | Co-government and a social-assistance reduction |
| `unknown-facts.json` | Missing facts remain unknown and are named |
| `prolog-benefit.json` | Native Prolog clauses with exact scaled-decimal arithmetic |

## Scenarios and imports

```sh
npm test
npm run conformance
```

The unchanged upstream fixtures cover 177 passing scenarios, one scenario skipped
because upstream marks it `@wip`, and 56 passing golden cases. The generated
regelrecht knowledge has 38 `.pl` files for 33 law identities and their versions.
Golden YAML inputs are explicitly converted before evaluation through the same
Prolog path.

Runtime knowledge lives in `knowledge/`; the original material under
`conformance/regelrecht/` remains the conformance reference. To regenerate the
imported knowledge and grammar from it:

```sh
npm run import:regelrecht
node scripts/manifest.js
```

Regeneration replaces imported `.pl` files. Native knowledge under
`knowledge/examples/` is maintained separately. The runtime grammar is
`knowledge/regelrecht/grammar.pl`; `.feature` scenarios retain the upstream
vocabulary and files. The conversion scripts are the only law-loading path that
reads YAML. The CLI and playground load `.pl` knowledge.

To run scenario directories explicitly:

```sh
node eyelee.js knowledge/regelrecht/regulation --scenarios conformance/regelrecht
```

## Playground

Run `node src/playground-server.js` and open
http://127.0.0.1:8000/playground.html. Choose a question or law and press
**Evaluate** (Ctrl/⌘ + Enter). **Run a scenario** runs any selected `.feature`
file, including edited text. The browser loads the same `.pl` knowledge and
executes the same pinned eyelang reasoner as the CLI.

## Library

```js
import { Engine } from './src/index.js';

const engine = new Engine();
engine.loadLaw(prologText);
engine.setDataSource({ name: 'brp', key: 'bsn', records: [{ bsn: '999993653', leeftijd: 35 }] });
const result = engine.evaluate('participatiewet', ['uitkering_bedrag'], { bsn: '999993653' }, '2025-01-01');
result.outputs;      // exact decimals, booleans, text, dates, lists, records, Unknown
result.provenance;   // direct, reactive, override, or voided
result.trace;        // article derivations and supporting Prolog evidence
```

`compileRulework(object)` converts a rulework data object to `.pl` source.
`importRuleworkYaml(text)` is the explicit migration adapter for existing YAML.
`Engine.loadLaw` accepts Prolog source or a data object compiled to Prolog; it
does not interpret YAML text.

## Execution and limits

- eyelang derives expression dependencies, selected branches, Kleene boolean
  results, collection execution, and native Prolog rule answers.
- eyelee selects law versions, resolves registers and cross-law references,
  enforces nullability, and applies open terms, territorial scope, hooks, and
  overrides. Grounded decimal, structural-value, and calendar operations supply
  facts to the reasoner. Amounts do not pass through binary64 arithmetic.
- Every expression result has supporting Prolog evidence. Domain replies retain
  the requests and premises that led to them; Reason output shows concrete
  calculations and the legal execution chain.
- Untranslatable constructs retain `error`, `propagate`, `warn`, and `ignore`
  behavior. Notes retain exact and fuzzy legal-text anchoring.
- The engine does not implement unit checking, stage-by-stage Awb procedures,
  or execution receipts. Native rules must produce one ground result per output.
  eyelang is a finite-value, tabled Prolog subset, not a complete Prolog system;
  arbitrary native rules can fail to terminate.

## Layout

| Path | Contents |
| --- | --- |
| `knowledge/regelrecht/` | Imported Prolog laws and scenario grammar |
| `knowledge/runtime.pl` | Prolog expression-control and collection clauses |
| `knowledge/examples/` | Native Prolog examples |
| `src/reasoner.js` | Scoped requests, exact domain replies, and Prolog proof evidence |
| `src/prolog-compiler.js` · `src/prolog-values.js` | Rulework import, metadata, and value encoding |
| `src/engine.js` | Legal versions, articles, inputs, open terms, hooks, and overrides |
| `src/operations.js` · `src/decimal.js` · `src/values.js` | Grounded domain primitives, exact amounts, and dates |
| `vendor/eyelang/` | Pinned eyelang v0.1.0 source, license, commit, and checksum |
| `conformance/regelrecht/` | Unchanged upstream corpus, grammar, scenarios, and golden cases |
| `scripts/import-regelrecht.js` | Reproducible conversion from upstream fixtures |
| `test/` | Conformance, native-rule, compiler, browser-asset, and website-path tests |

## License

MIT for eyelee and the vendored eyelang reasoner; see their license files.
The upstream material in `conformance/regelrecht/` and its converted derivatives
in `knowledge/regelrecht/` retain EUPL-1.2. Their provenance is recorded in each
knowledge directory's documentation.
