% wet_open_overheid, in force from 2025-02-12.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("wet_open_overheid").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.0/schema/v0.5.0/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2022-03-29").
law_property("valid_from", "2025-02-12").
law_property("bwb_id", "BWBR0045754").
law_property("url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12").
law_property("name", "#wet_naam").
law_property("competent_authority", "#bevoegd_gezag").
article("1.1", "Eenieder heeft recht op toegang tot publieke informatie zonder daartoe een belang te hoeven stellen, behoudens bij deze wet gestelde beperkingen.").
article_property("1.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel1.1").

article("2.1", "In deze wet en de daarop berustende bepalingen wordt verstaan onder:\n\na. document: een door een orgaan, persoon of college als bedoeld in artikel 2.2, eerste lid, opgemaakt of ontvangen schriftelijk stuk of ander geheel van vastgelegde gegevens dat naar zijn aard verband houdt met de publieke taak van dat orgaan, die persoon of dat college;\n\nb. milieu-informatie: hetgeen daaronder wordt verstaan in artikel 19.1a van de Wet milieubeheer;\n\nc. Onze Minister: Onze Minister van Binnenlandse Zaken en Koninkrijksrelaties;\n\nd. publieke informatie: informatie neergelegd in documenten die berusten bij een orgaan, persoon of college als bedoeld in artikel 2.2, eerste lid, of informatie die krachtens artikel 2.3 door een bestuursorgaan kan worden gevorderd.").
article_property("2.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel2.1").
definition("2.1", "verantwoordelijke_autoriteit", expression("wet_open_overheid@2025-02-12/expression1/1")).
execution_property("2.1", "actions", [
  record([
    field("output", "wet_naam"),
    field("value", expression("wet_open_overheid@2025-02-12/expression2/1"))
  ]),
  record([
    field("output", "bevoegd_gezag"),
    field("value", expression("wet_open_overheid@2025-02-12/expression3/1"))
  ])
]).

