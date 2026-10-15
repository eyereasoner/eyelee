% test_nullable, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_nullable").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.8/schema/v0.5.8/schema.json").
law_property("name", "Testwet afwezigheid als eigenschap van het type").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999912").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_nullable").
article("1", "Van huur is geen sprake indien in de registratie geen huur is opgenomen. De huurgrens is de huur uit de huurgrensregistratie vermeerderd met honderd.").
article_property("1", "url", "https://example.com/test_nullable/1").
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
    field("nullable", true),
    field("source", record([]))
  ]),
  record([
    field("name", "huurgrens"),
    field("type", "number"),
    field("source", record([]))
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "heeft_huur"),
    field("type", "boolean")
  ]),
  record([
    field("name", "huurgrens_plus"),
    field("type", "number")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "heeft_huur"),
    field("value", expression("test_nullable@2025-01-01/expression1/1"))
  ]),
  record([
    field("output", "huurgrens_plus"),
    field("value", expression("test_nullable@2025-01-01/expression2/1"))
  ])
]).

article("2", "De toeslag is de in de registratie opgenomen toeslag. De toeslagklasse is gewoon indien de toeslag zeshonderdvijftig bedraagt. De hoogste toeslag is de hoogste van de in de registratie opgenomen toeslagen.").
article_property("2", "url", "https://example.com/test_nullable/2").
execution_property("2", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("2", "input", [
  record([
    field("name", "toeslag"),
    field("type", "number"),
    field("nullable", true),
    field("source", record([]))
  ]),
  record([
    field("name", "toeslagen"),
    field("type", "array"),
    field("source", record([]))
  ])
]).
execution_property("2", "output", [
  record([
    field("name", "toeslagklasse"),
    field("type", "string"),
    field("nullable", true)
  ]),
  record([
    field("name", "hoogste_toeslag"),
    field("type", "number")
  ])
]).
execution_property("2", "actions", [
  record([
    field("output", "toeslagklasse"),
    field("value", expression("test_nullable@2025-01-01/expression3/1"))
  ]),
  record([
    field("output", "hoogste_toeslag"),
    field("value", expression("test_nullable@2025-01-01/expression4/1"))
  ])
]).

article("3", "Het geboortejaar van de partner is het geboortejaar, bedoeld in artikel 1 van de Testwet afwezigheid als eigenschap van het type (bron), van de partner.").
article_property("3", "url", "https://example.com/test_nullable/3").
execution_property("3", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("3", "input", [
  record([
    field("name", "partner_bsn"),
    field("type", "string"),
    field("nullable", true),
    field("source", record([]))
  ]),
  record([
    field("name", "partner_geboortejaar"),
    field("type", "number"),
    field("nullable", true),
    field("source", record([
      field("regulation", "test_nullable_bron"),
      field("output", "geboortejaar"),
      field("parameters", record([
        field("bsn", expression("test_nullable@2025-01-01/expression6/1"))
      ]))
    ]))
  ])
]).
execution_property("3", "output", [
  record([
    field("name", "partner_geboortejaar"),
    field("type", "number"),
    field("nullable", true)
  ])
]).
execution_property("3", "actions", [
  record([
    field("output", "partner_geboortejaar"),
    field("value", expression("test_nullable@2025-01-01/expression5/1"))
  ])
]).

article("3a", "Het geboortejaar van de partner, bedoeld in artikel 3, wordt in dit artikel als altijd aanwezig behandeld.").
article_property("3a", "url", "https://example.com/test_nullable/3a").
execution_property("3a", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("3a", "input", [
  record([
    field("name", "partner_bsn"),
    field("type", "string"),
    field("source", record([]))
  ]),
  record([
    field("name", "partner_geboortejaar_strikt"),
    field("type", "number"),
    field("source", record([
      field("regulation", "test_nullable_bron"),
      field("output", "geboortejaar"),
      field("parameters", record([
        field("bsn", expression("test_nullable@2025-01-01/expression8/1"))
      ]))
    ]))
  ])
]).
execution_property("3a", "output", [
  record([
    field("name", "partner_geboortejaar_strikt"),
    field("type", "number")
  ])
]).
execution_property("3a", "actions", [
  record([
    field("output", "partner_geboortejaar_strikt"),
    field("value", expression("test_nullable@2025-01-01/expression7/1"))
  ])
]).

article("4", "Een aanvrager zonder toeslagpartner is alleenstaand.").
article_property("4", "url", "https://example.com/test_nullable/4").
execution_property("4", "parameters", [
  record([
    field("name", "toeslagpartner"),
    field("type", "string"),
    field("required", true),
    field("nullable", true)
  ])
]).
execution_property("4", "output", [
  record([
    field("name", "alleenstaand"),
    field("type", "boolean")
  ])
]).
execution_property("4", "actions", [
  record([
    field("output", "alleenstaand"),
    field("value", expression("test_nullable@2025-01-01/expression9/1"))
  ])
]).

article("5", "Of de aanvraag past wordt bepaald overeenkomstig artikel 1 van de Testwet afwezigheid als eigenschap van het type (bron), met het in de registratie opgenomen bedrag.").
article_property("5", "url", "https://example.com/test_nullable/5").
execution_property("5", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("5", "input", [
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
      field("regulation", "test_nullable_bron"),
      field("output", "past_aanvraag"),
      field("parameters", record([
        field("bsn", expression("test_nullable@2025-01-01/expression11/1")),
        field("aanvraag_bedrag", expression("test_nullable@2025-01-01/expression12/1"))
      ]))
    ]))
  ])
]).
execution_property("5", "output", [
  record([
    field("name", "aanvraag_past"),
    field("type", "boolean")
  ])
]).
execution_property("5", "actions", [
  record([
    field("output", "aanvraag_past"),
    field("value", expression("test_nullable@2025-01-01/expression10/1"))
  ])
]).

