# Prolog conversion of the regelrecht contract

These files are generated from `conformance/regelrecht/`, upstream commit
`804d30885b4cefab25353a91ea41e0fede2e8963` (2026-10-14).
They preserve the upstream EUPL-1.2 license; see `LICENSE.EUPL-1.2.txt`.

Run `npm run import:regelrecht` from the project root to reproduce the conversion.
The import preserves legal text, declarations, parameters, references, defaults,
hooks, overrides, and operation semantics. It encodes expression dependencies
as Prolog facts evaluated by `knowledge/runtime.pl` through eyelang. The original
YAML, grammar, scenarios, and golden inputs remain unchanged as test fixtures.

Generated `.pl` is the runtime format. Native clauses can also be authored with
`law/1`, `article/2`, `parameter/5`, `output/4`, and `rule/4`; see
`knowledge/examples/illustrative-benefit.pl`.
