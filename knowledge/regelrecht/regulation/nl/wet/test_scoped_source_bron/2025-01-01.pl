% test_scoped_source_bron, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_scoped_source_bron").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.7/schema/v0.5.7/schema.json").
law_property("name", "Testwet gescoopte databron (bron)").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999907").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_scoped_source_bron").
article("1", "Het toetsingsinkomen is het tweevoud van het in de registratie opgenomen inkomen.").
article_property("1", "url", "https://example.com/test_scoped_source_bron/1").
execution_property("1", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("1", "input", [
  record([
    field("name", "inkomen"),
    field("type", "number"),
    field("source", record([])),
    field("description", "Inkomen uit de registratie, buiten de wet opgelost.")
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "inkomen"),
    field("type", "number")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "inkomen"),
    field("value", expression("test_scoped_source_bron@2025-01-01/expression1/1"))
  ])
]).

ee_reference("test_scoped_source_bron@2025-01-01/expression1/2", "inkomen").
ee_literal("test_scoped_source_bron@2025-01-01/expression1/3", decimal(2, 0)).
ee_arguments("test_scoped_source_bron@2025-01-01/expression1/1", ["test_scoped_source_bron@2025-01-01/expression1/2", "test_scoped_source_bron@2025-01-01/expression1/3"]).
ee_primitive("test_scoped_source_bron@2025-01-01/expression1/1", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
