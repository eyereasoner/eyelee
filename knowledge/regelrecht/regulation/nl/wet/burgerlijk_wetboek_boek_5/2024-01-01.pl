% burgerlijk_wetboek_boek_5.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("burgerlijk_wetboek_boek_5").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.7/schema/v0.5.7/schema.json").
law_property("uuid", "5a42b000-5a42-5a42-5a42-5a42b0000042").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2024-01-01").
law_property("bwb_id", "BWBR0005288").
law_property("url", "https://wetten.overheid.nl/BWBR0005288").
article("42", "1. Het is niet geoorloofd binnen de in lid 2 bepaalde afstand van de grenslijn\nvan eens anders erf bomen, heesters of heggen te hebben, tenzij de eigenaar\ndaartoe toestemming heeft gegeven of dat erf een openbare weg of een openbaar\nwater is.\n\n2. De in lid 1 bedoelde afstand bedraagt voor bomen twee meter te rekenen\nvanaf het midden van de voet van de boom en voor heesters en heggen een\nhalve meter, tenzij ingevolge een verordening of een plaatselijke gewoonte\neen kleinere afstand is toegelaten.\n\n3. De nabuur kan zich niet verzetten tegen de aanwezigheid van bomen,\nheesters of heggen die niet hoger reiken dan de scheidsmuur tussen de erven.\n\n4. Ter zake van een volgens dit artikel ongeoorloofde toestand is slechts\nvergoeding verschuldigd van de schade, ontstaan na het tijdstip waartegen\ntot opheffing van die toestand is aangemaand.\n").
article_property("42", "url", "https://wetten.overheid.nl/BWBR0005288/2024-01-01#Boek5_Titeldeel4_Artikel42").
article_rule("42", "open_terms", [
  record([
    field("id", "gemeentelijke_afstand_cm"),
    field("type", "number"),
    field("required", false),
    field("delegated_to", "gemeenteraad"),
    field("delegation_type", "GEMEENTELIJKE_VERORDENING"),
    field("legal_basis", "artikel 5:42 lid 2 Burgerlijk Wetboek"),
    field("default", record([
      field("actions", [
        record([
          field("output", "gemeentelijke_afstand_cm"),
          field("value", expression("burgerlijk_wetboek_boek_5@undated/expression6/1"))
        ])
      ])
    ]))
  ])
]).
article_rule("42", "untranslatables", [
  record([
    field("construct", "afwijking van de wettelijke afstand op grond van een plaatselijke gewoonte"),
    field("reason", "Een plaatselijke gewoonte is ongeschreven recht: er is geen register, verordening of ander document waaraan de engine dit kan binden. De open_terms/implements-constructie (RFC-003) veronderstelt een bron die een gemeente vaststelt en publiceert; \"gewoonte\" is per definitie niet dat. Alleen de verordeningstak van lid 2 is gemodelleerd (open term gemeentelijke_afstand_cm)."),
    field("suggestion", "Geen automatische oplossing: een plaatselijke gewoonte is per zaak een feitelijke vaststelling (getuigenbewijs, lokale praktijk), niet iets dat vooraf in een bron ligt. Zou alsnog gemodelleerd moeten worden zodra er een vastlegging bestaat die als bron kan dienen."),
    field("legal_text_excerpt", "tenzij ingevolge een verordening of een plaatselijke gewoonte een kleinere afstand is toegelaten"),
    field("accepted", true)
  ])
]).
execution_property("42", "produces", record([
  field("legal_character", "INFORMATIEF"),
  field("decision_type", "GEEN_BESLUIT")
])).
execution_property("42", "parameters", [
  record([
    field("name", "gemeente_code"),
    field("type", "string"),
    field("required", true),
    field("description", "CBS gemeentecode waar het perceel ligt")
  ]),
  record([
    field("name", "type_beplanting"),
    field("type", "string"),
    field("required", true),
    field("description", "Type beplanting - \"boom\" of \"heg_of_heester\"")
  ]),
  record([
    field("name", "toestemming_nabuur_gegeven"),
    field("type", "boolean"),
    field("nullable", true),
    field("required", false),
    field("description", "Of de eigenaar van het naburige erf toestemming heeft gegeven voor beplanting binnen de afstand van lid 2 (lid 1)")
  ]),
  record([
    field("name", "naburig_erf_is_openbare_weg_of_water"),
    field("type", "boolean"),
    field("nullable", true),
    field("required", false),
    field("description", "Of het naburige erf een openbare weg of een openbaar water is (lid 1)")
  ]),
  record([
    field("name", "beplanting_hoger_dan_scheidsmuur"),
    field("type", "boolean"),
    field("nullable", true),
    field("required", false),
    field("description", "Of de bomen, heesters of heggen hoger reiken dan de scheidsmuur tussen de erven (lid 3)")
  ]),
  record([
    field("name", "datum_aanmaning_opheffing"),
    field("type", "date"),
    field("nullable", true),
    field("required", false),
    field("description", "Datum waartegen is aangemaand tot opheffing van de ongeoorloofde toestand (lid 4); ontbreekt zolang niet is aangemaand")
  ]),
  record([
    field("name", "datum_ontstaan_schade"),
    field("type", "date"),
    field("nullable", true),
    field("required", false),
    field("description", "Datum waarop de schade als gevolg van de ongeoorloofde toestand is ontstaan (lid 4)")
  ])
]).
execution_property("42", "output", [
  record([
    field("name", "minimale_afstand_cm"),
    field("type", "number"),
    field("description", "De geldende minimale afstand tot de erfgrens in centimeters")
  ]),
  record([
    field("name", "minimale_afstand_m"),
    field("type", "number"),
    field("description", "De geldende minimale afstand tot de erfgrens in meters")
  ]),
  record([
    field("name", "beplanting_geoorloofd"),
    field("type", "boolean"),
    field("nullable", true),
    field("description", "Of de beplanting binnen de afstand van lid 2 geoorloofd is: bij toestemming van de nabuur, of als het naburige erf een openbare weg of openbaar water is (lid 1)")
  ]),
  record([
    field("name", "nabuur_kan_zich_verzetten"),
    field("type", "boolean"),
    field("nullable", true),
    field("description", "Of de nabuur zich kan verzetten tegen de aanwezigheid van de beplanting: niet als deze niet hoger reikt dan de scheidsmuur (lid 3)")
  ]),
  record([
    field("name", "vergoedbare_schade"),
    field("type", "boolean"),
    field("nullable", true),
    field("description", "Of de schade als gevolg van de ongeoorloofde toestand vergoedbaar is: alleen de schade die is ontstaan na het tijdstip waartegen is aangemaand tot opheffing (lid 4)")
  ])
]).
execution_property("42", "actions", [
  record([
    field("output", "minimale_afstand_cm"),
    field("value", expression("burgerlijk_wetboek_boek_5@undated/expression1/1"))
  ]),
  record([
    field("output", "minimale_afstand_m"),
    field("value", expression("burgerlijk_wetboek_boek_5@undated/expression2/1"))
  ]),
  record([
    field("output", "beplanting_geoorloofd"),
    field("value", expression("burgerlijk_wetboek_boek_5@undated/expression3/1"))
  ]),
  record([
    field("output", "nabuur_kan_zich_verzetten"),
    field("value", expression("burgerlijk_wetboek_boek_5@undated/expression4/1"))
  ]),
  record([
    field("output", "vergoedbare_schade"),
    field("value", expression("burgerlijk_wetboek_boek_5@undated/expression5/1"))
  ])
]).