article("2.2", "1. Deze wet is van toepassing op:\na. bestuursorganen;\nb. de Kamers en de verenigde vergadering der Staten-Generaal;\nc. de Raad voor de rechtspraak en het College van afgevaardigden;\nd. de Raad van State, tenzij de Raad het koninklijk gezag uitoefent, en met uitzondering van de Afdeling\nbestuursrechtspraak;\ne. de Algemene Rekenkamer;\nf. de Nationale ombudsman en de substituut-ombudsmannen als bedoeld in artikel 9, eerste lid, van de Wet Nationale\nombudsman, en ombudsmannen en ombudscommissies als bedoeld in artikel 9:17, onderdeel b, van de Algemene wet\nbestuursrecht.\n\n2. Voor de toepassing van deze wet worden de organen, personen en colleges, bedoeld in het eerste lid, onderdelen b\ntot en met f, die op grond van de Algemene wet bestuursrecht geen bestuursorgaan zijn, gelijk gesteld met een\nbestuursorgaan.").
article_property("2.2", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel2.2").

article("2.4", "1. Een bestuursorgaan draagt er zorg voor dat de documenten die het ontvangt, vervaardigt of anderszins onder zich\nheeft, zich in goede, geordende en toegankelijke staat bevinden.\n\n2. Een bestuursorgaan draagt er zoveel mogelijk zorg voor dat de informatie die het overeenkomstig deze wet verstrekt,\nactueel, nauwkeurig en vergelijkbaar is.\n\n3. Indien een bestuursorgaan overeenkomstig deze wet informatie openbaar maakt, geschiedt dat op zodanige wijze dat de\nbelanghebbende en belangstellende burger zoveel mogelijk wordt bereikt en op de volgende algemeen toegankelijke wijze:\na. in elektronische vorm, in een machinaal leesbaar open formaat, samen met de metadata, overeenkomstig artikel 5,\neerste lid, van de Richtlijn 2003/98/EG van het Europees Parlement en de Raad van 17 november 2003 inzake het\nhergebruik van overheidsinformatie (PbEG 2003 L 345), zoals deze is gewijzigd bij Richtlijn 2013/37/EU van het\nEuropees Parlement en de Raad van 26 juni 2013 tot wijziging van Richtlijn 2003/98/EG inzake het hergebruik van\noverheidsinformatie (PbEU 2013 L 175);\nb. of, indien verstrekking in een machinaal leesbaar open formaat redelijkerwijs niet gevergd kan worden, in andere\nelektronisch doorzoekbare vorm;\nc. of, indien elektronische verschaffing redelijkerwijs niet gevergd kan worden, door verstrekking van een kopie van\nde letterlijke inhoud ervan in andere vorm te verstrekken;\nd. of, indien verstrekking van een kopie of de letterlijke inhoud redelijkerwijs niet gevergd kan worden, door een\nuittreksel of een samenvatting van de inhoud te geven, inlichtingen daaruit te verschaffen of door terinzagelegging.\n\n4. Een bestuursorgaan is niet verantwoordelijk voor de juistheid of de volledigheid van door derden opgestelde\ninformatie.\n\n5. Indien het bestuursorgaan kennis draagt van de onjuistheid of onvolledigheid van de verstrekte informatie, doet het\nhiervan mededeling.\n\n6. Indien het bestuursorgaan informatie verstrekt, verstrekt het zo nodig, en voor zover deze informatie voorhanden\nis, tevens informatie over de methoden die zijn gebruikt bij het samenstellen van de informatie.").
article_property("2.4", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel2.4").

article("2.5", "Bij de toepassing van deze wet wordt uitgegaan van het algemeen belang van openbaarheid van publieke informatie voor de democratische samenleving.").
article_property("2.5", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel2.5").

article("3.1", "1. Het bestuursorgaan dat het rechtstreeks aangaat, maakt bij de uitvoering van zijn taak uit eigen beweging de bij het bestuursorgaan berustende informatie neergelegd in documenten voor eenieder openbaar, indien dit zonder onevenredige inspanning of kosten redelijkerwijs mogelijk is, behoudens voor zover de artikelen 5.1, eerste, tweede en vijfde lid, en 5.2 aan openbaarmaking in de weg staan of met de openbaarmaking geen redelijk belang wordt gediend. Deze informatie betreft in ieder geval informatie over het beleid, inclusief de voorbereiding, uitvoering, naleving, handhaving en evaluatie.\n\n2. Het bestuursorgaan doet bij een gedeeltelijke niet-openbaarmaking hiervan mededeling gelijktijdig met de openbaarmaking.\n\n3. Documenten als bedoeld in het eerste lid worden niet openbaar gemaakt dan nadat belanghebbenden die naar verwachting bedenkingen zullen hebben tegen openbaarmaking, in de gelegenheid zijn gesteld binnen een door het bestuursorgaan gestelde termijn hun zienswijze naar voren te brengen.\n\n4. Het bestuursorgaan deelt een belanghebbende mede dat toepassing wordt gegeven aan het eerste lid, onder vermelding van het tijdstip van openbaarmaking en de openbaar te maken documenten. De mededeling wordt gelijkgesteld met een besluit.").
article_property("3.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel3.1").

article("3.3", "1. Een bestuursorgaan maakt in ieder geval uit eigen beweging openbaar:\na. wetten en andere algemeen verbindende voorschriften;\nb. overige besluiten van algemene strekking;\nc. [dit onderdeel is nog niet in werking getreden];\nd. inzicht in zijn organisatie en werkwijze, waaronder de taken en bevoegdheden van de organisatieonderdelen;\ne. de bereikbaarheid van het bestuursorgaan en zijn organisatieonderdelen en de wijze waarop een verzoek om informatie\nkan worden ingediend.\n\n2. Behoudens voor zover de artikelen 5.1, eerste, tweede en vijfde lid, en 5.2 daaraan in de weg staan, maakt het\nbestuursorgaan voorts uit eigen beweging openbaar:\na. [dit onderdeel is nog niet in werking getreden];\nb. vergaderstukken en verslagen van de Kamers en de verenigde vergadering der Staten-Generaal en hun commissies,\ntenzij deze betrekking hebben op door de regering vertrouwelijk aan de Staten-Generaal verstrekte informatie;\nc. [dit onderdeel is nog niet in werking getreden];\nd. [dit onderdeel is nog niet in werking getreden];\ne. [dit onderdeel is nog niet in werking getreden];\nf. [dit onderdeel is nog niet in werking getreden];\ng. [dit onderdeel is nog niet in werking getreden];\nh. [dit onderdeel is nog niet in werking getreden];\ni. [dit onderdeel is nog niet in werking getreden];\nj. [dit onderdeel is nog niet in werking getreden];\nk. [dit onderdeel is nog niet in werking getreden];\nl. [dit onderdeel is nog niet in werking getreden].\n\n3. Op voordracht van Onze Minister kan bij algemene maatregel van bestuur worden bepaald dat:\na. het bestuursorgaan andere categorieen van informatie uit eigen beweging openbaar maakt overeenkomstig het eerste of\ntweede lid; en\nb. categorieen van beschikkingen worden aangewezen die in afwijking van het tweede lid, onderdeel k, uit eigen\nbeweging openbaar gemaakt worden.\n\n4. De openbaarmaking, bedoeld in het eerste en tweede lid, geschiedt zo spoedig mogelijk, doch uiterlijk binnen twee\nweken na vaststelling of ontvangst van de informatie.\n\n5. In afwijking van het vierde lid:\na. worden de ontwerpen en de bijbehorende adviesaanvragen, bedoeld in het eerste lid, onderdeel c, alsmede de daarop\nbetrekking hebbende adviezen, bedoeld in het tweede lid, onderdeel e, onder 1, door het bestuursorgaan dat het advies\nheeft gevraagd openbaar gemaakt uiterlijk gelijktijdig met de indiening van het voorstel van wet bij de\nStaten-Generaal dan wel de bekendmaking van het algemeen verbindend voorschrift of besluit, indien het bestuursorgaan\nin zijn adviesaanvraag heeft gemotiveerd dat eerdere openbaarmaking afbreuk zou doen aan een met de wet, het\nvoorschrift of het besluit beoogde doel;\nb. worden in geval van voorstellen van algemene begrotingswetten en de stukken betreffende de verantwoording van de\nontvangsten en de uitgaven van het Rijk als bedoeld in artikel 105, eerste, tweede en derde lid, van de Grondwet, de\ndaarbij behorende toelichtende stukken, alsmede in geval van een op het in artikel 65 van de Grondwet bedoelde\ntijdstip ingediende voorstel van wet voor zover dat voorstel betrekking heeft op het heffen van belasting, de versies\nwaarover een adviesaanvraag wordt gedaan, de op die versies betrekking hebbende adviezen als bedoeld in het tweede\nlid, onderdeel e, en de op die versies betrekking hebbende onderzoeken als bedoeld in het tweede lid, onderdeel j,\nopenbaar gemaakt gelijktijdig met de indiening van het voorstel van wet of de stukken bij de Staten-Generaal;\nc. worden vergaderstukken als bedoeld in het tweede lid, onderdelen b en c, openbaar gemaakt, gelijktijdig met de\nverspreiding aan de deelnemers van de betreffende vergadering;\nd. worden agenda's als bedoeld in het tweede lid, onderdeel d, openbaar gemaakt, uiterlijk bij aanvang van de\nbetreffende vergadering;\ne. wordt de inhoud van een schriftelijk verzoek als bedoeld in het tweede lid, onderdeel i, openbaar gemaakt met de\nbeslissing op dat verzoek;\nf. geschiedt de openbaarmaking van onderzoeken als bedoeld in het tweede lid, onderdeel j, onder 1, uiterlijk binnen\nvier weken na ontvangst van het onderzoek;\ng. geschiedt de openbaarmaking van een beschikking houdende een herstelsanctie die niet in het tweede lid, onderdeel\nk, onder 6, is uitgezonderd, uiterlijk twee weken nadat de beschikking onherroepelijk is geworden;\nh. worden ingekomen documenten als bedoeld in het tweede lid, niet openbaar gemaakt dan nadat belanghebbenden die naar\nverwachting bedenkingen zullen hebben tegen openbaarmaking, in de gelegenheid zijn gesteld binnen twee weken hun\nzienswijze naar voren te brengen;\ni. worden documenten als bedoeld in het tweede lid, waarbij gedurende de voorbereiding ervan of na toepassing van\nonderdeel h is gebleken dat een belanghebbende naar verwachting bezwaar heeft tegen een voorgeschreven openbaarmaking,\nopenbaar gemaakt na twee weken na vaststelling, onderscheidenlijk het verstrijken van de op grond van onderdeel h\ngestelde termijn om een zienswijze naar voren te brengen.\n\n6. De openbaarmaking, bedoeld in het tweede lid, onderdeel e, geschiedt:\na. voor een adviesaanvraag aan een adviescollege of -commissie door het bestuursorgaan dat het advies heeft gevraagd;\nb. voor een advies van een adviescollege of -commissie door dat adviescollege of die commissie, behoudens de gevallen,\nbedoeld in het vijfde lid, onderdelen a en b;\nc. voor een advies van een andere externe partij door het bestuursorgaan dat het advies heeft ontvangen.\n\n7. Het bestuursorgaan deelt een belanghebbende mede dat toepassing wordt gegeven aan het vijfde lid, onderdeel i,\nonder vermelding van het tijdstip van openbaarmaking en de openbaar te maken documenten. De mededeling wordt\ngelijkgesteld met een besluit.\n\n8. Het bestuursorgaan doet mededeling van een gedeeltelijke niet-openbaarmaking gelijktijdig met de openbaarmaking.\nVan een gehele niet-openbaarmaking doet het bestuursorgaan mededeling op de wijze en het tijdstip waarop het\nniet-openbaar gemaakte stuk openbaar zou zijn gemaakt.\n\n9. Onze Minister kan bij ministeriele regeling nadere regels stellen over de wijze waarop in dit artikel genoemde\ndocumenten actief openbaar worden gemaakt.").
article_property("3.3", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel3.3").

article("3.3a", "1. Een bestuursorgaan kan in plaats van door openbaarmaking overeenkomstig artikel 3.3, tweede lid, onderdeel k, de\ninformatie over beschikkingen inzake subsidies aan anderen dan natuurlijke personen openbaar maken in een voor\npersonen elektronisch raadpleegbaar overzicht, waarbij, voor zover de informatie in de beschikking is opgenomen en de\nartikelen 5.1, eerste, tweede en vijfde lid, en 5.2 niet aan openbaarmaking in de weg staan, in ieder geval openbaar\nwordt gemaakt:\na. de grondslag van de subsidie;\nb. de ontvanger;\nc. de activiteiten waarvoor de subsidie wordt verstrekt, alsmede in de beschikking opgenomen doelvoorschriften;\nd. de hoogte van verleningen, vaststellingen en wijzigingen;\ne. de intrekkingen;\nf. de dagtekening van de beschikking.\n\n2. Een bestuursorgaan kan in plaats van door openbaarmaking overeenkomstig artikel 3.3, tweede lid, onderdeel k, de\ninformatie over andere beschikkingen dan beschikkingen inzake subsidies openbaar maken in een voor personen\nelektronisch raadpleegbaar overzicht, waarbij, voor zover de informatie in de beschikking is opgenomen en de artikelen\n5.1, eerste, tweede en vijfde lid, en 5.2 niet aan openbaarmaking in de weg staan, in ieder geval openbaar wordt\ngemaakt:\na. de grondslag van de beschikking;\nb. het rechtsgevolg van de beschikking, inclusief in de beschikking opgenomen voorschriften;\nc. de duur van de beschikking;\nd. de geadresseerde, voor zover de bescherming van de persoonlijke levenssfeer hieraan niet in de weg staat;\ne. de dagtekening van de beschikking.\n\n3. Een bestuursorgaan kan in plaats van door openbaarmaking overeenkomstig artikel 3.3, tweede lid, onderdeel l, de\ninformatie over schriftelijke oordelen in klachtprocedures openbaar maken in een voor personen elektronisch\nraadpleegbaar overzicht, waarbij, voor zover de informatie in het oordeel is opgenomen en de artikelen 5.1, eerste,\ntweede en vijfde lid, en 5.2 niet aan openbaarmaking in de weg staan, in ieder geval openbaar wordt gemaakt:\na. de datum van ontvangst van de klacht;\nb. het betrokken organisatieonderdeel;\nc. de functiebenaming van de ambtenaar over wie is geklaagd;\nd. de omschrijving van de gedraging waartegen de klacht gericht is;\ne. de bevindingen;\nf. het oordeel;\ng. de conclusies;\nh. de dagtekening van het oordeel.\n\n4. Een bestuursorgaan kan in het overzicht, bedoeld in het derde lid, vergelijkbare klachten betreffende een\norganisatieonderdeel gecombineerd weergeven, indien ook het oordeel en de conclusies vergelijkbaar zijn. Voor iedere\ngecombineerde weergave wordt in plaats van de informatie, bedoeld in het derde lid, onderdelen a en h, het aantal\nverzonden oordelen per maand vermeld.\n\n5. Een overzicht als bedoeld in dit artikel wordt ten minste iedere twee weken bijgewerkt.\n\n6. Onze Minister kan bij ministeriele regeling nadere regels stellen over de wijze waarop in dit artikel genoemde\noverzichten actief openbaar worden gemaakt.").
article_property("3.3a", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel3.3a").

article("3.3b", "De openbaarmaking van de in de artikelen 3.3 en 3.3a genoemde documenten geschiedt elektronisch op een algemeen toegankelijke wijze door middel van een door Onze Minister in stand gehouden digitale infrastructuur. Deze infrastructuur is beschikbaar voor de openbaarmaking van andere documenten.").
article_property("3.3b", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel3.3b").

article("3.4", "In afwijking van de artikelen 5.1 en 5.2 kan een bestuursorgaan informatie uit eigen beweging openbaar maken, wanneer een ander zwaarwegend algemeen belang, daaronder begrepen het belang van openbare veiligheid, de volksgezondheid of het milieu of de bescherming van de democratische rechtsorde, dat in een concreet geval vergt.").
article_property("3.4", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel3.4").

article("3.5", "Een bestuursorgaan besteedt in de jaarlijkse begroting dan wel de jaarlijkse begroting van het openbaar lichaam of de rechtspersoon waarvan het bestuursorgaan deel uit maakt, aandacht aan de beleidsvoornemens inzake de uitvoering van deze wet en doet in de jaarlijkse verantwoording verslag van de uitvoering ervan, mede in relatie tot de beleidsvoornemens.").
article_property("3.5", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel3.5").

article("4.1", "1. Eenieder kan een verzoek om publieke informatie richten tot een bestuursorgaan of een onder verantwoordelijkheid van een bestuursorgaan werkzame instelling, dienst of bedrijf. In het laatste geval beslist het verantwoordelijke bestuursorgaan op het verzoek.\n\n2. Een verzoek kan mondeling of schriftelijk worden ingediend en kan elektronisch worden verzonden op de door het bestuursorgaan aangegeven wijze.\n\n3. De verzoeker behoeft bij zijn verzoek geen belang te stellen.\n\n4. De verzoeker vermeldt bij zijn verzoek de aangelegenheid of het daarop betrekking hebbende document, waarover hij informatie wenst te ontvangen.\n\n5. Indien een verzoek te algemeen geformuleerd is, verzoekt het bestuursorgaan binnen twee weken na ontvangst van het verzoek de verzoeker om het verzoek te preciseren en is het de verzoeker daarbij behulpzaam.\n\n6. Het bestuursorgaan kan besluiten een verzoek niet te behandelen, indien de verzoeker niet meewerkt aan een verzoek tot precisering als bedoeld het vijfde lid. In afwijking van artikel 4:5, vierde lid, van de Algemene wet bestuursrecht wordt het besluit om het verzoek niet te behandelen aan de verzoeker bekendgemaakt binnen twee weken nadat het verzoek is gepreciseerd of nadat de daarvoor gestelde termijn ongebruikt is verstreken.\n\n7. Een verzoek om informatie wordt ingewilligd met inachtneming van het bepaalde in hoofdstuk 5.").
article_property("4.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.1").

article("4.1a", "Het bestuursorgaan waarborgt het behoud van de documenten waarop een door hem ontvangen verzoek betrekking heeft.").
article_property("4.1a", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.1a").

article("4.2", "1. Voor zover het verzoek betrekking heeft op informatie die berust bij een ander bestuursorgaan dan dat waarbij het verzoek is ingediend, wordt de verzoeker zo nodig naar dat bestuursorgaan verwezen. Is het verzoek schriftelijk gedaan, dan wordt het voor zover betrekking hebbend op informatie die bij een ander bestuursorgaan berust, onverwijld doorgezonden aan dat bestuursorgaan, onder mededeling van de doorzending aan de verzoeker.\n\n2. Indien het verzoek betrekking heeft op informatie die op grond van enig wettelijk voorschrift bij het bestuursorgaan had behoren te berusten, vordert het bestuursorgaan de gevraagde informatie van degene die over de informatie beschikt. Degene die over de gevraagde informatie beschikt, verstrekt deze per omgaande aan het bestuursorgaan.\n\n3. Voor zover een verzoek als bedoeld in artikel 4.1, eerste lid, dat is gericht aan een der Kamers of de verenigde vergadering der Staten-Generaal, betrekking heeft op informatie die door de regering vertrouwelijk aan de Staten-Generaal is verstrekt, zendt de Kamer of de verenigde vergadering het verzoek ter behandeling door aan Onze Minister of Onze Ministers die deze informatie vertrouwelijk heeft of hebben verstrekt.").
article_property("4.2", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.2").

article("4.2a", "Indien een voldoende gespecificeerd verzoek zodanig omvangrijk is dat niet binnen de termijn van artikel 4.4, eerste lid, kan worden beslist, treedt het bestuursorgaan voor het einde van die termijn in overleg met de verzoeker over de prioritering van de afhandeling van het verzoek. Het bestuursorgaan verstrekt de gevraagde documenten zo veel mogelijk in de door de verzoeker gewenste volgorde.").
article_property("4.2a", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.2a").

article("4.3", "1. De beslissing op een verzoek om informatie wordt mondeling of schriftelijk genomen.\n\n2. Het bestuursorgaan besluit in ieder geval schriftelijk op een verzoek om informatie, indien:\na. het schriftelijke verzoek geheel of gedeeltelijk wordt afgewezen;\nb. de verzoeker bij gehele of gedeeltelijke afwijzing van het mondelinge verzoek verzoekt om een schriftelijk besluit;\nc. de gevraagde informatie slechts wordt verstrekt aan de verzoeker overeenkomstig artikel 5.5, artikel 5.6 of artikel\n5.7 en aan de verstrekking voorwaarden worden verbonden; of\nd. de gevraagde informatie betrekking heeft op of afkomstig is van derden, tenzij deze hebben verklaard aan een\nschriftelijk besluit geen behoefte te hebben.\n\n3. Bij de afwijzing van een mondeling verzoek, wordt de verzoeker gewezen op de mogelijkheid van een schriftelijk\nbesluit.").
article_property("4.3", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.3").

article("4.4", "1. Het bestuursorgaan beslist op het verzoek om informatie zo spoedig mogelijk, doch uiterlijk binnen vier weken gerekend vanaf de dag na die waarop het verzoek is ontvangen.\n\n2. Het bestuursorgaan kan de beslissing voor ten hoogste twee weken verdagen, indien de omvang of de gecompliceerdheid van de informatie een verlenging rechtvaardigt. Van de verdaging wordt voor de afloop van de eerste termijn schriftelijk gemotiveerd mededeling gedaan aan de verzoeker.\n\n3. Onverminderd artikel 4:15 van de Algemene wet bestuursrecht wordt de termijn voor het geven van een beschikking opgeschort gerekend vanaf de dag na die waarop het bestuursorgaan de verzoeker meedeelt dat toepassing is gegeven aan artikel 4:8 van de Algemene wet bestuursrecht, tot en met de dag waarop door de belanghebbende of belanghebbenden een zienswijze naar voren is gebracht of de daarvoor gestelde termijn ongebruikt is verstreken.\n\n4. Indien de opschorting, bedoeld in het derde lid, eindigt, doet het bestuursorgaan daarvan zo spoedig mogelijk mededeling aan de verzoeker, onder vermelding van de termijn binnen welke de beschikking alsnog moet worden gegeven.\n\n5. Indien het bestuursorgaan heeft besloten informatie te verstrekken, wordt de informatie verstrekt tegelijk met de bekendmaking van het besluit, tenzij naar verwachting een belanghebbende bezwaar daartegen heeft, in welk geval de informatie wordt verstrekt twee weken nadat de beslissing is bekendgemaakt. Indien wordt verzocht om een voorlopige voorziening als bedoeld in artikel 8:81 van de Algemene wet bestuursrecht, wordt de openbaarmaking opgeschort totdat de voorzieningenrechter uitspraak heeft gedaan of het verzoek is ingetrokken.\n\n6. Indien het bestuursorgaan heeft besloten informatie te verstrekken die rechtstreeks betrekking heeft op een derde of die van een derde afkomstig is, deelt het bestuursorgaan dit besluit gelijktijdig mede aan deze derde.").
article_property("4.4", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.4").
execution_property("4.4", "produces", record([
  field("legal_character", "WAARDEBEPALING")
])).
execution_property("4.4", "parameters", [
  record([
    field("name", "verzoek_ontvangst_datum"),
    field("type", "date"),
    field("required", true)
  ]),
  record([
    field("name", "is_verdaagd"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "heeft_derde_belanghebbende"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "opschorting_dagen"),
    field("type", "number"),
    field("required", true),
    field("description", "Lid 3: aantal dagen dat de beslistermijn is opgeschort wegens zienswijzeprocedure (art 4:8 Awb). Geef 0 als geen opschorting.")
  ])
]).
execution_property("4.4", "output", [
  record([
    field("name", "beslistermijn_weken"),
    field("type", "number")
  ]),
  record([
    field("name", "uiterste_beslisdatum"),
    field("type", "date")
  ]),
  record([
    field("name", "uiterste_openbaarmaking_datum"),
    field("type", "date"),
    field("description", "Bovengrens voor openbaarmaking. Art 4.4 lid 5 zegt \"twee weken nadat de beslissing is bekendgemaakt\" — de werkelijke openbaarmaking hangt af van de feitelijke bekendmakingsdatum, niet de uiterste beslisdatum. Deze output berekent de bovengrens (uiterste beslisdatum als basis).")
  ])
]).
execution_property("4.4", "actions", [
  record([
    field("output", "beslistermijn_weken"),
    field("value", expression("wet_open_overheid@2025-02-12/expression4/1"))
  ]),
  record([
    field("output", "uiterste_beslisdatum"),
    field("value", expression("wet_open_overheid@2025-02-12/expression5/1"))
  ]),
  record([
    field("output", "uiterste_openbaarmaking_datum"),
    field("value", expression("wet_open_overheid@2025-02-12/expression6/1"))
  ])
]).

article("4.5", "1. Het bestuursorgaan verstrekt de informatie in de door verzoeker verzochte vorm of, indien dit redelijkerwijs niet gevergd kan worden, met inachtneming van het bepaalde in artikel 2.4, derde lid.\n\n2. Indien de informatie reeds in een voor de verzoeker gemakkelijk toegankelijke vorm voor het publiek beschikbaar is, wijst het bestuursorgaan de verzoeker daarop.").
article_property("4.5", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.5").

article("4.6", "Indien de verzoeker kennelijk een ander doel heeft dan het verkrijgen van publieke informatie of indien het verzoek evident geen bestuurlijke aangelegenheid betreft, kan het bestuursorgaan binnen twee weken na ontvangst van het verzoek, dan wel onverwijld nadat is gebleken dat de verzoeker kennelijk een ander doel heeft dan het verkrijgen van publieke informatie, besluiten het verzoek niet te behandelen.").
article_property("4.6", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.6").

article("4.7", "Ter beantwoording van vragen over de beschikbaarheid van publieke informatie wijst het bestuursorgaan een of meer contactpersonen aan.").
article_property("4.7", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel4.7").

article("5.1", "1. Het openbaar maken van informatie ingevolge deze wet blijft achterwege voor zover dit:\na. de eenheid van de Kroon in gevaar zou kunnen brengen;\nb. de veiligheid van de Staat zou kunnen schaden;\nc. bedrijfs- en fabricagegegevens betreft die door natuurlijke personen of rechtspersonen vertrouwelijk aan de\noverheid zijn meegedeeld;\nd. persoonsgegevens betreft als bedoeld in paragraaf 3.1 onderscheidenlijk paragraaf 3.2 van de Uitvoeringswet\nAlgemene verordening gegevensbescherming, tenzij de betrokkene uitdrukkelijk toestemming heeft gegeven voor de\nopenbaarmaking van deze persoonsgegevens of deze persoonsgegevens kennelijk door de betrokkene openbaar zijn gemaakt;\ne. nummers betreft die dienen ter identificatie van personen die bij wet of algemene maatregel van bestuur zijn\nvoorgeschreven als bedoeld in artikel 46 van de Uitvoeringswet Algemene verordening gegevensbescherming, tenzij de\nverstrekking kennelijk geen inbreuk op de levenssfeer maakt.\n\n2. Het openbaar maken van informatie blijft eveneens achterwege voor zover het belang daarvan niet opweegt tegen de\nvolgende belangen:\na. de betrekkingen van Nederland met andere landen en staten en met internationale organisaties;\nb. de economische of financiele belangen van de Staat, andere publiekrechtelijke lichamen of bestuursorganen, in geval\nvan milieu-informatie slechts voor zover de informatie betrekking heeft op handelingen met een vertrouwelijk karakter;\nc. de opsporing en vervolging van strafbare feiten;\nd. de inspectie, controle en toezicht door bestuursorganen;\ne. de eerbiediging van de persoonlijke levenssfeer;\nf. de bescherming van andere dan in het eerste lid, onderdeel c, genoemde concurrentiegevoelige bedrijfs- en\nfabricagegegevens;\ng. de bescherming van het milieu waarop deze informatie betrekking heeft;\nh. de beveiliging van personen en bedrijven en het voorkomen van sabotage;\ni. het goed functioneren van de Staat, andere publiekrechtelijke lichamen of bestuursorganen.\n\n3. Indien een verzoek tot openbaarmaking op een van de in het tweede lid genoemde gronden wordt afgewezen, bevat het\nbesluit hiervoor een uitdrukkelijke motivering.\n\n4. Openbaarmaking kan tijdelijk achterwege blijven, indien het belang van de geadresseerde van de informatie om als\neerste kennis te nemen van de informatie dit kennelijk vereist. Het bestuursorgaan doet mededeling aan de verzoeker\nvan de termijn waarbinnen de openbaarmaking alsnog zal geschieden.\n\n5. In uitzonderlijke gevallen kan openbaarmaking van andere informatie dan milieu-informatie voorts achterwege blijven\nindien openbaarmaking onevenredige benadeling toebrengt aan een ander belang dan genoemd in het eerste of tweede lid\nen het algemeen belang van openbaarheid niet tegen deze benadeling opweegt. Het bestuursorgaan baseert een beslissing\ntot achterwege laten van de openbaarmaking van enige informatie op deze grond ten aanzien van dezelfde informatie niet\ntevens op een van de in het eerste of tweede lid genoemde gronden.\n\n6. Het openbaar maken van informatie blijft in afwijking van het eerste lid, onderdeel c, in geval van\nmilieu-informatie eveneens achterwege voor zover daardoor het in het eerste lid, onderdeel c, genoemde belang ernstig\ngeschaad wordt en het algemeen belang van openbaarheid van informatie niet opweegt tegen deze schade.\n\n7. Het eerste en tweede lid zijn niet van toepassing op milieu-informatie die betrekking heeft op emissies in het\nmilieu.").
article_property("5.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel5.1").
execution_property("5.1", "produces", record([
  field("legal_character", "TOETS")
])).
execution_property("5.1", "parameters", [
  record([
    field("name", "raakt_eenheid_kroon"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_veiligheid_staat"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "bevat_vertrouwelijke_bedrijfsgegevens"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "bevat_bijzondere_persoonsgegevens"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "bevat_identificatienummers"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "betrokkene_heeft_toestemming"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "persoonsgegevens_kennelijk_openbaar_gemaakt"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "verstrekking_geen_inbreuk_levenssfeer"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "is_milieu_informatie"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "betreft_emissies"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_internationale_betrekkingen"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_economische_belangen"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_opsporing_vervolging"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_inspectie_toezicht"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_persoonlijke_levenssfeer"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_concurrentiegevoelige_gegevens"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_milieubescherming"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_beveiliging_personen"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "raakt_goed_functioneren_staat"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "belang_openbaarheid_weegt_zwaarder"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "onevenredige_benadeling_ander_belang"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "bedrijfsgegevens_ernstig_geschaad"),
    field("type", "boolean"),
    field("required", true)
  ]),
  record([
    field("name", "milieu_belang_openbaarheid_weegt_op"),
    field("type", "boolean"),
    field("required", true)
  ])
]).
execution_property("5.1", "output", [
  record([
    field("name", "heeft_absolute_weigeringsgrond"),
    field("type", "boolean")
  ]),
  record([
    field("name", "heeft_relatieve_weigeringsgrond"),
    field("type", "boolean")
  ]),
  record([
    field("name", "heeft_lid5_weigeringsgrond"),
    field("type", "boolean")
  ]),
  record([
    field("name", "openbaarmaking_toegestaan"),
    field("type", "boolean")
  ])
]).
execution_property("5.1", "actions", [
  record([
    field("output", "heeft_absolute_weigeringsgrond"),
    field("value", expression("wet_open_overheid@2025-02-12/expression7/1"))
  ]),
  record([
    field("output", "heeft_relatieve_weigeringsgrond"),
    field("value", expression("wet_open_overheid@2025-02-12/expression8/1"))
  ]),
  record([
    field("output", "heeft_lid5_weigeringsgrond"),
    field("value", expression("wet_open_overheid@2025-02-12/expression9/1"))
  ]),
  record([
    field("output", "openbaarmaking_toegestaan"),
    field("value", expression("wet_open_overheid@2025-02-12/expression10/1"))
  ])
]).

article("5.2", "1. In geval van een verzoek om informatie uit documenten, opgesteld ten behoeve van intern beraad, wordt geen informatie verstrekt over daarin opgenomen persoonlijke beleidsopvattingen. Onder persoonlijke beleidsopvattingen worden verstaan ambtelijke adviezen, visies, standpunten en overwegingen ten behoeve van intern beraad, niet zijnde feiten, prognoses, beleidsalternatieven, de gevolgen van een bepaald beleidsalternatief of andere onderdelen met een overwegend objectief karakter.\n\n2. Het bestuursorgaan kan over persoonlijke beleidsopvattingen met het oog op een goede en democratische bestuursvoering informatie verstrekken in niet tot personen herleidbare vorm. Indien degene die deze opvattingen heeft geuit of zich erachter heeft gesteld, daarmee heeft ingestemd, kan de informatie in tot personen herleidbare vorm worden verstrekt.\n\n3. Onverminderd het eerste en tweede lid wordt uit documenten opgesteld ten behoeve van formele bestuurlijke besluitvorming door een minister, een commissaris van de Koning, Gedeputeerde Staten, een gedeputeerde, het college van burgemeester en wethouders, een burgemeester, een wethouder, het dagelijks bestuur van een waterschap of een lid van dat bestuur, informatie verstrekt over persoonlijke beleidsopvattingen in niet tot personen herleidbare vorm, tenzij het kunnen voeren van intern beraad onevenredig wordt geschaad.\n\n4. In afwijking van het eerste lid wordt bij milieu-informatie het belang van de bescherming van de persoonlijke beleidsopvattingen afgewogen tegen het belang van openbaarmaking. Informatie over persoonlijke beleidsopvattingen kan worden verstrekt in niet tot personen herleidbare vorm. Indien degene die deze opvattingen heeft geuit of zich erachter heeft gesteld, daarmee heeft ingestemd, kan de informatie in tot personen herleidbare vorm worden verstrekt.").
article_property("5.2", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel5.2").

article("5.3", "Bij een verzoek om informatie die ouder is dan vijf jaar motiveert het bestuursorgaan bij een weigering van die informatie waarom de in artikel 5.1, tweede of vijfde lid, of artikel 5.2 bedoelde belangen ondanks het tijdsverloop zwaarder wegen dan het algemeen belang van openbaarheid.").
article_property("5.3", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel5.3").
execution_property("5.3", "produces", record([
  field("legal_character", "TOETS")
])).
execution_property("5.3", "parameters", [
  record([
    field("name", "informatie_datum"),
    field("type", "date"),
    field("required", true)
  ]),
  record([
    field("name", "peildatum"),
    field("type", "date"),
    field("required", true),
    field("description", "Datum waarop de leeftijd van de informatie wordt berekend (doorgaans datum van het verzoek)")
  ])
]).
execution_property("5.3", "output", [
  record([
    field("name", "informatie_leeftijd_jaren"),
    field("type", "number")
  ]),
  record([
    field("name", "verzwaarde_motiveringsplicht"),
    field("type", "boolean")
  ])
]).
execution_property("5.3", "actions", [
  record([
    field("output", "informatie_leeftijd_jaren"),
    field("value", expression("wet_open_overheid@2025-02-12/expression11/1"))
  ]),
  record([
    field("output", "verzwaarde_motiveringsplicht"),
    field("value", expression("wet_open_overheid@2025-02-12/expression12/1"))
  ])
]).

article("5.4", "In afwijking van de artikelen 5.1 en 5.2 is informatie die berust bij de formateur of de informateur, dan wel informatie die door een bestuursorgaan aan de formateur of de informateur is gezonden niet openbaar totdat de formatie is afgerond.").
article_property("5.4", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel5.4").

article("5.4a", "1. In afwijking van de artikelen 5.1 en 5.2 is niet openbaar de informatie betreffende de ondersteuning van individuele leden van de Eerste Kamer of de Tweede Kamer der Staten-Generaal, provinciale staten of de gemeenteraad door ambtenaren werkzaam bij de Eerste Kamer of de Tweede Kamer, de griffie van provinciale staten of de griffie van de gemeenteraad.\n\n2. In afwijking van artikel 5.2, eerste lid, wordt met betrekking tot informatie die aan individuele Kamerleden wordt verstrekt onder persoonlijke beleidsopvattingen verstaan ambtelijke adviezen, visies, standpunten en overwegingen ten behoeve van intern beraad.").
article_property("5.4a", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel5.4a").

article("5.5", "1. Onverminderd het elders bij wet bepaalde, verstrekt een bestuursorgaan iedere natuurlijke of rechtspersoon op diens verzoek de op de verzoeker betrekking hebbende in documenten neergelegde informatie, tenzij een in artikel 5.1, eerste lid, onderdelen a, b en c, alsmede d en e, voor zover betrekking hebbend op derden, genoemd belang aan de orde is of een in artikel 5.1, tweede of vijfde lid, of artikel 5.2 genoemd belang zwaarder weegt dan het belang van de verzoeker bij toegang tot op hem betrekking hebbende informatie. De verzoeker vermeldt bij zijn verzoek de aangelegenheid of het daarop betrekking hebbende document, waarover hij informatie wenst te ontvangen.\n\n2. Het eerste lid is van overeenkomstige toepassing op een verzoek met betrekking tot gegevens ten aanzien van een overleden echtgenoot, geregistreerd partner, kind of ouder van de verzoeker, tenzij een schriftelijke wilsverklaring van de overledene aan de verstrekking in de weg staat.\n\n3. Het bestuursorgaan draagt zorg voor een deugdelijke vaststelling van de identiteit van de verzoeker.\n\n4. Het bestuursorgaan kan aan de verstrekking voorwaarden verbinden ter bescherming van een van de belangen, genoemd in de artikelen 5.1 en 5.2, tenzij de gevraagde informatie met toepassing van de artikelen 5.1 en 5.2 openbaar voor eenieder zou zijn.").
article_property("5.5", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel5.5").

article("5.6", "1. Het bestuursorgaan kan, in geval informatie ingevolge de artikelen 5.1 en 5.2 niet openbaar gemaakt kan worden, besluiten de informatie uitsluitend aan de verzoeker te verstrekken, indien er klemmende redenen zijn om de verzoeker niettegenstaande de toepasselijke uitzonderingsgrond of -gronden de gevraagde informatie niet te onthouden.\n\n2. Het eerste lid vindt slechts toepassing voor zover dit niet in strijd is met een toepasselijke geheimhoudingsplicht.\n\n3. Het bestuursorgaan kan aan de verstrekking voorwaarden verbinden ter bescherming van een van de belangen, genoemd in de artikelen 5.1 en 5.2.").
article_property("5.6", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel5.6").

article("5.7", "1. Een bestuursorgaan kan ten behoeve van historisch, statistisch, wetenschappelijk of journalistiek onderzoek toegang\nbieden tot informatie:\na. die ingevolge de artikelen 5.1 en 5.2 niet openbaar gemaakt kan worden; of\nb. waarvan de vaststelling of deze informatie ingevolge de artikelen 5.1 en 5.2 openbaar gemaakt kan worden een\nonevenredige inspanning vergt.\n\n2. Het bestuursorgaan kan aan het verlenen van toegang voorwaarden verbinden.\n\n3. De toegang tot informatie overeenkomstig het eerste lid wordt in ieder geval verleend onder de voorwaarde dat\ndegene aan wie toegang wordt verleend, de verkregen informatie niet verder verspreidt zonder voorafgaand besluit van\nhet bestuursorgaan waarin de informatie met toepassing van de artikelen 5.1 en 5.2 openbaar gemaakt wordt.").
article_property("5.7", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel5.7").

article("6.1", "Het bestuursorgaan treft maatregelen ten behoeve van het duurzaam toegankelijk maken van de digitale documenten, bedoeld in artikel 2.4, eerste lid.").
article_property("6.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel6.1").

article("6.2", "1. Onze Minister, in overeenstemming met Onze Minister van Onderwijs, Cultuur en Wetenschap, zendt een meerjarenplan naar de Staten-Generaal over de wijze waarop bestuursorganen hun digitale overheidsinformatie duurzaam toegankelijk maken.\n\n2. Het meerjarenplan bevat langetermijndoelen voor de verbetering van de wijze waarop digitale documenten worden vervaardigd, geordend, bewaard, vernietigd en ontsloten alsmede de stappen die daartoe op korte termijn worden gezet.\n\n3. Het meerjarenplan voorziet in stappen waarmee wordt bereikt dat eenieder zo veel mogelijk inzicht kan hebben in de aanwezigheid van publieke informatie bij een orgaan, persoon of college als bedoeld in artikel 2.2, eerste lid.\n\n4. Onze Minister, in overeenstemming met Onze Minister van Onderwijs, Cultuur en Wetenschap, vult het meerjarenplan aan met de nodige maatregelen tot de digitale overheidsinformatie voldoende duurzaam toegankelijk is.").
article_property("6.2", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel6.2").

article("7.1", "1. Er is een Adviescollege openbaarheid en informatiehuishouding.\n\n2. Het college bestaat uit een voorzitter en ten hoogste vier andere leden.\n\n3. De benoeming van de leden bij koninklijk besluit geschiedt op voordracht van Onze Minister, in overeenstemming met Onze Minister van Onderwijs, Cultuur en Wetenschap.\n\n4. De artikelen 13, 16 en 19 van de Kaderwet zelfstandige bestuursorganen zijn van overeenkomstige toepassing.").
article_property("7.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel7.1").

article("7.2", "1. Het college adviseert de regering en de beide Kamers der Staten-Generaal gevraagd en ongevraagd over de uitvoering\nvan de regels over openbaarmaking van publieke informatie.\n\n2. Het college adviseert Onze Minister periodiek over aanpassing van het meerjarenplan. Het college rapporteert in\nzijn advies in elk geval over de stand van de informatiehuishouding in het bestuur, de voortgang van de uitvoering van\nhet meerjarenplan en de toegang tot de publieke informatie.\n\n3. Het college wordt om advies gevraagd over voorstellen van wet en ontwerpen van algemene maatregelen van bestuur die\ngeheel of voor een belangrijk deel betrekking hebben op de openbaarmaking en de ontsluiting van publieke informatie.\n\n4. Het college adviseert het betrokken bestuursorgaan naar aanleiding van bij het college ingediende klachten van\njournalisten, wetenschappers of andere naar het oordeel van het college in aanmerking komende groepen met een\nberoepsmatig belang bij het gebruik van publieke informatie over de wijze waarop dat bestuursorgaan publieke\ninformatie openbaar maakt.\n\n5. Het college bevordert de toepassing van deze wet, onder meer door:\na. het geven van voorlichting aan bestuursorganen en anderen;\nb. het opleiden van personen werkzaam bij organen belast met de uitvoering van openbaarmaking van publieke informatie;\nc. het monitoren en onderzoeken van en rapporteren over de openbaarmaking van publieke informatie in algemene zin of\ndoor specifieke organen in het bijzonder;\nd. het publiceren van richtsnoeren ter bevordering van de openbaarmaking uit eigen beweging en de ontsluiting van\ninformatie.").
article_property("7.2", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel7.2").

article("7.3", "1. Alvorens een advies als bedoeld in artikel 7.2, vierde lid, uit te brengen, bemiddelt het college tussen het bestuursorgaan en de klager. Het bestuursorgaan werkt aan de bemiddeling mee.\n\n2. Indien de klacht mede betrekking heeft op een besluit op grond van deze wet waartegen bezwaar open staat, wordt de termijn voor het indienen van bezwaar, bedoeld in artikel 6:7 van de Algemene wet bestuursrecht, opgeschort tot het college advies heeft uitgebracht, dan wel aan de klager en het bestuursorgaan heeft bericht dat geen advies zal worden uitgebracht. De opschorting van de bezwaartermijn vangt aan met ingang van de dag nadat de klager de klacht aan het college heeft gezonden.\n\n3. Indien de klager bezwaar maakt tegen het besluit, bedoeld in het tweede lid, beslist het bestuursorgaan in afwijking van artikel 7:10, eerste lid, van de Algemene wet bestuursrecht binnen twee weken nadat het college advies heeft uitgebracht, dan wel aan de klager en het bestuursorgaan heeft bericht dat geen advies zal worden uitgebracht.\n\n4. Bij algemene maatregel van bestuur kunnen nadere regels worden gesteld over de wijze waarop klachten worden ingediend en het college tussen het bestuursorgaan en de klager bemiddelt als bedoeld in het eerste lid.").
article_property("7.3", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel7.3").

article("7.4", "Een bestuursorgaan verstrekt desgevraagd het college alle gegevens die het nodig heeft voor zijn taak.").
article_property("7.4", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel7.4").

article("7.5", "1. De leden van het college alsmede de ambtenaren van zijn bureau zijn tot geheimhouding verplicht voor zover zij krachtens deze wet beschikken over documenten die door het bestuursorgaan waarvan zij afkomstig zijn niet openbaar zijn gemaakt.\n\n2. Voor zover een aan het college gericht verzoek op grond van deze wet betrekking heeft op door een bestuursorgaan aan het college verstrekte informatie, zendt het college het verzoek ter behandeling door aan het bestuursorgaan.").
article_property("7.5", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel7.5").

article("8.1", "1. Overtreding van een voorwaarde die op grond van artikel 5.5, vierde lid, 5.6, derde lid, of artikel 5.7, tweede of derde lid, aan een verstrekking is verbonden, wordt gestraft met gevangenisstraf van ten hoogste een jaar of geldboete van de vierde categorie.\n\n2. Het in het eerste lid strafbaar gestelde feit is een misdrijf.").
article_property("8.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel8.1").

article("8.2", "Paragraaf 4.1.3.2 van de Algemene wet bestuursrecht is niet van toepassing op besluiten op grond van deze wet en op beslissingen op bezwaar tegen deze besluiten.").
article_property("8.2", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel8.2").
execution_property("8.2", "produces", record([
  field("legal_character", "WAARDEBEPALING")
])).
execution_property("8.2", "output", [
  record([
    field("name", "dwangsom_van_toepassing"),
    field("type", "boolean")
  ])
]).
execution_property("8.2", "actions", [
  record([
    field("output", "dwangsom_van_toepassing"),
    field("value", expression("wet_open_overheid@2025-02-12/expression13/1"))
  ])
]).

article("8.4", "1. In geval van een gegrond beroep tegen het niet tijdig nemen van een besluit op grond van deze wet of een beslissing\nop bezwaar tegen een dergelijk besluit, waarbij nog geen besluit is bekendgemaakt, bepaalt de bestuursrechter, indien\nde omvang van het verzoek hiertoe aanleiding geeft, in afwijking van artikel 8:55d, eerste lid, van de Algemene wet\nbestuursrecht de termijn waarbinnen het bestuursorgaan alsnog een besluit bekendmaakt.\n\n2. Indien de bestuursrechter oordeelt dat het niet tijdig nemen van een besluit kennelijk het gevolg is van de wijze\nvan indiening van het verzoek en nog geen besluit is bekendgemaakt, bepaalt de bestuursrechter, indien het verzoek\nhiertoe aanleiding geeft, in afwijking van artikel 8:55d, eerste lid, van de Algemene wet bestuursrecht een langere\ntermijn waarbinnen het bestuursorgaan alsnog een besluit bekendmaakt.\n\n3. De bestuursrechter kan artikel 8:74, eerste lid, van de Algemene wet bestuursrecht buiten toepassing laten en een\nproceskostenveroordeling op grond van artikel 8:75, eerste lid, van de Algemene wet bestuursrecht achterwege laten,\nindien de indiener van het beroepschrift, gelet op de omvang van het verzoek, onvoldoende heeft meegewerkt aan het\nbereiken van overeenstemming over:\na. een opschorting van de beslistermijn als bedoeld in artikel 4:15, tweede lid, onderdeel a, van de Algemene wet\nbestuursrecht; of\nb. verder uitstel van de beslistermijn, bedoeld in artikel 7:10, vierde lid, onderdeel a of b, van de Algemene wet\nbestuursrecht.\n\n4. De bestuursrechter kan eveneens artikel 8:74, eerste lid, van de Algemene wet bestuursrecht buiten toepassing laten\nen een proceskostenveroordeling op grond van artikel 8:75, eerste lid, van de Algemene wet bestuursrecht achterwege\nlaten, indien hij oordeelt dat het niet tijdig nemen van een besluit kennelijk het gevolg is van de wijze van\nindiening van het verzoek.").
article_property("8.4", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel8.4").

article("8.5", "Het bestuursorgaan is bevoegd tot oplegging van een last onder dwangsom ter handhaving van artikel 4.2, tweede lid.").
article_property("8.5", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel8.5").

article("8.6", "1. De openbaarmaking van informatie op grond van deze wet is kosteloos.\n\n2. Voor de vervaardiging van kopieen van documenten kan een bestuursorgaan een redelijke vergoeding vragen, die de kostprijs van de verstrekte informatiedragers niet overstijgt.\n\n3. Op voordracht van Onze Minister kunnen bij of krachtens algemene maatregel van bestuur regels worden gesteld met betrekking tot het tweede lid.").
article_property("8.6", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel8.6").

article("8.7", "Op voordracht van Onze Minister kunnen bij of krachtens algemene maatregel van bestuur regels worden gesteld over de wijze waarop een bestuursorgaan de uitvoering van deze wet organiseert.").
article_property("8.7", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel8.7").

article("8.8", "De artikelen 3.1, 3.3, 4.1, 5.1, eerste, tweede en vijfde lid, en 5.2 zijn niet van toepassing op informatie waarvoor een bepaling geldt die is opgenomen in de bijlage bij deze wet.").
article_property("8.8", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel8.8").

article("8.9", "1. Onze Minister zendt binnen vijf jaar na de inwerkingtreding van deze wet aan de Staten-Generaal een verslag over de doeltreffendheid en de effecten van deze wet in de praktijk.\n\n2. In deze evaluatie wordt in ieder geval aandacht besteed aan de vraag of het noodzakelijk is om een Informatiecommissaris in te stellen.").
article_property("8.9", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel8.9").

article("10.1", "De Wet openbaarheid van bestuur wordt ingetrokken.").
article_property("10.1", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.1").

article("10.2", "1. Documenten die voor de inwerkingtreding van deze wet zijn opgesteld, worden niet openbaar gemaakt op grond van artikel 3.1, eerste lid, of artikel 3.3, eerste of tweede lid, tenzij het bestuursorgaan dat redelijkerwijs mogelijk acht.\n\n2. Het eerste lid is niet van toepassing op documenten die voor de datum van inwerkingtreding van deze wet zijn opgesteld en waarvan de aktieve openbaarmaking reeds op grond van de Wet openbaarheid van bestuur plaatsvond.").
article_property("10.2", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.2").

article("10.2a", "Voor documenten die voor de inwerkingtreding van deze wet zijn opgesteld en waarop een verzoek betrekking heeft, zijn de bepalingen van deze wet van toepassing, tenzij toepassing daarvan onredelijk bezwarend is voor het betrokken bestuursorgaan.").
article_property("10.2a", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.2a").

article("10.2b", "De bepalingen van deze wet zijn niet van toepassing op adviezen van de Afdeling advisering van de Raad van State die voor de inwerkingtreding van deze wet zijn uitgebracht.").
article_property("10.2b", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.2b").

article("10.2c", "De bepalingen van deze wet zijn niet van toepassing op documenten waarop artikel 8.8 van toepassing is die voor de inwerkingtreding van deze wet zijn opgesteld.").
article_property("10.2c", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.2c").

article("10.2d", "Artikel 10.2b laat onverlet de bepalingen van de Rijkswet Koninkrijksgeschillen.").
article_property("10.2d", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.2d").

article("10.2f", "Hoofdstuk 6 van deze wet vervalt op een bij koninklijk besluit te bepalen tijdstip.").
article_property("10.2f", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.2f").

article("10.2g", "Artikel 10.2e vervalt.").
article_property("10.2g", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.2g").

article("10.3", "Deze wet treedt in werking op een bij koninklijk besluit te bepalen tijdstip.").
article_property("10.3", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.3").

article("10.4", "Deze wet wordt aangehaald als: Wet open overheid.").
article_property("10.4", "url", "https://wetten.overheid.nl/BWBR0045754/2025-02-12#Artikel10.4").

ee_literal("wet_open_overheid@2025-02-12/expression1/1", "Minister van Binnenlandse Zaken en Koninkrijksrelaties").
ee_literal("wet_open_overheid@2025-02-12/expression2/1", "Wet open overheid").
ee_literal("wet_open_overheid@2025-02-12/expression3/1", "Minister van Binnenlandse Zaken en Koninkrijksrelaties").
ee_reference("wet_open_overheid@2025-02-12/expression4/3", "is_verdaagd").
ee_literal("wet_open_overheid@2025-02-12/expression4/4", true).
ee_arguments("wet_open_overheid@2025-02-12/expression4/2", ["wet_open_overheid@2025-02-12/expression4/3", "wet_open_overheid@2025-02-12/expression4/4"]).
ee_primitive("wet_open_overheid@2025-02-12/expression4/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("wet_open_overheid@2025-02-12/expression4/5", decimal(6, 0)).
ee_literal("wet_open_overheid@2025-02-12/expression4/6", decimal(4, 0)).
ee_conditional("wet_open_overheid@2025-02-12/expression4/1", [case("wet_open_overheid@2025-02-12/expression4/2", "wet_open_overheid@2025-02-12/expression4/5")], "wet_open_overheid@2025-02-12/expression4/6").
ee_reference("wet_open_overheid@2025-02-12/expression5/2", "verzoek_ontvangst_datum").
ee_literal("wet_open_overheid@2025-02-12/expression5/3", decimal(0, 0)).
ee_literal("wet_open_overheid@2025-02-12/expression5/4", decimal(0, 0)).
ee_reference("wet_open_overheid@2025-02-12/expression5/5", "beslistermijn_weken").
ee_reference("wet_open_overheid@2025-02-12/expression5/6", "opschorting_dagen").
ee_arguments("wet_open_overheid@2025-02-12/expression5/1", ["wet_open_overheid@2025-02-12/expression5/2", "wet_open_overheid@2025-02-12/expression5/3", "wet_open_overheid@2025-02-12/expression5/4", "wet_open_overheid@2025-02-12/expression5/5", "wet_open_overheid@2025-02-12/expression5/6"]).
ee_primitive("wet_open_overheid@2025-02-12/expression5/1", "DATE_ADD", record([field("operation", "DATE_ADD"), field("shape", [record([field("field", "date"), field("count", null)]), record([field("field", "years"), field("count", null)]), record([field("field", "months"), field("count", null)]), record([field("field", "weeks"), field("count", null)]), record([field("field", "days"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_ADD")])), field("missingValue", true)])).
ee_reference("wet_open_overheid@2025-02-12/expression6/3", "heeft_derde_belanghebbende").
ee_literal("wet_open_overheid@2025-02-12/expression6/4", true).
ee_arguments("wet_open_overheid@2025-02-12/expression6/2", ["wet_open_overheid@2025-02-12/expression6/3", "wet_open_overheid@2025-02-12/expression6/4"]).
ee_primitive("wet_open_overheid@2025-02-12/expression6/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_open_overheid@2025-02-12/expression6/6", "uiterste_beslisdatum").
ee_literal("wet_open_overheid@2025-02-12/expression6/7", decimal(0, 0)).
ee_literal("wet_open_overheid@2025-02-12/expression6/8", decimal(0, 0)).
ee_literal("wet_open_overheid@2025-02-12/expression6/9", decimal(2, 0)).
ee_literal("wet_open_overheid@2025-02-12/expression6/10", decimal(0, 0)).
ee_arguments("wet_open_overheid@2025-02-12/expression6/5", ["wet_open_overheid@2025-02-12/expression6/6", "wet_open_overheid@2025-02-12/expression6/7", "wet_open_overheid@2025-02-12/expression6/8", "wet_open_overheid@2025-02-12/expression6/9", "wet_open_overheid@2025-02-12/expression6/10"]).
ee_primitive("wet_open_overheid@2025-02-12/expression6/5", "DATE_ADD", record([field("operation", "DATE_ADD"), field("shape", [record([field("field", "date"), field("count", null)]), record([field("field", "years"), field("count", null)]), record([field("field", "months"), field("count", null)]), record([field("field", "weeks"), field("count", null)]), record([field("field", "days"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_ADD")])), field("missingValue", true)])).
ee_reference("wet_open_overheid@2025-02-12/expression6/11", "uiterste_beslisdatum").
ee_conditional("wet_open_overheid@2025-02-12/expression6/1", [case("wet_open_overheid@2025-02-12/expression6/2", "wet_open_overheid@2025-02-12/expression6/5")], "wet_open_overheid@2025-02-12/expression6/11").
ee_reference("wet_open_overheid@2025-02-12/expression7/3", "is_milieu_informatie").
ee_reference("wet_open_overheid@2025-02-12/expression7/4", "betreft_emissies").
ee_logical("wet_open_overheid@2025-02-12/expression7/2", "AND", ["wet_open_overheid@2025-02-12/expression7/3", "wet_open_overheid@2025-02-12/expression7/4"]).
ee_literal("wet_open_overheid@2025-02-12/expression7/5", false).
ee_reference("wet_open_overheid@2025-02-12/expression7/7", "raakt_eenheid_kroon").
ee_reference("wet_open_overheid@2025-02-12/expression7/8", "raakt_veiligheid_staat").
ee_reference("wet_open_overheid@2025-02-12/expression7/10", "is_milieu_informatie").
ee_reference("wet_open_overheid@2025-02-12/expression7/12", "bevat_vertrouwelijke_bedrijfsgegevens").
ee_reference("wet_open_overheid@2025-02-12/expression7/13", "bedrijfsgegevens_ernstig_geschaad").
ee_reference("wet_open_overheid@2025-02-12/expression7/15", "milieu_belang_openbaarheid_weegt_op").
ee_arguments("wet_open_overheid@2025-02-12/expression7/14", ["wet_open_overheid@2025-02-12/expression7/15"]).
ee_primitive("wet_open_overheid@2025-02-12/expression7/14", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("wet_open_overheid@2025-02-12/expression7/11", "AND", ["wet_open_overheid@2025-02-12/expression7/12", "wet_open_overheid@2025-02-12/expression7/13", "wet_open_overheid@2025-02-12/expression7/14"]).
ee_reference("wet_open_overheid@2025-02-12/expression7/16", "bevat_vertrouwelijke_bedrijfsgegevens").
ee_conditional("wet_open_overheid@2025-02-12/expression7/9", [case("wet_open_overheid@2025-02-12/expression7/10", "wet_open_overheid@2025-02-12/expression7/11")], "wet_open_overheid@2025-02-12/expression7/16").
ee_reference("wet_open_overheid@2025-02-12/expression7/18", "bevat_bijzondere_persoonsgegevens").
ee_reference("wet_open_overheid@2025-02-12/expression7/22", "betrokkene_heeft_toestemming").
ee_literal("wet_open_overheid@2025-02-12/expression7/23", true).
ee_arguments("wet_open_overheid@2025-02-12/expression7/21", ["wet_open_overheid@2025-02-12/expression7/22", "wet_open_overheid@2025-02-12/expression7/23"]).
ee_primitive("wet_open_overheid@2025-02-12/expression7/21", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("wet_open_overheid@2025-02-12/expression7/25", "persoonsgegevens_kennelijk_openbaar_gemaakt").
ee_literal("wet_open_overheid@2025-02-12/expression7/26", true).
ee_arguments("wet_open_overheid@2025-02-12/expression7/24", ["wet_open_overheid@2025-02-12/expression7/25", "wet_open_overheid@2025-02-12/expression7/26"]).
ee_primitive("wet_open_overheid@2025-02-12/expression7/24", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("wet_open_overheid@2025-02-12/expression7/20", "OR", ["wet_open_overheid@2025-02-12/expression7/21", "wet_open_overheid@2025-02-12/expression7/24"]).
ee_arguments("wet_open_overheid@2025-02-12/expression7/19", ["wet_open_overheid@2025-02-12/expression7/20"]).
ee_primitive("wet_open_overheid@2025-02-12/expression7/19", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("wet_open_overheid@2025-02-12/expression7/17", "AND", ["wet_open_overheid@2025-02-12/expression7/18", "wet_open_overheid@2025-02-12/expression7/19"]).
ee_reference("wet_open_overheid@2025-02-12/expression7/28", "bevat_identificatienummers").
ee_reference("wet_open_overheid@2025-02-12/expression7/31", "verstrekking_geen_inbreuk_levenssfeer").
ee_literal("wet_open_overheid@2025-02-12/expression7/32", true).
ee_arguments("wet_open_overheid@2025-02-12/expression7/30", ["wet_open_overheid@2025-02-12/expression7/31", "wet_open_overheid@2025-02-12/expression7/32"]).
ee_primitive("wet_open_overheid@2025-02-12/expression7/30", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("wet_open_overheid@2025-02-12/expression7/29", ["wet_open_overheid@2025-02-12/expression7/30"]).
ee_primitive("wet_open_overheid@2025-02-12/expression7/29", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("wet_open_overheid@2025-02-12/expression7/27", "AND", ["wet_open_overheid@2025-02-12/expression7/28", "wet_open_overheid@2025-02-12/expression7/29"]).
ee_logical("wet_open_overheid@2025-02-12/expression7/6", "OR", ["wet_open_overheid@2025-02-12/expression7/7", "wet_open_overheid@2025-02-12/expression7/8", "wet_open_overheid@2025-02-12/expression7/9", "wet_open_overheid@2025-02-12/expression7/17", "wet_open_overheid@2025-02-12/expression7/27"]).
ee_conditional("wet_open_overheid@2025-02-12/expression7/1", [case("wet_open_overheid@2025-02-12/expression7/2", "wet_open_overheid@2025-02-12/expression7/5")], "wet_open_overheid@2025-02-12/expression7/6").
ee_reference("wet_open_overheid@2025-02-12/expression8/3", "is_milieu_informatie").
ee_reference("wet_open_overheid@2025-02-12/expression8/4", "betreft_emissies").
ee_logical("wet_open_overheid@2025-02-12/expression8/2", "AND", ["wet_open_overheid@2025-02-12/expression8/3", "wet_open_overheid@2025-02-12/expression8/4"]).
ee_literal("wet_open_overheid@2025-02-12/expression8/5", false).
ee_reference("wet_open_overheid@2025-02-12/expression8/8", "belang_openbaarheid_weegt_zwaarder").
ee_arguments("wet_open_overheid@2025-02-12/expression8/7", ["wet_open_overheid@2025-02-12/expression8/8"]).
ee_primitive("wet_open_overheid@2025-02-12/expression8/7", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("wet_open_overheid@2025-02-12/expression8/10", "raakt_internationale_betrekkingen").
ee_reference("wet_open_overheid@2025-02-12/expression8/11", "raakt_economische_belangen").
ee_reference("wet_open_overheid@2025-02-12/expression8/12", "raakt_opsporing_vervolging").
ee_reference("wet_open_overheid@2025-02-12/expression8/13", "raakt_inspectie_toezicht").
ee_reference("wet_open_overheid@2025-02-12/expression8/14", "raakt_persoonlijke_levenssfeer").
ee_reference("wet_open_overheid@2025-02-12/expression8/15", "raakt_concurrentiegevoelige_gegevens").
ee_reference("wet_open_overheid@2025-02-12/expression8/16", "raakt_milieubescherming").
ee_reference("wet_open_overheid@2025-02-12/expression8/17", "raakt_beveiliging_personen").
ee_reference("wet_open_overheid@2025-02-12/expression8/18", "raakt_goed_functioneren_staat").
ee_logical("wet_open_overheid@2025-02-12/expression8/9", "OR", ["wet_open_overheid@2025-02-12/expression8/10", "wet_open_overheid@2025-02-12/expression8/11", "wet_open_overheid@2025-02-12/expression8/12", "wet_open_overheid@2025-02-12/expression8/13", "wet_open_overheid@2025-02-12/expression8/14", "wet_open_overheid@2025-02-12/expression8/15", "wet_open_overheid@2025-02-12/expression8/16", "wet_open_overheid@2025-02-12/expression8/17", "wet_open_overheid@2025-02-12/expression8/18"]).
ee_logical("wet_open_overheid@2025-02-12/expression8/6", "AND", ["wet_open_overheid@2025-02-12/expression8/7", "wet_open_overheid@2025-02-12/expression8/9"]).
ee_conditional("wet_open_overheid@2025-02-12/expression8/1", [case("wet_open_overheid@2025-02-12/expression8/2", "wet_open_overheid@2025-02-12/expression8/5")], "wet_open_overheid@2025-02-12/expression8/6").
ee_reference("wet_open_overheid@2025-02-12/expression9/3", "is_milieu_informatie").
ee_arguments("wet_open_overheid@2025-02-12/expression9/2", ["wet_open_overheid@2025-02-12/expression9/3"]).
ee_primitive("wet_open_overheid@2025-02-12/expression9/2", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("wet_open_overheid@2025-02-12/expression9/4", "onevenredige_benadeling_ander_belang").
ee_logical("wet_open_overheid@2025-02-12/expression9/1", "AND", ["wet_open_overheid@2025-02-12/expression9/2", "wet_open_overheid@2025-02-12/expression9/4"]).
ee_reference("wet_open_overheid@2025-02-12/expression10/3", "heeft_absolute_weigeringsgrond").
ee_arguments("wet_open_overheid@2025-02-12/expression10/2", ["wet_open_overheid@2025-02-12/expression10/3"]).
ee_primitive("wet_open_overheid@2025-02-12/expression10/2", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("wet_open_overheid@2025-02-12/expression10/5", "heeft_relatieve_weigeringsgrond").
ee_arguments("wet_open_overheid@2025-02-12/expression10/4", ["wet_open_overheid@2025-02-12/expression10/5"]).
ee_primitive("wet_open_overheid@2025-02-12/expression10/4", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("wet_open_overheid@2025-02-12/expression10/7", "heeft_lid5_weigeringsgrond").
ee_arguments("wet_open_overheid@2025-02-12/expression10/6", ["wet_open_overheid@2025-02-12/expression10/7"]).
ee_primitive("wet_open_overheid@2025-02-12/expression10/6", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("wet_open_overheid@2025-02-12/expression10/1", "AND", ["wet_open_overheid@2025-02-12/expression10/2", "wet_open_overheid@2025-02-12/expression10/4", "wet_open_overheid@2025-02-12/expression10/6"]).
ee_reference("wet_open_overheid@2025-02-12/expression11/2", "informatie_datum").
ee_reference("wet_open_overheid@2025-02-12/expression11/3", "peildatum").
ee_arguments("wet_open_overheid@2025-02-12/expression11/1", ["wet_open_overheid@2025-02-12/expression11/2", "wet_open_overheid@2025-02-12/expression11/3"]).
ee_primitive("wet_open_overheid@2025-02-12/expression11/1", "AGE", record([field("operation", "AGE"), field("shape", [record([field("field", "date_of_birth"), field("count", null)]), record([field("field", "reference_date"), field("count", null)])]), field("staticFields", record([field("operation", "AGE")])), field("missingValue", true)])).
ee_reference("wet_open_overheid@2025-02-12/expression12/2", "informatie_leeftijd_jaren").
ee_literal("wet_open_overheid@2025-02-12/expression12/3", decimal(5, 0)).
ee_arguments("wet_open_overheid@2025-02-12/expression12/1", ["wet_open_overheid@2025-02-12/expression12/2", "wet_open_overheid@2025-02-12/expression12/3"]).
ee_primitive("wet_open_overheid@2025-02-12/expression12/1", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_literal("wet_open_overheid@2025-02-12/expression13/1", false).
