% test_einddatum_afnemer, in force from 2023-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_einddatum_afnemer").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/heads/main/schema/v0.5.3/schema.json").
law_property("name", "Testwet einddatum afnemer").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999903").
law_property("publication_date", "2023-01-01").
law_property("valid_from", "2023-01-01").
law_property("url", "https://example.com/test_einddatum_afnemer").
article("1", "Het afgeleide bedrag is gelijk aan het normbedrag, bedoeld in artikel 1 van de Testwet einddatum.").
article_property("1", "url", "https://example.com/test_einddatum_afnemer/1").
execution_property("1", "input", [
  record([
    field("name", "normbedrag"),
    field("type", "amount"),
    field("source", record([
      field("regulation", "test_einddatum"),
      field("output", "normbedrag")
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "afgeleid_bedrag"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "afgeleid_bedrag"),
    field("value", expression("test_einddatum_afnemer@2023-01-01/expression1/1"))
  ])
]).

ee_reference("test_einddatum_afnemer@2023-01-01/expression1/1", "normbedrag").
