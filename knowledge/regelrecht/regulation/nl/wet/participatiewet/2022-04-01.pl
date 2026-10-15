% participatiewet, in force from 2022-04-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("participatiewet").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.7/schema/v0.5.7/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2014-07-15").
law_property("valid_from", "2022-04-01").
law_property("bwb_id", "BWBR0015703").
law_property("url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01").
law_property("name", "Participatiewet").
article("7", "**Opdracht college**\n\n1. Het college:\n   a. ondersteunt bij arbeidsinschakeling:\n      1°. personen die algemene bijstand ontvangen,\n      2°. personen als bedoeld in de artikelen 34a, vijfde lid, onderdeel b, 35, vierde lid, onderdeel b, en 36,\n      derde lid, onderdeel b, van de Wet werk en inkomen naar arbeidsvermogen tot het moment dat het inkomen uit\n      arbeid in dienstbetrekking gedurende twee aaneengesloten jaren ten minste het minimumloon bedraagt en ten\n      behoeve van die persoon in die twee jaren geen loonkostensubsidie als bedoeld in artikel 10d is verleend,\n      3°. personen als bedoeld in artikel 10, tweede lid,\n      4°. personen met een nabestaanden- of wezenuitkering op grond van de Algemene nabestaandenwet,\n      5°. personen met een uitkering op grond van de Wet inkomensvoorziening oudere en gedeeltelijk\n      arbeidsongeschikte werkloze werknemers,\n      6°. personen met een uitkering op grond van de Wet inkomensvoorziening oudere en gedeeltelijk\n      arbeidsongeschikte gewezen zelfstandigen, en\n      7°. niet-uitkeringsgerechtigden\n   en, indien het college daarbij het aanbieden van een voorziening, waaronder begrepen sociale activering gericht\n   op arbeidsinschakeling, noodzakelijk acht, bepaalt en biedt deze voorziening aan;\n   b. verleent bijstand aan personen hier te lande die in zodanige omstandigheden verkeren of dreigen te geraken\n   dat zij niet over de middelen beschikken om in de noodzakelijke kosten van het bestaan te voorzien; en\n   c. verleent uitkeringen als bedoeld in de Wet inkomensvoorziening oudere en gedeeltelijk arbeidsongeschikte\n   werkloze werknemers en de Wet inkomensvoorziening oudere en gedeeltelijk arbeidsongeschikte gewezen\n   zelfstandigen.").
article_property("7", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel7").

article("8", "**Verordeningen uitkeringen**\n\n1. De gemeenteraad stelt bij verordening regels met betrekking tot:\n   a. het verlagen van de bijstand, bedoeld in artikel 18, tweede lid en de periode van de verlaging van de\n   bijstand, bedoeld in artikel 18, vijfde en zesde lid;\n   b. het verlenen van een individuele inkomenstoeslag als bedoeld in artikel 36;\n   c. het verlagen van de bijstand, bedoeld in artikel 9a, twaalfde lid.\n\n2. De regels, bedoeld in het eerste lid, hebben voor zover het gaat om het eerste lid, onderdeel b, in ieder geval\nbetrekking op de hoogte van de individuele inkomenstoeslag en de wijze waarop invulling wordt gegeven aan de\nbegrippen langdurig en laag inkomen.").
article_property("8", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel8").
article_rule("8", "open_terms", [
  record([
    field("id", "verlaging_percentage"),
    field("type", "number"),
    field("required", true),
    field("delegated_to", "gemeenteraad"),
    field("delegation_type", "GEMEENTELIJKE_VERORDENING"),
    field("legal_basis", "artikel 8 lid 1 onderdeel a Participatiewet"),
    field("default", record([
      field("actions", [
        record([
          field("output", "verlaging_percentage"),
          field("value", expression("participatiewet@2022-04-01/expression3/1"))
        ])
      ])
    ]))
  ]),
  record([
    field("id", "duur_maanden"),
    field("type", "number"),
    field("required", true),
    field("delegated_to", "gemeenteraad"),
    field("delegation_type", "GEMEENTELIJKE_VERORDENING"),
    field("legal_basis", "artikel 8 lid 1 onderdeel a Participatiewet"),
    field("default", record([
      field("actions", [
        record([
          field("output", "duur_maanden"),
          field("value", expression("participatiewet@2022-04-01/expression4/1"))
        ])
      ])
    ]))
  ])
]).
execution_property("8", "parameters", [
  record([
    field("name", "gemeente_code"),
    field("type", "string"),
    field("required", true),
    field("description", "CBS gemeentecode van de gemeente")
  ])
]).
execution_property("8", "output", [
  record([
    field("name", "verlaging_percentage"),
    field("type", "number"),
    field("description", "Verlagingspercentage uit gemeentelijke afstemmingsverordening")
  ]),
  record([
    field("name", "duur_maanden"),
    field("type", "number"),
    field("description", "Duur van de verlaging in maanden uit gemeentelijke afstemmingsverordening")
  ])
]).
execution_property("8", "actions", [
  record([
    field("output", "verlaging_percentage"),
    field("value", expression("participatiewet@2022-04-01/expression1/1"))
  ]),
  record([
    field("output", "duur_maanden"),
    field("value", expression("participatiewet@2022-04-01/expression2/1"))
  ])
]).

article("11", "**Rechthebbenden**\n\n1. Iedere in Nederland woonachtige Nederlander die hier te lande in zodanige omstandigheden verkeert of dreigt te\ngeraken dat hij niet over de middelen beschikt om in de noodzakelijke kosten van bestaan te voorzien, heeft recht\nop bijstand van overheidswege.\n\n2. Met de Nederlander, bedoeld in het eerste lid, wordt gelijkgesteld de hier te lande woonachtige vreemdeling die\nrechtmatig in Nederland verblijf houdt in de zin van artikel 8, onderdelen a tot en met e en l, van de\nVreemdelingenwet 2000, met uitzondering van de gevallen, bedoeld in artikel 24, tweede lid, van Richtlijn\n2004/38/EG.\n\n3. Bij algemene maatregel van bestuur kunnen andere hier te lande woonachtige vreemdelingen dan de in het tweede\nlid bedoelde voor de toepassing van deze wet met een Nederlander gelijk worden gesteld:\n   a. ter uitvoering van een verdrag dan wel van een besluit van een volkenrechtelijke organisatie, of\n   b. indien zij, na rechtmatig verblijf te hebben gehouden in de zin van artikel 8, onderdelen a tot en met e en\n   l, van de Vreemdelingenwet 2000, rechtmatig in Nederland verblijf hebben als bedoeld in artikel 8, onderdeel g\n   of h, van die wet en zij aan de in die algemene maatregel van bestuur gestelde voorwaarden voldoen.\n\n4. Het recht op bijstand komt de echtgenoten gezamenlijk toe, tenzij een van de echtgenoten geen recht op bijstand\nheeft.").
article_property("11", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel11").

article("18", "**Afstemming**\n\n1. Het college stemt de bijstand en de daaraan verbonden verplichtingen af op de omstandigheden, mogelijkheden en\nmiddelen van de belanghebbende.\n\n2. Het college verlaagt de bijstand overeenkomstig de verordening, bedoeld in artikel 8, eerste lid, onderdeel a,\nter zake van het niet nakomen door de belanghebbende van de verplichtingen voortvloeiende uit deze wet, met\nuitzondering van artikel 17, eerste lid, dan wel indien de belanghebbende naar het oordeel van het college\ntekortschietend besef van verantwoordelijkheid betoont voor de voorziening in het bestaan.\n\n3. Het college heroverweegt een besluit als bedoeld in het tweede lid binnen een door hem te bepalen termijn die\nten hoogste drie maanden bedraagt.\n\n4. Het college verlaagt in ieder geval de bijstand overeenkomstig het vijfde, zesde, zevende of achtste lid ter\nzake van het niet nakomen door de belanghebbende van de volgende verplichtingen:\n   a. het aanvaarden of het behouden van algemeen geaccepteerde arbeid;\n   b. het uitvoering geven aan de door het college opgelegde verplichting om ingeschreven te staan bij een\n   uitzendbureau;\n   c. het naar vermogen verkrijgen van algemeen geaccepteerde arbeid in een andere dan de gemeente van inwoning,\n   alvorens naar die andere gemeente te verhuizen;\n   d. bereid zijn om te reizen over een afstand met een totale reisduur van 3 uur per dag, indien dat noodzakelijk\n   is voor het naar vermogen verkrijgen, het aanvaarden of het behouden van algemeen geaccepteerde arbeid;\n   e. bereid zijn om te verhuizen, indien het college is gebleken dat er geen andere mogelijkheid is voor het naar\n   vermogen verkrijgen, het aanvaarden of het behouden van algemeen geaccepteerde arbeid, en de belanghebbende een\n   arbeidsovereenkomst met een duur van tenminste een jaar en een netto beloning die ten minste gelijk is aan de\n   voor de belanghebbende geldende bijstandsnorm, kan aangaan;\n   f. het verkrijgen en behouden van kennis en vaardigheden, noodzakelijk voor het naar vermogen verkrijgen, het\n   aanvaarden of het behouden van algemeen geaccepteerde arbeid;\n   g. het naar vermogen verkrijgen, het aanvaarden of het behouden van algemeen geaccepteerde arbeid niet\n   belemmeren door kleding, gebrek aan persoonlijke verzorging of gedrag;\n   h. het gebruik maken van door het college aangeboden voorzieningen, waaronder begrepen sociale activering,\n   gericht op arbeidsinschakeling en mee te werken aan onderzoek naar zijn of haar mogelijkheden tot\n   arbeidsinschakeling.\n\n5. Indien de belanghebbende een verplichting als bedoeld in het vierde lid niet nakomt, verlaagt het college de\nbijstand met 100% voor een bij de verordening, bedoeld in artikel 8, eerste lid, onderdeel a, vastgestelde periode\nvan ten minste een maand en ten hoogste drie maanden.\n\n6. Indien de belanghebbende een verplichting als bedoeld in het vierde lid niet nakomt binnen twaalf maanden nadat\nhet vijfde lid toepassing heeft gevonden, verlaagt het college, in afwijking van het vijfde lid, de bijstand met\n100% voor een bij de verordening, bedoeld in artikel 8, eerste lid, onderdeel a, vastgestelde periode die in ieder\ngeval langer is dan de op grond van het vijfde lid vastgestelde periode van verlaging en ten hoogste drie maanden.\n\n7. Indien de belanghebbende een verplichting als bedoeld in het vierde lid niet nakomt binnen twaalf maanden nadat\nhet zesde lid toepassing heeft gevonden, verlaagt het college, in afwijking van het vijfde en zesde lid, de\nbijstand met 100% voor een periode van drie maanden.\n\n8. Indien de belanghebbende een verplichting als bedoeld in het vierde lid niet nakomt binnen twaalf maanden nadat\nhet zevende lid toepassing heeft gevonden, verlaagt het college, in afwijking van het vijfde, zesde en zevende\nlid, telkens de bijstand met 100% voor een periode van drie maanden.\n\n9. Het college ziet af van het opleggen van een maatregel, indien elke vorm van verwijtbaarheid ontbreekt.\n\n10. Het college stemt een op te leggen maatregel of een opgelegde maatregel af op de omstandigheden van de\nbelanghebbende en diens mogelijkheden om middelen te verwerven, indien naar zijn oordeel, gelet op bijzondere\nomstandigheden, dringende redenen daartoe noodzaken.\n\n11. Indien het college de bijstand overeenkomstig het vijfde, zesde, zevende of achtste lid heeft verlaagd, kan\nhet college op verzoek van de belanghebbende ten aanzien van wie de maatregel is opgelegd, de verlaging herzien\nzodra uit de houding en gedragingen van de belanghebbende ondubbelzinnig is gebleken dat hij de verplichtingen,\nbedoeld in het vierde lid, nakomt.\n\n12. Bij de toepassing van dit artikel wordt onder belanghebbende mede verstaan het gezin.").
article_property("18", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel18").
definition("18", "PERCENTAGE_LID_5", record([
  field("value", expression("participatiewet@2022-04-01/expression5/1"))
])).
execution_property("18", "output", [
  record([
    field("name", "verlaging_percentage_lid_5"),
    field("type", "number"),
    field("description", "Verlagingspercentage conform art. 18 lid 5 (altijd 100%)")
  ])
]).
execution_property("18", "actions", [
  record([
    field("output", "verlaging_percentage_lid_5"),
    field("value", expression("participatiewet@2022-04-01/expression6/1"))
  ])
]).

article("21", "**Normen 21–pensioengerechtigde leeftijd**\n\nVoor belanghebbenden van 21 jaar of ouder doch jonger dan de pensioengerechtigde leeftijd is de norm per\nkalendermaand, indien het betreft:\n\n   a. een alleenstaande of een alleenstaande ouder zonder kostendelende medebewoners: € 1.091,71;\n\n   b. gehuwden waarvan beide echtgenoten jonger zijn dan de pensioengerechtigde leeftijd, zonder kostendelende\n   medebewoners: € 1.559,58.").
article_property("21", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel21").
definition("21", "norm_alleenstaande", record([
  field("value", expression("participatiewet@2022-04-01/expression7/1"))
])).
definition("21", "norm_gehuwden", record([
  field("value", expression("participatiewet@2022-04-01/expression8/1"))
])).
execution_property("21", "produces", record([
  field("legal_character", "WAARDEBEPALING")
])).
execution_property("21", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ]),
  record([
    field("name", "leeftijd"),
    field("type", "number"),
    field("required", true),
    field("description", "Leeftijd in jaren (bron: BRP)")
  ]),
  record([
    field("name", "is_alleenstaande"),
    field("type", "boolean"),
    field("required", true),
    field("description", "Is alleenstaande (bron: BRP)")
  ]),
  record([
    field("name", "heeft_kostendelende_medebewoners"),
    field("type", "boolean"),
    field("required", false),
    field("description", "Heeft kostendelende medebewoners (bron: BRP)")
  ]),
  record([
    field("name", "heeft_pensioengerechtigde_leeftijd_bereikt"),
    field("type", "boolean"),
    field("required", false),
    field("description", "Heeft AOW-leeftijd bereikt (bron: AOW)")
  ])
]).
execution_property("21", "output", [
  record([
    field("name", "normbedrag_artikel_21"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "voldoet_aan_voorwaarden_artikel_21"),
    field("type", "boolean")
  ])
]).
execution_property("21", "actions", [
  record([
    field("output", "voldoet_aan_voorwaarden_artikel_21"),
    field("value", expression("participatiewet@2022-04-01/expression9/1"))
  ]),
  record([
    field("output", "normbedrag_artikel_21"),
    field("value", expression("participatiewet@2022-04-01/expression10/1"))
  ])
]).

article("22", "**Normen pensioengerechtigden**\n\nVoor belanghebbenden die de pensioengerechtigde leeftijd hebben bereikt is de norm per kalendermaand, indien het\nbetreft:\n\n   a. een alleenstaande of een alleenstaande ouder zonder kostendelende medebewoners: € 1.213,06;\n\n   b. gehuwden waarvan beide echtgenoten de pensioengerechtigde leeftijd hebben bereikt, zonder kostendelende\n   medebewoners: € 1.642,54;\n\n   c. gehuwden waarvan een echtgenoot de pensioengerechtigde leeftijd heeft bereikt en de andere echtgenoot 21\n   jaar of ouder, doch de pensioengerechtigde leeftijd nog niet heeft bereikt, zonder kostendelende medebewoners:\n   € 1.642,54.").
article_property("22", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel22").

article("22a", "**Kostendelersnorm**\n\n1. Indien de belanghebbende van 21 jaar of ouder een of meer kostendelende medebewoners heeft, is de norm per\nkalendermaand voor de belanghebbende: [formule niet in tekst beschikbaar] Hierbij staat:    • A voor het aantal\nkostendelende medebewoners plus de belanghebbende en zijn echtgenoot van 21 jaar of ouder indien hij gehuwd is;\nen    • B voor de norm, bedoeld in artikel:    a. 21, onderdeel b, indien de belanghebbende jonger dan de\npensioengerechtigde leeftijd is;    b. 22, onderdeel c, indien de belanghebbende jonger dan de\npensioengerechtigde leeftijd is en zijn echtgenoot de pensioengerechtigde leeftijd heeft bereikt;    c. 22,\nonderdeel b, indien de belanghebbende de pensioengerechtigde leeftijd heeft bereikt.\n\n2. De norm voor gehuwden, op wie het eerste lid van toepassing is, is gelijk aan de som van de normen, bedoeld in\ndat lid, die voor ieder van de rechthebbende echtgenoten afzonderlijk van toepassing is.\n\n3. Voor rechthebbende gehuwden, waarvan een echtgenoot 18, 19 of 20 jaar is en de andere echtgenoot 21 jaar of\nouder is, met een of meer kostendelende medebewoners, is de norm per kalendermaand:    a. indien ze een of meer\nten laste komende kinderen hebben: € 581,43 plus de op basis van dit artikel van toepassing zijnde norm voor de\nechtgenoot van 21 jaar of ouder,    b. indien ze geen ten laste komende kinderen hebben: € 269,51 plus de op basis\nvan dit artikel van toepassing zijnde norm voor de echtgenoot van 21 jaar of ouder.").
article_property("22a", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel22a").
article_rule("22a", "untranslatables", [
  record([
    field("construct", "de norm per kalendermaand als functie van A en B (lid 1)"),
    field("reason", "De formule staat in de BWB-bron als afbeelding en niet als tekst, dus de verhouding tussen A en B volgt niet uit de wettekst."),
    field("suggestion", "De formule uit Stb. overnemen zodra een machine-leesbare vorm van artikel 22a lid 1 beschikbaar is."),
    field("legal_text_excerpt", "is de norm per kalendermaand voor de belanghebbende"),
    field("accepted", true)
  ]),
  record([
    field("construct", "de norm voor gehuwden (lid 2)"),
    field("reason", "Lid 2 is de som van de normen uit lid 1 voor elk van de rechthebbende echtgenoten, en die norm volgt hierboven al niet uit de tekst."),
    field("suggestion", "Volgt zodra de formule uit lid 1 beschikbaar is."),
    field("legal_text_excerpt", "is gelijk aan de som van de normen, bedoeld in dat lid, die voor ieder van de rechthebbende echtgenoten afzonderlijk van toepassing is"),
    field("accepted", true)
  ]),
  record([
    field("construct", "de norm bij een echtgenoot van 18, 19 of 20 jaar (lid 3)"),
    field("reason", "Lid 3 geeft voor dit huishouden een eigen norm van € 581,43 of € 269,51 plus de norm voor de echtgenoot van 21 jaar of ouder, en die laatste volgt uit lid 1, dat hierboven onvertaalbaar is."),
    field("suggestion", "Volgt zodra de formule uit lid 1 beschikbaar is."),
    field("legal_text_excerpt", "Voor rechthebbende gehuwden, waarvan een echtgenoot 18, 19 of 20 jaar is en de andere echtgenoot 21 jaar of ouder is, met een of meer kostendelende medebewoners, is de norm per kalendermaand"),
    field("accepted", true)
  ])
]).
execution_property("22a", "produces", record([
  field("legal_character", "INFORMATIEF")
])).
execution_property("22a", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ]),
  record([
    field("name", "leeftijd"),
    field("type", "number"),
    field("required", true),
    field("description", "Leeftijd van de belanghebbende in jaren (bron: BRP)")
  ]),
  record([
    field("name", "is_gehuwd"),
    field("type", "boolean"),
    field("required", true),
    field("description", "Is gehuwd (bron: BRP)")
  ]),
  record([
    field("name", "leeftijd_echtgenoot"),
    field("type", "number"),
    field("required", true),
    field("description", "Leeftijd van de echtgenoot in jaren (bron: BRP). Alleen van belang indien gehuwd, maar wel altijd vereist: `rekengetal_a` leest dit veld zodra `is_gehuwd` waar is, en het schema kent geen operatie om binnen een expressie op afwezigheid te toetsen. Vul voor een ongehuwde belanghebbende een willekeurige waarde in; die wordt niet gelezen.")
  ]),
  record([
    field("name", "medebewoners"),
    field("type", "array"),
    field("required", true),
    field("description", "Kostendelende medebewoners, elk met een leeftijd. De leeftijden komen uit de BRP; deze wet bepaalt wat ermee gebeurt.")
  ])
]).
execution_property("22a", "output", [
  record([
    field("name", "aantal_kostendelende_medebewoners"),
    field("type", "number")
  ]),
  record([
    field("name", "is_kostendelersnorm_van_toepassing"),
    field("type", "boolean")
  ]),
  record([
    field("name", "rekengetal_a"),
    field("type", "number")
  ])
]).
execution_property("22a", "actions", [
  record([
    field("output", "aantal_kostendelende_medebewoners"),
    field("value", expression("participatiewet@2022-04-01/expression11/1"))
  ]),
  record([
    field("output", "is_kostendelersnorm_van_toepassing"),
    field("value", expression("participatiewet@2022-04-01/expression12/1"))
  ]),
  record([
    field("output", "rekengetal_a"),
    field("value", expression("participatiewet@2022-04-01/expression13/1"))
  ])
]).

article("23", "**Normen in inrichting**\n\n1. Bij een verblijf in een inrichting is de norm per kalendermaand, indien het betreft:    a. een alleenstaande of een alleenstaande ouder: € 345,68;    b. gehuwden: € 537,69.\n\n2. Het bedrag van de norm, bedoeld in het eerste lid, wordt verhoogd met:    a. voor een alleenstaande of een alleenstaande ouder € 34,00;    b. voor gehuwden € 79,00.\n\n3. Indien een van de gehuwden in een inrichting verblijft, is de norm de som van de normen die voor ieder van hen als alleenstaande of alleenstaande ouder zouden gelden.").
article_property("23", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel23").

article("24", "**Afwijking norm gehuwden**\n\nVoor gehuwden waarvan een echtgenoot geen recht op algemene bijstand heeft is voor de rechthebbende echtgenoot de\nnorm gelijk aan 50% van de norm die voor hem zou gelden als hij gehuwd zou zijn met een rechthebbende echtgenoot\nvan zijn leeftijd, indien:\n\n   a. de rechthebbende echtgenoot 21 jaar of ouder is en geen kostendelende medebewoners heeft; dan wel\n\n   b. de rechthebbende echtgenoot jonger dan 21 jaar is.").
article_property("24", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel24").

article("43", "**Vaststelling op aanvraag**\n\n1. Het college stelt het recht op bijstand op schriftelijke aanvraag of, indien een schriftelijke aanvraag niet mogelijk is, ambtshalve vast.\n\n2. De bijstand wordt door de echtgenoten gezamenlijk aangevraagd dan wel door een van hen met schriftelijke toestemming van de ander.\n\n3. Het college stelt het recht op bijstand ambtshalve vast indien een van de echtgenoten niet met de aanvraag instemt, doch bijstandsverlening, gezien de belangen van de overige gezinsleden, niettemin geboden is.\n\n4. Het college houdt, indien artikel 41, vierde lid, van toepassing is, bij de vaststelling van het recht op algemene bijstand rekening met de houding en gedragingen van de meerderjarige personen die ten tijde van de aanvraag van algemene bijstand jonger dan 27 jaar zijn gedurende de vier weken na de melding, bedoeld in artikel 44.\n\n5. Indien artikel 41, vierde lid, niet van toepassing is, beoordeelt het college in ieder geval de houding en gedragingen gedurende de vier weken na de melding, bedoeld in artikel 44, van de meerderjarige personen die ten tijde van de aanvraag van algemene bijstand jonger dan 27 jaar zijn.").
article_property("43", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel43").
execution_property("43", "produces", record([
  field("legal_character", "BESCHIKKING"),
  field("decision_type", "TOEKENNING")
])).
execution_property("43", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true),
    field("description", "Burgerservicenummer van de aanvrager")
  ])
]).
execution_property("43", "input", [
  record([
    field("name", "heeft_recht_op_bijstand"),
    field("type", "boolean"),
    field("description", "Voldoet aan voorwaarden voor bijstand (art. 21, interim voor art. 11)"),
    field("source", record([
      field("output", "voldoet_aan_voorwaarden_artikel_21")
    ]))
  ]),
  record([
    field("name", "normbedrag_artikel_21"),
    field("type", "amount"),
    field("description", "Normbedrag per kalendermaand (art. 21)"),
    field("source", record([
      field("output", "normbedrag_artikel_21")
    ])),
    field("type_spec", record([
      field("unit", "eurocent")
    ]))
  ]),
  record([
    field("name", "verlaging_percentage"),
    field("type", "number"),
    field("description", "Verlagingspercentage uit gemeentelijke afstemmingsverordening (art. 8)"),
    field("source", record([
      field("output", "verlaging_percentage")
    ]))
  ])
]).
execution_property("43", "output", [
  record([
    field("name", "heeft_recht_op_bijstand"),
    field("type", "boolean"),
    field("description", "Heeft de aanvrager recht op bijstand?")
  ]),
  record([
    field("name", "uitkering_bedrag"),
    field("type", "amount"),
    field("type_spec", record([
      field("unit", "eurocent")
    ])),
    field("description", "Finale uitkering na eventuele verlaging")
  ])
]).
execution_property("43", "actions", [
  record([
    field("output", "heeft_recht_op_bijstand"),
    field("value", expression("participatiewet@2022-04-01/expression14/1"))
  ]),
  record([
    field("output", "verlaging_bedrag"),
    field("value", expression("participatiewet@2022-04-01/expression15/1"))
  ]),
  record([
    field("output", "uitkering_bedrag"),
    field("value", expression("participatiewet@2022-04-01/expression16/1"))
  ])
]).

