% wet_inkomstenbelasting_2001, in force from 2024-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("wet_inkomstenbelasting_2001").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.0/schema/v0.5.0/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2001-12-15").
law_property("valid_from", "2024-01-01").
law_property("bwb_id", "BWBR0011353").
law_property("url", "https://wetten.overheid.nl/BWBR0011353/2024-01-01").
law_property("name", "Wet inkomstenbelasting 2001").
law_property("competent_authority", record([
  field("name", "Belastingdienst")
])).
article("3.1", "Belastbaar inkomen uit werk en woning is het inkomen uit werk en woning verminderd met de te verrekenen\nverliezen uit werk en woning.").
article_property("3.1", "url", "https://wetten.overheid.nl/BWBR0011353/2024-01-01#Artikel3.1").
execution_property("3.1", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("3.1", "input", [
  record([
    field("name", "loon_uit_dienstbetrekking"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "uitkeringen_en_pensioenen"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "winst_uit_onderneming"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "resultaat_overige_werkzaamheden"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "eigen_woning"),
    field("type", "number"),
    field("source", record([]))
  ])
]).
execution_property("3.1", "output", [
  record([
    field("name", "box1_inkomen"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("3.1", "actions", [
  record([
    field("output", "box1_inkomen"),
    field("value", expression("wet_inkomstenbelasting_2001@2024-01-01/expression1/1"))
  ])
]).

article("4.12", "Inkomen uit aanmerkelijk belang is het gezamenlijke bedrag van de reguliere voordelen en de\nvervreemdingsvoordelen verminderd met de te verrekenen verliezen uit aanmerkelijk belang.").
article_property("4.12", "url", "https://wetten.overheid.nl/BWBR0011353/2024-01-01#Artikel4.12").
execution_property("4.12", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("4.12", "input", [
  record([
    field("name", "reguliere_voordelen"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "vervreemdingsvoordelen"),
    field("type", "number"),
    field("source", record([]))
  ])
]).
execution_property("4.12", "output", [
  record([
    field("name", "box2_inkomen"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("4.12", "actions", [
  record([
    field("output", "box2_inkomen"),
    field("value", expression("wet_inkomstenbelasting_2001@2024-01-01/expression2/1"))
  ])
]).

article("5.2", "Rendementsgrondslag is de waarde van de bezittingen verminderd met de waarde van de schulden. De rendementsgrondslag aan het begin van het kalenderjaar (peildatum 1 januari) wordt als uitgangspunt genomen.").
article_property("5.2", "url", "https://wetten.overheid.nl/BWBR0011353/2024-01-01#Artikel5.2").
execution_property("5.2", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("5.2", "input", [
  record([
    field("name", "spaargeld"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "beleggingen"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "onroerend_goed"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "schulden"),
    field("type", "number"),
    field("source", record([]))
  ])
]).
execution_property("5.2", "output", [
  record([
    field("name", "rendementsgrondslag"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("5.2", "actions", [
  record([
    field("output", "rendementsgrondslag"),
    field("value", expression("wet_inkomstenbelasting_2001@2024-01-01/expression3/1"))
  ])
]).

article("2.18", "Verzamelinkomen is het gezamenlijke bedrag van:\n\na. het inkomen uit werk en woning;\n\nb. het inkomen uit aanmerkelijk belang en\n\nc. het belastbare inkomen uit sparen en beleggen, verminderd met daarin begrepen te conserveren inkomen").
article_property("2.18", "url", "https://wetten.overheid.nl/BWBR0011353/2024-01-01#Artikel2.18").
execution_property("2.18", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("2.18", "input", [
  record([
    field("name", "box1_inkomen"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ])),
    field("source", record([
      field("regulation", "wet_inkomstenbelasting_2001"),
      field("output", "box1_inkomen"),
      field("parameters", record([
        field("bsn", expression("wet_inkomstenbelasting_2001@2024-01-01/expression5/1"))
      ]))
    ]))
  ]),
  record([
    field("name", "box2_inkomen"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ])),
    field("source", record([
      field("regulation", "wet_inkomstenbelasting_2001"),
      field("output", "box2_inkomen"),
      field("parameters", record([
        field("bsn", expression("wet_inkomstenbelasting_2001@2024-01-01/expression6/1"))
      ]))
    ]))
  ])
]).
execution_property("2.18", "output", [
  record([
    field("name", "verzamelinkomen"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("2.18", "actions", [
  record([
    field("output", "verzamelinkomen"),
    field("value", expression("wet_inkomstenbelasting_2001@2024-01-01/expression4/1"))
  ])
]).

ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression1/2", "loon_uit_dienstbetrekking").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression1/3", "uitkeringen_en_pensioenen").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression1/4", "winst_uit_onderneming").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression1/5", "resultaat_overige_werkzaamheden").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression1/6", "eigen_woning").
ee_arguments("wet_inkomstenbelasting_2001@2024-01-01/expression1/1", ["wet_inkomstenbelasting_2001@2024-01-01/expression1/2", "wet_inkomstenbelasting_2001@2024-01-01/expression1/3", "wet_inkomstenbelasting_2001@2024-01-01/expression1/4", "wet_inkomstenbelasting_2001@2024-01-01/expression1/5", "wet_inkomstenbelasting_2001@2024-01-01/expression1/6"]).
ee_primitive("wet_inkomstenbelasting_2001@2024-01-01/expression1/1", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(5, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression2/2", "reguliere_voordelen").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression2/3", "vervreemdingsvoordelen").
ee_arguments("wet_inkomstenbelasting_2001@2024-01-01/expression2/1", ["wet_inkomstenbelasting_2001@2024-01-01/expression2/2", "wet_inkomstenbelasting_2001@2024-01-01/expression2/3"]).
ee_primitive("wet_inkomstenbelasting_2001@2024-01-01/expression2/1", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression3/3", "spaargeld").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression3/4", "beleggingen").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression3/5", "onroerend_goed").
ee_arguments("wet_inkomstenbelasting_2001@2024-01-01/expression3/2", ["wet_inkomstenbelasting_2001@2024-01-01/expression3/3", "wet_inkomstenbelasting_2001@2024-01-01/expression3/4", "wet_inkomstenbelasting_2001@2024-01-01/expression3/5"]).
ee_primitive("wet_inkomstenbelasting_2001@2024-01-01/expression3/2", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(3, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression3/6", "schulden").
ee_arguments("wet_inkomstenbelasting_2001@2024-01-01/expression3/1", ["wet_inkomstenbelasting_2001@2024-01-01/expression3/2", "wet_inkomstenbelasting_2001@2024-01-01/expression3/6"]).
ee_primitive("wet_inkomstenbelasting_2001@2024-01-01/expression3/1", "SUBTRACT", record([field("operation", "SUBTRACT"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "SUBTRACT")])), field("missingValue", true)])).
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression4/2", "box1_inkomen").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression4/3", "box2_inkomen").
ee_arguments("wet_inkomstenbelasting_2001@2024-01-01/expression4/1", ["wet_inkomstenbelasting_2001@2024-01-01/expression4/2", "wet_inkomstenbelasting_2001@2024-01-01/expression4/3"]).
ee_primitive("wet_inkomstenbelasting_2001@2024-01-01/expression4/1", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression5/1", "bsn").
ee_reference("wet_inkomstenbelasting_2001@2024-01-01/expression6/1", "bsn").
