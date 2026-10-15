% test_collections, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_collections").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.7/schema/v0.5.7/schema.json").
law_property("name", "Testwet collectiebewerkingen").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999905").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_collections").
article("1", "Het aantal medebewoners van 21 jaar of ouder wordt vastgesteld, alsmede het totaal van hun bijdragen. Een medebewoner die de leeftijd van 21 jaar niet heeft bereikt, telt niet mee. Het hoogste en het laagste bedrag worden afzonderlijk vastgesteld.").
article_property("1", "url", "https://example.com/test_collections/1").
execution_property("1", "parameters", [
  record([
    field("name", "medebewoners"),
    field("type", "array"),
    field("required", true),
    field("description", "Medebewoners, elk met een leeftijd en een bijdrage. De leeftijdsgrens staat in deze wet, niet in de bronregistratie.")
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "aantal_medebewoners_21_plus"),
    field("type", "number")
  ]),
  record([
    field("name", "totaal_bijdragen"),
    field("type", "number")
  ]),
  record([
    field("name", "totaal_alle_bijdragen"),
    field("type", "number")
  ]),
  record([
    field("name", "hoogste_bijdrage"),
    field("type", "number"),
    field("nullable", true)
  ]),
  record([
    field("name", "laagste_bijdrage"),
    field("type", "number"),
    field("nullable", true)
  ]),
  record([
    field("name", "iedereen_draagt_bij"),
    field("type", "boolean")
  ]),
  record([
    field("name", "iemand_draagt_bij"),
    field("type", "boolean")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "aantal_medebewoners_21_plus"),
    field("value", expression("test_collections@2025-01-01/expression1/1"))
  ]),
  record([
    field("output", "totaal_bijdragen"),
    field("value", expression("test_collections@2025-01-01/expression2/1"))
  ]),
  record([
    field("output", "totaal_alle_bijdragen"),
    field("value", expression("test_collections@2025-01-01/expression3/1"))
  ]),
  record([
    field("output", "hoogste_bijdrage"),
    field("value", expression("test_collections@2025-01-01/expression4/1"))
  ]),
  record([
    field("output", "laagste_bijdrage"),
    field("value", expression("test_collections@2025-01-01/expression5/1"))
  ]),
  record([
    field("output", "iedereen_draagt_bij"),
    field("value", expression("test_collections@2025-01-01/expression6/1"))
  ]),
  record([
    field("output", "iemand_draagt_bij"),
    field("value", expression("test_collections@2025-01-01/expression7/1"))
  ])
]).

article("2", "Het totaal van de bijdragen van alle leden van alle huishoudens wordt vastgesteld. Van elk huishouden telt uitsluitend de hoogste bijdrage mee voor het aantal draagkrachtige huishoudens.").
article_property("2", "url", "https://example.com/test_collections/2").
definition("2", "huishoudens", record([
  field("value", expression("test_collections@2025-01-01/expression8/1"))
])).
execution_property("2", "output", [
  record([
    field("name", "totaal_over_huishoudens"),
    field("type", "number")
  ]),
  record([
    field("name", "aantal_huishoudens"),
    field("type", "number")
  ])
]).
execution_property("2", "actions", [
  record([
    field("output", "totaal_over_huishoudens"),
    field("value", expression("test_collections@2025-01-01/expression9/1"))
  ]),
  record([
    field("output", "aantal_huishoudens"),
    field("value", expression("test_collections@2025-01-01/expression10/1"))
  ])
]).

article("3", "Het totaal van de hoogste bijdragen per huishouden wordt vastgesteld.").
article_property("3", "url", "https://example.com/test_collections/3").
definition("3", "huishoudens", record([
  field("value", expression("test_collections@2025-01-01/expression11/1"))
])).
execution_property("3", "output", [
  record([
    field("name", "hoogste_per_huishouden_totaal"),
    field("type", "number")
  ])
]).
execution_property("3", "actions", [
  record([
    field("output", "hoogste_per_huishouden_totaal"),
    field("value", expression("test_collections@2025-01-01/expression12/1"))
  ])
]).

