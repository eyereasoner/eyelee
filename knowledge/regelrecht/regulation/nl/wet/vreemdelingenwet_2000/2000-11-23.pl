% vreemdelingenwet_2000, in force from 2000-11-23.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("vreemdelingenwet_2000").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.0/schema/v0.5.0/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2026-01-01").
law_property("valid_from", "2000-11-23").
law_property("name", "Vreemdelingenwet 2000").
law_property("bwb_id", "BWBR0011823").
law_property("url", "https://wetten.overheid.nl/BWBR0011823/2024-01-01").
article("14", "1. Onze Minister is bevoegd:\na. de aanvraag tot het verlenen van een verblijfsvergunning\nvoor bepaalde tijd in te willigen, af te wijzen dan wel niet\nin behandeling te nemen.").
article_property("14", "url", "https://wetten.overheid.nl/BWBR0011823/2024-01-01#Artikel14").
execution_property("14", "produces", record([
  field("legal_character", "BESCHIKKING")
])).
execution_property("14", "output", [
  record([
    field("name", "minister_is_bevoegd"),
    field("type", "boolean")
  ])
]).
execution_property("14", "actions", [
  record([
    field("output", "minister_is_bevoegd"),
    field("value", expression("vreemdelingenwet_2000@2000-11-23/expression1/1"))
  ])
]).

article("16", "1. Een aanvraag tot het verlenen van een verblijfsvergunning\nvoor bepaalde tijd als bedoeld in artikel 14 kan worden\nafgewezen indien:\na. de vreemdeling niet beschikt over een geldige machtiging\ntot voorlopig verblijf die overeenkomt met het verblijfsdoel;\nb. de vreemdeling niet beschikt over een geldig document voor\ngrensoverschrijding.").
article_property("16", "url", "https://wetten.overheid.nl/BWBR0011823/2024-01-01#Artikel16").

article("69", "1. In afwijking van artikel 6:7 van de Algemene wet\n   bestuursrecht bedraagt de termijn voor het indienen van\n   een bezwaar- of beroepschrift vier weken.").
article_property("69", "url", "https://wetten.overheid.nl/BWBR0011823/2024-01-01#Artikel69").
article_rule("69", "overrides", [
  record([
    field("law", "algemene_wet_bestuursrecht"),
    field("article", "6:7"),
    field("output", "bezwaartermijn_weken")
  ])
]).
execution_property("69", "output", [
  record([
    field("name", "bezwaartermijn_weken"),
    field("type", "number")
  ])
]).
execution_property("69", "actions", [
  record([
    field("output", "bezwaartermijn_weken"),
    field("value", expression("vreemdelingenwet_2000@2000-11-23/expression2/1"))
  ])
]).

ee_literal("vreemdelingenwet_2000@2000-11-23/expression1/1", true).
ee_literal("vreemdelingenwet_2000@2000-11-23/expression2/1", decimal(4, 0)).
