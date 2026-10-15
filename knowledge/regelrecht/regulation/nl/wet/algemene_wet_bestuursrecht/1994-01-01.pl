% algemene_wet_bestuursrecht, in force from 1994-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("algemene_wet_bestuursrecht").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.8.0/schema/v0.8.0/schema.json").
law_property("regulatory_layer", "WET").
law_property("publication_date", "2026-01-01").
law_property("valid_from", "1994-01-01").
law_property("name", "Algemene wet bestuursrecht").
law_property("bwb_id", "BWBR0005537").
law_property("url", "https://wetten.overheid.nl/BWBR0005537/2024-01-01").
law_property("procedure", [
  record([
    field("id", "beschikking"),
    field("default", true),
    field("applies_to", record([
      field("legal_character", "BESCHIKKING")
    ])),
    field("stages", [
      record([
        field("name", "AANVRAAG"),
        field("description", "Belanghebbende dient aanvraag in (AWB 4:1)"),
        field("requires", [
          record([
            field("name", "aanvraag_datum"),
            field("type", "date")
          ])
        ])
      ]),
      record([
        field("name", "BEHANDELING"),
        field("description", "Bestuursorgaan onderzoekt de aanvraag (AWB 3:2)"),
        field("requires", [
          record([
            field("name", "beslistermijn_start"),
            field("type", "date")
          ])
        ])
      ]),
      record([
        field("name", "BESLUIT"),
        field("description", "Bestuursorgaan neemt besluit (AWB 1:3)"),
        field("requires", [
          record([
            field("name", "besluit_datum"),
            field("type", "date")
          ])
        ])
      ]),
      record([
        field("name", "BEKENDMAKING"),
        field("description", "Besluit wordt bekendgemaakt (AWB 3:41)"),
        field("requires", [
          record([
            field("name", "bekendmaking_datum"),
            field("type", "date")
          ])
        ])
      ]),
      record([
        field("name", "BEZWAAR"),
        field("description", "Bezwaarperiode (AWB 6:4 e.v.)")
      ])
    ])
  ])
]).
article("3:46", "Een besluit dient te berusten op een deugdelijke motivering.").
article_property("3:46", "url", "https://wetten.overheid.nl/BWBR0005537/2024-01-01#Artikel3:46").
article_rule("3:46", "hooks", [
  record([
    field("hook_point", "pre_actions"),
    field("applies_to", record([
      field("legal_character", "BESCHIKKING"),
      field("stage", "BESLUIT")
    ]))
  ])
]).
execution_property("3:46", "output", [
  record([
    field("name", "motivering_vereist"),
    field("type", "boolean")
  ])
]).
execution_property("3:46", "actions", [
  record([
    field("output", "motivering_vereist"),
    field("value", expression("algemene_wet_bestuursrecht@1994-01-01/expression1/1"))
  ])
]).

article("4:2", "1. De aanvraag wordt ondertekend en bevat ten minste:\na. de naam en het adres van de aanvrager;\nb. de dagtekening;\nc. een aanduiding van de beschikking die wordt gevraagd.\n2. De aanvrager verschaft voorts de gegevens en bescheiden die voor de\nbeslissing op de aanvraag nodig zijn en waarover hij redelijkerwijs de\nbeschikking kan krijgen.").
article_property("4:2", "url", "https://wetten.overheid.nl/BWBR0005537/2024-01-01#Artikel4:2").
article_rule("4:2", "hooks", [
  record([
    field("hook_point", "pre_actions"),
    field("applies_to", record([
      field("submission", "AANVRAAG")
    ]))
  ])
]).
execution_property("4:2", "parameters", [
  record([
    field("name", "aanvraag_ondertekend"),
    field("type", "boolean"),
    field("nullable", true),
    field("required", false),
    field("description", "Of de aanvraag is ondertekend (lid 1, aanhef).")
  ]),
  record([
    field("name", "naam_aanvrager"),
    field("type", "string"),
    field("nullable", true),
    field("required", false),
    field("description", "De naam van de aanvrager (lid 1, onder a).")
  ]),
  record([
    field("name", "adres_aanvrager"),
    field("type", "string"),
    field("nullable", true),
    field("required", false),
    field("description", "Het adres van de aanvrager (lid 1, onder a).")
  ]),
  record([
    field("name", "dagtekening"),
    field("type", "date"),
    field("nullable", true),
    field("required", false),
    field("description", "De dagtekening van de aanvraag (lid 1, onder b).")
  ]),
  record([
    field("name", "gevraagde_beschikking"),
    field("type", "string"),
    field("nullable", true),
    field("required", false),
    field("description", "Een aanduiding van de beschikking die wordt gevraagd (lid 1, onder c).")
  ])
]).
execution_property("4:2", "output", [
  record([
    field("name", "aanvraag_bevat_wat_artikel_4_2_eist"),
    field("type", "boolean"),
    field("description", "Of de aanvraag is ondertekend en ten minste de gegevens van lid 1 bevat.")
  ])
]).
execution_property("4:2", "actions", [
  record([
    field("output", "aanvraag_bevat_wat_artikel_4_2_eist"),
    field("value", expression("algemene_wet_bestuursrecht@1994-01-01/expression2/1"))
  ])
]).

