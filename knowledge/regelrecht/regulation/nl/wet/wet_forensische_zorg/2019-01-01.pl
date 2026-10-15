% wet_forensische_zorg, in force from 2019-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("wet_forensische_zorg").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.0/schema/v0.5.0/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2019-01-01").
law_property("valid_from", "2019-01-01").
law_property("bwb_id", "BWBR0040634").
law_property("url", "https://wetten.overheid.nl/BWBR0040634/2019-01-01").
law_property("name", "#wet_naam").
law_property("competent_authority", record([
  field("name", "Minister van Justitie en Veiligheid")
])).
article("1.1", "Artikel 1.1 1. In deze wet en de daarop berustende bepalingen wordt verstaan onder:\n\nforensische zorg: geestelijke gezondheidszorg, verslavingszorg en de zorg voor verstandelijk\ngehandicapten, die onderdeel is van, dan wel aansluit bij een (voorwaardelijke) straf of maatregel\nof die voortvloeit uit een last tot plaatsing als bedoeld in artikel 2.3.\n\n2. Onder forensische zorg als bedoeld in het eerste lid wordt verstaan:\n\na. geestelijke gezondheidszorg als omschreven bij of krachtens de Wet verplichte geestelijke\ngezondheidszorg;\n\nb. verslavingszorg;\n\nc. zorg voor verstandelijk gehandicapten als omschreven bij of krachtens de Wet zorg en dwang\npsychogeriatrische en verstandelijk gehandicapte clienten.").
article_property("1.1", "url", "https://wetten.overheid.nl/BWBR0040634/2019-01-01#Hoofdstuk1_Artikel1.1").
definition("1.1", "forensische_zorgtypen", record([
  field("value", expression("wet_forensische_zorg@2019-01-01/expression1/1"))
])).
definition("1.1", "geldige_juridische_titels", record([
  field("value", expression("wet_forensische_zorg@2019-01-01/expression2/1"))
])).
execution_property("1.1", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("1.1", "input", [
  record([
    field("name", "zorgtype"),
    field("type", "string"),
    field("source", record([]))
  ]),
  record([
    field("name", "juridische_grondslag"),
    field("type", "string"),
    field("source", record([]))
  ])
]).
execution_property("1.1", "output", [
  record([
    field("name", "is_forensisch"),
    field("type", "boolean")
  ])
]).
execution_property("1.1", "actions", [
  record([
    field("output", "is_forensisch"),
    field("value", expression("wet_forensische_zorg@2019-01-01/expression3/1"))
  ])
]).

article("2.1", "Artikel 2.1 De tenuitvoerlegging van een vrijheidsbenemende straf of maatregel wordt zo veel\nmogelijk dienstbaar gemaakt aan de voorbereiding van de terugkeer van de forensische patient in\nde maatschappij en de vermindering van de kans op recidive, met inachtneming van de veiligheid\nvan de samenleving.").
article_property("2.1", "url", "https://wetten.overheid.nl/BWBR0040634/2019-01-01#Hoofdstuk2_Artikel2.1").

article("10.3", "Artikel 10.3 Deze wet wordt aangehaald als: Wet forensische zorg.").
article_property("10.3", "url", "https://wetten.overheid.nl/BWBR0040634/2019-01-01#Hoofdstuk10_Artikel10.3").
execution_property("10.3", "output", [
  record([
    field("name", "wet_naam"),
    field("type", "string")
  ])
]).
execution_property("10.3", "actions", [
  record([
    field("output", "wet_naam"),
    field("value", expression("wet_forensische_zorg@2019-01-01/expression4/1"))
  ])
]).

ee_literal("wet_forensische_zorg@2019-01-01/expression1/2", "GGZ").
ee_literal("wet_forensische_zorg@2019-01-01/expression1/3", "VERSLAVINGSZORG").
ee_literal("wet_forensische_zorg@2019-01-01/expression1/4", "VG_ZORG").
ee_arguments("wet_forensische_zorg@2019-01-01/expression1/1", ["wet_forensische_zorg@2019-01-01/expression1/2", "wet_forensische_zorg@2019-01-01/expression1/3", "wet_forensische_zorg@2019-01-01/expression1/4"]).
ee_primitive("wet_forensische_zorg@2019-01-01/expression1/1", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_literal("wet_forensische_zorg@2019-01-01/expression2/2", "VOORWAARDELIJKE_VEROORDELING").
ee_literal("wet_forensische_zorg@2019-01-01/expression2/3", "TBS").
ee_literal("wet_forensische_zorg@2019-01-01/expression2/4", "PIJ_MAATREGEL").
ee_literal("wet_forensische_zorg@2019-01-01/expression2/5", "ISD_MAATREGEL").
ee_literal("wet_forensische_zorg@2019-01-01/expression2/6", "VOORWAARDELIJKE_INVRIJHEIDSTELLING").
ee_literal("wet_forensische_zorg@2019-01-01/expression2/7", "OVERPLAATSING").
ee_literal("wet_forensische_zorg@2019-01-01/expression2/8", "ZORGMACHTIGING").
ee_literal("wet_forensische_zorg@2019-01-01/expression2/9", "VOORLOPIGE_HECHTENIS").
ee_arguments("wet_forensische_zorg@2019-01-01/expression2/1", ["wet_forensische_zorg@2019-01-01/expression2/2", "wet_forensische_zorg@2019-01-01/expression2/3", "wet_forensische_zorg@2019-01-01/expression2/4", "wet_forensische_zorg@2019-01-01/expression2/5", "wet_forensische_zorg@2019-01-01/expression2/6", "wet_forensische_zorg@2019-01-01/expression2/7", "wet_forensische_zorg@2019-01-01/expression2/8", "wet_forensische_zorg@2019-01-01/expression2/9"]).
ee_primitive("wet_forensische_zorg@2019-01-01/expression2/1", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_reference("wet_forensische_zorg@2019-01-01/expression3/3", "zorgtype").
ee_reference("wet_forensische_zorg@2019-01-01/expression3/4", "forensische_zorgtypen").
ee_arguments("wet_forensische_zorg@2019-01-01/expression3/2", ["wet_forensische_zorg@2019-01-01/expression3/3", "wet_forensische_zorg@2019-01-01/expression3/4"]).
ee_primitive("wet_forensische_zorg@2019-01-01/expression3/2", "IN", record([field("operation", "IN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "IN")])), field("missingValue", false)])).
ee_reference("wet_forensische_zorg@2019-01-01/expression3/6", "juridische_grondslag").
ee_reference("wet_forensische_zorg@2019-01-01/expression3/7", "geldige_juridische_titels").
ee_arguments("wet_forensische_zorg@2019-01-01/expression3/5", ["wet_forensische_zorg@2019-01-01/expression3/6", "wet_forensische_zorg@2019-01-01/expression3/7"]).
ee_primitive("wet_forensische_zorg@2019-01-01/expression3/5", "IN", record([field("operation", "IN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "IN")])), field("missingValue", false)])).
ee_logical("wet_forensische_zorg@2019-01-01/expression3/1", "AND", ["wet_forensische_zorg@2019-01-01/expression3/2", "wet_forensische_zorg@2019-01-01/expression3/5"]).
ee_literal("wet_forensische_zorg@2019-01-01/expression4/1", "Wet forensische zorg").
