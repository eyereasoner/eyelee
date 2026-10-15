% wet_op_de_zorgtoeslag, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("wet_op_de_zorgtoeslag").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.8/schema/v0.5.8/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2024-12-20").
law_property("valid_from", "2025-01-01").
law_property("bwb_id", "BWBR0018451").
law_property("url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01").
law_property("name", "#wet_naam").
law_property("competent_authority", "#bevoegd_gezag").
article("1", "1. In deze wet en de daarop berustende bepalingen wordt, tenzij anders is geregeld, verstaan onder: a. Onze Minister: Onze Minister van Volksgezondheid, Welzijn en Sport; b. zorgverzekering: de schadeverzekering, bedoeld in artikel 1, onder d, van de Zorgverzekeringswet; c. verzekerde: de persoon, bedoeld in artikel 1, onder f, van de Zorgverzekeringswet, de persoon die een bijdrage als bedoeld in artikel 68b, vijfde lid, van de Zorgverzekeringswet verschuldigd is, of de persoon, bedoeld in artikel 69 van de Zorgverzekeringswet, steeds vanaf de eerste dag van de kalendermaand volgende op de maand waarin hij achttien jaar wordt, met uitzondering van de verzekerde, bedoeld in artikel 24, eerste of derde lid,van die wet; d. premie: een premie als bedoeld in afdeling 3.3.1 van de Zorgverzekeringswet; e. zorgtoeslag: een tegemoetkoming in een premie dan wel in een bestuursrechtelijke premie als bedoeld in artikel 18d of 18e van de Zorgverzekeringswet en in het verplicht eigen risico, bedoeld in artikel 19 van de Zorgverzekeringswet; f. drempelinkomen: 108% van het twaalfvoud van het voor de maand januari van het berekeningsjaar geldende in artikel 8, eerste lid, onderdeel b, van de Wet minimumloon en minimumvakantiebijslag bedoelde bedrag per maand; g. de standaardpremie: het op grond van artikel 4 vastgestelde bedrag; h. de normpremie: de aan de hand van het drempelinkomen en het toetsingsinkomen van de verzekerde berekende premie voor een zorgverzekering in het berekeningsjaar.\n\n2. De hoogte van de zorgtoeslag is afhankelijk van de draagkracht op basis van het inkomen en het vermogen.").
article_property("1", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel1").
definition("1", "verantwoordelijke_autoriteit", expression("wet_op_de_zorgtoeslag@2025-01-01/expression1/1")).

article("2", "1. Indien de normpremie voor een verzekerde in het berekeningsjaar minder bedraagt dan de standaardpremie in dat jaar, heeft de verzekerde aanspraak op een zorgtoeslag ter grootte van dat verschil. Voor een verzekerde met een partner wordt daarbij tweemaal de standaardpremie in aanmerking genomen; in dat geval worden de verzekerde en zijn partner voor de toepassing van deze wet geacht gezamenlijk één aanspraak te hebben.\n\n2. De normpremie bedraagt een percentage van het drempelinkomen in het berekeningsjaar, vermeerderd met een percentage van het toetsingsinkomen van de verzekerde in dat jaar voorzover dat toetsingsinkomen het drempelinkomen te boven gaat. Voor een verzekerde met een partner wordt daarbij het gezamenlijke toetsingsinkomen in aanmerking genomen.\n\n3. De percentages worden voor verzekerden met een partner vastgesteld op 4,273% van het drempelinkomen, vermeerderd met 13,700% van het toetsingsinkomen voor zover dat boven het drempelinkomen uitgaat en voor een verzekerde zonder partner op 1,896% van het drempelinkomen, vermeerderd met 13,700% van het toetsingsinkomen voor zover dat boven het drempelinkomen uitgaat. Deze percentages kunnen bij algemene maatregel van bestuur worden gewijzigd.\n\n4. In afwijking van het eerste lid bedraagt de aanspraak op een zorgtoeslag voor een verzekerde met een partner die geen verzekerde is, vijftig procent van het op grond van het eerste lid berekende bedrag.\n\n5. De aanspraak op een zorgtoeslag wordt voor iedere kalendermaand afzonderlijk bepaald.\n\n6. Bij regeling van Onze Minister kunnen omtrent het bepaalde in het vijfde lid nadere regels worden gesteld.\n\n7. De voordracht voor een krachtens het derde lid vast te stellen algemene maatregel van bestuur wordt niet eerder gedaan dan twee weken nadat het ontwerp aan beide kamers der Staten-Generaal is overgelegd.").
article_property("2", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel2").
definition("2", "drempelinkomen_alleenstaande", record([
  field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression2/1")),
  field("type", "amount"),
  field("type_spec", record([
    field("unit", "eurocent")
  ]))
])).
definition("2", "drempelinkomen_aanvrager_met_toeslagpartner", record([
  field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression3/1")),
  field("type", "amount"),
  field("type_spec", record([
    field("unit", "eurocent")
  ]))
])).
definition("2", "percentage_drempelinkomen_alleenstaande", record([
  field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression4/1")),
  field("type", "number"),
  field("type_spec", record([
    field("unit", "ratio")
  ]))
])).
definition("2", "percentage_drempelinkomen_partner", record([
  field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression5/1")),
  field("type", "number"),
  field("type_spec", record([
    field("unit", "ratio")
  ]))
])).
definition("2", "percentage_toetsingsinkomen", record([
  field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression6/1")),
  field("type", "number"),
  field("type_spec", record([
    field("unit", "ratio")
  ]))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression10/1"))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression11/1"))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression12/1"))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression13/1"))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression14/1"))
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
    field("legal_basis", record([
      field("law", "Wet op de zorgtoeslag"),
      field("bwb_id", "BWBR0018451"),
      field("article", "2"),
      field("paragraph", "2"),
      field("url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel2"),
      field("juriconnect", "jci1.3:c:BWBR0018451&artikel=2&lid=2&z=2025-01-01&g=2025-01-01"),
      field("explanation", "Het toetsingsinkomen waarmee de normpremie wordt berekend. Voor een verzekerde met een partner is dat het gezamenlijke toetsingsinkomen: dat van de verzekerde vermeerderd met dat van de partner. Zonder partner is het dat van de verzekerde.")
    ])),
    field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression7/1"))
  ]),
  record([
    field("output", "hoogte_zorgtoeslag"),
    field("legal_basis", record([
      field("law", "Wet op de zorgtoeslag"),
      field("bwb_id", "BWBR0018451"),
      field("article", "2"),
      field("paragraph", "1"),
      field("url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel2"),
      field("juriconnect", "jci1.3:c:BWBR0018451&artikel=2&lid=1&z=2025-01-01&g=2025-01-01"),
      field("explanation", "Het verschil tussen de standaardpremie en de normpremie. Lid 1 verdubbelt de standaardpremie bij een toeslagpartner; de normpremie zelf volgt uit lid 2 en lid 3. Lid 4 (vijftig procent bij een partner die geen verzekerde is) is nog niet gemodelleerd.")
    ])),
    field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression8/1"))
  ]),
  record([
    field("output", "heeft_recht_op_zorgtoeslag"),
    field("legal_basis", record([
      field("law", "Wet op de zorgtoeslag"),
      field("bwb_id", "BWBR0018451"),
      field("article", "2"),
      field("url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel2"),
      field("juriconnect", "jci1.3:c:BWBR0018451&artikel=2&z=2025-01-01&g=2025-01-01"),
      field("explanation", "De aanspraak ontstaat pas als het verschil uit artikel 2 lid 1 positief is. Daarnaast gelden twee voorwaarden van buiten dit lid: verzekerd zijn (artikel 1 onderdeel a) en de vermogenstoets (artikel 3), die als uitsluitingsgrond is geformuleerd.")
    ])),
    field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression9/1"))
  ])
]).