article("4:13", "1. Een beschikking dient te worden gegeven binnen de bij wettelijk\nvoorschrift bepaalde termijn of, bij het ontbreken van zulk een termijn,\nbinnen een redelijke termijn na ontvangst van de aanvraag.\n2. De in het eerste lid bedoelde redelijke termijn is in ieder geval\nverstreken wanneer het bestuursorgaan binnen acht weken na ontvangst van\nde aanvraag geen beschikking heeft gegeven, noch een mededeling als\nbedoeld in artikel 4:14, derde lid, heeft gedaan.").
article_property("4:13", "url", "https://wetten.overheid.nl/BWBR0005537/2024-01-01#Artikel4:13").
article_rule("4:13", "hooks", [
  record([
    field("hook_point", "post_actions"),
    field("applies_to", record([
      field("submission", "AANVRAAG")
    ]))
  ])
]).
execution_property("4:13", "produces", record([
  field("moment", record([
    field("parameter", "datum_ontvangst"),
    field("legal_basis", record([
      field("law", "Algemene wet bestuursrecht"),
      field("bwb_id", "BWBR0005537"),
      field("article", "4:13"),
      field("paragraph", "1"),
      field("url", "https://wetten.overheid.nl/BWBR0005537/2024-01-01#Artikel4:13"),
      field("juriconnect", "jci1.3:c:BWBR0005537&artikel=4:13&lid=1&z=2024-01-01&g=2024-01-01")
    ]))
  ]))
])).
execution_property("4:13", "parameters", [
  record([
    field("name", "datum_ontvangst"),
    field("type", "date"),
    field("required", false),
    field("description", "De dag waarop het bestuursorgaan de aanvraag ontving (lid 1).")
  ])
]).
execution_property("4:13", "output", [
  record([
    field("name", "redelijke_beslistermijn_einddatum"),
    field("type", "date"),
    field("description", "De laatste dag van de redelijke termijn van lid 1 voor zover lid 2 die begrenst: acht weken na ontvangst. De dag erna is de termijn in ieder geval verstreken.")
  ])
]).
execution_property("4:13", "actions", [
  record([
    field("output", "redelijke_beslistermijn_einddatum"),
    field("value", expression("algemene_wet_bestuursrecht@1994-01-01/expression3/1"))
  ])
]).

article("6:7", "De termijn voor het indienen van een bezwaar- of\nberoepschrift bedraagt zes weken.").
article_property("6:7", "url", "https://wetten.overheid.nl/BWBR0005537/2024-01-01#Artikel6:7").
article_rule("6:7", "hooks", [
  record([
    field("hook_point", "post_actions"),
    field("applies_to", record([
      field("legal_character", "BESCHIKKING"),
      field("stage", "BESLUIT")
    ]))
  ])
]).
execution_property("6:7", "output", [
  record([
    field("name", "bezwaartermijn_weken"),
    field("type", "number")
  ])
]).
execution_property("6:7", "actions", [
  record([
    field("output", "bezwaartermijn_weken"),
    field("value", expression("algemene_wet_bestuursrecht@1994-01-01/expression4/1"))
  ])
]).

