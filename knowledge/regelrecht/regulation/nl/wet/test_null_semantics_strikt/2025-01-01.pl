% test_null_semantics_strikt, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_null_semantics_strikt").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.8/schema/v0.5.8/schema.json").
law_property("name", "Testwet afwezig en onbekend (strikt)").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999911").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_null_semantics_strikt").
article("1", "Het geboortejaar is het geboortejaar, bedoeld in artikel 1 van de Testwet afwezig en onbekend (bron).").
article_property("1", "url", "https://example.com/test_null_semantics_strikt/1").
execution_property("1", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("1", "input", [
  record([
    field("name", "geboortejaar"),
    field("type", "number"),
    field("source", record([
      field("regulation", "test_null_semantics_bron"),
      field("output", "geboortejaar")
    ]))
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "geboortejaar"),
    field("type", "number")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "geboortejaar"),
    field("value", expression("test_null_semantics_strikt@2025-01-01/expression1/1"))
  ])
]).

ee_reference("test_null_semantics_strikt@2025-01-01/expression1/1", "geboortejaar").