ee_reference("test_collections@2025-01-01/expression1/2", "medebewoners").
ee_reference("test_collections@2025-01-01/expression1/4", "medebewoner.leeftijd").
ee_literal("test_collections@2025-01-01/expression1/5", decimal(21, 0)).
ee_arguments("test_collections@2025-01-01/expression1/3", ["test_collections@2025-01-01/expression1/4", "test_collections@2025-01-01/expression1/5"]).
ee_primitive("test_collections@2025-01-01/expression1/3", "GREATER_THAN_OR_EQUAL", record([field("operation", "GREATER_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_literal("test_collections@2025-01-01/expression1/6", decimal(1, 0)).
ee_foreach("test_collections@2025-01-01/expression1/1", "test_collections@2025-01-01/expression1/2", "test_collections@2025-01-01/expression1/3", "test_collections@2025-01-01/expression1/6", "medebewoner", "ADD").
ee_reference("test_collections@2025-01-01/expression2/2", "medebewoners").
ee_reference("test_collections@2025-01-01/expression2/4", "medebewoner.leeftijd").
ee_literal("test_collections@2025-01-01/expression2/5", decimal(21, 0)).
ee_arguments("test_collections@2025-01-01/expression2/3", ["test_collections@2025-01-01/expression2/4", "test_collections@2025-01-01/expression2/5"]).
ee_primitive("test_collections@2025-01-01/expression2/3", "GREATER_THAN_OR_EQUAL", record([field("operation", "GREATER_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_reference("test_collections@2025-01-01/expression2/6", "medebewoner.bijdrage").
ee_foreach("test_collections@2025-01-01/expression2/1", "test_collections@2025-01-01/expression2/2", "test_collections@2025-01-01/expression2/3", "test_collections@2025-01-01/expression2/6", "medebewoner", "ADD").
ee_reference("test_collections@2025-01-01/expression3/2", "medebewoners").
ee_literal("test_collections@2025-01-01/expression3/3", true).
ee_reference("test_collections@2025-01-01/expression3/4", "medebewoner.bijdrage").
ee_foreach("test_collections@2025-01-01/expression3/1", "test_collections@2025-01-01/expression3/2", "test_collections@2025-01-01/expression3/3", "test_collections@2025-01-01/expression3/4", "medebewoner", "ADD").
ee_reference("test_collections@2025-01-01/expression4/2", "medebewoners").
ee_literal("test_collections@2025-01-01/expression4/3", true).
ee_reference("test_collections@2025-01-01/expression4/4", "medebewoner.bijdrage").
ee_foreach("test_collections@2025-01-01/expression4/1", "test_collections@2025-01-01/expression4/2", "test_collections@2025-01-01/expression4/3", "test_collections@2025-01-01/expression4/4", "medebewoner", "MAX").
ee_reference("test_collections@2025-01-01/expression5/2", "medebewoners").
ee_literal("test_collections@2025-01-01/expression5/3", true).
ee_reference("test_collections@2025-01-01/expression5/4", "medebewoner.bijdrage").
ee_foreach("test_collections@2025-01-01/expression5/1", "test_collections@2025-01-01/expression5/2", "test_collections@2025-01-01/expression5/3", "test_collections@2025-01-01/expression5/4", "medebewoner", "MIN").
ee_reference("test_collections@2025-01-01/expression6/2", "medebewoners").
ee_literal("test_collections@2025-01-01/expression6/3", true).
ee_reference("test_collections@2025-01-01/expression6/5", "medebewoner.bijdrage").
ee_literal("test_collections@2025-01-01/expression6/6", decimal(0, 0)).
ee_arguments("test_collections@2025-01-01/expression6/4", ["test_collections@2025-01-01/expression6/5", "test_collections@2025-01-01/expression6/6"]).
ee_primitive("test_collections@2025-01-01/expression6/4", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_foreach("test_collections@2025-01-01/expression6/1", "test_collections@2025-01-01/expression6/2", "test_collections@2025-01-01/expression6/3", "test_collections@2025-01-01/expression6/4", "medebewoner", "AND").
ee_reference("test_collections@2025-01-01/expression7/2", "medebewoners").
ee_literal("test_collections@2025-01-01/expression7/3", true).
ee_reference("test_collections@2025-01-01/expression7/5", "medebewoner.bijdrage").
ee_literal("test_collections@2025-01-01/expression7/6", decimal(0, 0)).
ee_arguments("test_collections@2025-01-01/expression7/4", ["test_collections@2025-01-01/expression7/5", "test_collections@2025-01-01/expression7/6"]).
ee_primitive("test_collections@2025-01-01/expression7/4", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_foreach("test_collections@2025-01-01/expression7/1", "test_collections@2025-01-01/expression7/2", "test_collections@2025-01-01/expression7/3", "test_collections@2025-01-01/expression7/4", "medebewoner", "OR").
ee_literal("test_collections@2025-01-01/expression8/5", decimal(100, 0)).
ee_arguments("test_collections@2025-01-01/expression8/4", ["test_collections@2025-01-01/expression8/5"]).
ee_primitive("test_collections@2025-01-01/expression8/4", "RECORD", record([field("operation", "RECORD"), field("keys", ["bijdrage"])])).
ee_literal("test_collections@2025-01-01/expression8/7", decimal(200, 0)).
ee_arguments("test_collections@2025-01-01/expression8/6", ["test_collections@2025-01-01/expression8/7"]).
ee_primitive("test_collections@2025-01-01/expression8/6", "RECORD", record([field("operation", "RECORD"), field("keys", ["bijdrage"])])).
ee_arguments("test_collections@2025-01-01/expression8/3", ["test_collections@2025-01-01/expression8/4", "test_collections@2025-01-01/expression8/6"]).
ee_primitive("test_collections@2025-01-01/expression8/3", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_collections@2025-01-01/expression8/2", ["test_collections@2025-01-01/expression8/3"]).
ee_primitive("test_collections@2025-01-01/expression8/2", "RECORD", record([field("operation", "RECORD"), field("keys", ["leden"])])).
ee_literal("test_collections@2025-01-01/expression8/11", decimal(50, 0)).
ee_arguments("test_collections@2025-01-01/expression8/10", ["test_collections@2025-01-01/expression8/11"]).
ee_primitive("test_collections@2025-01-01/expression8/10", "RECORD", record([field("operation", "RECORD"), field("keys", ["bijdrage"])])).
ee_arguments("test_collections@2025-01-01/expression8/9", ["test_collections@2025-01-01/expression8/10"]).
ee_primitive("test_collections@2025-01-01/expression8/9", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_collections@2025-01-01/expression8/8", ["test_collections@2025-01-01/expression8/9"]).
ee_primitive("test_collections@2025-01-01/expression8/8", "RECORD", record([field("operation", "RECORD"), field("keys", ["leden"])])).
ee_arguments("test_collections@2025-01-01/expression8/13", []).
ee_primitive("test_collections@2025-01-01/expression8/13", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_collections@2025-01-01/expression8/12", ["test_collections@2025-01-01/expression8/13"]).
ee_primitive("test_collections@2025-01-01/expression8/12", "RECORD", record([field("operation", "RECORD"), field("keys", ["leden"])])).
ee_arguments("test_collections@2025-01-01/expression8/1", ["test_collections@2025-01-01/expression8/2", "test_collections@2025-01-01/expression8/8", "test_collections@2025-01-01/expression8/12"]).
ee_primitive("test_collections@2025-01-01/expression8/1", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_reference("test_collections@2025-01-01/expression9/2", "huishoudens").
ee_literal("test_collections@2025-01-01/expression9/3", true).
ee_reference("test_collections@2025-01-01/expression9/5", "huishouden.leden").
ee_literal("test_collections@2025-01-01/expression9/6", true).
ee_reference("test_collections@2025-01-01/expression9/7", "lid.bijdrage").
ee_foreach("test_collections@2025-01-01/expression9/4", "test_collections@2025-01-01/expression9/5", "test_collections@2025-01-01/expression9/6", "test_collections@2025-01-01/expression9/7", "lid", "ADD").
ee_foreach("test_collections@2025-01-01/expression9/1", "test_collections@2025-01-01/expression9/2", "test_collections@2025-01-01/expression9/3", "test_collections@2025-01-01/expression9/4", "huishouden", "ADD").
ee_reference("test_collections@2025-01-01/expression10/2", "huishoudens").
ee_literal("test_collections@2025-01-01/expression10/3", true).
ee_literal("test_collections@2025-01-01/expression10/4", decimal(1, 0)).
ee_foreach("test_collections@2025-01-01/expression10/1", "test_collections@2025-01-01/expression10/2", "test_collections@2025-01-01/expression10/3", "test_collections@2025-01-01/expression10/4", "huishouden", "ADD").
ee_literal("test_collections@2025-01-01/expression11/5", decimal(100, 0)).
ee_arguments("test_collections@2025-01-01/expression11/4", ["test_collections@2025-01-01/expression11/5"]).
ee_primitive("test_collections@2025-01-01/expression11/4", "RECORD", record([field("operation", "RECORD"), field("keys", ["bijdrage"])])).
ee_literal("test_collections@2025-01-01/expression11/7", decimal(200, 0)).
ee_arguments("test_collections@2025-01-01/expression11/6", ["test_collections@2025-01-01/expression11/7"]).
ee_primitive("test_collections@2025-01-01/expression11/6", "RECORD", record([field("operation", "RECORD"), field("keys", ["bijdrage"])])).
ee_arguments("test_collections@2025-01-01/expression11/3", ["test_collections@2025-01-01/expression11/4", "test_collections@2025-01-01/expression11/6"]).
ee_primitive("test_collections@2025-01-01/expression11/3", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_collections@2025-01-01/expression11/2", ["test_collections@2025-01-01/expression11/3"]).
ee_primitive("test_collections@2025-01-01/expression11/2", "RECORD", record([field("operation", "RECORD"), field("keys", ["leden"])])).
ee_literal("test_collections@2025-01-01/expression11/11", decimal(50, 0)).
ee_arguments("test_collections@2025-01-01/expression11/10", ["test_collections@2025-01-01/expression11/11"]).
ee_primitive("test_collections@2025-01-01/expression11/10", "RECORD", record([field("operation", "RECORD"), field("keys", ["bijdrage"])])).
ee_arguments("test_collections@2025-01-01/expression11/9", ["test_collections@2025-01-01/expression11/10"]).
ee_primitive("test_collections@2025-01-01/expression11/9", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_collections@2025-01-01/expression11/8", ["test_collections@2025-01-01/expression11/9"]).
ee_primitive("test_collections@2025-01-01/expression11/8", "RECORD", record([field("operation", "RECORD"), field("keys", ["leden"])])).
ee_arguments("test_collections@2025-01-01/expression11/13", []).
ee_primitive("test_collections@2025-01-01/expression11/13", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_collections@2025-01-01/expression11/12", ["test_collections@2025-01-01/expression11/13"]).
ee_primitive("test_collections@2025-01-01/expression11/12", "RECORD", record([field("operation", "RECORD"), field("keys", ["leden"])])).
ee_arguments("test_collections@2025-01-01/expression11/1", ["test_collections@2025-01-01/expression11/2", "test_collections@2025-01-01/expression11/8", "test_collections@2025-01-01/expression11/12"]).
ee_primitive("test_collections@2025-01-01/expression11/1", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_reference("test_collections@2025-01-01/expression12/2", "huishoudens").
ee_literal("test_collections@2025-01-01/expression12/3", true).
ee_reference("test_collections@2025-01-01/expression12/5", "huishouden.leden").
ee_literal("test_collections@2025-01-01/expression12/6", true).
ee_reference("test_collections@2025-01-01/expression12/7", "lid.bijdrage").
ee_foreach("test_collections@2025-01-01/expression12/4", "test_collections@2025-01-01/expression12/5", "test_collections@2025-01-01/expression12/6", "test_collections@2025-01-01/expression12/7", "lid", "MAX").
ee_foreach("test_collections@2025-01-01/expression12/1", "test_collections@2025-01-01/expression12/2", "test_collections@2025-01-01/expression12/3", "test_collections@2025-01-01/expression12/4", "huishouden", "ADD").