article("6", "Of de partner iemand is, wordt bepaald overeenkomstig artikel 2 van de Testwet afwezigheid als eigenschap van het type (bron).").
article_property("6", "url", "https://example.com/test_nullable/6").
execution_property("6", "parameters", [
  record([
    field("name", "bsn"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("6", "input", [
  record([
    field("name", "partner_bsn"),
    field("type", "string"),
    field("nullable", true),
    field("source", record([]))
  ]),
  record([
    field("name", "partner_is_iemand"),
    field("type", "boolean"),
    field("source", record([
      field("regulation", "test_nullable_bron"),
      field("output", "is_iemand"),
      field("parameters", record([
        field("bsn", expression("test_nullable@2025-01-01/expression14/1"))
      ]))
    ]))
  ])
]).
execution_property("6", "output", [
  record([
    field("name", "partner_is_iemand"),
    field("type", "boolean")
  ])
]).
execution_property("6", "actions", [
  record([
    field("output", "partner_is_iemand"),
    field("value", expression("test_nullable@2025-01-01/expression13/1"))
  ])
]).

ee_reference("test_nullable@2025-01-01/expression1/3", "huur").
ee_literal("test_nullable@2025-01-01/expression1/4", null).
ee_arguments("test_nullable@2025-01-01/expression1/2", ["test_nullable@2025-01-01/expression1/3", "test_nullable@2025-01-01/expression1/4"]).
ee_primitive("test_nullable@2025-01-01/expression1/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_arguments("test_nullable@2025-01-01/expression1/1", ["test_nullable@2025-01-01/expression1/2"]).
ee_primitive("test_nullable@2025-01-01/expression1/1", "NOT", record([field("operation", "NOT"), field("shape", [record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "NOT")])), field("missingValue", false)])).
ee_reference("test_nullable@2025-01-01/expression2/2", "huurgrens").
ee_literal("test_nullable@2025-01-01/expression2/3", decimal(100, 0)).
ee_arguments("test_nullable@2025-01-01/expression2/1", ["test_nullable@2025-01-01/expression2/2", "test_nullable@2025-01-01/expression2/3"]).
ee_primitive("test_nullable@2025-01-01/expression2/1", "ADD", record([field("operation", "ADD"), field("shape", [record([field("field", "values"), field("count", decimal(2, 0))])]), field("staticFields", record([field("operation", "ADD")])), field("missingValue", true)])).
ee_reference("test_nullable@2025-01-01/expression3/3", "toeslag").
ee_literal("test_nullable@2025-01-01/expression3/4", decimal(650, 0)).
ee_arguments("test_nullable@2025-01-01/expression3/2", ["test_nullable@2025-01-01/expression3/3", "test_nullable@2025-01-01/expression3/4"]).
ee_primitive("test_nullable@2025-01-01/expression3/2", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_literal("test_nullable@2025-01-01/expression3/5", "gewoon").
ee_literal("test_nullable@2025-01-01/expression3/6", null).
ee_conditional("test_nullable@2025-01-01/expression3/1", [case("test_nullable@2025-01-01/expression3/2", "test_nullable@2025-01-01/expression3/5")], "test_nullable@2025-01-01/expression3/6").
ee_reference("test_nullable@2025-01-01/expression4/2", "toeslagen").
ee_literal("test_nullable@2025-01-01/expression4/3", true).
ee_reference("test_nullable@2025-01-01/expression4/4", "t").
ee_foreach("test_nullable@2025-01-01/expression4/1", "test_nullable@2025-01-01/expression4/2", "test_nullable@2025-01-01/expression4/3", "test_nullable@2025-01-01/expression4/4", "t", "MAX").
ee_reference("test_nullable@2025-01-01/expression5/1", "partner_geboortejaar").
ee_reference("test_nullable@2025-01-01/expression6/1", "partner_bsn").
ee_reference("test_nullable@2025-01-01/expression7/1", "partner_geboortejaar_strikt").
ee_reference("test_nullable@2025-01-01/expression8/1", "partner_bsn").
ee_reference("test_nullable@2025-01-01/expression9/2", "toeslagpartner").
ee_literal("test_nullable@2025-01-01/expression9/3", null).
ee_arguments("test_nullable@2025-01-01/expression9/1", ["test_nullable@2025-01-01/expression9/2", "test_nullable@2025-01-01/expression9/3"]).
ee_primitive("test_nullable@2025-01-01/expression9/1", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("test_nullable@2025-01-01/expression10/1", "aanvraag_past").
ee_reference("test_nullable@2025-01-01/expression11/1", "bsn").
ee_reference("test_nullable@2025-01-01/expression12/1", "bedrag").
ee_reference("test_nullable@2025-01-01/expression13/1", "partner_is_iemand").
ee_reference("test_nullable@2025-01-01/expression14/1", "partner_bsn").
