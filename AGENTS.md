# Working on eyelee

eyelee evaluates Dutch-law knowledge in Prolog `.pl` files with the eyelang
reasoner and a dependency-free JavaScript legal coordinator. It answers questions with ARC: Answer,
Reason and Check. Describe what it implements and where it stops, and keep
behaviour that has been demonstrated apart from design goals. Keep explanations
concrete, error messages specific, and user-facing text direct. Do not claim
legal validity: a rulework is an interpretation of the law, not the law.

## Independence

The legal coordinator follows the regelrecht format, built from its
public contract: the JSON schema, the documentation, `bdd/grammar.yaml`, the
conformance scenarios and the golden cases. Derive behaviour from that
contract and from the scenarios, not by translating the reference engine's
code. Where the contract leaves a choice open, make the choice deliberately
and record it as a **Choice** in `SEMANTICS.md`. Error wording that scenarios
assert (`declares as never absent`, `operand is null`, `not declared nullable`,
`No version of law '…' in force on …`, …) is part of that contract.

## Repository map

- `src/engine.js`: laws and versions, article execution (parameters, inputs,
  data sources, open terms, actions, overrides, hooks), the derivation trace
  and the Check facts.
- `knowledge/runtime.pl`: expression control flow executed by eyelang.
- `knowledge/regelrecht/`: reproducibly imported Prolog law versions and grammar.
- `knowledge/examples/`: native Prolog ruleworks.
- `vendor/eyelang/`: pinned upstream reasoner, license, commit, and checksum.
- `src/reasoner.js`: scoped requests, grounded domain replies, and proof evidence.
- `src/prolog-compiler.js`, `src/prolog-values.js`: Prolog metadata and values.
- `src/operations.js`: grounded domain operations and the rules for absent (`null`) and
  unknown values (RFC-036).
- `src/decimal.js`: exact decimal arithmetic (BigInt mantissa and scale).
- `src/values.js`: the value model, `Unknown`, and date arithmetic.
- `src/yaml.js`, `src/import-yaml.js`: explicit YAML import and conformance adapters; runtime laws are Prolog.
- `src/gherkin.js` and `src/scenarios.js`: the Gherkin reader and the scenario
  actions; step matchers are generated from `knowledge/regelrecht/grammar.pl` at run time.
- `src/notes.js`: anchoring notes to legal text (exact and fuzzy).
- `src/explain.js`: rendering Answer, Reason and Check.
- `src/corpus.js`: loading laws and scenarios from disk (Node only).
- `src/index.js`: the library exports.
- `eyelee.js`: the command-line entry point.
- `playground.html`, `src/playground.js`: the browser playground;
  `src/playground-server.js`: the local static server.
- `examples/*.json`: whole questions (law, outputs, date, parameters, data).
- `conformance/regelrecht/`: a verbatim copy of regelrecht's corpus, grammar,
  conformance scenarios and golden cases (EUPL-1.2), plus `manifest.json`.
- `test/*.test.js`: scenario, golden and unit tests.
- `SEMANTICS.md`: the semantics eyelee implements, including its choices.
- `README.md`: the introduction, usage and example index.
- `scripts/prepare-pages.js`, `scripts/pages-layout.html`: website staging.
- `scripts/import-regelrecht.js`: reproduces imported Prolog knowledge and the embedded runtime.
- `scripts/manifest.js`: regenerates `knowledge/manifest.json`.
- `scripts/sync-version.js`, `release`, `.github/workflows/`: versions,
  releases and GitHub Pages deployment.

## Commands

Node.js 18 or later is required. The project uses ES modules and has no
package dependencies or build step.

```sh
node eyelee.js knowledge/regelrecht/regulation --query examples/zorgtoeslag-2025.json
node eyelee.js knowledge/regelrecht/regulation --law vreemdelingenwet_2000 --output minister_is_bevoegd --date 2026-01-01
node eyelee.js knowledge/regelrecht/regulation --scenarios conformance/regelrecht
node src/playground-server.js
node --test test/units.test.js
npm test
node scripts/import-regelrecht.js
node scripts/manifest.js
node scripts/prepare-pages.js
git diff --check
```

