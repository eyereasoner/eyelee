% test_value_typing, in force from 2023-01-01.
% Prolog knowledge. Evaluation clauses: knowledge/runtime.pl.

law("test_value_typing").
law_property("$schema", "https://raw.githubusercontent.com/MinBZK/regelrecht/refs/tags/schema-v0.5.6/schema/v0.5.6/schema.json").
law_property("name", "Testwet waardetypering").
law_property("regulatory_layer", "WET").
law_property("bwb_id", "BWBR9999904").
law_property("publication_date", "2023-01-01").
law_property("valid_from", "2023-01-01").
law_property("url", "https://example.com/test_value_typing").
article("1", "De waarde is een getal indien zij gelijk is aan 42, en tekst indien zij gelijk is aan \"42\".").
article_property("1", "url", "https://example.com/test_value_typing/1").
execution_property("1", "parameters", [
  record([
    field("name", "waarde"),
    field("type", "string"),
    field("required", true)
  ])
]).
execution_property("1", "output", [
  record([
    field("name", "waarde_is_getal"),
    field("type", "boolean")
  ]),
  record([
    field("name", "waarde_is_tekst"),
    field("type", "boolean")
  ])
]).
execution_property("1", "actions", [
  record([
    field("output", "waarde_is_getal"),
    field("value", expression("test_value_typing@2023-01-01/expression1/1"))
  ]),
  record([
    field("output", "waarde_is_tekst"),
    field("value", expression("test_value_typing@2023-01-01/expression2/1"))
  ])
]).

ee_reference("test_value_typing@2023-01-01/expression1/3", "waarde").
ee_arguments("test_value_typing@2023-01-01/expression1/2", ["test_value_typing@2023-01-01/expression1/3"]).
ee_primitive("test_value_typing@2023-01-01/expression1/2", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_literal("test_value_typing@2023-01-01/expression1/5", decimal(42, 0)).
ee_arguments("test_value_typing@2023-01-01/expression1/4", ["test_value_typing@2023-01-01/expression1/5"]).
ee_primitive("test_value_typing@2023-01-01/expression1/4", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_value_typing@2023-01-01/expression1/1", ["test_value_typing@2023-01-01/expression1/2", "test_value_typing@2023-01-01/expression1/4"]).
ee_primitive("test_value_typing@2023-01-01/expression1/1", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
ee_reference("test_value_typing@2023-01-01/expression2/3", "waarde").
ee_arguments("test_value_typing@2023-01-01/expression2/2", ["test_value_typing@2023-01-01/expression2/3"]).
ee_primitive("test_value_typing@2023-01-01/expression2/2", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_literal("test_value_typing@2023-01-01/expression2/5", "42").
ee_arguments("test_value_typing@2023-01-01/expression2/4", ["test_value_typing@2023-01-01/expression2/5"]).
ee_primitive("test_value_typing@2023-01-01/expression2/4", "LIST", record([field("operation", "LIST"), field("fields", ["items"])])).
ee_arguments("test_value_typing@2023-01-01/expression2/1", ["test_value_typing@2023-01-01/expression2/2", "test_value_typing@2023-01-01/expression2/4"]).
ee_primitive("test_value_typing@2023-01-01/expression2/1", "EQUALS", record([field("operation", "EQUALS"), field("shape", [record([field("field", "subject"), field("count", null)]), record([field("field", "value"), field("count", null)])]), field("staticFields", record([field("operation", "EQUALS")])), field("missingValue", false)])).
