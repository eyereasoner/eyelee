# regelrecht conformance material

This directory is a verbatim copy of test material from
[regelrecht](https://github.com/MinBZK/regelrecht) (mirrored at
NederlandseDigitaleDienst/regelrecht), commit
`804d30885b4cefab25353a91ea41e0fede2e8963` (2026-10-14). It is licensed under
the EUPL-1.2 (see `LICENSE.EUPL-1.2.txt`), unlike the eyelee code itself.

| Path | Upstream | Use |
|------|----------|-----|
| `regulation/` | `corpus/regulation/` | The rulework corpus: real Dutch laws and synthetic `test_*` laws, with law-validation scenarios (bucket A) next to them |
| `bdd/grammar.yaml` | `bdd/grammar.yaml` | The canonical, engine-neutral Gherkin vocabulary |
| `bdd/conformance/` | `bdd/conformance/` | The engine-conformance scenarios (bucket B) |
| `fixtures/` | `packages/engine/tests/fixtures/` | Golden JSON cases generated from the earlier Python engine |

eyelee reads none of the upstream code: only the format, the vocabulary and
the expected outcomes.
