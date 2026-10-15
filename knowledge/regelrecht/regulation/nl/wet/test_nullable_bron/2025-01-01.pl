% test_nullable_bron, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_nullable_bron").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.8/schema/v0.5.8/schema.json").
law_property("name", "Testwet afwezigheid als eigenschap van het type (bron)").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999913").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_nullable_bron").
article("1", "Het geboortejaar is het in de registratie opgenomen geboortejaar. Een aanvraag past indien het aangevraagde bedrag meer dan honderd bedraagt.").
article_property("1", "url", "https://example.com/test_nullable_bron/1").
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
    field("source", record([]))
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
    field("value", expression("test_nullable_bron@2025-01-01/expression1/1"))
  ]),
  record([
    field("output", "past_aanvraag"),
    field("value", expression("test_nullable_bron@2025-01-01/expression2/1"))
  ])
]).

article("2", "Iemand is degene die met een burgerservicenummer is aangeduid; zonder burgerservicenummer is er niemand.").
article_property("2", "url", "https://example.com/test_nullable_bron/2").
execution_property("2", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true),
    field("nullable", true)
  ])
]).
execution_property("2", "output", [
  record([
    field("name", "is_iemand"),
    field("type", "boolean")
  ])
]).
execution_property("2", "actions", [
  record([
    field("output", "is_iemand"),
    field("value", expression("test_nullable_bron@2025-01-01/expression3/1"))
  ])
]).

ee_reference("test_nullable_bron@2025-01-01/expression1/1", "geboortejaar").
ee_reference("test_nullable_bron@2025-01-01/expression2/2", "aanvraag_bedrag").
ee_literal("test_nullable_bron@2025-01-01/expression2/3", decimal(100, 0)).
ee_arguments("test_nullable_bron@2025-01-01/expression2/1", ["test_nullable_bron@2025-01-01/expression2/2", "test_nullable_bron@2025-01-01/expression2/3"]).
ee_primitive("test_nullable_bron@2025-01-01/expression2/1", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_nullable_bron@2025-01-01/expression3/3", "bsn").
ee_literal("test_nullable_bron@2025-01-01/expression3/4", null).
ee_arguments("test_nullable_bron@2025-01-01/expression3/2", ["test_nullable_bron@2025-01-01/expression3/3", "test_nullable_bron@2025-01-01/expression3/4"]).
ee_primitive("test_nullable_bron@2025-01-01/expression3/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("test_nullable_bron@2025-01-01/expression3/1", ["test_nullable_bron@2025-01-01/expression3/2"]).
ee_primitive("test_nullable_bron@2025-01-01/expression3/1", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
