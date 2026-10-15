% test_null_semantics_bron, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_null_semantics_bron").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.8/schema/v0.5.8/schema.json").
law_property("name", "Testwet afwezig en onbekend (bron)").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999909").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_null_semantics_bron").
article("1", "Het geboortejaar is het in de registratie opgenomen geboortejaar. Een aanvraag past indien het aangevraagde bedrag meer dan honderd bedraagt.").
article_property("1", "url", "https://example.com/test_null_semantics_bron/1").
execution_property("1", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ]),
  record([
    field("name", "aanvraag_bedrag"),
    field("type", "number"),
    field("required", false)
  ])
]).
execution_property("1", "input", [
  record([
    field("name", "geboortejaar"),
    field("type", "number"),
    field("source", record([])),
    field("description", "Geboortejaar uit de registratie, buiten de wet opgelost.")
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "geboortejaar"),
    field("type", "number")
  ]),
  record([
    field("name", "past_aanvraag"),
    field("type", "boolean")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "geboortejaar"),
    field("value", expression("test_null_semantics_bron@2025-01-01/expression1/1"))
  ]),
  record([
    field("output", "past_aanvraag"),
    field("value", expression("test_null_semantics_bron@2025-01-01/expression2/1"))
  ])
]).

ee_reference("test_null_semantics_bron@2025-01-01/expression1/1", "geboortejaar").
ee_reference("test_null_semantics_bron@2025-01-01/expression2/2", "aanvraag_bedrag").
ee_literal("test_null_semantics_bron@2025-01-01/expression2/3", decimal(100, 0)).
ee_arguments("test_null_semantics_bron@2025-01-01/expression2/1", ["test_null_semantics_bron@2025-01-01/expression2/2", "test_null_semantics_bron@2025-01-01/expression2/3"]).
ee_primitive("test_null_semantics_bron@2025-01-01/expression2/1", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
