% afstemmingsverordening_participatiewet_diemen, in force from 2015-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("afstemmingsverordening_participatiewet_diemen").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.0/schema/v0.5.0/schema.json").
law_property("regulatory_layer", "GEMEENTELIJKE_VERORDENING").
law_property("publication_date", "2014-12-18").
law_property("valid_from", "2015-01-01").
law_property("gemeente_code", "GM0384").
law_property("officiele_titel", "Afstemmingsverordening Participatiewet, IOAW en IOAZ Diemen 2015").
law_property("url", "https://lokaleregelgeving.overheid.nl/CVDR345917/1").
law_property("name", "Afstemmingsverordening Participatiewet Diemen 2015").
law_property("legal_basis", [
  record([
    field("law_id", "participatiewet"),
    field("article", "8"),
    field("description", "Artikel 8, eerste lid, onderdeel a - gemeentelijke verordening over verlaging bijstand")
  ])
]).
article("7", "**Gedragingen Participatiewet**\n\nGedragingen van een belanghebbende waardoor de verplichting op grond van artikel 9, eerste lid, van de\nParticipatiewet niet of onvoldoende is nagekomen worden onderscheiden in de volgende categorieën:\n\n   a. eerste categorie: het zich niet tijdig laten registreren als werkzoekende bij het Uitvoeringsinstituut\n   werknemersverzekeringen;\n\n   b. tweede categorie:\n      1. het niet of onvoldoende meewerken aan het opstellen, uitvoeren en evalueren van een plan van aanpak als\n      bedoeld in artikel 44a van de Participatiewet;\n      2. het niet binnen vier weken na melding als bedoeld in artikel 43, vierde en vijfde lid, van de\n      Participatiewet voldoende meewerken aan het onderzoek naar de mogelijkheden tot arbeidsinschakeling of\n      sociale activering als dit een persoon jonger dan 27 jaar betreft;\n      3. het als alleenstaande ouder niet naar vermogen trachten arbeid in deeltijd te verkrijgen;\n      4. het niet of onvoldoende verrichten van de door het college opgedragen tegenprestatie als bedoeld in\n      artikel 9, eerste lid, onderdeel c, van de Participatiewet;\n\n   c. derde categorie: het niet naar vermogen proberen algemeen geaccepteerde arbeid te verkrijgen.").
article_property("7", "url", "https://lokaleregelgeving.overheid.nl/CVDR345917/1#Artikel7").
execution_property("7", "produces", record([
  field("legal_character", "INFORMATIEF")
])).
execution_property("7", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true),
    field("description", "BSN van de belanghebbende")
  ]),
  record([
    field("name", "heeft_niet_tijdig_geregistreerd_uwv"),
    field("type", "boolean"),
    field("required", false),
    field("description", "Onderdeel a. Belanghebbende heeft zich niet tijdig laten registreren als werkzoekende bij het UWV")
  ]),
  record([
    field("name", "heeft_niet_meegewerkt_plan_van_aanpak"),
    field("type", "boolean"),
    field("required", false),
    field("description", "Onderdeel b, sub 1. Belanghebbende heeft niet of onvoldoende meegewerkt aan het plan van aanpak (art. 44a Pw)")
  ]),
  record([
    field("name", "heeft_niet_meegewerkt_onderzoek_jongeren"),
    field("type", "boolean"),
    field("required", false),
    field("description", "Onderdeel b, sub 2. Belanghebbende (jonger dan 27) heeft niet binnen vier weken na melding voldoende meegewerkt aan het onderzoek naar arbeidsinschakeling of sociale activering (art. 43 vierde en vijfde lid Pw)")
  ]),
  record([
    field("name", "heeft_als_alleenstaande_ouder_geen_deeltijdarbeid_getracht"),
    field("type", "boolean"),
    field("required", false),
    field("description", "Onderdeel b, sub 3. Belanghebbende heeft als alleenstaande ouder niet naar vermogen getracht arbeid in deeltijd te verkrijgen")
  ]),
  record([
    field("name", "heeft_tegenprestatie_niet_verricht"),
    field("type", "boolean"),
    field("required", false),
    field("description", "Onderdeel b, sub 4. Belanghebbende heeft de opgedragen tegenprestatie (art. 9 eerste lid onderdeel c Pw) niet of onvoldoende verricht")
  ]),
  record([
    field("name", "heeft_niet_naar_vermogen_arbeid_getracht_te_verkrijgen"),
    field("type", "boolean"),
    field("required", false),
    field("description", "Onderdeel c. Belanghebbende heeft niet naar vermogen algemeen geaccepteerde arbeid getracht te verkrijgen")
  ])
]).
execution_property("7", "output", [
  record([
    field("name", "gedragscategorie"),
    field("type", "number"),
    field("nullable", true),
    field("description", "Categorie van de gedraging conform art. 7 (1, 2 of 3), of afwezig als geen van de gedragingen zich voordoet")
  ])
]).
execution_property("7", "actions", [
  record([
    field("output", "gedragscategorie"),
    field("value", expression("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/1"))
  ])
]).

