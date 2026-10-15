% kieswet, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("kieswet").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.0/schema/v0.5.0/schema.json").
law_property("uuid", "96d926a0-b45f-4cf3-92af-01b167221a00").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2024-01-01").
law_property("valid_from", "2025-01-01").
law_property("bwb_id", "BWBR0004627").
law_property("url", "https://wetten.overheid.nl/BWBR0004627/2025-02-12").
law_property("name", "Kieswet").
article("B1", "1. De leden van de Tweede Kamer der Staten-Generaal worden gekozen door degenen die op de dag van de\nkandidaatstelling Nederlander zijn en op de dag van de stemming de leeftijd van achttien jaar hebben bereikt,\nmet uitzondering van degenen die op de dag van de kandidaatstelling hun werkelijke woonplaats hebben in Aruba,\nCuraçao of Sint Maarten.\n\n2. De uitsluiting, bedoeld in het eerste lid, geldt niet ten aanzien van:\na. Nederlanders die gedurende ten minste tien jaren ingezetene van Nederland zijn geweest;\nb. Nederlanders in Nederlandse openbare dienst in de betrokken gebiedsdelen, alsmede hun Nederlandse\nechtgenoten, geregistreerde partners of levensgezellen en kinderen, voor zover zij met hen een\ngemeenschappelijke huishouding voeren.").
article_property("B1", "url", "https://wetten.overheid.nl/BWBR0004627/2025-02-12#AfdelingII_HoofdstukB_ArtikelB1").
definition("B1", "MINIMUM_LEEFTIJD", record([
  field("value", expression("kieswet@2025-01-01/expression1/1"))
])).
execution_property("B1", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ]),
  record([
    field("name", "is_tien_jaar_ingezetene_geweest"),
    field("type", "boolean"),
    field("required", true),
    field("description", "Lid 2a — gedurende ten minste tien jaren ingezetene van Nederland geweest (false indien niet van toepassing)")
  ]),
  record([
    field("name", "is_in_openbare_dienst_bes"),
    field("type", "boolean"),
    field("required", true),
    field("description", "Lid 2b — in Nederlandse openbare dienst in Aruba/Curacao/ Sint Maarten of gezinslid daarvan (false indien n.v.t.)")
  ]),
  record([
    field("name", "verkiezingsdatum"),
    field("type", "date"),
    field("required", true),
    field("description", "Datum van de Tweede Kamerverkiezingen (dag van de stemming)")
  ]),
  record([
    field("name", "heeft_nederlandse_nationaliteit"),
    field("type", "boolean"),
    field("required", true),
    field("description", "Nederlander zijn op dag van kandidaatstelling (Art B1 lid 1)")
  ]),
  record([
    field("name", "werkelijke_woonplaats"),
    field("type", "string"),
    field("required", true),
    field("description", "Werkelijke woonplaats op dag van kandidaatstelling (Art B1 lid 1)")
  ])
]).
execution_property("B1", "input", [
  record([
    field("name", "leeftijd_op_verkiezingsdatum"),
    field("type", "number"),
    field("source", record([
      field("regulation", "wet_basisregistratie_personen"),
      field("output", "leeftijd"),
      field("parameters", record([
        field("bsn", expression("kieswet@2025-01-01/expression3/1")),
        field("peildatum", expression("kieswet@2025-01-01/expression4/1"))
      ])),
      field("description", "Leeftijd op de dag van de stemming conform art. B1 lid 1")
    ]))
  ])
]).
execution_property("B1", "output", [
  record([
    field("name", "heeft_kiesrecht_tweede_kamer"),
    field("type", "boolean")
  ])
]).
execution_property("B1", "actions", [
  record([
    field("output", "heeft_kiesrecht_tweede_kamer"),
    field("value", expression("kieswet@2025-01-01/expression2/1"))
  ])
]).