article("3", "1. In afwijking van artikel 7, derde lid, van de Algemene wet inkomensafhankelijke regelingen, bestaat geen aanspraak op een zorgtoeslag indien de rendementsgrondslag, bedoeld in artikel 5.3 van de Wet inkomstenbelasting 2001, van de verzekerde aan het begin van het berekeningsjaar meer bedraagt dan € 141.896 of, indien de verzekerde het gehele berekeningsjaar dezelfde partner heeft, de gezamenlijke rendementsgrondslag, bedoeld in artikel 5.3, van de Wet inkomstenbelasting 2001, van de verzekerde en zijn partner aan het begin van het berekeningsjaar meer bedraagt dan € 179.429. Bij de bepaling van de rendementsgrondslag, bedoeld in de vorige zin, wordt geen rekening gehouden met de vrijstelling, bedoeld in artikel 5.13 van de Wet inkomstenbelasting 2001.\n\n2. Bij het begin van het kalenderjaar worden de bedragen, bedoeld in het eerste lid, bij ministeriële regeling gewijzigd overeenkomstig de tabelcorrectiefactor, bedoeld in artikel 10.2 van de Wet inkomstenbelasting 2001.\n\n3. Indien er aanleiding is om de bedragen, bedoeld in het eerste lid, te verhogen op een andere wijze dan op grond van het tweede lid, worden de bedragen vastgesteld bij algemene maatregel van bestuur.\n\n4. De overeenkomstig het tweede en derde lid aangepaste bedragen treden in de plaats van de bedragen, genoemd in het eerste lid.\n\n5. Indien een verhoging als bedoeld in het derde lid wordt toegepast, vindt deze verhoging plaats nadat het tweede lid toepassing heeft gevonden.").
article_property("3", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel3").
definition("3", "vermogensgrens_verzekerde", record([
  field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression15/1")),
  field("type", "amount"),
  field("type_spec", record([
    field("unit", "eurocent")
  ]))
])).
definition("3", "vermogensgrens_gezamenlijk", record([
  field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression16/1")),
  field("type", "amount"),
  field("type_spec", record([
    field("unit", "eurocent")
  ]))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression18/1"))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression19/1"))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression20/1"))
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
        field("bsn", expression("wet_op_de_zorgtoeslag@2025-01-01/expression21/1"))
      ]))
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "heeft_gehele_berekeningsjaar_dezelfde_partner"),
    field("type", "boolean"),
    field("source", record([]))
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
    field("legal_basis", record([
      field("law", "Wet op de zorgtoeslag"),
      field("bwb_id", "BWBR0018451"),
      field("article", "3"),
      field("paragraph", "1"),
      field("url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel3"),
      field("juriconnect", "jci1.3:c:BWBR0018451&artikel=3&lid=1&z=2025-01-01&g=2025-01-01"),
      field("explanation", "Lid 1 kent twee gronden, verbonden door \"of\": de rendementsgrondslag van de verzekerde bedraagt meer dan 141.896 euro, \"of, indien de verzekerde het gehele berekeningsjaar dezelfde partner heeft\", de gezamenlijke rendementsgrondslag van de verzekerde en zijn partner bedraagt meer dan 179.429 euro. Is een van beide waar, dan bestaat geen aanspraak. De vermogenstoets is doorstaan als geen van beide waar is.")
    ])),
    field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression17/1"))
  ])
]).

