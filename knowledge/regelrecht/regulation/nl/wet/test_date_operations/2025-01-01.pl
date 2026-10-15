% test_date_operations, in force from 2025-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_date_operations").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.7.0/schema/v0.7.0/schema.json").
law_property("name", "Testwet datumoperaties").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999902").
law_property("publication_date", "2025-01-01").
law_property("valid_from", "2025-01-01").
law_property("url", "https://example.com/test_date_operations").
article("1", "Een verzoek is tijdig ingediend wanneer de indieningsdatum op of voor de peildatum valt, en is op de peildatum ingediend wanneer de indieningsdatum gelijk is aan de peildatum. De doorlooptijd is het aantal dagen, dan wel het aantal gehele maanden of jaren, tussen de indieningsdatum en de peildatum.").
article_property("1", "url", "https://example.com/test_date_operations/1").
execution_property("1", "parameters", [
  record([
    field("name", "indieningsdatum"),
    field("type", "date"),
    field("required", true),
    field("description", "Datum waarop het verzoek is ingediend")
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "tijdig_ingediend"),
    field("type", "boolean")
  ]),
  record([
    field("name", "op_peildatum_ingediend"),
    field("type", "boolean")
  ]),
  record([
    field("name", "doorlooptijd_dagen"),
    field("type", "number")
  ]),
  record([
    field("name", "doorlooptijd_maanden"),
    field("type", "number")
  ]),
  record([
    field("name", "doorlooptijd_jaren"),
    field("type", "number")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "tijdig_ingediend"),
    field("value", expression("test_date_operations@2025-01-01/expression1/1"))
  ]),
  record([
    field("output", "op_peildatum_ingediend"),
    field("value", expression("test_date_operations@2025-01-01/expression2/1"))
  ]),
  record([
    field("output", "doorlooptijd_dagen"),
    field("value", expression("test_date_operations@2025-01-01/expression3/1"))
  ]),
  record([
    field("output", "doorlooptijd_maanden"),
    field("value", expression("test_date_operations@2025-01-01/expression4/1"))
  ]),
  record([
    field("output", "doorlooptijd_jaren"),
    field("value", expression("test_date_operations@2025-01-01/expression5/1"))
  ])
]).

article("2", "Het jaar en de maand van een wijziging zijn het jaartal en het maandnummer van de wijzigingsdatum. Het begin van de maand is de eerste dag van de maand waarin de wijzigingsdatum valt, en het begin van het jaar de eerste dag van dat jaar. Een wijziging die zich voordoet na de eerste dag van de maand wordt in aanmerking genomen vanaf de eerste dag van de daaropvolgende maand, en een wijziging op de eerste dag van de maand vanaf die dag zelf.").
article_property("2", "url", "https://example.com/test_date_operations/2").
execution_property("2", "parameters", [
  record([
    field("name", "wijzigingsdatum"),
    field("type", "date"),
    field("required", true),
    field("description", "Datum waarop de wijziging zich voordoet")
  ])
]).
execution_property("2", "output", [
  record([
    field("name", "wijzigingsjaar"),
    field("type", "number")
  ]),
  record([
    field("name", "wijzigingsmaand"),
    field("type", "number")
  ]),
  record([
    field("name", "begin_wijzigingsmaand"),
    field("type", "string")
  ]),
  record([
    field("name", "begin_wijzigingsjaar"),
    field("type", "string")
  ]),
  record([
    field("name", "eerste_dag_volgende_maand"),
    field("type", "string")
  ]),
  record([
    field("name", "ingangsdatum_wijziging"),
    field("type", "string")
  ])
]).
execution_property("2", "actions", [
  record([
    field("output", "wijzigingsjaar"),
    field("value", expression("test_date_operations@2025-01-01/expression6/1"))
  ]),
  record([
    field("output", "wijzigingsmaand"),
    field("value", expression("test_date_operations@2025-01-01/expression7/1"))
  ]),
  record([
    field("output", "begin_wijzigingsmaand"),
    field("value", expression("test_date_operations@2025-01-01/expression8/1"))
  ]),
  record([
    field("output", "begin_wijzigingsjaar"),
    field("value", expression("test_date_operations@2025-01-01/expression9/1"))
  ]),
  record([
    field("output", "eerste_dag_volgende_maand"),
    field("value", expression("test_date_operations@2025-01-01/expression10/1"))
  ]),
  record([
    field("output", "ingangsdatum_wijziging"),
    field("value", expression("test_date_operations@2025-01-01/expression11/1"))
  ])
]).

