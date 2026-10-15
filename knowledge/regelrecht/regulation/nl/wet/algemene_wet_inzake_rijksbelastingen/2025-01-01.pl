% algemene_wet_inzake_rijksbelastingen, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("algemene_wet_inzake_rijksbelastingen").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.8/schema/v0.5.8/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2025-12-23").
law_property("valid_from", "2025-01-01").
law_property("bwb_id", "BWBR0002320").
law_property("url", "https://wetten.overheid.nl/BWBR0002320/2025-01-01").
law_property("name", "Algemene wet inzake rijksbelastingen").
article("21", "In dit hoofdstuk en de daarop berustende bepalingen wordt verstaan onder:\n\na. basisregistratie: verzameling gegevens waarvan bij wet is bepaald dat deze authentieke gegevens bevat;\n\nb. authentiek gegeven: in een basisregistratie opgenomen gegeven dat bij wettelijk voorschrift als authentiek is\naangemerkt;\n\nc. verzamelinkomen: verzamelinkomen als bedoeld in [artikel 2.18 van de Wet inkomstenbelasting 2001][ref1];\n\nd. belastbaar loon: belastbaar loon als bedoeld in [artikel 9 van de Wet op de loonbelasting 1964][ref2], met\nuitzondering van loon dat als een eindheffingsbestanddeel in de zin van die wet is belast;\n\ne. inkomensgegeven:\n\n1°. indien over een kalenderjaar een aanslag of navorderingsaanslag inkomstenbelasting is of wordt vastgesteld: het\nna afloop van dat kalenderjaar van betrokkene over dat kalenderjaar laatst bepaalde verzamelinkomen;\n\n2°. indien over een kalenderjaar geen aanslag of navorderingsaanslag inkomstenbelasting is of wordt vastgesteld:\nhet na afloop van dat kalenderjaar van betrokkene over dat kalenderjaar laatst bepaalde belastbare loon;\n\nf. afnemer: bestuursorgaan dat op grond van een wettelijk voorschrift bevoegd is tot gebruik van een\ninkomensgegeven;\n\ng. betrokkene: degene op wie het inkomensgegeven betrekking heeft;\n\nh. terugmelding: melding als bedoeld in [artikel 21h, eerste lid][ref3].\n\n\n[ref1]: https://wetten.overheid.nl/BWBR0011353#Artikel2.18\n[ref2]: https://wetten.overheid.nl/BWBR0002471#Artikel9\n[ref3]: https://wetten.overheid.nl/BWBR0002320#Artikel21h").
article_property("21", "url", "https://wetten.overheid.nl/BWBR0002320/2025-01-01#Artikel21").
article_property("21", "references", [
  record([
    field("id", "ref1"),
    field("bwb_id", "BWBR0011353"),
    field("artikel", "2.18")
  ]),
  record([
    field("id", "ref2"),
    field("bwb_id", "BWBR0002471"),
    field("artikel", "9")
  ]),
  record([
    field("id", "ref3"),
    field("bwb_id", "BWBR0002320"),
    field("artikel", "21h"),
    field("hoofdstuk", "IVA")
  ])
]).
execution_property("21", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ]),
  record([
    field("name", "kalenderjaar"),
    field("type", "number"),
    field("required", true)
  ])
]).
execution_property("21", "input", [
  record([
    field("name", "aanslag_of_navorderingsaanslag_vastgesteld"),
    field("type", "boolean"),
    field("source", record([]))
  ]),
  record([
    field("name", "verzamelinkomen"),
    field("type", "amount"),
    field("source", record([
      field("regulation", "wet_inkomstenbelasting_2001"),
      field("output", "verzamelinkomen"),
      field("parameters", record([
        field("bsn", expression("algemene_wet_inzake_rijksbelastingen@2025-01-01/expression2/1"))
      ]))
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "belastbaar_loon"),
    field("type", "amount"),
    field("source", record([])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("21", "output", [
  record([
    field("name", "inkomensgegeven"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("21", "actions", [
  record([
    field("output", "inkomensgegeven"),
    field("value", expression("algemene_wet_inzake_rijksbelastingen@2025-01-01/expression1/1"))
  ])
]).

ee_reference("algemene_wet_inzake_rijksbelastingen@2025-01-01/expression1/2", "aanslag_of_navorderingsaanslag_vastgesteld").
ee_reference("algemene_wet_inzake_rijksbelastingen@2025-01-01/expression1/3", "verzamelinkomen").
ee_reference("algemene_wet_inzake_rijksbelastingen@2025-01-01/expression1/4", "belastbaar_loon").
ee_conditional("algemene_wet_inzake_rijksbelastingen@2025-01-01/expression1/1", [case("algemene_wet_inzake_rijksbelastingen@2025-01-01/expression1/2", "algemene_wet_inzake_rijksbelastingen@2025-01-01/expression1/3")], "algemene_wet_inzake_rijksbelastingen@2025-01-01/expression1/4").
ee_reference("algemene_wet_inzake_rijksbelastingen@2025-01-01/expression2/1", "bsn").