article("4", "Onze Minister stelt uiterlijk 22 dagen voorafgaande aan het berekeningsjaar bij regeling de standaardpremie voor het berekeningsjaar vast die wordt gevormd door de geraamde gemiddelde premie voor een verzekerde voor een zorgverzekering in het berekeningsjaar te vermeerderen met het geraamde gemiddelde bedrag dat een verzekerde naar verwachting in dat jaar betaalt ingevolge artikel 19 van de Zorgverzekeringswet.").
article_property("4", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel4").
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
    field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression22/1"))
  ])
]).

article("4a", "1. De standaardpremie voor een persoon als bedoeld in artikel 69 van de Zorgverzekeringswet is, in afwijking van artikel 4, gelijk aan het met toepassing van dat artikel bepaalde bedrag, vermenigvuldigd met het getal dat wordt berekend uit de verhouding tussen de gemiddelde uitgaven voor zorg voor een persoon ten laste van de sociale zorgverzekeringen in het woonland van deze persoon, en de gemiddelde uitgaven voor zorg voor een persoon ten laste van de sociale zorgverzekeringen in Nederland.\n\n2. Bij ministeriële regeling wordt jaarlijks uiterlijk in november per land het in het eerste lid bedoelde verhoudingsgetal vastgesteld.\n\n3. De aanspraak op een zorgtoeslag van een verzekerde met een partner die een persoon is als bedoeld in artikel 69 van de Zorgverzekeringswet, wordt berekend met toepassing van artikel 2, eerste lid, tweede zin, waarbij de standaardpremie, bedoeld in het eerste lid, in acht wordt genomen.\n\n4. De standaardpremie voor een partner van een persoon als bedoeld in artikel 69 van de Zorgverzekeringswet wordt overeenkomstig het eerste lid vastgesteld, tenzij deze partner een persoon is als bedoeld in artikel 1, onderdeel f, van de Zorgverzekeringswet.").
article_property("4a", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel4a").

article("5", "1. De Dienst Toeslagen is belast met de uitvoering van deze wet.\n\n2. In afwijking van artikel 25, eerste lid, van de Algemene wet inkomensafhankelijke regelingen betaalt de Dienst Toeslagen in opdracht van het CAK, genoemd in artikel 6.1.1, eerste lid, van de Wet langdurige zorg, de zorgtoeslag of het voorschot op de zorgtoeslag als tegemoetkoming in de bestuursrechtelijke premie, bedoeld in artikel 18d of 18e van de Zorgverzekeringswet, aan het CAK uit.\n\n3. De persoon, bedoeld in artikel 68b, vijfde lid, van de Zorgverzekeringswet, wordt geacht, zo nodig in afwijking van artikel 15, eerste lid, van de Algemene wet inkomensafhankelijke regelingen, tijdig een aanvraag als bedoeld in laatstgenoemd artikel te hebben gedaan voor de berekeningsjaren in de periode gelegen tussen de ingangsdatum van de verzekeringsplicht voor de Zorgverzekeringswet en het moment waarop hij van het CAK een kennisgeving heeft ontvangen van de verplichting om een zorgverzekering af te sluiten.\n\n4. Voor de toepassing van artikel 16, eerste lid, van de Algemene wet inkomensafhankelijke regelingen wordt in het geval, bedoeld in het derde lid, de aanvraag geacht te zijn gedaan op het moment waarop de Belastingdienst/Toeslagen van het CAK een afschrift heeft ontvangen van de beschikking, bedoeld in artikel 68b, zesde lid, van de Zorgverzekeringswet.\n\n5. De zorgtoeslag komt ten laste van het Rijk.").
article_property("5", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel5").
execution_property("5", "actions", [
  record([
    field("output", "bevoegd_gezag"),
    field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression23/1"))
  ])
]).

article("6", "Onze Minister zendt binnen vier jaar na de inwerkingtreding van deze wet, en vervolgens telkens na vier jaar, aan de Staten-Generaal een verslag over de doeltreffendheid en de effecten van deze wet in de praktijk, in het bijzonder van de bij of krachtens deze wet vastgestelde percentages ter bepaling van de normpremie.").
article_property("6", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel6").

article("7", "Deze wet treedt in werking op een bij koninklijk besluit te bepalen tijdstip.").
article_property("7", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel7").

article("8", "Deze wet wordt aangehaald als: Wet op de zorgtoeslag.").
article_property("8", "url", "https://wetten.overheid.nl/BWBR0018451/2025-01-01#Artikel8").
execution_property("8", "actions", [
  record([
    field("output", "wet_naam"),
    field("value", expression("wet_op_de_zorgtoeslag@2025-01-01/expression24/1"))
  ])
]).

ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression1/1", "Minister van Volksgezondheid, Welzijn en Sport").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression2/1", decimal(2820096, 0)).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression3/1", decimal(2820096, 0)).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression4/1", decimal(1896, 5)).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression5/1", decimal(4273, 5)).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression6/1", decimal(137, 3)).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression7/4", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression7/5", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression7/3", ["wet_op_de_zorgtoeslag@2025-01-01/expression7/4", "wet_op_de_zorgtoeslag@2025-01-01/expression7/5"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression7/3", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression7/8", "toetsingsinkomen_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression7/9", null).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression7/7", ["wet_op_de_zorgtoeslag@2025-01-01/expression7/8", "wet_op_de_zorgtoeslag@2025-01-01/expression7/9"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression7/7", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression7/6", ["wet_op_de_zorgtoeslag@2025-01-01/expression7/7"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression7/6", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("wet_op_de_zorgtoeslag@2025-01-01/expression7/2", "AND", ["wet_op_de_zorgtoeslag@2025-01-01/expression7/3", "wet_op_de_zorgtoeslag@2025-01-01/expression7/6"]).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression7/11", "toetsingsinkomen").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression7/12", "toetsingsinkomen_toeslagpartner").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression7/10", ["wet_op_de_zorgtoeslag@2025-01-01/expression7/11", "wet_op_de_zorgtoeslag@2025-01-01/expression7/12"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression7/10", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression7/13", "toetsingsinkomen").
ee_conditional("wet_op_de_zorgtoeslag@2025-01-01/expression7/1", [case("wet_op_de_zorgtoeslag@2025-01-01/expression7/2", "wet_op_de_zorgtoeslag@2025-01-01/expression7/10")], "wet_op_de_zorgtoeslag@2025-01-01/expression7/13").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/3", decimal(0, 0)).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/7", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/8", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/6", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/7", "wet_op_de_zorgtoeslag@2025-01-01/expression8/8"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/10", decimal(2, 0)).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/11", "standaardpremie").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/9", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/10", "wet_op_de_zorgtoeslag@2025-01-01/expression8/11"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/9", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/12", "standaardpremie").
ee_conditional("wet_op_de_zorgtoeslag@2025-01-01/expression8/5", [case("wet_op_de_zorgtoeslag@2025-01-01/expression8/6", "wet_op_de_zorgtoeslag@2025-01-01/expression8/9")], "wet_op_de_zorgtoeslag@2025-01-01/expression8/12").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/17", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/18", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/16", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/17", "wet_op_de_zorgtoeslag@2025-01-01/expression8/18"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/16", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/19", "percentage_drempelinkomen_partner").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/20", "percentage_drempelinkomen_alleenstaande").
ee_conditional("wet_op_de_zorgtoeslag@2025-01-01/expression8/15", [case("wet_op_de_zorgtoeslag@2025-01-01/expression8/16", "wet_op_de_zorgtoeslag@2025-01-01/expression8/19")], "wet_op_de_zorgtoeslag@2025-01-01/expression8/20").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/23", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/24", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/22", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/23", "wet_op_de_zorgtoeslag@2025-01-01/expression8/24"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/22", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/25", "drempelinkomen_aanvrager_met_toeslagpartner").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/26", "drempelinkomen_alleenstaande").
ee_conditional("wet_op_de_zorgtoeslag@2025-01-01/expression8/21", [case("wet_op_de_zorgtoeslag@2025-01-01/expression8/22", "wet_op_de_zorgtoeslag@2025-01-01/expression8/25")], "wet_op_de_zorgtoeslag@2025-01-01/expression8/26").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/14", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/15", "wet_op_de_zorgtoeslag@2025-01-01/expression8/21"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/14", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/29", "in_aanmerking_genomen_toetsingsinkomen").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/32", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/33", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/31", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/32", "wet_op_de_zorgtoeslag@2025-01-01/expression8/33"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/31", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/34", "drempelinkomen_aanvrager_met_toeslagpartner").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/35", "drempelinkomen_alleenstaande").
ee_conditional("wet_op_de_zorgtoeslag@2025-01-01/expression8/30", [case("wet_op_de_zorgtoeslag@2025-01-01/expression8/31", "wet_op_de_zorgtoeslag@2025-01-01/expression8/34")], "wet_op_de_zorgtoeslag@2025-01-01/expression8/35").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/28", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/29", "wet_op_de_zorgtoeslag@2025-01-01/expression8/30"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/28", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/38", "in_aanmerking_genomen_toetsingsinkomen").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/41", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/42", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/40", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/41", "wet_op_de_zorgtoeslag@2025-01-01/expression8/42"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/40", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/43", "drempelinkomen_aanvrager_met_toeslagpartner").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/44", "drempelinkomen_alleenstaande").
ee_conditional("wet_op_de_zorgtoeslag@2025-01-01/expression8/39", [case("wet_op_de_zorgtoeslag@2025-01-01/expression8/40", "wet_op_de_zorgtoeslag@2025-01-01/expression8/43")], "wet_op_de_zorgtoeslag@2025-01-01/expression8/44").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/37", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/38", "wet_op_de_zorgtoeslag@2025-01-01/expression8/39"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/37", "SUBTRACT", record([field("operation", "SUBTRACT"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "SUBTRACT")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression8/45", "percentage_toetsingsinkomen").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/36", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/37", "wet_op_de_zorgtoeslag@2025-01-01/expression8/45"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/36", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/46", decimal(0, 0)).
ee_conditional("wet_op_de_zorgtoeslag@2025-01-01/expression8/27", [case("wet_op_de_zorgtoeslag@2025-01-01/expression8/28", "wet_op_de_zorgtoeslag@2025-01-01/expression8/36")], "wet_op_de_zorgtoeslag@2025-01-01/expression8/46").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/13", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/14", "wet_op_de_zorgtoeslag@2025-01-01/expression8/27"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/13", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/4", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/5", "wet_op_de_zorgtoeslag@2025-01-01/expression8/13"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/4", "SUBTRACT", record([field("operation", "SUBTRACT"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "SUBTRACT")])), field("missingValue", true)])).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/2", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/3", "wet_op_de_zorgtoeslag@2025-01-01/expression8/4"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/2", "MAX", record([field("operation", "MAX"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MAX")])), field("missingValue", true)])).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression8/47", decimal(0, 0)).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression8/1", ["wet_op_de_zorgtoeslag@2025-01-01/expression8/2", "wet_op_de_zorgtoeslag@2025-01-01/expression8/47"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression8/1", "ROUND", record([field("operation", "ROUND"), field("shape", [record([field("field", "value"), field("count", null)]), record([field("field", "precision"), field("count", null)])]), field("staticFields", record([field("operation", "ROUND")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression9/3", "is_verzekerde").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression9/4", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression9/2", ["wet_op_de_zorgtoeslag@2025-01-01/expression9/3", "wet_op_de_zorgtoeslag@2025-01-01/expression9/4"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression9/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression9/6", "vermogen_onder_grens").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression9/7", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression9/5", ["wet_op_de_zorgtoeslag@2025-01-01/expression9/6", "wet_op_de_zorgtoeslag@2025-01-01/expression9/7"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression9/5", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression9/9", "hoogte_zorgtoeslag").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression9/10", decimal(0, 0)).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression9/8", ["wet_op_de_zorgtoeslag@2025-01-01/expression9/9", "wet_op_de_zorgtoeslag@2025-01-01/expression9/10"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression9/8", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_logical("wet_op_de_zorgtoeslag@2025-01-01/expression9/1", "AND", ["wet_op_de_zorgtoeslag@2025-01-01/expression9/2", "wet_op_de_zorgtoeslag@2025-01-01/expression9/5", "wet_op_de_zorgtoeslag@2025-01-01/expression9/8"]).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression10/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression11/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression12/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression13/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression14/1", "bsn_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression15/1", decimal(14189600, 0)).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression16/1", decimal(17942900, 0)).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression17/3", "vermogen").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression17/4", "vermogensgrens_verzekerde").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression17/2", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/3", "wet_op_de_zorgtoeslag@2025-01-01/expression17/4"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression17/2", "LESS_THAN_OR_EQUAL", record([field("operation", "LESS_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "LESS_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression17/8", "heeft_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression17/9", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression17/7", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/8", "wet_op_de_zorgtoeslag@2025-01-01/expression17/9"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression17/7", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression17/11", "heeft_gehele_berekeningsjaar_dezelfde_partner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression17/12", true).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression17/10", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/11", "wet_op_de_zorgtoeslag@2025-01-01/expression17/12"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression17/10", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression17/15", "vermogen_toeslagpartner").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression17/16", null).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression17/14", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/15", "wet_op_de_zorgtoeslag@2025-01-01/expression17/16"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression17/14", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression17/13", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/14"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression17/13", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("wet_op_de_zorgtoeslag@2025-01-01/expression17/6", "AND", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/7", "wet_op_de_zorgtoeslag@2025-01-01/expression17/10", "wet_op_de_zorgtoeslag@2025-01-01/expression17/13"]).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression17/19", "vermogen").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression17/20", "vermogen_toeslagpartner").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression17/18", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/19", "wet_op_de_zorgtoeslag@2025-01-01/expression17/20"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression17/18", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression17/21", "vermogensgrens_gezamenlijk").
ee_arguments("wet_op_de_zorgtoeslag@2025-01-01/expression17/17", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/18", "wet_op_de_zorgtoeslag@2025-01-01/expression17/21"]).
ee_primitive("wet_op_de_zorgtoeslag@2025-01-01/expression17/17", "LESS_THAN_OR_EQUAL", record([field("operation", "LESS_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "LESS_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression17/22", true).
ee_conditional("wet_op_de_zorgtoeslag@2025-01-01/expression17/5", [case("wet_op_de_zorgtoeslag@2025-01-01/expression17/6", "wet_op_de_zorgtoeslag@2025-01-01/expression17/17")], "wet_op_de_zorgtoeslag@2025-01-01/expression17/22").
ee_logical("wet_op_de_zorgtoeslag@2025-01-01/expression17/1", "AND", ["wet_op_de_zorgtoeslag@2025-01-01/expression17/2", "wet_op_de_zorgtoeslag@2025-01-01/expression17/5"]).
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression18/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression19/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression20/1", "bsn").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression21/1", "bsn_toeslagpartner").
ee_reference("wet_op_de_zorgtoeslag@2025-01-01/expression22/1", "standaardpremie").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression23/1", "Dienst Toeslagen").
ee_literal("wet_op_de_zorgtoeslag@2025-01-01/expression24/1", "Wet op de zorgtoeslag").
