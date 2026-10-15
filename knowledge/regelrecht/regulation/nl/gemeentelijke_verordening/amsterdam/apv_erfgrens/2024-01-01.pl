% apv_erfgrens_amsterdam, in force from 2024-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("apv_erfgrens_amsterdam").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.0/schema/v0.5.0/schema.json").
law_property("uuid", "a0a0a0a0-a0a0-a0a0-a0a0-a0a0a0a00363").
law_property("regulatory_layer", "GEMEENTELIJKE_VERORDENING").
law_property("publication_date", "2024-01-01").
law_property("valid_from", "2024-01-01").
law_property("gemeente_code", "GM0363").
law_property("officiele_titel", "Algemene Plaatselijke Verordening Amsterdam - Erfgrensbeplanting").
law_property("url", "https://lokaleregelgeving.overheid.nl/CVDR000000/amsterdam/apv_erfgrens").
law_property("legal_basis", [
  record([
    field("law_id", "burgerlijk_wetboek_boek_5"),
    field("article", "42"),
    field("description", "Lid 2 - gemeente kan kleinere afstand dan 2m/0,5m toestaan")
  ])
]).
article("2.75", "Afstand van bomen, heesters en heggen tot de erfgrens\n\n1. In afwijking van artikel 5:42 lid 2 van het Burgerlijk Wetboek bedraagt\nde afstand voor bomen in het centrum van Amsterdam (postcodegebied 1011-1018)\neen meter.\n\n2. Voor heesters en heggen geldt in heel Amsterdam de afstand van\neen halve meter als bedoeld in artikel 5:42 lid 2 van het Burgerlijk Wetboek.\n").
article_property("2.75", "url", "https://lokaleregelgeving.overheid.nl/CVDR000000/amsterdam/apv_erfgrens#artikel2.75").
article_rule("2.75", "implements", [
  record([
    field("law", "burgerlijk_wetboek_boek_5"),
    field("article", "42"),
    field("open_term", "gemeentelijke_afstand_cm"),
    field("gelet_op", "Gelet op artikel 5:42 lid 2 van het Burgerlijk Wetboek")
  ])
]).
execution_property("2.75", "parameters", [
  record([
    field("name", "type_beplanting"),
    field("type", "string"),
    field("required", true),
    field("description", "Type beplanting - \"boom\" of \"heg_of_heester\"")
  ]),
  record([
    field("name", "postcode"),
    field("type", "number"),
    field("required", false),
    field("description", "Postcodegebied van de locatie (4-cijferig)")
  ])
]).
execution_property("2.75", "output", [
  record([
    field("name", "gemeentelijke_afstand_cm"),
    field("type", "number"),
    field("nullable", true),
    field("description", "Gemeentelijke afstand tot erfgrens in centimeters")
  ])
]).
execution_property("2.75", "actions", [
  record([
    field("output", "gemeentelijke_afstand_cm"),
    field("value", expression("apv_erfgrens_amsterdam@2024-01-01/expression1/1"))
  ])
]).

ee_reference("apv_erfgrens_amsterdam@2024-01-01/expression1/4", "type_beplanting").
ee_literal("apv_erfgrens_amsterdam@2024-01-01/expression1/5", "boom").
ee_arguments("apv_erfgrens_amsterdam@2024-01-01/expression1/3", ["apv_erfgrens_amsterdam@2024-01-01/expression1/4", "apv_erfgrens_amsterdam@2024-01-01/expression1/5"]).
ee_primitive("apv_erfgrens_amsterdam@2024-01-01/expression1/3", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("apv_erfgrens_amsterdam@2024-01-01/expression1/7", "postcode").
ee_literal("apv_erfgrens_amsterdam@2024-01-01/expression1/8", decimal(1011, 0)).
ee_arguments("apv_erfgrens_amsterdam@2024-01-01/expression1/6", ["apv_erfgrens_amsterdam@2024-01-01/expression1/7", "apv_erfgrens_amsterdam@2024-01-01/expression1/8"]).
ee_primitive("apv_erfgrens_amsterdam@2024-01-01/expression1/6", "GREATER_THAN_OR_EQUAL", record([field("operation", "GREATER_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_reference("apv_erfgrens_amsterdam@2024-01-01/expression1/10", "postcode").
ee_literal("apv_erfgrens_amsterdam@2024-01-01/expression1/11", decimal(1018, 0)).
ee_arguments("apv_erfgrens_amsterdam@2024-01-01/expression1/9", ["apv_erfgrens_amsterdam@2024-01-01/expression1/10", "apv_erfgrens_amsterdam@2024-01-01/expression1/11"]).
ee_primitive("apv_erfgrens_amsterdam@2024-01-01/expression1/9", "LESS_THAN_OR_EQUAL", record([field("operation", "LESS_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "LESS_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_logical("apv_erfgrens_amsterdam@2024-01-01/expression1/2", "AND", ["apv_erfgrens_amsterdam@2024-01-01/expression1/3", "apv_erfgrens_amsterdam@2024-01-01/expression1/6", "apv_erfgrens_amsterdam@2024-01-01/expression1/9"]).
ee_literal("apv_erfgrens_amsterdam@2024-01-01/expression1/12", decimal(100, 0)).
ee_reference("apv_erfgrens_amsterdam@2024-01-01/expression1/14", "type_beplanting").
ee_literal("apv_erfgrens_amsterdam@2024-01-01/expression1/15", "heg_of_heester").
ee_arguments("apv_erfgrens_amsterdam@2024-01-01/expression1/13", ["apv_erfgrens_amsterdam@2024-01-01/expression1/14", "apv_erfgrens_amsterdam@2024-01-01/expression1/15"]).
ee_primitive("apv_erfgrens_amsterdam@2024-01-01/expression1/13", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("apv_erfgrens_amsterdam@2024-01-01/expression1/16", decimal(50, 0)).
ee_literal("apv_erfgrens_amsterdam@2024-01-01/expression1/17", null).
ee_conditional("apv_erfgrens_amsterdam@2024-01-01/expression1/1", [case("apv_erfgrens_amsterdam@2024-01-01/expression1/2", "apv_erfgrens_amsterdam@2024-01-01/expression1/12"), case("apv_erfgrens_amsterdam@2024-01-01/expression1/13", "apv_erfgrens_amsterdam@2024-01-01/expression1/16")], "apv_erfgrens_amsterdam@2024-01-01/expression1/17").
