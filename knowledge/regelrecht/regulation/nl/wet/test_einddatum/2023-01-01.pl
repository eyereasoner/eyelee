% test_einddatum, in force from 2023-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_einddatum").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/heads/main/schema/v0.5.3/schema.json").
law_property("name", "Testwet einddatum").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999902").
law_property("publication_date", "2023-01-01").
law_property("valid_from", "2023-01-01").
law_property("valid_to", "2024-12-31").
law_property("url", "https://example.com/test_einddatum").
article("1", "Het normbedrag bedraagt 500 eurocent.").
article_property("1", "url", "https://example.com/test_einddatum/1").
execution_property("1", "output", [
  record([
    field("name", "normbedrag"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "normbedrag"),
    field("value", expression("test_einddatum@2023-01-01/expression1/1"))
  ])
]).

article("2", "Deze wet vervalt met ingang van 1 januari 2025.").
article_property("2", "url", "https://example.com/test_einddatum/2").

ee_literal("test_einddatum@2023-01-01/expression1/1", decimal(500, 0)).