article("B5", "Van het kiesrecht zijn uitgesloten zij die bij onherroepelijke rechterlijke uitspraak van het kiesrecht zijn ontzet.").
article_property("B5", "url", "https://wetten.overheid.nl/BWBR0004627/2025-02-12#AfdelingII_HoofdstukB_ArtikelB5").

ee_literal("kieswet@2025-01-01/expression1/1", decimal(18, 0)).
ee_reference("kieswet@2025-01-01/expression2/3", "heeft_nederlandse_nationaliteit").
ee_literal("kieswet@2025-01-01/expression2/4", true).
ee_arguments("kieswet@2025-01-01/expression2/2", ["kieswet@2025-01-01/expression2/3", "kieswet@2025-01-01/expression2/4"]).
ee_primitive("kieswet@2025-01-01/expression2/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("kieswet@2025-01-01/expression2/6", "leeftijd_op_verkiezingsdatum").
ee_reference("kieswet@2025-01-01/expression2/7", "MINIMUM_LEEFTIJD").
ee_arguments("kieswet@2025-01-01/expression2/5", ["kieswet@2025-01-01/expression2/6", "kieswet@2025-01-01/expression2/7"]).
ee_primitive("kieswet@2025-01-01/expression2/5", "GREATER_THAN_OR_EQUAL", record([field("operation", "GREATER_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_reference("kieswet@2025-01-01/expression2/11", "werkelijke_woonplaats").
ee_literal("kieswet@2025-01-01/expression2/12", "ARUBA").
ee_literal("kieswet@2025-01-01/expression2/13", "CURACAO").
ee_literal("kieswet@2025-01-01/expression2/14", "SINT_MAARTEN").
ee_arguments("kieswet@2025-01-01/expression2/10", ["kieswet@2025-01-01/expression2/11", "kieswet@2025-01-01/expression2/12", "kieswet@2025-01-01/expression2/13", "kieswet@2025-01-01/expression2/14"]).
ee_primitive("kieswet@2025-01-01/expression2/10", "IN", record([field("operation", "IN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "values"), field("count", decimal(3, 0))])]), field("staticFields", record([field("operation", "IN")])), field("missingValue", true)])).
ee_reference("kieswet@2025-01-01/expression2/18", "is_tien_jaar_ingezetene_geweest").
ee_literal("kieswet@2025-01-01/expression2/19", true).
ee_arguments("kieswet@2025-01-01/expression2/17", ["kieswet@2025-01-01/expression2/18", "kieswet@2025-01-01/expression2/19"]).
ee_primitive("kieswet@2025-01-01/expression2/17", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("kieswet@2025-01-01/expression2/21", "is_in_openbare_dienst_bes").
ee_literal("kieswet@2025-01-01/expression2/22", true).
ee_arguments("kieswet@2025-01-01/expression2/20", ["kieswet@2025-01-01/expression2/21", "kieswet@2025-01-01/expression2/22"]).
ee_primitive("kieswet@2025-01-01/expression2/20", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("kieswet@2025-01-01/expression2/16", "OR", ["kieswet@2025-01-01/expression2/17", "kieswet@2025-01-01/expression2/20"]).
ee_arguments("kieswet@2025-01-01/expression2/15", ["kieswet@2025-01-01/expression2/16"]).
ee_primitive("kieswet@2025-01-01/expression2/15", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("kieswet@2025-01-01/expression2/9", "AND", ["kieswet@2025-01-01/expression2/10", "kieswet@2025-01-01/expression2/15"]).
ee_arguments("kieswet@2025-01-01/expression2/8", ["kieswet@2025-01-01/expression2/9"]).
ee_primitive("kieswet@2025-01-01/expression2/8", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("kieswet@2025-01-01/expression2/1", "AND", ["kieswet@2025-01-01/expression2/2", "kieswet@2025-01-01/expression2/5", "kieswet@2025-01-01/expression2/8"]).
ee_reference("kieswet@2025-01-01/expression3/1", "bsn").
ee_reference("kieswet@2025-01-01/expression4/1", "verkiezingsdatum").
