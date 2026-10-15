% regeling_standaardpremie, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("regeling_standaardpremie").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.0/schema/v0.5.0/schema.json").
law_property("regulatory_layer", "MINISTERIELE_REGELING").
law_property("publication_date", "2024-11-19").
law_property("valid_from", "2025-01-01").
law_property("bwb_id", "BWBR0050536").
law_property("url", "https://wetten.overheid.nl/BWBR0050536/2025-01-01").
law_property("name", "#wet_naam").
law_property("competent_authority", record([
  field("name", "Minister van Volksgezondheid, Welzijn en Sport")
])).
law_property("legal_basis", [
  record([
    field("law_id", "wet_op_de_zorgtoeslag"),
    field("article", "4")
  ]),
  record([
    field("law_id", "zorgverzekeringswet"),
    field("article", "18d")
  ]),
  record([
    field("law_id", "zorgverzekeringswet"),
    field("article", "18e")
  ])
]).
article("1", "De standaardpremie, bedoeld in [artikel 4 van de Wet op de zorgtoeslag](https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel4), bedraagt voor het berekeningsjaar 2025: € 2.112,–.").
article_property("1", "url", "https://wetten.overheid.nl/BWBR0050536/2025-01-01#Artikel1").
article_rule("1", "implements", [
  record([
    field("law", "wet_op_de_zorgtoeslag"),
    field("article", "4"),
    field("open_term", "standaardpremie"),
    field("gelet_op", "Gelet op artikel 4 van de Wet op de zorgtoeslag")
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "standaardpremie"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "berekeningsjaar"),
    field("type", "number")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "standaardpremie"),
    field("value", expression("regeling_standaardpremie@2025-01-01/expression1/1"))
  ]),
  record([
    field("output", "berekeningsjaar"),
    field("value", expression("regeling_standaardpremie@2025-01-01/expression2/1"))
  ])
]).

article("2", "[Red: Wijzigt de Regeling zorgverzekering.]").
article_property("2", "url", "https://wetten.overheid.nl/BWBR0050536/2025-01-01#Artikel2").

article("3", "Deze regeling treedt in werking met ingang van 1 januari 2025.").
article_property("3", "url", "https://wetten.overheid.nl/BWBR0050536/2025-01-01#Artikel3").
execution_property("3", "output", [
  record([
    field("name", "datum_inwerkingtreding"),
    field("type", "string")
  ])
]).
execution_property("3", "actions", [
  record([
    field("output", "datum_inwerkingtreding"),
    field("value", expression("regeling_standaardpremie@2025-01-01/expression3/1"))
  ])
]).

article("4", "Deze regeling wordt aangehaald als: Regeling vaststelling standaardpremie en bestuursrechtelijke premies 2025.").
article_property("4", "url", "https://wetten.overheid.nl/BWBR0050536/2025-01-01#Artikel4").
execution_property("4", "output", [
  record([
    field("name", "wet_naam"),
    field("type", "string")
  ])
]).
execution_property("4", "actions", [
  record([
    field("output", "wet_naam"),
    field("value", expression("regeling_standaardpremie@2025-01-01/expression4/1"))
  ])
]).

ee_literal("regeling_standaardpremie@2025-01-01/expression1/1", decimal(211200, 0)).
ee_literal("regeling_standaardpremie@2025-01-01/expression2/1", decimal(2025, 0)).
ee_literal("regeling_standaardpremie@2025-01-01/expression3/1", "2025-01-01").
ee_literal("regeling_standaardpremie@2025-01-01/expression4/1", "Regeling vaststelling standaardpremie en bestuursrechtelijke premies 2025").