article("69", "**Uitkering en verdeling onder de gemeenten**\n\n1. Onze Minister verstrekt jaarlijks ten laste van 's Rijks kas aan het college een uitkering om het college van\nmiddelen te voorzien met het oog op:\n   a. het toekennen van algemene bijstand en van uitkeringen als bedoeld in de Wet inkomensvoorziening oudere en\n   gedeeltelijk arbeidsongeschikte werkloze werknemers en de Wet inkomensvoorziening oudere en gedeeltelijk\n   arbeidsongeschikte gewezen zelfstandigen en voor de daarbij verschuldigde loonbelasting, premies\n   volksverzekeringen en de inkomensafhankelijke bijdrage, bedoeld in artikel 42 van de Zorgverzekeringswet;\n   b. de kosten van de loonkostensubsidies, die op grond van artikel 10d, worden verstrekt.\n\n2. Bij wet wordt het totale bedrag dat beschikbaar is voor de uitkering, bedoeld in het eerste lid, vastgesteld,\nwaarbij uitgangspunt is dat dit bedrag voor het desbetreffende kalenderjaar toereikend is voor de geraamde kosten\nvan alle gemeenten in verband met uitgaven als bedoeld in het eerste lid.\n\n3. Bij of krachtens algemene maatregel van bestuur worden regels gesteld voor de verdeling van de uitkering,\nbedoeld in het eerste lid, onder de gemeenten en het verzamelen van gegevens noodzakelijk voor het vaststellen van\ndeze verdeling.\n\n4. De uitkering aan het college wordt ten minste drie maanden voorafgaand aan het kalenderjaar waarop zij\nbetrekking heeft door Onze Minister bekend gemaakt.").
article_property("69", "url", "https://wetten.overheid.nl/BWBR0015703/2022-04-01#Artikel69").

