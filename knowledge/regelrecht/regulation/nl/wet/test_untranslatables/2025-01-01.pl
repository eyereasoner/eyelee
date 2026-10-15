% test_untranslatables, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_untranslatables").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.1/schema/v0.5.1/schema.json").
law_property("name", "Testwet onvertaalbare constructies").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999901").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_untranslatables").
article("1", "De basistoeslag bedraagt 1000 eurocent.").
article_property("1", "url", "https://example.com/test_untranslatables/1").
execution_property("1", "output", [
  record([
    field("name", "basistoeslag"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "basistoeslag"),
    field("value", expression("test_untranslatables@2025-01-01/expression1/1"))
  ])
]).

article("2", "Het bedrag wordt naar boven afgerond op hele euro's.").
article_property("2", "url", "https://example.com/test_untranslatables/2").
article_rule("2", "untranslatables", [
  record([
    field("construct", "afronden op hele euro's"),
    field("reason", "Rounding is not available as an engine operation"),
    field("suggestion", "Add ROUND/CEIL operation to engine"),
    field("legal_text_excerpt", "Het bedrag wordt naar boven afgerond op hele euro's"),
    field("accepted", false)
  ])
]).
execution_property("2", "parameters", [
  record([
    field("name", "bedrag"),
    field("type", "number")
  ])
]).
execution_property("2", "output", [
  record([
    field("name", "afgerond_bedrag"),
    field("type", "number"),
    field("description", "Rounding NOT applied — value is unrounded")
  ])
]).
execution_property("2", "actions", [
  record([
    field("output", "afgerond_bedrag"),
    field("value", expression("test_untranslatables@2025-01-01/expression2/1"))
  ])
]).

article("3", "De toegekende toeslag bedraagt tweemaal de basistoeslag.").
article_property("3", "url", "https://example.com/test_untranslatables/3").
execution_property("3", "input", [
  record([
    field("name", "basistoeslag"),
    field("type", "amount"),
    field("source", record([
      field("output", "basistoeslag")
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("3", "output", [
  record([
    field("name", "toegekende_toeslag"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("3", "actions", [
  record([
    field("output", "toegekende_toeslag"),
    field("value", expression("test_untranslatables@2025-01-01/expression3/1"))
  ])
]).

article("4", "De deeltoeslagen worden naar redelijkheid vastgesteld en opgeteld. Dit artikel is geaccepteerd als onvertaalbaar.").
article_property("4", "url", "https://example.com/test_untranslatables/4").
article_rule("4", "untranslatables", [
  record([
    field("construct", "naar redelijkheid vaststellen van een deeltoeslag"),
    field("reason", "An open norm requiring judgement; the engine cannot determine what is reasonable in a given case."),
    field("suggestion", "Requires a human decision, or a lower regulation filling the norm in via open_terms (RFC-003)."),
    field("legal_text_excerpt", "De deeltoeslagen worden naar redelijkheid vastgesteld"),
    field("accepted", true)
  ])
]).
execution_property("4", "output", [
  record([
    field("name", "som_deeltoeslagen"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("4", "actions", [
  record([
    field("output", "som_deeltoeslagen"),
    field("value", expression("test_untranslatables@2025-01-01/expression4/1"))
  ])
]).

ee_literal("test_untranslatables@2025-01-01/expression1/1", decimal(1000, 0)).
ee_reference("test_untranslatables@2025-01-01/expression2/1", "bedrag").
ee_reference("test_untranslatables@2025-01-01/expression3/2", "basistoeslag").
ee_literal("test_untranslatables@2025-01-01/expression3/3", decimal(2, 0)).
ee_arguments("test_untranslatables@2025-01-01/expression3/1", ["test_untranslatables@2025-01-01/expression3/2", "test_untranslatables@2025-01-01/expression3/3"]).
ee_primitive("test_untranslatables@2025-01-01/expression3/1", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
ee_literal("test_untranslatables@2025-01-01/expression4/1", decimal(0, 0)).