article("6:8", "1. De termijn vangt aan met ingang van de dag na die\nwaarop het besluit op de voorgeschreven wijze is\nbekendgemaakt.").
article_property("6:8", "url", "https://wetten.overheid.nl/BWBR0005537/2024-01-01#Artikel6:8").
article_rule("6:8", "hooks", [
  record([
    field("hook_point", "post_actions"),
    field("applies_to", record([
      field("legal_character", "BESCHIKKING"),
      field("stage", "BEKENDMAKING")
    ]))
  ])
]).
execution_property("6:8", "parameters", [
  record([
    field("name", "bekendmaking_datum"),
    field("type", "date"),
    field("required", true),
    field("description", "Datum waarop het besluit is bekendgemaakt")
  ])
]).
execution_property("6:8", "input", [
  record([
    field("name", "bezwaartermijn_weken"),
    field("type", "number"),
    field("source", record([
      field("regulation", "algemene_wet_bestuursrecht"),
      field("output", "bezwaartermijn_weken")
    ]))
  ])
]).
execution_property("6:8", "output", [
  record([
    field("name", "bezwaartermijn_startdatum"),
    field("type", "date")
  ]),
  record([
    field("name", "bezwaartermijn_einddatum"),
    field("type", "date")
  ])
]).
execution_property("6:8", "actions", [
  record([
    field("output", "bezwaartermijn_startdatum"),
    field("value", expression("algemene_wet_bestuursrecht@1994-01-01/expression5/1"))
  ]),
  record([
    field("output", "bezwaartermijn_einddatum"),
    field("value", expression("algemene_wet_bestuursrecht@1994-01-01/expression6/1"))
  ])
]).

ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression1/1", true).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression2/3", "aanvraag_ondertekend").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression2/4", true).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/2", ["algemene_wet_bestuursrecht@1994-01-01/expression2/3", "algemene_wet_bestuursrecht@1994-01-01/expression2/4"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression2/7", "naam_aanvrager").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression2/8", null).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/6", ["algemene_wet_bestuursrecht@1994-01-01/expression2/7", "algemene_wet_bestuursrecht@1994-01-01/expression2/8"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/5", ["algemene_wet_bestuursrecht@1994-01-01/expression2/6"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/5", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression2/11", "adres_aanvrager").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression2/12", null).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/10", ["algemene_wet_bestuursrecht@1994-01-01/expression2/11", "algemene_wet_bestuursrecht@1994-01-01/expression2/12"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/10", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/9", ["algemene_wet_bestuursrecht@1994-01-01/expression2/10"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/9", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression2/15", "dagtekening").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression2/16", null).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/14", ["algemene_wet_bestuursrecht@1994-01-01/expression2/15", "algemene_wet_bestuursrecht@1994-01-01/expression2/16"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/14", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/13", ["algemene_wet_bestuursrecht@1994-01-01/expression2/14"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/13", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression2/19", "gevraagde_beschikking").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression2/20", null).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/18", ["algemene_wet_bestuursrecht@1994-01-01/expression2/19", "algemene_wet_bestuursrecht@1994-01-01/expression2/20"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/18", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression2/17", ["algemene_wet_bestuursrecht@1994-01-01/expression2/18"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression2/17", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("algemene_wet_bestuursrecht@1994-01-01/expression2/1", "AND", ["algemene_wet_bestuursrecht@1994-01-01/expression2/2", "algemene_wet_bestuursrecht@1994-01-01/expression2/5", "algemene_wet_bestuursrecht@1994-01-01/expression2/9", "algemene_wet_bestuursrecht@1994-01-01/expression2/13", "algemene_wet_bestuursrecht@1994-01-01/expression2/17"]).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression3/2", "datum_ontvangst").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression3/3", decimal(0, 0)).
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression3/4", decimal(0, 0)).
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression3/5", decimal(8, 0)).
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression3/6", decimal(0, 0)).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression3/1", ["algemene_wet_bestuursrecht@1994-01-01/expression3/2", "algemene_wet_bestuursrecht@1994-01-01/expression3/3", "algemene_wet_bestuursrecht@1994-01-01/expression3/4", "algemene_wet_bestuursrecht@1994-01-01/expression3/5", "algemene_wet_bestuursrecht@1994-01-01/expression3/6"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression3/1", "DATE_ADD", record([field("operation", "DATE_ADD"), field("shape", [record([field("field", "date"), field("count", null)]), record([field("field", "years"), field("count", null)]), record([field("field", "months"), field("count", null)]), record([field("field", "weeks"), field("count", null)]), record([field("field", "days"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_ADD")])), field("missingValue", true)])).
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression4/1", decimal(6, 0)).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression5/2", "bekendmaking_datum").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression5/3", decimal(0, 0)).
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression5/4", decimal(0, 0)).
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression5/5", decimal(0, 0)).
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression5/6", decimal(1, 0)).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression5/1", ["algemene_wet_bestuursrecht@1994-01-01/expression5/2", "algemene_wet_bestuursrecht@1994-01-01/expression5/3", "algemene_wet_bestuursrecht@1994-01-01/expression5/4", "algemene_wet_bestuursrecht@1994-01-01/expression5/5", "algemene_wet_bestuursrecht@1994-01-01/expression5/6"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression5/1", "DATE_ADD", record([field("operation", "DATE_ADD"), field("shape", [record([field("field", "date"), field("count", null)]), record([field("field", "years"), field("count", null)]), record([field("field", "months"), field("count", null)]), record([field("field", "weeks"), field("count", null)]), record([field("field", "days"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_ADD")])), field("missingValue", true)])).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression6/2", "bekendmaking_datum").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression6/3", decimal(0, 0)).
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression6/4", decimal(0, 0)).
ee_reference("algemene_wet_bestuursrecht@1994-01-01/expression6/5", "bezwaartermijn_weken").
ee_literal("algemene_wet_bestuursrecht@1994-01-01/expression6/6", decimal(0, 0)).
ee_arguments("algemene_wet_bestuursrecht@1994-01-01/expression6/1", ["algemene_wet_bestuursrecht@1994-01-01/expression6/2", "algemene_wet_bestuursrecht@1994-01-01/expression6/3", "algemene_wet_bestuursrecht@1994-01-01/expression6/4", "algemene_wet_bestuursrecht@1994-01-01/expression6/5", "algemene_wet_bestuursrecht@1994-01-01/expression6/6"]).
ee_primitive("algemene_wet_bestuursrecht@1994-01-01/expression6/1", "DATE_ADD", record([field("operation", "DATE_ADD"), field("shape", [record([field("field", "date"), field("count", null)]), record([field("field", "years"), field("count", null)]), record([field("field", "months"), field("count", null)]), record([field("field", "weeks"), field("count", null)]), record([field("field", "days"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_ADD")])), field("missingValue", true)])).
