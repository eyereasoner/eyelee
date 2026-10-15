# eyelee semantics

eyelee executes Prolog knowledge with eyelang and applies the regelrecht
public contract for legal execution. The unchanged upstream scenarios and golden
cases remain the behavioral reference. Choices left open by that contract are
marked **Choice** below. A rulework is an interpretation of the law, not the law;
execution and conformance results do not establish legal validity.

## Prolog knowledge and reasoner boundary

Runtime laws and the scenario grammar use `.pl`, with the Prolog syntax supported
by the eyelang v0.6.2 npm dependency. `package.json` pins its version and
`package-lock.json` records its registry source and integrity. CLI modules import
`eyelang/src/language.js`; the browser import map resolves that same module to
an unchanged local copy from the installed package. Website staging includes
the source and its MIT license. The reasoner runs in both CLI and browser.

**Choice:** retain a domain boundary for registers, exact `Dec` arithmetic,
calendar operations, and structural values. `knowledge/runtime.pl` controls
expression dependencies, first-matching IF branches, short-circuiting Kleene
AND/OR, collection filters, and which bodies run. The host supplies only the
grounded requests derived by these clauses; it does not execute an alternative
JavaScript expression interpreter. eyelang then derives the expression answer.
Native Prolog predicates can perform arithmetic and comparisons directly.

Law-version selection, article parameters and inputs, cross-law execution, open
terms, hooks, overrides, nullability enforcement, and note anchoring remain in
the legal coordinator. This boundary preserves those behaviors while sharing
one logical inference implementation with eyelang.

The runtime metadata predicates are:

| Predicate | Meaning |
| --- | --- |
| `law(Id)` | Exactly one law identity per file |
| `law_property(Name, Value)` | Version, regulatory layer, territory, and other law metadata |
| `article(Number, Text)` | Article identity and legal text |
| `article_property(Number, Name, Value)` | Other article metadata such as its URL |
| `definition(Number, Name, Value)` | A named definition, possibly an expression |
| `article_rule(Number, Name, Value)` | Open terms, hooks, overrides, and other machine-readable declarations |
| `execution_property(Number, Name, Value)` | Imported execution declarations and action order |
| `parameter(Number, Name, Type, Required, Nullable)` | Compact native parameter declaration |
| `output(Number, Name, Type, Nullable)` | Compact native output declaration |
| `rule(Number, Output, Predicate, Inputs)` | Native `Predicate(Scope, Value)` producing an output |

Metadata records are `record([field(Name, Value), ...])`; arrays use proper
Prolog lists. Text uses double quotes, booleans use `true` / `false`, absence
uses `null`, unknown values use `unknown([MissingName, ...])`, and numbers use
`decimal(Mantissa, Scale)`. Amounts never travel through Prolog binary64 literals;
a bare integer is also an exact numeric result. `decimal/2` requires an integer
mantissa and a nonnegative safe-integer scale.

`rule/4` names the input references it reads. The coordinator resolves these
under the same parameter/input rules as any imported expression and supplies
`binding(Scope, Name, Value)` facts. A native predicate must derive exactly one
ground value. No value is a reasoner error; distinct values are an ambiguity
error. Missing facts and absence need explicit clauses just as ordinary native
Prolog values do. Separate evaluations and collection elements have separate
scopes. A rulework contains knowledge, not top-level queries or assertions;
`Engine.evaluate` supplies the scoped question and performs the legal checks.

Imported expressions use `ee_literal`, `ee_reference`, `ee_arguments`,
`ee_primitive`, `ee_conditional`, `ee_logical`, and `ee_foreach` facts. These are
domain predicates with ordinary Prolog term syntax; their executable clauses
are in `knowledge/runtime.pl`. `expression(Id)` links an action or definition
to its result. Generated runtime source is embedded in `src/runtime-program.js`
so synchronous library calls and the browser use the same checked-in clauses;
a regression test verifies byte-for-byte agreement with the `.pl` source.

The structured trace retains the complete selected Prolog proof, including the
request premises behind grounded host replies. Human-readable Reason output
shows concrete operations, native arithmetic checks, and the legal article
chain. A proof records the selected derivation; it is not an independent
certificate of the truth of supplied register data or legal interpretation.

**Choice:** the original upstream YAML corpus and grammar remain unchanged as
conformance fixtures. `scripts/import-regelrecht.js` converts them reproducibly
to `.pl`; golden inputs use the same explicit import adapter before execution.
The CLI, library's law loader, and browser evaluate Prolog source. Imported
files may be regenerated intentionally; native examples are maintained separately.

## Values

| Value | Meaning |
|-------|---------|
| `null` | **Absent.** The register is authoritative and says there is none (no partner, no rent). |
| *unknown* | **A fact nobody has yet.** It carries the names of the missing facts. |
| boolean, text | As written. |
| number | An exact decimal (BigInt mantissa and scale). Addition, subtraction and multiplication are exact; division carries 28 decimal places with half-up rounding. Other arithmetic does not round implicitly. |
| date | Text in canonical `YYYY-MM-DD`. `$referencedate` is the record `{iso, year, month, day}` of the calculation date. |
| list, record | As in JSON. |