ee_reference("burgerlijk_wetboek_boek_5@undated/expression1/1", "gemeentelijke_afstand_cm").
ee_reference("burgerlijk_wetboek_boek_5@undated/expression2/2", "minimale_afstand_cm").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression2/3", decimal(100, 0)).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression2/1", ["burgerlijk_wetboek_boek_5@undated/expression2/2", "burgerlijk_wetboek_boek_5@undated/expression2/3"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression2/1", "DIVIDE", record([field("operation", "DIVIDE"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "DIVIDE")])), field("missingValue", true)])).
ee_reference("burgerlijk_wetboek_boek_5@undated/expression3/3", "toestemming_nabuur_gegeven").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression3/4", true).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression3/2", ["burgerlijk_wetboek_boek_5@undated/expression3/3", "burgerlijk_wetboek_boek_5@undated/expression3/4"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression3/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression3/5", true).
ee_reference("burgerlijk_wetboek_boek_5@undated/expression3/7", "naburig_erf_is_openbare_weg_of_water").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression3/8", true).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression3/6", ["burgerlijk_wetboek_boek_5@undated/expression3/7", "burgerlijk_wetboek_boek_5@undated/expression3/8"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression3/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression3/9", true).
ee_reference("burgerlijk_wetboek_boek_5@undated/expression3/12", "toestemming_nabuur_gegeven").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression3/13", null).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression3/11", ["burgerlijk_wetboek_boek_5@undated/expression3/12", "burgerlijk_wetboek_boek_5@undated/expression3/13"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression3/11", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("burgerlijk_wetboek_boek_5@undated/expression3/15", "naburig_erf_is_openbare_weg_of_water").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression3/16", null).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression3/14", ["burgerlijk_wetboek_boek_5@undated/expression3/15", "burgerlijk_wetboek_boek_5@undated/expression3/16"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression3/14", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("burgerlijk_wetboek_boek_5@undated/expression3/10", "OR", ["burgerlijk_wetboek_boek_5@undated/expression3/11", "burgerlijk_wetboek_boek_5@undated/expression3/14"]).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression3/17", null).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression3/18", false).
ee_conditional("burgerlijk_wetboek_boek_5@undated/expression3/1", [case("burgerlijk_wetboek_boek_5@undated/expression3/2", "burgerlijk_wetboek_boek_5@undated/expression3/5"), case("burgerlijk_wetboek_boek_5@undated/expression3/6", "burgerlijk_wetboek_boek_5@undated/expression3/9"), case("burgerlijk_wetboek_boek_5@undated/expression3/10", "burgerlijk_wetboek_boek_5@undated/expression3/17")], "burgerlijk_wetboek_boek_5@undated/expression3/18").
ee_reference("burgerlijk_wetboek_boek_5@undated/expression4/3", "beplanting_hoger_dan_scheidsmuur").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression4/4", null).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression4/2", ["burgerlijk_wetboek_boek_5@undated/expression4/3", "burgerlijk_wetboek_boek_5@undated/expression4/4"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression4/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression4/5", null).
ee_reference("burgerlijk_wetboek_boek_5@undated/expression4/7", "beplanting_hoger_dan_scheidsmuur").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression4/8", false).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression4/6", ["burgerlijk_wetboek_boek_5@undated/expression4/7", "burgerlijk_wetboek_boek_5@undated/expression4/8"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression4/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression4/9", false).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression4/10", true).
ee_conditional("burgerlijk_wetboek_boek_5@undated/expression4/1", [case("burgerlijk_wetboek_boek_5@undated/expression4/2", "burgerlijk_wetboek_boek_5@undated/expression4/5"), case("burgerlijk_wetboek_boek_5@undated/expression4/6", "burgerlijk_wetboek_boek_5@undated/expression4/9")], "burgerlijk_wetboek_boek_5@undated/expression4/10").
ee_reference("burgerlijk_wetboek_boek_5@undated/expression5/3", "datum_aanmaning_opheffing").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression5/4", null).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression5/2", ["burgerlijk_wetboek_boek_5@undated/expression5/3", "burgerlijk_wetboek_boek_5@undated/expression5/4"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression5/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression5/5", false).
ee_reference("burgerlijk_wetboek_boek_5@undated/expression5/7", "datum_ontstaan_schade").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression5/8", null).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression5/6", ["burgerlijk_wetboek_boek_5@undated/expression5/7", "burgerlijk_wetboek_boek_5@undated/expression5/8"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression5/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression5/9", null).
ee_reference("burgerlijk_wetboek_boek_5@undated/expression5/12", "datum_aanmaning_opheffing").
ee_reference("burgerlijk_wetboek_boek_5@undated/expression5/13", "datum_ontstaan_schade").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression5/14", "days").
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression5/11", ["burgerlijk_wetboek_boek_5@undated/expression5/12", "burgerlijk_wetboek_boek_5@undated/expression5/13", "burgerlijk_wetboek_boek_5@undated/expression5/14"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression5/11", "DATE_DIFF", record([field("operation", "DATE_DIFF"), field("shape", [record([field("field", "from"), field("count", null)]), record([field("field", "to"), field("count", null)]), record([field("field", "in"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_DIFF")])), field("missingValue", true)])).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression5/15", decimal(0, 0)).
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression5/10", ["burgerlijk_wetboek_boek_5@undated/expression5/11", "burgerlijk_wetboek_boek_5@undated/expression5/15"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression5/10", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_conditional("burgerlijk_wetboek_boek_5@undated/expression5/1", [case("burgerlijk_wetboek_boek_5@undated/expression5/2", "burgerlijk_wetboek_boek_5@undated/expression5/5"), case("burgerlijk_wetboek_boek_5@undated/expression5/6", "burgerlijk_wetboek_boek_5@undated/expression5/9")], "burgerlijk_wetboek_boek_5@undated/expression5/10").
ee_reference("burgerlijk_wetboek_boek_5@undated/expression6/3", "type_beplanting").
ee_literal("burgerlijk_wetboek_boek_5@undated/expression6/4", "boom").
ee_arguments("burgerlijk_wetboek_boek_5@undated/expression6/2", ["burgerlijk_wetboek_boek_5@undated/expression6/3", "burgerlijk_wetboek_boek_5@undated/expression6/4"]).
ee_primitive("burgerlijk_wetboek_boek_5@undated/expression6/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression6/5", decimal(200, 0)).
ee_literal("burgerlijk_wetboek_boek_5@undated/expression6/6", decimal(50, 0)).
ee_conditional("burgerlijk_wetboek_boek_5@undated/expression6/1", [case("burgerlijk_wetboek_boek_5@undated/expression6/2", "burgerlijk_wetboek_boek_5@undated/expression6/5")], "burgerlijk_wetboek_boek_5@undated/expression6/6").
