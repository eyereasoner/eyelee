% wet_op_de_zorgtoeslag, in force from 2024-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("wet_op_de_zorgtoeslag").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.8/schema/v0.5.8/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2023-12-20").
law_property("valid_from", "2024-01-01").
law_property("bwb_id", "BWBR0018451").
law_property("url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01").
law_property("name", "#wet_naam").
law_property("competent_authority", "#bevoegd_gezag").
article("1", "In deze wet en de daarop berustende bepalingen wordt verstaan onder:\n\na. verzekerde: degene die ingevolge de Zorgverzekeringswet verzekerd is; b. toetsingsinkomen: het verzamelinkomen, bedoeld in artikel 2.18 van de Wet inkomstenbelasting 2001; c. drempelinkomen: het bedrag, bedoeld in artikel 2, tweede lid; d. normpremie: de premie, berekend overeenkomstig artikel 2; e. standaardpremie: de premie, bedoeld in artikel 4.").
article_property("1", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel1").

article("1a", "In deze wet en de daarop berustende bepalingen wordt verstaan onder Onze Minister: Onze Minister van Volksgezondheid, Welzijn en Sport.").
article_property("1a", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel1a").
definition("1a", "verantwoordelijke_autoriteit", expression("wet_op_de_zorgtoeslag@2024-01-01/expression1/1")).

article("2", "1. Indien de normpremie voor een verzekerde in het berekeningsjaar minder bedraagt dan de standaardpremie in dat jaar, heeft de verzekerde aanspraak op een zorgtoeslag ter grootte van dat verschil. Voor een verzekerde met een toeslagpartner geldt het dubbele van de standaardpremie en worden de verzekerde en de toeslagpartner geacht gezamenlijk aanspraak te maken op zorgtoeslag.\n\n2. De normpremie bedraagt een percentage van het drempelinkomen in het berekeningsjaar, vermeerderd met een percentage van het toetsingsinkomen van de verzekerde. Ingeval de verzekerde een toeslagpartner heeft, wordt het gezamenlijk toetsingsinkomen van de verzekerde en de toeslagpartner in aanmerking genomen.\n\n3. De percentages, bedoeld in het tweede lid, bedragen voor een verzekerde met een toeslagpartner 4,256 procent van het drempelinkomen, vermeerderd met 13,670 procent van het toetsingsinkomen, en voor een verzekerde zonder toeslagpartner 1,879 procent van het drempelinkomen, vermeerderd met 13,670 procent van het toetsingsinkomen. Bij ministeriële regeling kunnen deze percentages worden gewijzigd.\n\n4. In afwijking van het eerste lid bedraagt de aanspraak op een zorgtoeslag voor een verzekerde met een partner die geen verzekerde is, vijftig procent van het op grond van het eerste lid berekende bedrag.\n\n5. De aanspraak op een zorgtoeslag wordt voor iedere kalendermaand afzonderlijk bepaald.\n\n6. Bij ministeriële regeling kunnen nadere regels worden gesteld.\n\n7. Onze Minister zendt een voornemen tot wijziging van de percentages, bedoeld in het derde lid, ten minste twee weken voor de vaststelling aan beide kamers der Staten-Generaal.").
article_property("2", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel2").
definition("2", "drempelinkomen_alleenstaande", record([
  field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression2/1"))
])).
definition("2", "drempelinkomen_aanvrager_met_toeslagpartner", record([
  field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression3/1"))
])).
definition("2", "percentage_drempelinkomen_alleenstaande", record([
  field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression4/1"))
])).
definition("2", "percentage_drempelinkomen_partner", record([
  field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression5/1"))
])).
definition("2", "percentage_toetsingsinkomen", record([
  field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression6/1"))
])).
execution_property("2", "produces", record([
  field("legal_character", "BESCHIKKING"),
  field("decision_type", "TOEKENNING")
])).
execution_property("2", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("2", "input", [
  record([
    field("name", "is_verzekerde"),
    field("type", "boolean"),
    field("source", record([
      field("regulation", "zorgverzekeringswet"),
      field("output", "is_verzekerd"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression10/1"))
      ]))
    ]))
  ]),
  record([
    field("name", "heeft_toeslagpartner"),
    field("type", "boolean"),
    field("source", record([
      field("regulation", "algemene_wet_inkomensafhankelijke_regelingen"),
      field("output", "heeft_toeslagpartner"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression11/1"))
      ]))
    ]))
  ]),
  record([
    field("name", "toetsingsinkomen"),
    field("type", "amount"),
    field("source", record([
      field("regulation", "algemene_wet_inkomensafhankelijke_regelingen"),
      field("output", "toetsingsinkomen"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression12/1"))
      ]))
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "bsn_toeslagpartner"),
    field("type", "string"),
    field("nullable", true),
    field("source", record([
      field("regulation", "algemene_wet_inkomensafhankelijke_regelingen"),
      field("output", "bsn_toeslagpartner"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression13/1"))
      ]))
    ]))
  ]),
  record([
    field("name", "toetsingsinkomen_toeslagpartner"),
    field("type", "amount"),
    field("nullable", true),
    field("source", record([
      field("regulation", "algemene_wet_inkomensafhankelijke_regelingen"),
      field("output", "toetsingsinkomen"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression14/1"))
      ]))
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "standaardpremie"),
    field("type", "amount"),
    field("source", record([
      field("regulation", "regeling_standaardpremie"),
      field("output", "standaardpremie")
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "vermogen_onder_grens"),
    field("type", "boolean"),
    field("source", record([
      field("output", "vermogen_onder_grens")
    ]))
  ])
]).
execution_property("2", "output", [
  record([
    field("name", "heeft_recht_op_zorgtoeslag"),
    field("type", "boolean")
  ]),
  record([
    field("name", "hoogte_zorgtoeslag"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "in_aanmerking_genomen_toetsingsinkomen"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("2", "actions", [
  record([
    field("output", "in_aanmerking_genomen_toetsingsinkomen"),
    field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression7/1"))
  ]),
  record([
    field("output", "hoogte_zorgtoeslag"),
    field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression8/1"))
  ]),
  record([
    field("output", "heeft_recht_op_zorgtoeslag"),
    field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression9/1"))
  ])
]).

article("3", "Een verzekerde heeft geen aanspraak op zorgtoeslag indien de rendementsgrondslag, bedoeld in artikel 5.2 van de Wet inkomstenbelasting 2001, van de verzekerde of, ingeval de verzekerde een toeslagpartner heeft, de gezamenlijke rendementsgrondslag van de verzekerde en de toeslagpartner op de peildatum meer bedraagt dan € 127.582 voor een verzekerde zonder toeslagpartner, onderscheidenlijk € 161.329 voor een verzekerde met een toeslagpartner.").
article_property("3", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel3").
definition("3", "vermogensgrens_alleenstaand", record([
  field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression15/1"))
])).
definition("3", "vermogensgrens_aanvrager_met_toeslagpartner", record([
  field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression16/1"))
])).
execution_property("3", "produces", record([
  field("legal_character", "TOETS"),
  field("decision_type", "GOEDKEURING")
])).
execution_property("3", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("3", "input", [
  record([
    field("name", "vermogen"),
    field("type", "amount"),
    field("source", record([
      field("regulation", "wet_inkomstenbelasting_2001"),
      field("output", "rendementsgrondslag"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression18/1"))
      ]))
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "heeft_toeslagpartner"),
    field("type", "boolean"),
    field("source", record([
      field("regulation", "algemene_wet_inkomensafhankelijke_regelingen"),
      field("output", "heeft_toeslagpartner"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression19/1"))
      ]))
    ]))
  ]),
  record([
    field("name", "bsn_toeslagpartner"),
    field("type", "string"),
    field("nullable", true),
    field("source", record([
      field("regulation", "algemene_wet_inkomensafhankelijke_regelingen"),
      field("output", "bsn_toeslagpartner"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression20/1"))
      ]))
    ]))
  ]),
  record([
    field("name", "vermogen_toeslagpartner"),
    field("type", "amount"),
    field("nullable", true),
    field("source", record([
      field("regulation", "wet_inkomstenbelasting_2001"),
      field("output", "rendementsgrondslag"),
      field("parameters", record([
        field("bsn", expression("wet_op_de_zorgtoeslag@2024-01-01/expression21/1"))
      ]))
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("3", "output", [
  record([
    field("name", "vermogen_onder_grens"),
    field("type", "boolean")
  ])
]).
execution_property("3", "actions", [
  record([
    field("output", "vermogen_onder_grens"),
    field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression17/1"))
  ])
]).

article("4", "Onze Minister stelt uiterlijk 22 dagen voorafgaande aan het berekeningsjaar bij regeling de standaardpremie voor het berekeningsjaar vast.").
article_property("4", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel4").
article_rule("4", "open_terms", [
  record([
    field("id", "standaardpremie"),
    field("type", "amount"),
    field("required", true),
    field("delegated_to", "minister"),
    field("delegation_type", "MINISTERIELE_REGELING"),
    field("legal_basis", "artikel 4 Wet op de zorgtoeslag")
  ])
]).
execution_property("4", "output", [
  record([
    field("name", "standaardpremie"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ])
]).
execution_property("4", "actions", [
  record([
    field("output", "standaardpremie"),
    field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression22/1"))
  ])
]).

article("4a", "Voor de persoon, bedoeld in artikel 69 van de Zorgverzekeringswet, wordt de standaardpremie aangepast aan de hand van de verhouding tussen de zorguitgaven per verzekerde in het land waar de persoon woont en de zorguitgaven per verzekerde in Nederland.").
article_property("4a", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel4a").

article("5", "1. De Dienst Toeslagen is belast met de uitvoering van deze wet.\n\n2. Tot en met 4. [Procedurele bepalingen over aanvraag en betaling]\n\n5. De zorgtoeslag komt ten laste van het Rijk.").
article_property("5", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel5").
execution_property("5", "actions", [
  record([
    field("output", "bevoegd_gezag"),
    field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression23/1"))
  ])
]).

article("6", "Onze Minister zendt binnen vier jaar na de inwerkingtreding van deze wet, en vervolgens telkens na vier jaar, aan de Staten-Generaal een verslag over de doeltreffendheid en de effecten van deze wet in de praktijk.").
article_property("6", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel6").

article("7", "Deze wet treedt in werking op een bij koninklijk besluit te bepalen tijdstip.").
article_property("7", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel7").

article("8", "Deze wet wordt aangehaald als: Wet op de zorgtoeslag.").
article_property("8", "url", "https://wetten.overheid.nl/BWBR0018451/2024-01-01#Artikel8").
execution_property("8", "actions", [
  record([
    field("output", "wet_naam"),
    field("value", expression("wet_op_de_zorgtoeslag@2024-01-01/expression24/1"))
  ])
]).

ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression1/1", "Minister van Volksgezondheid, Welzijn en Sport").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression2/1", decimal(3749600, 0)).
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression3/1", decimal(4821800, 0)).
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression4/1", decimal(1879, 5)).
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression5/1", decimal(4256, 5)).
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression6/1", decimal(1367, 4)).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression7/4", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression7/5", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression7/3", ["wet_op_de_zorgtoeslag@2024-01-01/expression7/4", "wet_op_de_zorgtoeslag@2024-01-01/expression7/5"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression7/3", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression7/8", "toetsingsinkomen_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression7/9", null).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression7/7", ["wet_op_de_zorgtoeslag@2024-01-01/expression7/8", "wet_op_de_zorgtoeslag@2024-01-01/expression7/9"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression7/7", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression7/6", ["wet_op_de_zorgtoeslag@2024-01-01/expression7/7"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression7/6", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("wet_op_de_zorgtoeslag@2024-01-01/expression7/2", "AND", ["wet_op_de_zorgtoeslag@2024-01-01/expression7/3", "wet_op_de_zorgtoeslag@2024-01-01/expression7/6"]).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression7/11", "toetsingsinkomen").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression7/12", "toetsingsinkomen_toeslagpartner").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression7/10", ["wet_op_de_zorgtoeslag@2024-01-01/expression7/11", "wet_op_de_zorgtoeslag@2024-01-01/expression7/12"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression7/10", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression7/13", "toetsingsinkomen").
ee_conditional("wet_op_de_zorgtoeslag@2024-01-01/expression7/1", [case("wet_op_de_zorgtoeslag@2024-01-01/expression7/2", "wet_op_de_zorgtoeslag@2024-01-01/expression7/10")], "wet_op_de_zorgtoeslag@2024-01-01/expression7/13").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression8/2", decimal(0, 0)).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/6", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression8/7", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/5", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/6", "wet_op_de_zorgtoeslag@2024-01-01/expression8/7"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/5", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression8/9", decimal(2, 0)).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/10", "standaardpremie").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/8", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/9", "wet_op_de_zorgtoeslag@2024-01-01/expression8/10"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/8", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/11", "standaardpremie").
ee_conditional("wet_op_de_zorgtoeslag@2024-01-01/expression8/4", [case("wet_op_de_zorgtoeslag@2024-01-01/expression8/5", "wet_op_de_zorgtoeslag@2024-01-01/expression8/8")], "wet_op_de_zorgtoeslag@2024-01-01/expression8/11").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/16", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression8/17", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/15", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/16", "wet_op_de_zorgtoeslag@2024-01-01/expression8/17"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/15", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/18", "percentage_drempelinkomen_partner").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/19", "percentage_drempelinkomen_alleenstaande").
ee_conditional("wet_op_de_zorgtoeslag@2024-01-01/expression8/14", [case("wet_op_de_zorgtoeslag@2024-01-01/expression8/15", "wet_op_de_zorgtoeslag@2024-01-01/expression8/18")], "wet_op_de_zorgtoeslag@2024-01-01/expression8/19").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/21", "in_aanmerking_genomen_toetsingsinkomen").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/24", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression8/25", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/23", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/24", "wet_op_de_zorgtoeslag@2024-01-01/expression8/25"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/23", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/26", "drempelinkomen_aanvrager_met_toeslagpartner").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/27", "drempelinkomen_alleenstaande").
ee_conditional("wet_op_de_zorgtoeslag@2024-01-01/expression8/22", [case("wet_op_de_zorgtoeslag@2024-01-01/expression8/23", "wet_op_de_zorgtoeslag@2024-01-01/expression8/26")], "wet_op_de_zorgtoeslag@2024-01-01/expression8/27").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/20", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/21", "wet_op_de_zorgtoeslag@2024-01-01/expression8/22"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/20", "MIN", record([field("operation", "MIN"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MIN")])), field("missingValue", true)])).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/13", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/14", "wet_op_de_zorgtoeslag@2024-01-01/expression8/20"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/13", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/30", "in_aanmerking_genomen_toetsingsinkomen").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/33", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression8/34", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/32", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/33", "wet_op_de_zorgtoeslag@2024-01-01/expression8/34"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/32", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/35", "drempelinkomen_aanvrager_met_toeslagpartner").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/36", "drempelinkomen_alleenstaande").
ee_conditional("wet_op_de_zorgtoeslag@2024-01-01/expression8/31", [case("wet_op_de_zorgtoeslag@2024-01-01/expression8/32", "wet_op_de_zorgtoeslag@2024-01-01/expression8/35")], "wet_op_de_zorgtoeslag@2024-01-01/expression8/36").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/29", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/30", "wet_op_de_zorgtoeslag@2024-01-01/expression8/31"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/29", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/39", "in_aanmerking_genomen_toetsingsinkomen").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/42", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression8/43", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/41", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/42", "wet_op_de_zorgtoeslag@2024-01-01/expression8/43"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/41", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/44", "drempelinkomen_aanvrager_met_toeslagpartner").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/45", "drempelinkomen_alleenstaande").
ee_conditional("wet_op_de_zorgtoeslag@2024-01-01/expression8/40", [case("wet_op_de_zorgtoeslag@2024-01-01/expression8/41", "wet_op_de_zorgtoeslag@2024-01-01/expression8/44")], "wet_op_de_zorgtoeslag@2024-01-01/expression8/45").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/38", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/39", "wet_op_de_zorgtoeslag@2024-01-01/expression8/40"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/38", "SUBTRACT", record([field("operation", "SUBTRACT"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "SUBTRACT")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression8/46", "percentage_toetsingsinkomen").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/37", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/38", "wet_op_de_zorgtoeslag@2024-01-01/expression8/46"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/37", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression8/47", decimal(0, 0)).
ee_conditional("wet_op_de_zorgtoeslag@2024-01-01/expression8/28", [case("wet_op_de_zorgtoeslag@2024-01-01/expression8/29", "wet_op_de_zorgtoeslag@2024-01-01/expression8/37")], "wet_op_de_zorgtoeslag@2024-01-01/expression8/47").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/12", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/13", "wet_op_de_zorgtoeslag@2024-01-01/expression8/28"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/12", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/3", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/4", "wet_op_de_zorgtoeslag@2024-01-01/expression8/12"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/3", "SUBTRACT", record([field("operation", "SUBTRACT"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "SUBTRACT")])), field("missingValue", true)])).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression8/1", ["wet_op_de_zorgtoeslag@2024-01-01/expression8/2", "wet_op_de_zorgtoeslag@2024-01-01/expression8/3"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression8/1", "MAX", record([field("operation", "MAX"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MAX")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression9/3", "is_verzekerde").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression9/4", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression9/2", ["wet_op_de_zorgtoeslag@2024-01-01/expression9/3", "wet_op_de_zorgtoeslag@2024-01-01/expression9/4"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression9/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression9/6", "vermogen_onder_grens").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression9/7", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression9/5", ["wet_op_de_zorgtoeslag@2024-01-01/expression9/6", "wet_op_de_zorgtoeslag@2024-01-01/expression9/7"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression9/5", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression9/9", "hoogte_zorgtoeslag").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression9/10", decimal(0, 0)).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression9/8", ["wet_op_de_zorgtoeslag@2024-01-01/expression9/9", "wet_op_de_zorgtoeslag@2024-01-01/expression9/10"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression9/8", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_logical("wet_op_de_zorgtoeslag@2024-01-01/expression9/1", "AND", ["wet_op_de_zorgtoeslag@2024-01-01/expression9/2", "wet_op_de_zorgtoeslag@2024-01-01/expression9/5", "wet_op_de_zorgtoeslag@2024-01-01/expression9/8"]).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression10/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression11/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression12/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression13/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression14/1", "bsn_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression15/1", decimal(12758200, 0)).
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression16/1", decimal(16132900, 0)).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression17/4", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression17/5", true).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression17/3", ["wet_op_de_zorgtoeslag@2024-01-01/expression17/4", "wet_op_de_zorgtoeslag@2024-01-01/expression17/5"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression17/3", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression17/8", "vermogen_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression17/9", null).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression17/7", ["wet_op_de_zorgtoeslag@2024-01-01/expression17/8", "wet_op_de_zorgtoeslag@2024-01-01/expression17/9"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression17/7", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression17/6", ["wet_op_de_zorgtoeslag@2024-01-01/expression17/7"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression17/6", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("wet_op_de_zorgtoeslag@2024-01-01/expression17/2", "AND", ["wet_op_de_zorgtoeslag@2024-01-01/expression17/3", "wet_op_de_zorgtoeslag@2024-01-01/expression17/6"]).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression17/12", "vermogen").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression17/13", "vermogen_toeslagpartner").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression17/11", ["wet_op_de_zorgtoeslag@2024-01-01/expression17/12", "wet_op_de_zorgtoeslag@2024-01-01/expression17/13"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression17/11", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression17/14", "vermogensgrens_aanvrager_met_toeslagpartner").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression17/10", ["wet_op_de_zorgtoeslag@2024-01-01/expression17/11", "wet_op_de_zorgtoeslag@2024-01-01/expression17/14"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression17/10", "LESS_THAN_OR_EQUAL", record([field("operation", "LESS_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "LESS_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression17/16", "vermogen").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression17/17", "vermogensgrens_alleenstaand").
ee_arguments("wet_op_de_zorgtoeslag@2024-01-01/expression17/15", ["wet_op_de_zorgtoeslag@2024-01-01/expression17/16", "wet_op_de_zorgtoeslag@2024-01-01/expression17/17"]).
ee_primitive("wet_op_de_zorgtoeslag@2024-01-01/expression17/15", "LESS_THAN_OR_EQUAL", record([field("operation", "LESS_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "LESS_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_conditional("wet_op_de_zorgtoeslag@2024-01-01/expression17/1", [case("wet_op_de_zorgtoeslag@2024-01-01/expression17/2", "wet_op_de_zorgtoeslag@2024-01-01/expression17/10")], "wet_op_de_zorgtoeslag@2024-01-01/expression17/15").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression18/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression19/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression20/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression21/1", "bsn_toeslagpartner").
ee_reference("wet_op_de_zorgtoeslag@2024-01-01/expression22/1", "standaardpremie").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression23/1", "Dienst Toeslagen").
ee_literal("wet_op_de_zorgtoeslag@2024-01-01/expression24/1", "Wet op de zorgtoeslag").