The local playground is at `http://127.0.0.1:8000/playground.html`.
`prepare-pages.js` stages the website in `_pages/`, and the Pages workflow
renders it with Jekyll into `_site/`. Both directories are generated and
ignored.

## Engine and semantics

- Read the relevant section of `SEMANTICS.md` before changing behaviour. Keep
  the implementation, `SEMANTICS.md`, the README and the tests consistent.
- Keep absent and unknown apart. `null` may be tested (`EQUALS`, `IN`) but not
  calculated with or decided on. Unknown propagates and names its missing
  facts, and a definite operand still decides `AND`/`OR`. Enforce `nullable`
  where a value crosses into an article, and name where the value came from.
- Express new declarative logic with ordinary Prolog clauses and `.pl` files.
  Do not add YAML interpretation to runtime law loading or a JavaScript fallback
  for IF/AND/OR/FOREACH. The pinned eyelang source stays unmodified.
- Numbers are `Dec`. Never round implicitly and never route amounts through
  binary floats; convert to a JavaScript number only for output.
- Dates are canonical `YYYY-MM-DD` text. Month and year arithmetic clamps to
  the month's last day, and `DATE_DIFF` and `AGE` count complete units the
  same way.
- Every new behaviour should leave a trace in the Reason, and a Check where
  something was verified. An answer without its derivation is incomplete.
- Keep everything under `src/` except `corpus.js` and `playground-server.js`
  free of Node APIs, so the browser runs the same engine.

## Conformance material

- Do not edit files under `conformance/regelrecht/`. To update them, copy a
  newer upstream commit verbatim, record its hash and date in
  `conformance/regelrecht/README.md`, and run `node scripts/import-regelrecht.js` and `node scripts/manifest.js`.
- A failing upstream scenario is a question about eyelee's semantics, not a
  test to adjust. If upstream marks a scenario `@wip`, it stays skipped.
- Supported scenario tiers are `core`, `provenance`, `untranslatable` and
  `notes`. Add a tier to `SUPPORTED_TIERS` only once all of its actions work.

## Examples, website and playground

- Each example in `examples/` is a whole question with a `description`. Add a
  new example to the README table; `node scripts/manifest.js` adds it to the
  playground selector.
- Keep the same top navigation on the homepage, semantics page and playground:
  eyelee, Repository, Playground, Semantics.
- For playground changes, check the page in a real browser, not only the
  tests. For website changes, verify paths under `/eyelee/`, including
  `/playground/` and `/SEMANTICS/`.
- Full Reason output for a chain such as zorgtoeslag runs to dozens of lines.
  Inspect focused sections rather than flooding the terminal.

## Implementation and verification

Match the existing JavaScript style: two-space indentation, single-quoted
strings, semicolons, and named ES module imports and exports. Run focused tests
while making changes, and `npm test` before finishing changes to code,
examples, the manifest or release tooling. Add a regression test for each
meaningful change in behaviour. Documentation-only edits need a review and
`git diff --check`.

## Versions and releases

`package.json` is the version source. The npm `version` lifecycle hook runs
`scripts/sync-version.js`, which updates the marker in `playground.html`.
Do not edit versions by hand.

Follow the user's instructions about committing, pushing and releasing. The
release script takes `patch`, `minor` or `major`, plus an optional message
(default `Release vX.Y.Z`). When a release with the latest commit message is
requested, commit the intended changes first, then run:

```sh
./release patch "$(git log -1 --pretty=%B)"
```

The script switches to `main`, pulls with `--ff-only` when an upstream exists,
runs the tests, bumps the version, stages every change, commits, creates an
annotated tag, and pushes the branch and the tag. Review the working tree
first, because it stages everything. A push to `main` deploys GitHub Pages; a
`v*` tag runs the tests and creates the GitHub release from the tag message.
Verify the workflows and the published version after a release.