ee_reference("participatiewet@2022-04-01/expression1/1", "verlaging_percentage").
ee_reference("participatiewet@2022-04-01/expression2/1", "duur_maanden").
ee_literal("participatiewet@2022-04-01/expression3/1", decimal(0, 0)).
ee_literal("participatiewet@2022-04-01/expression4/1", decimal(0, 0)).
ee_literal("participatiewet@2022-04-01/expression5/1", decimal(100, 0)).
ee_reference("participatiewet@2022-04-01/expression6/1", "PERCENTAGE_LID_5").
ee_literal("participatiewet@2022-04-01/expression7/1", decimal(109171, 0)).
ee_literal("participatiewet@2022-04-01/expression8/1", decimal(155958, 0)).
ee_reference("participatiewet@2022-04-01/expression9/3", "leeftijd").
ee_literal("participatiewet@2022-04-01/expression9/4", decimal(21, 0)).
ee_arguments("participatiewet@2022-04-01/expression9/2", ["participatiewet@2022-04-01/expression9/3", "participatiewet@2022-04-01/expression9/4"]).
ee_primitive("participatiewet@2022-04-01/expression9/2", "GREATER_THAN_OR_EQUAL", record([field("operation", "GREATER_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_reference("participatiewet@2022-04-01/expression9/6", "heeft_pensioengerechtigde_leeftijd_bereikt").
ee_literal("participatiewet@2022-04-01/expression9/7", false).
ee_arguments("participatiewet@2022-04-01/expression9/5", ["participatiewet@2022-04-01/expression9/6", "participatiewet@2022-04-01/expression9/7"]).
ee_primitive("participatiewet@2022-04-01/expression9/5", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("participatiewet@2022-04-01/expression9/1", "AND", ["participatiewet@2022-04-01/expression9/2", "participatiewet@2022-04-01/expression9/5"]).
ee_reference("participatiewet@2022-04-01/expression10/3", "is_alleenstaande").
ee_literal("participatiewet@2022-04-01/expression10/4", true).
ee_arguments("participatiewet@2022-04-01/expression10/2", ["participatiewet@2022-04-01/expression10/3", "participatiewet@2022-04-01/expression10/4"]).
ee_primitive("participatiewet@2022-04-01/expression10/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("participatiewet@2022-04-01/expression10/5", "norm_alleenstaande").
ee_reference("participatiewet@2022-04-01/expression10/6", "norm_gehuwden").
ee_conditional("participatiewet@2022-04-01/expression10/1", [case("participatiewet@2022-04-01/expression10/2", "participatiewet@2022-04-01/expression10/5")], "participatiewet@2022-04-01/expression10/6").
ee_reference("participatiewet@2022-04-01/expression11/2", "medebewoners").
ee_literal("participatiewet@2022-04-01/expression11/3", true).
ee_literal("participatiewet@2022-04-01/expression11/4", decimal(1, 0)).
ee_foreach("participatiewet@2022-04-01/expression11/1", "participatiewet@2022-04-01/expression11/2", "participatiewet@2022-04-01/expression11/3", "participatiewet@2022-04-01/expression11/4", "medebewoner", "ADD").
ee_reference("participatiewet@2022-04-01/expression12/3", "leeftijd").
ee_literal("participatiewet@2022-04-01/expression12/4", decimal(21, 0)).
ee_arguments("participatiewet@2022-04-01/expression12/2", ["participatiewet@2022-04-01/expression12/3", "participatiewet@2022-04-01/expression12/4"]).
ee_primitive("participatiewet@2022-04-01/expression12/2", "GREATER_THAN_OR_EQUAL", record([field("operation", "GREATER_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_reference("participatiewet@2022-04-01/expression12/6", "aantal_kostendelende_medebewoners").
ee_literal("participatiewet@2022-04-01/expression12/7", decimal(0, 0)).
ee_arguments("participatiewet@2022-04-01/expression12/5", ["participatiewet@2022-04-01/expression12/6", "participatiewet@2022-04-01/expression12/7"]).
ee_primitive("participatiewet@2022-04-01/expression12/5", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_logical("participatiewet@2022-04-01/expression12/1", "AND", ["participatiewet@2022-04-01/expression12/2", "participatiewet@2022-04-01/expression12/5"]).
ee_reference("participatiewet@2022-04-01/expression13/2", "aantal_kostendelende_medebewoners").
ee_literal("participatiewet@2022-04-01/expression13/3", decimal(1, 0)).
ee_reference("participatiewet@2022-04-01/expression13/7", "is_gehuwd").
ee_literal("participatiewet@2022-04-01/expression13/8", true).
ee_arguments("participatiewet@2022-04-01/expression13/6", ["participatiewet@2022-04-01/expression13/7", "participatiewet@2022-04-01/expression13/8"]).
ee_primitive("participatiewet@2022-04-01/expression13/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("participatiewet@2022-04-01/expression13/10", "leeftijd_echtgenoot").
ee_literal("participatiewet@2022-04-01/expression13/11", decimal(21, 0)).
ee_arguments("participatiewet@2022-04-01/expression13/9", ["participatiewet@2022-04-01/expression13/10", "participatiewet@2022-04-01/expression13/11"]).
ee_primitive("participatiewet@2022-04-01/expression13/9", "GREATER_THAN_OR_EQUAL", record([field("operation", "GREATER_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_logical("participatiewet@2022-04-01/expression13/5", "AND", ["participatiewet@2022-04-01/expression13/6", "participatiewet@2022-04-01/expression13/9"]).
ee_literal("participatiewet@2022-04-01/expression13/12", decimal(1, 0)).
ee_literal("participatiewet@2022-04-01/expression13/13", decimal(0, 0)).
ee_conditional("participatiewet@2022-04-01/expression13/4", [case("participatiewet@2022-04-01/expression13/5", "participatiewet@2022-04-01/expression13/12")], "participatiewet@2022-04-01/expression13/13").
ee_arguments("participatiewet@2022-04-01/expression13/1", ["participatiewet@2022-04-01/expression13/2", "participatiewet@2022-04-01/expression13/3", "participatiewet@2022-04-01/expression13/4"]).
ee_primitive("participatiewet@2022-04-01/expression13/1", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(3, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("participatiewet@2022-04-01/expression14/1", "heeft_recht_op_bijstand").
ee_reference("participatiewet@2022-04-01/expression15/3", "normbedrag_artikel_21").
ee_reference("participatiewet@2022-04-01/expression15/4", "verlaging_percentage").
ee_arguments("participatiewet@2022-04-01/expression15/2", ["participatiewet@2022-04-01/expression15/3", "participatiewet@2022-04-01/expression15/4"]).
ee_primitive("participatiewet@2022-04-01/expression15/2", "MULTIPLY", record([field("operation", "MULTIPLY"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "MULTIPLY")])), field("missingValue", true)])).
ee_literal("participatiewet@2022-04-01/expression15/5", decimal(100, 0)).
ee_arguments("participatiewet@2022-04-01/expression15/1", ["participatiewet@2022-04-01/expression15/2", "participatiewet@2022-04-01/expression15/5"]).
ee_primitive("participatiewet@2022-04-01/expression15/1", "DIVIDE", record([field("operation", "DIVIDE"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "DIVIDE")])), field("missingValue", true)])).
ee_reference("participatiewet@2022-04-01/expression16/3", "heeft_recht_op_bijstand").
ee_literal("participatiewet@2022-04-01/expression16/4", false).
ee_arguments("participatiewet@2022-04-01/expression16/2", ["participatiewet@2022-04-01/expression16/3", "participatiewet@2022-04-01/expression16/4"]).
ee_primitive("participatiewet@2022-04-01/expression16/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("participatiewet@2022-04-01/expression16/5", decimal(0, 0)).
ee_reference("participatiewet@2022-04-01/expression16/7", "normbedrag_artikel_21").
ee_reference("participatiewet@2022-04-01/expression16/8", "verlaging_bedrag").
ee_arguments("participatiewet@2022-04-01/expression16/6", ["participatiewet@2022-04-01/expression16/7", "participatiewet@2022-04-01/expression16/8"]).
ee_primitive("participatiewet@2022-04-01/expression16/6", "SUBTRACT", record([field("operation", "SUBTRACT"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "SUBTRACT")])), field("missingValue", true)])).
ee_conditional("participatiewet@2022-04-01/expression16/1", [case("participatiewet@2022-04-01/expression16/2", "participatiewet@2022-04-01/expression16/5")], "participatiewet@2022-04-01/expression16/6").
