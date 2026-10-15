% test_null_semantics, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_null_semantics").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.8/schema/v0.5.8/schema.json").
law_property("name", "Testwet afwezig en onbekend").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999910").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_null_semantics").
article("1", "De huur is hoog indien zij meer dan vijfhonderd bedraagt. De verhoogde huur is de huur vermeerderd met honderd. De huurklasse is hoog indien de huur hoog is en anders laag. De huur wordt vergeleken met de huur van de partner; de huur en het burgerservicenummer van de partner worden als opsomming vergeleken.").
article_property("1", "url", "https://example.com/test_null_semantics/1").
execution_property("1", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("1", "input", [
  record([
    field("name", "huur"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "partner_huur"),
    field("type", "number"),
    field("source", record([]))
  ]),
  record([
    field("name", "partner_bsn"),
    field("type", "string"),
    field("source", record([]))
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "huur_hoog"),
    field("type", "boolean")
  ]),
  record([
    field("name", "verhoogde_huur"),
    field("type", "number")
  ]),
  record([
    field("name", "niet_hoog"),
    field("type", "boolean")
  ]),
  record([
    field("name", "huurklasse"),
    field("type", "string")
  ]),
  record([
    field("name", "hoog_en_bekend"),
    field("type", "boolean")
  ]),
  record([
    field("name", "hoog_en_onwaar"),
    field("type", "boolean")
  ]),
  record([
    field("name", "hoog_of_onbekend"),
    field("type", "boolean")
  ]),
  record([
    field("name", "hoog_of_waar"),
    field("type", "boolean")
  ]),
  record([
    field("name", "huur_gelijk_aan_partner"),
    field("type", "boolean")
  ]),
  record([
    field("name", "lijsten_gelijk"),
    field("type", "boolean")
  ]),
  record([
    field("name", "lijst_in_lijsten"),
    field("type", "boolean")
  ]),
  record([
    field("name", "verzamelingen_gelijk"),
    field("type", "boolean")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "huur_hoog"),
    field("value", expression("test_null_semantics@2025-01-01/expression1/1"))
  ]),
  record([
    field("output", "verhoogde_huur"),
    field("value", expression("test_null_semantics@2025-01-01/expression2/1"))
  ]),
  record([
    field("output", "niet_hoog"),
    field("value", expression("test_null_semantics@2025-01-01/expression3/1"))
  ]),
  record([
    field("output", "huurklasse"),
    field("value", expression("test_null_semantics@2025-01-01/expression4/1"))
  ]),
  record([
    field("output", "hoog_en_bekend"),
    field("value", expression("test_null_semantics@2025-01-01/expression5/1"))
  ]),
  record([
    field("output", "hoog_en_onwaar"),
    field("value", expression("test_null_semantics@2025-01-01/expression6/1"))
  ]),
  record([
    field("output", "hoog_of_onbekend"),
    field("value", expression("test_null_semantics@2025-01-01/expression7/1"))
  ]),
  record([
    field("output", "hoog_of_waar"),
    field("value", expression("test_null_semantics@2025-01-01/expression8/1"))
  ]),
  record([
    field("output", "huur_gelijk_aan_partner"),
    field("value", expression("test_null_semantics@2025-01-01/expression9/1"))
  ]),
  record([
    field("output", "lijsten_gelijk"),
    field("value", expression("test_null_semantics@2025-01-01/expression10/1"))
  ]),
  record([
    field("output", "lijst_in_lijsten"),
    field("value", expression("test_null_semantics@2025-01-01/expression11/1"))
  ]),
  record([
    field("output", "verzamelingen_gelijk"),
    field("value", expression("test_null_semantics@2025-01-01/expression12/1"))
  ])
]).