article("9", "**Hoogte en duur van de verlaging**\n\n1. De verlaging bij gedragingen als bedoeld in de artikelen 7 en 8 bedraagt:\n   a. eerste categorie: 5 procent van de bijstandsnorm gedurende 1 maand;\n   b. tweede categorie: 30 procent van de bijstandsnorm gedurende 1 maand;\n   c. derde categorie: 100 procent van de bijstandsnorm gedurende 1 maand.\n\n2. Het college kan de verlaging afwijkend vaststellen, met een minimum van 5% en een maximum van 100% van de\nbijstandsnorm, als de ernst van de gedraging, de mate van verwijtbaarheid of de individuele omstandigheden van de\nbelanghebbende daartoe aanleiding geven.").
article_property("9", "url", "https://lokaleregelgeving.overheid.nl/CVDR345917/1#Artikel9").
article_rule("9", "implements", [
  record([
    field("law", "participatiewet"),
    field("article", "8"),
    field("open_term", "verlaging_percentage"),
    field("gelet_op", "Gelet op artikel 8, eerste lid, onderdeel a van de Participatiewet")
  ]),
  record([
    field("law", "participatiewet"),
    field("article", "8"),
    field("open_term", "duur_maanden"),
    field("gelet_op", "Gelet op artikel 8, eerste lid, onderdeel a van de Participatiewet")
  ])
]).
definition("9", "PERCENTAGE_CATEGORIE_1", record([
  field("value", expression("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression2/1"))
])).
definition("9", "PERCENTAGE_CATEGORIE_2", record([
  field("value", expression("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression3/1"))
])).
definition("9", "DUUR_MAANDEN", record([
  field("value", expression("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression4/1"))
])).
execution_property("9", "produces", record([
  field("legal_character", "WAARDEBEPALING")
])).
execution_property("9", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true),
    field("description", "BSN van de belanghebbende")
  ]),
  record([
    field("name", "gedragscategorie"),
    field("type", "number"),
    field("required", false),
    field("nullable", true),
    field("description", "Gedragscategorie (1, 2 of 3), of afwezig als geen verwijtbare gedraging is vastgesteld; indien niet meegegeven wordt dit afgeleid via art. 7")
  ])
]).
execution_property("9", "input", [
  record([
    field("name", "gedragscategorie"),
    field("type", "number"),
    field("nullable", true),
    field("description", "Gedragscategorie conform art. 7 (1, 2 of 3), of afwezig als geen verwijtbare gedraging is vastgesteld"),
    field("source", record([
      field("output", "gedragscategorie")
    ]))
  ]),
  record([
    field("name", "percentage_categorie_3"),
    field("type", "number"),
    field("description", "Verlagingspercentage voor categorie 3 uit Participatiewet art. 18 lid 5"),
    field("source", record([
      field("regulation", "participatiewet"),
      field("output", "verlaging_percentage_lid_5")
    ]))
  ])
]).
execution_property("9", "output", [
  record([
    field("name", "verlaging_percentage"),
    field("type", "number"),
    field("nullable", true),
    field("description", "Verlagingspercentage conform art. 9 lid 1")
  ]),
  record([
    field("name", "duur_maanden"),
    field("type", "number"),
    field("nullable", true),
    field("description", "Aantal maanden dat de verlaging duurt")
  ])
]).
execution_property("9", "actions", [
  record([
    field("output", "verlaging_percentage"),
    field("value", expression("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/1"))
  ]),
  record([
    field("output", "duur_maanden"),
    field("value", expression("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/1"))
  ])
]).

ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/3", "heeft_niet_naar_vermogen_arbeid_getracht_te_verkrijgen").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/4", true).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/2", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/3", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/4"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/5", decimal(3, 0)).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/8", "heeft_niet_meegewerkt_plan_van_aanpak").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/9", true).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/7", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/8", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/9"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/7", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/11", "heeft_niet_meegewerkt_onderzoek_jongeren").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/12", true).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/10", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/11", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/12"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/10", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/14", "heeft_als_alleenstaande_ouder_geen_deeltijdarbeid_getracht").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/15", true).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/13", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/14", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/15"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/13", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/17", "heeft_tegenprestatie_niet_verricht").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/18", true).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/16", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/17", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/18"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/16", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/6", "OR", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/7", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/10", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/13", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/16"]).
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/19", decimal(2, 0)).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/21", "heeft_niet_tijdig_geregistreerd_uwv").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/22", true).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/20", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/21", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/22"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/20", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/23", decimal(1, 0)).
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/24", null).
ee_conditional("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/1", [case("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/2", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/5"), case("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/6", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/19"), case("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/20", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/23")], "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression1/24").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression2/1", decimal(5, 0)).
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression3/1", decimal(30, 0)).
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression4/1", decimal(1, 0)).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/3", "gedragscategorie").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/4", decimal(1, 0)).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/2", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/3", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/4"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/5", "PERCENTAGE_CATEGORIE_1").
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/7", "gedragscategorie").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/8", decimal(2, 0)).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/6", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/7", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/8"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/9", "PERCENTAGE_CATEGORIE_2").
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/11", "gedragscategorie").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/12", decimal(3, 0)).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/10", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/11", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/12"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/10", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/13", "percentage_categorie_3").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/14", null).
ee_conditional("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/1", [case("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/2", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/5"), case("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/6", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/9"), case("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/10", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/13")], "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression5/14").
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/3", "gedragscategorie").
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/4", null).
ee_arguments("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/2", ["afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/3", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/4"]).
ee_primitive("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/5", null).
ee_reference("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/6", "DUUR_MAANDEN").
ee_conditional("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/1", [case("afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/2", "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/5")], "afstemmingsverordening_participatiewet_diemen@2015-01-01/expression6/6").