A string that starts with `$` is a reference. `$a.b` reads field `b` of record
`a`. A field of an absent record is absent. A field of an unknown record is
unknown. A field missing from a record is unknown for lack of `a.b`.

## The two kinds of nothing (RFC-036)

- An **absent** value may be tested (`EQUALS … null`, `IN`) and passed on.
  Calculating with it, ordering it, or deciding on it (`NOT`, `AND`, `OR`, an
  `IF` condition, a `FOREACH` filter or combine) is an error:
  `OP: operand is null (absent) …`.
- An **unknown** value propagates through every operation. The result names the
  union of the missing facts. A definite operand still decides: `AND` with a
  `false` is `false`, `OR` with a `true` is `true`. An `IF` whose condition is
  unknown is unknown; it takes neither its branch nor its default.
  `EQUALS` and `IN` are unknown when either side holds an unknown anywhere
  inside it. The exception is `IN` with a definite match, which is `true`.
- `nullable` is part of a field's declaration and defaults to `false`. A
  `null` that reaches a parameter, input or output declared never absent is
  refused where it arrives, and the message names where it came from
  (`source register`, `parameter from caller`, `parameter from <law>`,
  `<law>.<output>`, `skipped call to <law>`).

## Versions

A law's versions share its `$id`. On a calculation date the engine takes the
latest version with `valid_from <= date`. A version without `valid_from` is
always in force. If that version has a `valid_to` before the date, the law has
**ended**: there is no fall-back to an older version, and the error states the
data fact (`No version of law 'x' in force on D; last in force until E`).

## Executing an article

An output is computed by the article that declares it. Executing an article
runs all of its actions, so an error in any action fails the whole article.
The order of a run is:

1. **Untranslatables / markings.** Mode `error` (the default) and `ignore`
   refuse an unaccepted construct. `warn` runs the partial logic and notes it.
   `propagate` runs it and taints every output of the article, and with it
   every output that reads one of them.
2. **Parameters.** A passed parameter must respect `nullable`. At the top level
   a `null` for a parameter that is not nullable is the caller's error
   (`… cannot be evaluated for nobody …`). An optional parameter that is not
   passed is unknown for lack of itself. **Choice:** a *required* parameter
   that is not passed is an error only when the article actually reads it.
   The corpus scenarios rely on this: the Participatiewet runs without
   `gemeente_code`, and a test about a spouse's age is never reached for
   someone unmarried.
3. **Inputs**, every one of them, in declaration order. Earlier inputs can feed
   later ones. An input resolves by the first that applies:
   1. a parameter of the same name passed by the caller (it bypasses the
      register, never the declaration);
   2. a data source, if one has a record for the key and holds the field.
      Sources bound to this law come first, then unbound ones, by priority.
      **Choice:** this also holds for an input that names another law, so an
      unbound register column shadows a cross-law input of the same name
      (the scoped-data-source scenarios pin exactly this);
   3. `source.output` (with `source.regulation` for another law): the other
      law's output, evaluated with `source.parameters`. Without
      `parameters`, a reference into the same law passes the caller's
      parameters through. A *required* parameter of the target that is `null`
      skips the call and yields `null`, unless the target declares it nullable.
      If it is unknown, the call is skipped and the input is that unknown. An
      explicit call that leaves out a required parameter of the target is an
      error, so a misspelled key cannot quietly become an unknown outcome;
   4. otherwise it is unknown for lack of the input's name.
4. **Open terms.** Every regulation whose article `implements` this term and
   is in force is a candidate. A regulation carrying `gemeente_code`,
   `provincie_code` or `waterschap_code` applies only where the parameters
   name that code. Candidates are ordered by lex superior (regulatory layer),
   then lex posterior (later `valid_from`). The first that gives a value
   other than `null` fills the term; a silent (`null`) regulation passes the
   turn. Otherwise the term's `default` actions apply, then `null` if the term
   is optional. A required term with neither is an error. An implementation
   that reads the law it fills sees that law *without its own filling*.
5. **Hooks before** (`pre_actions`), then the **actions**, in dependency
   order: reading an output of the same article computes it first. If an
   output is assigned more than once, the last assignment wins. Imported actions retain the source contract’s value/operation distinction;
   each is compiled to a Prolog expression result. Native actions use `rule/4`.
6. **Overrides.** An output is replaced (or voided, `voids: true`) by an
   `overrides` declaration from a law that is in the execution chain, or from
   the same law. The overriding article sees the general rule with this
   override held back. A voided output is not in the result; reading it is an
   error saying it does not arise.
7. **Outputs** declared never absent must not be `null`
   (`output 'x' of L evaluated to null … not declared nullable`).
8. **Hooks after** (`post_actions`).