article("2", "Van huur is geen sprake indien in de registratie geen huur is opgenomen. De status is de status van de beschikking. Het geboortejaar van de partner is het geboortejaar, bedoeld in artikel 1 van de Testwet afwezig en onbekend (bron), van de partner.").
article_property("2", "url", "https://example.com/test_null_semantics/2").
execution_property("2", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("2", "input", [
  record([
    field("name", "huur"),
    field("type", "number"),
    field("nullable", true),
    field("source", record([]))
  ]),
  record([
    field("name", "partner_bsn"),
    field("type", "string"),
    field("nullable", true),
    field("source", record([]))
  ]),
  record([
    field("name", "beschikking"),
    field("type", "object"),
    field("nullable", true),
    field("source", record([]))
  ]),
  record([
    field("name", "partner_geboortejaar"),
    field("type", "number"),
    field("nullable", true),
    field("source", record([
      field("regulation", "test_null_semantics_bron"),
      field("output", "geboortejaar"),
      field("parameters", record([
        field("bsn", expression("test_null_semantics@2025-01-01/expression19/1"))
      ]))
    ]))
  ])
]).
execution_property("2", "output", [
  record([
    field("name", "huur_ontbreekt"),
    field("type", "boolean")
  ]),
  record([
    field("name", "heeft_huur"),
    field("type", "boolean")
  ]),
  record([
    field("name", "huur_hoog_veilig"),
    field("type", "boolean")
  ]),
  record([
    field("name", "huur_in_lijst"),
    field("type", "boolean")
  ]),
  record([
    field("name", "status"),
    field("type", "string"),
    field("nullable", true)
  ]),
  record([
    field("name", "partner_geboortejaar"),
    field("type", "number"),
    field("nullable", true)
  ])
]).
execution_property("2", "actions", [
  record([
    field("output", "huur_ontbreekt"),
    field("value", expression("test_null_semantics@2025-01-01/expression13/1"))
  ]),
  record([
    field("output", "heeft_huur"),
    field("value", expression("test_null_semantics@2025-01-01/expression14/1"))
  ]),
  record([
    field("output", "huur_hoog_veilig"),
    field("value", expression("test_null_semantics@2025-01-01/expression15/1"))
  ]),
  record([
    field("output", "huur_in_lijst"),
    field("value", expression("test_null_semantics@2025-01-01/expression16/1"))
  ]),
  record([
    field("output", "status"),
    field("value", expression("test_null_semantics@2025-01-01/expression17/1"))
  ]),
  record([
    field("output", "partner_geboortejaar"),
    field("value", expression("test_null_semantics@2025-01-01/expression18/1"))
  ])
]).

article("3", "Een verzekerde die bekend is, is verzekerd en bekend. Wie niet verzekerd is, is niet verzekerd. De verzekeringsklasse is ja voor een verzekerde en anders nee.").
article_property("3", "url", "https://example.com/test_null_semantics/3").
execution_property("3", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("3", "input", [
  record([
    field("name", "verzekerd"),
    field("type", "boolean"),
    field("source", record([]))
  ])
]).
execution_property("3", "output", [
  record([
    field("name", "verzekerd_en_waar"),
    field("type", "boolean")
  ]),
  record([
    field("name", "verzekerd_en_onwaar"),
    field("type", "boolean")
  ]),
  record([
    field("name", "verzekerd_of_waar"),
    field("type", "boolean")
  ]),
  record([
    field("name", "verzekerd_of_onwaar"),
    field("type", "boolean")
  ]),
  record([
    field("name", "niet_verzekerd"),
    field("type", "boolean")
  ]),
  record([
    field("name", "verzekeringsklasse"),
    field("type", "string")
  ])
]).
execution_property("3", "actions", [
  record([
    field("output", "verzekerd_en_waar"),
    field("value", expression("test_null_semantics@2025-01-01/expression20/1"))
  ]),
  record([
    field("output", "verzekerd_en_onwaar"),
    field("value", expression("test_null_semantics@2025-01-01/expression21/1"))
  ]),
  record([
    field("output", "verzekerd_of_waar"),
    field("value", expression("test_null_semantics@2025-01-01/expression22/1"))
  ]),
  record([
    field("output", "verzekerd_of_onwaar"),
    field("value", expression("test_null_semantics@2025-01-01/expression23/1"))
  ]),
  record([
    field("output", "niet_verzekerd"),
    field("value", expression("test_null_semantics@2025-01-01/expression24/1"))
  ]),
  record([
    field("output", "verzekeringsklasse"),
    field("value", expression("test_null_semantics@2025-01-01/expression25/1"))
  ])
]).

article("4", "Een aanvraag past indien het aangevraagde bedrag meer dan honderd bedraagt. Of de aanvraag past wordt tevens bepaald overeenkomstig artikel 1 van de Testwet afwezig en onbekend (bron).").
article_property("4", "url", "https://example.com/test_null_semantics/4").
execution_property("4", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ]),
  record([
    field("name", "aanvraag_bedrag"),
    field("type", "number"),
    field("required", false)
  ])
]).
execution_property("4", "input", [
  record([
    field("name", "bedrag"),
    field("type", "number"),
    field("nullable", true),
    field("source", record([]))
  ]),
  record([
    field("name", "aanvraag_past"),
    field("type", "boolean"),
    field("source", record([
      field("regulation", "test_null_semantics_bron"),
      field("output", "past_aanvraag"),
      field("parameters", record([
        field("bsn", expression("test_null_semantics@2025-01-01/expression30/1"))
      ]))
    ]))
  ]),
  record([
    field("name", "aanvraag_past_met_bedrag"),
    field("type", "boolean"),
    field("source", record([
      field("regulation", "test_null_semantics_bron"),
      field("output", "past_aanvraag"),
      field("parameters", record([
        field("bsn", expression("test_null_semantics@2025-01-01/expression31/1")),
        field("aanvraag_bedrag", expression("test_null_semantics@2025-01-01/expression32/1"))
      ]))
    ]))
  ]),
  record([
    field("name", "aanvraag_past_uit_register"),
    field("type", "boolean"),
    field("source", record([
      field("regulation", "test_null_semantics_bron"),
      field("output", "past_aanvraag"),
      field("parameters", record([
        field("bsn", expression("test_null_semantics@2025-01-01/expression33/1")),
        field("aanvraag_bedrag", expression("test_null_semantics@2025-01-01/expression34/1"))
      ]))
    ]))
  ])
]).
execution_property("4", "output", [
  record([
    field("name", "eigen_aanvraag_past"),
    field("type", "boolean")
  ]),
  record([
    field("name", "aanvraag_past"),
    field("type", "boolean")
  ]),
  record([
    field("name", "aanvraag_past_met_bedrag"),
    field("type", "boolean")
  ]),
  record([
    field("name", "aanvraag_past_uit_register"),
    field("type", "boolean")
  ])
]).
execution_property("4", "actions", [
  record([
    field("output", "eigen_aanvraag_past"),
    field("value", expression("test_null_semantics@2025-01-01/expression26/1"))
  ]),
  record([
    field("output", "aanvraag_past"),
    field("value", expression("test_null_semantics@2025-01-01/expression27/1"))
  ]),
  record([
    field("output", "aanvraag_past_met_bedrag"),
    field("value", expression("test_null_semantics@2025-01-01/expression28/1"))
  ]),
  record([
    field("output", "aanvraag_past_uit_register"),
    field("value", expression("test_null_semantics@2025-01-01/expression29/1"))
  ])
]).

