% test_scoped_source_afnemer, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_scoped_source_afnemer").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.7/schema/v0.5.7/schema.json").
law_property("name", "Testwet gescoopte databron (afnemer)").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999908").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_scoped_source_afnemer").
article("1", "De uitkomst is het toetsingsinkomen, bedoeld in artikel 1 van de Testwet gescoopte databron (bron).").
article_property("1", "url", "https://example.com/test_scoped_source_afnemer/1").
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
    field("source", record([
      field("regulation", "test_scoped_source_bron"),
      field("output", "inkomen"),
      field("parameters", record([
        field("bsn", expression("test_scoped_source_afnemer@2025-01-01/expression2/1"))
      ]))
    ]))
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "uitkomst"),
    field("type", "number")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "uitkomst"),
    field("value", expression("test_scoped_source_afnemer@2025-01-01/expression1/1"))
  ])
]).

ee_reference("test_scoped_source_afnemer@2025-01-01/expression1/1", "inkomen").
ee_reference("test_scoped_source_afnemer@2025-01-01/expression2/1", "bsn").