**Choice:** hooks fire for the articles evaluated at the top level, which is
the decision being taken. A hook applies when its `applies_to.legal_character`
(and `decision_type`, if given) matches the article's `produces`, or when its
`applies_to.submission` matches `produces.submission.kind`. A plain evaluation
is the decision itself, the `BESLUIT` stage of the Awb procedure, so hooks for
later stages (`BEKENDMAKING`, …) do not fire. Hook outputs join the result
with **reactive** provenance, or **override** provenance when an override
replaced them. The requested outputs and the other outputs of their articles
are **direct**.

**Choice:** a result holds every output of the articles that were executed, not
only the requested ones. The corpus scenarios evaluate one output and assert
its siblings.

## Operations

| Operation | Semantics |
|-----------|-----------|
| `ADD` `SUBTRACT` `MULTIPLY` `DIVIDE` | Over `values`, left to right. Division by zero is an error. `ADD` concatenates if all operands are text, and flattens lists. |
| `MIN` `MAX` | Over the flattened `values`; numbers or dates. An empty list gives `null`. |
| `EQUALS` | Structural: numbers by value, a date string equal to the `{iso…}` form of that date, lists and records element-wise. `42` is not `"42"`. |
| `GREATER_THAN` … `LESS_THAN_OR_EQUAL` | Numbers numerically; two dates chronologically. `value` is required. |
| `AND` `OR` | Kleene logic over booleans, short-circuiting on the deciding value. |
| `NOT` | Boolean negation. |
| `IF` | The first case whose `when` holds; otherwise `default`, or `null` without one. (`SWITCH` is accepted as an alias.) |
| `IN` | Membership in `values` (inline) or `value` (a list, or a single value). |
| `LIST` | The evaluated `items`. |
| `FOREACH` | See below. |
| `ROUND` `CEIL` `FLOOR` | To `precision` decimal places, which may be negative. `ROUND` is half-up (ties away from zero). |
| `AGE` | Complete years from `date_of_birth` to `reference_date`. |
| `DATE_ADD` | Years, then months (clamped to the month's last day: 31 Jan + 1 month = 28/29 Feb), then weeks and days. |
| `DATE` | From year, month and day; an impossible date is an error. |
| `DAY_OF_WEEK` | 0 = Monday … 6 = Sunday. |
| `DATE_DIFF` | Signed, `in: days / months / years`. Months and years count complete calendar units with the same clamping, so 31 Jan to 28 Feb is one month. |
| `DATE_PART` | `in: year / month / day`. |
| `START_OF` | `in: year / month`. |

`FOREACH` evaluates `collection`: `null` is empty and a single value iterates
once. At most 1000 elements. Each element gets a fresh scope binding `as`
(default `item`) and, for a record, its fields. Outer `FOREACH` bindings are
*not* visible inside, so an outer element reaches an inner iteration only
through `collection`. An element whose `filter` is `false` is skipped; an
unknown filter makes the result unknown. `combine` is `ADD` (empty: `0`),
`MIN`/`MAX` (empty: `null`), `AND` (empty: `true`) or `OR` (empty: `false`).
Without it, the result is the list. An unknown body makes `ADD`/`MIN`/`MAX`
unknown, and `AND`/`OR` follow Kleene logic.

Operation nesting is bounded at 100 levels and cross-law calls at 20. A cycle
between articles is an error.

## Scenarios

Scenarios are Gherkin in the vocabulary of regelrecht's `bdd/grammar.yaml`.
The runtime reads its reproducible Prolog conversion,
`knowledge/regelrecht/grammar.pl`; it does not hard-code the step sentences. A
quoted value or a table cell is typed by its content: `true`, `false`, `null`
(absence), JSON lists and records, numbers, and otherwise text. An empty table
cell leaves the value out, which makes it unknown. A feature runs if all of its
`@tier:` tags are supported; eyelee supports `core`, `provenance`,
`untranslatable` and `notes`. Scenarios tagged `@wip` are skipped.

## Notes

A note anchors to legal text with an exact quote plus optional prefix and
suffix. Resolution first looks for exact occurrences whose surroundings match:
one is *found*, several are *ambiguous*. If there are none, it scores windows
of the quote's length ±30% that share a significant word with it, using
`0.5·sim(quote) + 0.25·sim(prefix) + 0.25·sim(suffix)` with normalised
Levenshtein similarity. A score of at least 0.7 counts. Overlapping
candidates collapse to the best one. A single candidate, or one more than
0.1 ahead of the runner-up, is *found* (fuzzy); several close candidates are
*ambiguous*; none at all is *orphaned*. An article-number hint never decides:
the note follows the text.

## Not implemented

- Unit checking (`type_spec.unit`). Units are labels; eyelee does not yet
  refuse combining, say, `eurocent` with `days`.
- Stage-by-stage procedure execution (yielding between Awb stages).
- `resolve` actions, `valid_from: '#…'` references, and execution receipts
  with content hashes.