article("5", "Het bedrag van de beschikking is hoog indien het meer dan honderd bedraagt. Het verhoogde bedrag is het bedrag vermeerderd met honderd. Wie niet actief is volgens de beschikking, is inactief; de beschikkingsklasse is actief voor een actieve beschikking en anders inactief.").
article_property("5", "url", "https://example.com/test_null_semantics/5").
execution_property("5", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("5", "input", [
  record([
    field("name", "beschikking"),
    field("type", "object"),
    field("source", record([]))
  ])
]).
execution_property("5", "output", [
  record([
    field("name", "bedrag_hoog"),
    field("type", "boolean")
  ]),
  record([
    field("name", "verhoogd_bedrag"),
    field("type", "number")
  ]),
  record([
    field("name", "inactief"),
    field("type", "boolean")
  ]),
  record([
    field("name", "beschikkingsklasse"),
    field("type", "string")
  ])
]).
execution_property("5", "actions", [
  record([
    field("output", "bedrag_hoog"),
    field("value", expression("test_null_semantics@2025-01-01/expression35/1"))
  ]),
  record([
    field("output", "verhoogd_bedrag"),
    field("value", expression("test_null_semantics@2025-01-01/expression36/1"))
  ]),
  record([
    field("output", "inactief"),
    field("value", expression("test_null_semantics@2025-01-01/expression37/1"))
  ]),
  record([
    field("output", "beschikkingsklasse"),
    field("value", expression("test_null_semantics@2025-01-01/expression38/1"))
  ])
]).

ee_reference("test_null_semantics@2025-01-01/expression1/2", "huur").
ee_literal("test_null_semantics@2025-01-01/expression1/3", decimal(500, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression1/1", ["test_null_semantics@2025-01-01/expression1/2", "test_null_semantics@2025-01-01/expression1/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression1/1", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression2/2", "huur").
ee_literal("test_null_semantics@2025-01-01/expression2/3", decimal(100, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression2/1", ["test_null_semantics@2025-01-01/expression2/2", "test_null_semantics@2025-01-01/expression2/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression2/1", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("test_null_semantics@2025-01-01/expression3/3", "huur").
ee_literal("test_null_semantics@2025-01-01/expression3/4", decimal(500, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression3/2", ["test_null_semantics@2025-01-01/expression3/3", "test_null_semantics@2025-01-01/expression3/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression3/2", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_arguments("test_null_semantics@2025-01-01/expression3/1", ["test_null_semantics@2025-01-01/expression3/2"]).
ee_primitive("test_null_semantics@2025-01-01/expression3/1", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression4/3", "huur").
ee_literal("test_null_semantics@2025-01-01/expression4/4", decimal(500, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression4/2", ["test_null_semantics@2025-01-01/expression4/3", "test_null_semantics@2025-01-01/expression4/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression4/2", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_literal("test_null_semantics@2025-01-01/expression4/5", "hoog").
ee_literal("test_null_semantics@2025-01-01/expression4/6", "laag").
ee_conditional("test_null_semantics@2025-01-01/expression4/1", [case("test_null_semantics@2025-01-01/expression4/2", "test_null_semantics@2025-01-01/expression4/5")], "test_null_semantics@2025-01-01/expression4/6").
ee_reference("test_null_semantics@2025-01-01/expression5/3", "huur").
ee_literal("test_null_semantics@2025-01-01/expression5/4", decimal(500, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression5/2", ["test_null_semantics@2025-01-01/expression5/3", "test_null_semantics@2025-01-01/expression5/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression5/2", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression5/6", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression5/7", "bsn").
ee_arguments("test_null_semantics@2025-01-01/expression5/5", ["test_null_semantics@2025-01-01/expression5/6", "test_null_semantics@2025-01-01/expression5/7"]).
ee_primitive("test_null_semantics@2025-01-01/expression5/5", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("test_null_semantics@2025-01-01/expression5/1", "AND", ["test_null_semantics@2025-01-01/expression5/2", "test_null_semantics@2025-01-01/expression5/5"]).
ee_reference("test_null_semantics@2025-01-01/expression6/3", "huur").
ee_literal("test_null_semantics@2025-01-01/expression6/4", decimal(500, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression6/2", ["test_null_semantics@2025-01-01/expression6/3", "test_null_semantics@2025-01-01/expression6/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression6/2", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression6/7", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression6/8", "bsn").
ee_arguments("test_null_semantics@2025-01-01/expression6/6", ["test_null_semantics@2025-01-01/expression6/7", "test_null_semantics@2025-01-01/expression6/8"]).
ee_primitive("test_null_semantics@2025-01-01/expression6/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("test_null_semantics@2025-01-01/expression6/5", ["test_null_semantics@2025-01-01/expression6/6"]).
ee_primitive("test_null_semantics@2025-01-01/expression6/5", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("test_null_semantics@2025-01-01/expression6/1", "AND", ["test_null_semantics@2025-01-01/expression6/2", "test_null_semantics@2025-01-01/expression6/5"]).
ee_reference("test_null_semantics@2025-01-01/expression7/3", "huur").
ee_literal("test_null_semantics@2025-01-01/expression7/4", decimal(500, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression7/2", ["test_null_semantics@2025-01-01/expression7/3", "test_null_semantics@2025-01-01/expression7/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression7/2", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression7/7", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression7/8", "bsn").
ee_arguments("test_null_semantics@2025-01-01/expression7/6", ["test_null_semantics@2025-01-01/expression7/7", "test_null_semantics@2025-01-01/expression7/8"]).
ee_primitive("test_null_semantics@2025-01-01/expression7/6", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("test_null_semantics@2025-01-01/expression7/5", ["test_null_semantics@2025-01-01/expression7/6"]).
ee_primitive("test_null_semantics@2025-01-01/expression7/5", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("test_null_semantics@2025-01-01/expression7/1", "OR", ["test_null_semantics@2025-01-01/expression7/2", "test_null_semantics@2025-01-01/expression7/5"]).
ee_reference("test_null_semantics@2025-01-01/expression8/3", "huur").
ee_literal("test_null_semantics@2025-01-01/expression8/4", decimal(500, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression8/2", ["test_null_semantics@2025-01-01/expression8/3", "test_null_semantics@2025-01-01/expression8/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression8/2", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression8/6", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression8/7", "bsn").
ee_arguments("test_null_semantics@2025-01-01/expression8/5", ["test_null_semantics@2025-01-01/expression8/6", "test_null_semantics@2025-01-01/expression8/7"]).
ee_primitive("test_null_semantics@2025-01-01/expression8/5", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("test_null_semantics@2025-01-01/expression8/1", "OR", ["test_null_semantics@2025-01-01/expression8/2", "test_null_semantics@2025-01-01/expression8/5"]).
ee_reference("test_null_semantics@2025-01-01/expression9/2", "huur").
ee_reference("test_null_semantics@2025-01-01/expression9/3", "partner_huur").
ee_arguments("test_null_semantics@2025-01-01/expression9/1", ["test_null_semantics@2025-01-01/expression9/2", "test_null_semantics@2025-01-01/expression9/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression9/1", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression10/3", "huur").
ee_arguments("test_null_semantics@2025-01-01/expression10/2", ["test_null_semantics@2025-01-01/expression10/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression10/2", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_reference("test_null_semantics@2025-01-01/expression10/5", "partner_bsn").
ee_arguments("test_null_semantics@2025-01-01/expression10/4", ["test_null_semantics@2025-01-01/expression10/5"]).
ee_primitive("test_null_semantics@2025-01-01/expression10/4", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_null_semantics@2025-01-01/expression10/1", ["test_null_semantics@2025-01-01/expression10/2", "test_null_semantics@2025-01-01/expression10/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression10/1", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression11/3", "huur").
ee_arguments("test_null_semantics@2025-01-01/expression11/2", ["test_null_semantics@2025-01-01/expression11/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression11/2", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_reference("test_null_semantics@2025-01-01/expression11/5", "partner_bsn").
ee_arguments("test_null_semantics@2025-01-01/expression11/4", ["test_null_semantics@2025-01-01/expression11/5"]).
ee_primitive("test_null_semantics@2025-01-01/expression11/4", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_null_semantics@2025-01-01/expression11/1", ["test_null_semantics@2025-01-01/expression11/2", "test_null_semantics@2025-01-01/expression11/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression11/1", "IN", record([field("operation", "IN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "values"), field("count", decimal(1, 0))])]), field("staticFields", record([field("operation", "IN")])), field("missingValue", true)])).
ee_literal("test_null_semantics@2025-01-01/expression12/4", decimal(1, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression12/3", ["test_null_semantics@2025-01-01/expression12/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression12/3", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_literal("test_null_semantics@2025-01-01/expression12/5", true).
ee_reference("test_null_semantics@2025-01-01/expression12/6", "huur").
ee_foreach("test_null_semantics@2025-01-01/expression12/2", "test_null_semantics@2025-01-01/expression12/3", "test_null_semantics@2025-01-01/expression12/5", "test_null_semantics@2025-01-01/expression12/6", "x", null).
ee_literal("test_null_semantics@2025-01-01/expression12/9", decimal(1, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression12/8", ["test_null_semantics@2025-01-01/expression12/9"]).
ee_primitive("test_null_semantics@2025-01-01/expression12/8", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_literal("test_null_semantics@2025-01-01/expression12/10", true).
ee_reference("test_null_semantics@2025-01-01/expression12/11", "partner_bsn").
ee_foreach("test_null_semantics@2025-01-01/expression12/7", "test_null_semantics@2025-01-01/expression12/8", "test_null_semantics@2025-01-01/expression12/10", "test_null_semantics@2025-01-01/expression12/11", "x", null).
ee_arguments("test_null_semantics@2025-01-01/expression12/1", ["test_null_semantics@2025-01-01/expression12/2", "test_null_semantics@2025-01-01/expression12/7"]).
ee_primitive("test_null_semantics@2025-01-01/expression12/1", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression13/2", "huur").
ee_literal("test_null_semantics@2025-01-01/expression13/3", null).
ee_arguments("test_null_semantics@2025-01-01/expression13/1", ["test_null_semantics@2025-01-01/expression13/2", "test_null_semantics@2025-01-01/expression13/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression13/1", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression14/3", "huur").
ee_literal("test_null_semantics@2025-01-01/expression14/4", null).
ee_arguments("test_null_semantics@2025-01-01/expression14/2", ["test_null_semantics@2025-01-01/expression14/3", "test_null_semantics@2025-01-01/expression14/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression14/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("test_null_semantics@2025-01-01/expression14/1", ["test_null_semantics@2025-01-01/expression14/2"]).
ee_primitive("test_null_semantics@2025-01-01/expression14/1", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression15/3", "huur").
ee_literal("test_null_semantics@2025-01-01/expression15/4", null).
ee_arguments("test_null_semantics@2025-01-01/expression15/2", ["test_null_semantics@2025-01-01/expression15/3", "test_null_semantics@2025-01-01/expression15/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression15/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("test_null_semantics@2025-01-01/expression15/5", false).
ee_reference("test_null_semantics@2025-01-01/expression15/7", "huur").
ee_literal("test_null_semantics@2025-01-01/expression15/8", decimal(500, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression15/6", ["test_null_semantics@2025-01-01/expression15/7", "test_null_semantics@2025-01-01/expression15/8"]).
ee_primitive("test_null_semantics@2025-01-01/expression15/6", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_conditional("test_null_semantics@2025-01-01/expression15/1", [case("test_null_semantics@2025-01-01/expression15/2", "test_null_semantics@2025-01-01/expression15/5")], "test_null_semantics@2025-01-01/expression15/6").
ee_reference("test_null_semantics@2025-01-01/expression16/2", "huur").
ee_literal("test_null_semantics@2025-01-01/expression16/3", decimal(650, 0)).
ee_literal("test_null_semantics@2025-01-01/expression16/4", decimal(700, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression16/1", ["test_null_semantics@2025-01-01/expression16/2", "test_null_semantics@2025-01-01/expression16/3", "test_null_semantics@2025-01-01/expression16/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression16/1", "IN", record([field("operation", "IN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "IN")])), field("missingValue", true)])).
ee_reference("test_null_semantics@2025-01-01/expression17/1", "beschikking.status").
ee_reference("test_null_semantics@2025-01-01/expression18/1", "partner_geboortejaar").
ee_reference("test_null_semantics@2025-01-01/expression19/1", "partner_bsn").
ee_reference("test_null_semantics@2025-01-01/expression20/2", "verzekerd").
ee_reference("test_null_semantics@2025-01-01/expression20/4", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression20/5", "bsn").
ee_arguments("test_null_semantics@2025-01-01/expression20/3", ["test_null_semantics@2025-01-01/expression20/4", "test_null_semantics@2025-01-01/expression20/5"]).
ee_primitive("test_null_semantics@2025-01-01/expression20/3", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("test_null_semantics@2025-01-01/expression20/1", "AND", ["test_null_semantics@2025-01-01/expression20/2", "test_null_semantics@2025-01-01/expression20/3"]).
ee_reference("test_null_semantics@2025-01-01/expression21/2", "verzekerd").
ee_reference("test_null_semantics@2025-01-01/expression21/5", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression21/6", "bsn").
ee_arguments("test_null_semantics@2025-01-01/expression21/4", ["test_null_semantics@2025-01-01/expression21/5", "test_null_semantics@2025-01-01/expression21/6"]).
ee_primitive("test_null_semantics@2025-01-01/expression21/4", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("test_null_semantics@2025-01-01/expression21/3", ["test_null_semantics@2025-01-01/expression21/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression21/3", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("test_null_semantics@2025-01-01/expression21/1", "AND", ["test_null_semantics@2025-01-01/expression21/2", "test_null_semantics@2025-01-01/expression21/3"]).
ee_reference("test_null_semantics@2025-01-01/expression22/2", "verzekerd").
ee_reference("test_null_semantics@2025-01-01/expression22/4", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression22/5", "bsn").
ee_arguments("test_null_semantics@2025-01-01/expression22/3", ["test_null_semantics@2025-01-01/expression22/4", "test_null_semantics@2025-01-01/expression22/5"]).
ee_primitive("test_null_semantics@2025-01-01/expression22/3", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_logical("test_null_semantics@2025-01-01/expression22/1", "OR", ["test_null_semantics@2025-01-01/expression22/2", "test_null_semantics@2025-01-01/expression22/3"]).
ee_reference("test_null_semantics@2025-01-01/expression23/2", "verzekerd").
ee_reference("test_null_semantics@2025-01-01/expression23/5", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression23/6", "bsn").
ee_arguments("test_null_semantics@2025-01-01/expression23/4", ["test_null_semantics@2025-01-01/expression23/5", "test_null_semantics@2025-01-01/expression23/6"]).
ee_primitive("test_null_semantics@2025-01-01/expression23/4", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("test_null_semantics@2025-01-01/expression23/3", ["test_null_semantics@2025-01-01/expression23/4"]).
ee_primitive("test_null_semantics@2025-01-01/expression23/3", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_logical("test_null_semantics@2025-01-01/expression23/1", "OR", ["test_null_semantics@2025-01-01/expression23/2", "test_null_semantics@2025-01-01/expression23/3"]).
ee_reference("test_null_semantics@2025-01-01/expression24/2", "verzekerd").
ee_arguments("test_null_semantics@2025-01-01/expression24/1", ["test_null_semantics@2025-01-01/expression24/2"]).
ee_primitive("test_null_semantics@2025-01-01/expression24/1", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression25/2", "verzekerd").
ee_literal("test_null_semantics@2025-01-01/expression25/3", "ja").
ee_literal("test_null_semantics@2025-01-01/expression25/4", "nee").
ee_conditional("test_null_semantics@2025-01-01/expression25/1", [case("test_null_semantics@2025-01-01/expression25/2", "test_null_semantics@2025-01-01/expression25/3")], "test_null_semantics@2025-01-01/expression25/4").
ee_reference("test_null_semantics@2025-01-01/expression26/2", "aanvraag_bedrag").
ee_literal("test_null_semantics@2025-01-01/expression26/3", decimal(100, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression26/1", ["test_null_semantics@2025-01-01/expression26/2", "test_null_semantics@2025-01-01/expression26/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression26/1", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression27/1", "aanvraag_past").
ee_reference("test_null_semantics@2025-01-01/expression28/1", "aanvraag_past_met_bedrag").
ee_reference("test_null_semantics@2025-01-01/expression29/1", "aanvraag_past_uit_register").
ee_reference("test_null_semantics@2025-01-01/expression30/1", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression31/1", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression32/1", "aanvraag_bedrag").
ee_reference("test_null_semantics@2025-01-01/expression33/1", "bsn").
ee_reference("test_null_semantics@2025-01-01/expression34/1", "bedrag").
ee_reference("test_null_semantics@2025-01-01/expression35/2", "beschikking.bedrag").
ee_literal("test_null_semantics@2025-01-01/expression35/3", decimal(100, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression35/1", ["test_null_semantics@2025-01-01/expression35/2", "test_null_semantics@2025-01-01/expression35/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression35/1", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression36/2", "beschikking.bedrag").
ee_literal("test_null_semantics@2025-01-01/expression36/3", decimal(100, 0)).
ee_arguments("test_null_semantics@2025-01-01/expression36/1", ["test_null_semantics@2025-01-01/expression36/2", "test_null_semantics@2025-01-01/expression36/3"]).
ee_primitive("test_null_semantics@2025-01-01/expression36/1", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("test_null_semantics@2025-01-01/expression37/2", "beschikking.actief").
ee_arguments("test_null_semantics@2025-01-01/expression37/1", ["test_null_semantics@2025-01-01/expression37/2"]).
ee_primitive("test_null_semantics@2025-01-01/expression37/1", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("test_null_semantics@2025-01-01/expression38/2", "beschikking.actief").
ee_literal("test_null_semantics@2025-01-01/expression38/3", "actief").
ee_literal("test_null_semantics@2025-01-01/expression38/4", "inactief").
ee_conditional("test_null_semantics@2025-01-01/expression38/1", [case("test_null_semantics@2025-01-01/expression38/2", "test_null_semantics@2025-01-01/expression38/3")], "test_null_semantics@2025-01-01/expression38/4").