ee_reference("test_date_operations@2025-01-01/expression1/2", "indieningsdatum").
ee_reference("test_date_operations@2025-01-01/expression1/3", "referencedate.iso").
ee_arguments("test_date_operations@2025-01-01/expression1/1", ["test_date_operations@2025-01-01/expression1/2", "test_date_operations@2025-01-01/expression1/3"]).
ee_primitive("test_date_operations@2025-01-01/expression1/1", "LESS_THAN_OR_EQUAL", record([field("operation", "LESS_THAN_OR_EQUAL"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "LESS_THAN_OR_EQUAL")])), field("missingValue", false)])).
ee_reference("test_date_operations@2025-01-01/expression2/2", "indieningsdatum").
ee_reference("test_date_operations@2025-01-01/expression2/3", "referencedate").
ee_arguments("test_date_operations@2025-01-01/expression2/1", ["test_date_operations@2025-01-01/expression2/2", "test_date_operations@2025-01-01/expression2/3"]).
ee_primitive("test_date_operations@2025-01-01/expression2/1", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("test_date_operations@2025-01-01/expression3/2", "indieningsdatum").
ee_reference("test_date_operations@2025-01-01/expression3/3", "referencedate.iso").
ee_literal("test_date_operations@2025-01-01/expression3/4", "days").
ee_arguments("test_date_operations@2025-01-01/expression3/1", ["test_date_operations@2025-01-01/expression3/2", "test_date_operations@2025-01-01/expression3/3", "test_date_operations@2025-01-01/expression3/4"]).
ee_primitive("test_date_operations@2025-01-01/expression3/1", "DATE_DIFF", record([field("operation", "DATE_DIFF"), field("shape", [record([field("field", "from"), field("count", null)]), record([field("field", "to"), field("count", null)]), record([field("field", "in"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_DIFF")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression4/2", "indieningsdatum").
ee_reference("test_date_operations@2025-01-01/expression4/3", "referencedate.iso").
ee_literal("test_date_operations@2025-01-01/expression4/4", "months").
ee_arguments("test_date_operations@2025-01-01/expression4/1", ["test_date_operations@2025-01-01/expression4/2", "test_date_operations@2025-01-01/expression4/3", "test_date_operations@2025-01-01/expression4/4"]).
ee_primitive("test_date_operations@2025-01-01/expression4/1", "DATE_DIFF", record([field("operation", "DATE_DIFF"), field("shape", [record([field("field", "from"), field("count", null)]), record([field("field", "to"), field("count", null)]), record([field("field", "in"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_DIFF")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression5/2", "indieningsdatum").
ee_reference("test_date_operations@2025-01-01/expression5/3", "referencedate.iso").
ee_literal("test_date_operations@2025-01-01/expression5/4", "years").
ee_arguments("test_date_operations@2025-01-01/expression5/1", ["test_date_operations@2025-01-01/expression5/2", "test_date_operations@2025-01-01/expression5/3", "test_date_operations@2025-01-01/expression5/4"]).
ee_primitive("test_date_operations@2025-01-01/expression5/1", "DATE_DIFF", record([field("operation", "DATE_DIFF"), field("shape", [record([field("field", "from"), field("count", null)]), record([field("field", "to"), field("count", null)]), record([field("field", "in"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_DIFF")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression6/2", "wijzigingsdatum").
ee_arguments("test_date_operations@2025-01-01/expression6/1", ["test_date_operations@2025-01-01/expression6/2"]).
ee_primitive("test_date_operations@2025-01-01/expression6/1", "DATE_PART", record([field("operation", "DATE_PART"), field("shape", [record([field("field", "date"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_PART"), field("in", "year")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression7/2", "wijzigingsdatum").
ee_arguments("test_date_operations@2025-01-01/expression7/1", ["test_date_operations@2025-01-01/expression7/2"]).
ee_primitive("test_date_operations@2025-01-01/expression7/1", "DATE_PART", record([field("operation", "DATE_PART"), field("shape", [record([field("field", "date"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_PART"), field("in", "month")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression8/2", "wijzigingsdatum").
ee_arguments("test_date_operations@2025-01-01/expression8/1", ["test_date_operations@2025-01-01/expression8/2"]).
ee_primitive("test_date_operations@2025-01-01/expression8/1", "START_OF", record([field("operation", "START_OF"), field("shape", [record([field("field", "date"), field("count", null)])]), field("staticFields", record([field("operation", "START_OF"), field("in", "month")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression9/2", "wijzigingsdatum").
ee_arguments("test_date_operations@2025-01-01/expression9/1", ["test_date_operations@2025-01-01/expression9/2"]).
ee_primitive("test_date_operations@2025-01-01/expression9/1", "START_OF", record([field("operation", "START_OF"), field("shape", [record([field("field", "date"), field("count", null)])]), field("staticFields", record([field("operation", "START_OF"), field("in", "year")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression10/3", "wijzigingsdatum").
ee_arguments("test_date_operations@2025-01-01/expression10/2", ["test_date_operations@2025-01-01/expression10/3"]).
ee_primitive("test_date_operations@2025-01-01/expression10/2", "START_OF", record([field("operation", "START_OF"), field("shape", [record([field("field", "date"), field("count", null)])]), field("staticFields", record([field("operation", "START_OF"), field("in", "month")])), field("missingValue", true)])).
ee_literal("test_date_operations@2025-01-01/expression10/4", decimal(0, 0)).
ee_literal("test_date_operations@2025-01-01/expression10/5", decimal(1, 0)).
ee_literal("test_date_operations@2025-01-01/expression10/6", decimal(0, 0)).
ee_literal("test_date_operations@2025-01-01/expression10/7", decimal(0, 0)).
ee_arguments("test_date_operations@2025-01-01/expression10/1", ["test_date_operations@2025-01-01/expression10/2", "test_date_operations@2025-01-01/expression10/4", "test_date_operations@2025-01-01/expression10/5", "test_date_operations@2025-01-01/expression10/6", "test_date_operations@2025-01-01/expression10/7"]).
ee_primitive("test_date_operations@2025-01-01/expression10/1", "DATE_ADD", record([field("operation", "DATE_ADD"), field("shape", [record([field("field", "date"), field("count", null)]), record([field("field", "years"), field("count", null)]), record([field("field", "months"), field("count", null)]), record([field("field", "weeks"), field("count", null)]), record([field("field", "days"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_ADD")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression11/4", "wijzigingsdatum").
ee_arguments("test_date_operations@2025-01-01/expression11/3", ["test_date_operations@2025-01-01/expression11/4"]).
ee_primitive("test_date_operations@2025-01-01/expression11/3", "DATE_PART", record([field("operation", "DATE_PART"), field("shape", [record([field("field", "date"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_PART"), field("in", "day")])), field("missingValue", true)])).
ee_literal("test_date_operations@2025-01-01/expression11/5", decimal(1, 0)).
ee_arguments("test_date_operations@2025-01-01/expression11/2", ["test_date_operations@2025-01-01/expression11/3", "test_date_operations@2025-01-01/expression11/5"]).
ee_primitive("test_date_operations@2025-01-01/expression11/2", "GREATER_THAN", record([field("operation", "GREATER_THAN"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "GREATER_THAN")])), field("missingValue", false)])).
ee_reference("test_date_operations@2025-01-01/expression11/8", "wijzigingsdatum").
ee_arguments("test_date_operations@2025-01-01/expression11/7", ["test_date_operations@2025-01-01/expression11/8"]).
ee_primitive("test_date_operations@2025-01-01/expression11/7", "START_OF", record([field("operation", "START_OF"), field("shape", [record([field("field", "date"), field("count", null)])]), field("staticFields", record([field("operation", "START_OF"), field("in", "month")])), field("missingValue", true)])).
ee_literal("test_date_operations@2025-01-01/expression11/9", decimal(0, 0)).
ee_literal("test_date_operations@2025-01-01/expression11/10", decimal(1, 0)).
ee_literal("test_date_operations@2025-01-01/expression11/11", decimal(0, 0)).
ee_literal("test_date_operations@2025-01-01/expression11/12", decimal(0, 0)).
ee_arguments("test_date_operations@2025-01-01/expression11/6", ["test_date_operations@2025-01-01/expression11/7", "test_date_operations@2025-01-01/expression11/9", "test_date_operations@2025-01-01/expression11/10", "test_date_operations@2025-01-01/expression11/11", "test_date_operations@2025-01-01/expression11/12"]).
ee_primitive("test_date_operations@2025-01-01/expression11/6", "DATE_ADD", record([field("operation", "DATE_ADD"), field("shape", [record([field("field", "date"), field("count", null)]), record([field("field", "years"), field("count", null)]), record([field("field", "months"), field("count", null)]), record([field("field", "weeks"), field("count", null)]), record([field("field", "days"), field("count", null)])]), field("staticFields", record([field("operation", "DATE_ADD")])), field("missingValue", true)])).
ee_reference("test_date_operations@2025-01-01/expression11/14", "wijzigingsdatum").
ee_arguments("test_date_operations@2025-01-01/expression11/13", ["test_date_operations@2025-01-01/expression11/14"]).
ee_primitive("test_date_operations@2025-01-01/expression11/13", "START_OF", record([field("operation", "START_OF"), field("shape", [record([field("field", "date"), field("count", null)])]), field("staticFields", record([field("operation", "START_OF"), field("in", "month")])), field("missingValue", true)])).
ee_conditional("test_date_operations@2025-01-01/expression11/1", [case("test_date_operations@2025-01-01/expression11/2", "test_date_operations@2025-01-01/expression11/6")], "test_date_operations@2025-01-01/expression11/13").
