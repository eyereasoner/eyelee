% eyelee expression evaluation, executed by the eyelang reasoner.
% Grounded register, decimal, and calendar requests cross the domain boundary.
% Branches and collection bodies are requested only by these clauses.
:- table ee_append/3.
ee_append([], Right, Right).
ee_append([Head | Tail], Right, [Head | Joined]) :- ee_append(Tail, Right, Joined).

ee_value(Node, Scope, Value) :- ee_need(Node, Scope), ee_literal(Node, Value).
ee_value(Node, Scope, Value) :- ee_need(Node, Scope), ee_response(Node, Scope, Value).
ee_request(Node, Scope, reference(Path)) :- ee_need(Node, Scope), ee_reference(Node, Path).
ee_request(Node, Scope, error(Kind, Message)) :- ee_need(Node, Scope), ee_invalid(Node, Kind, Message).

% Evaluate primitive operands in written order, keeping the complete value list.
ee_pending(Node, Scope, Arguments, []) :- ee_need(Node, Scope), ee_arguments(Node, Arguments).
ee_need(First, Scope) :- ee_pending(Node, Scope, [First | Rest], Values).
ee_pending(Node, Scope, Rest, [Value | Values]) :-
    ee_pending(Node, Scope, [First | Rest], Values), ee_value(First, Scope, Value).
ee_request(Node, Scope, primitive(Operation, Metadata, Values)) :-
    ee_pending(Node, Scope, [], Values), ee_primitive(Node, Operation, Metadata).

% IF takes the first true branch. Unknown takes neither branch nor default.
ee_cases(Node, Scope, Cases, Default) :- ee_need(Node, Scope), ee_conditional(Node, Cases, Default).
ee_need(When, Scope) :- ee_cases(Node, Scope, [case(When, Then) | Rest], Default).
ee_request(condition(Node, When), Scope, condition("IF", Value)) :-
    ee_cases(Node, Scope, [case(When, Then) | Rest], Default), ee_value(When, Scope, Value).
ee_need(Then, Scope) :-
    ee_cases(Node, Scope, [case(When, Then) | Rest], Default), ee_response(condition(Node, When), Scope, true).
ee_value(Node, Scope, Value) :-
    ee_cases(Node, Scope, [case(When, Then) | Rest], Default), ee_response(condition(Node, When), Scope, true), ee_value(Then, Scope, Value).
ee_cases(Node, Scope, Rest, Default) :-
    ee_cases(Node, Scope, [case(When, Then) | Rest], Default), ee_response(condition(Node, When), Scope, false).
ee_value(Node, Scope, unknown(Missing)) :-
    ee_cases(Node, Scope, [case(When, Then) | Rest], Default), ee_response(condition(Node, When), Scope, unknown(Missing)).
ee_need(Default, Scope) :- ee_cases(Node, Scope, [], Default).
ee_value(Node, Scope, Value) :- ee_cases(Node, Scope, [], Default), ee_value(Default, Scope, Value).

% Kleene AND/OR: a decisive boolean ends the search; unknown names accumulate.
ee_logic(Node, Scope, Operation, Conditions, []) :- ee_need(Node, Scope), ee_logical(Node, Operation, Conditions).
ee_need(First, Scope) :- ee_logic(Node, Scope, Operation, [First | Rest], Missing).
ee_request(logical(Node, First), Scope, condition(Operation, Value)) :-
    ee_logic(Node, Scope, Operation, [First | Rest], Missing), ee_value(First, Scope, Value).
ee_value(Node, Scope, false) :-
    ee_logic(Node, Scope, "AND", [First | Rest], Missing), ee_response(logical(Node, First), Scope, false).
ee_value(Node, Scope, true) :-
    ee_logic(Node, Scope, "OR", [First | Rest], Missing), ee_response(logical(Node, First), Scope, true).
ee_logic(Node, Scope, "AND", Rest, Missing) :-
    ee_logic(Node, Scope, "AND", [First | Rest], Missing), ee_response(logical(Node, First), Scope, true).
ee_logic(Node, Scope, "OR", Rest, Missing) :-
    ee_logic(Node, Scope, "OR", [First | Rest], Missing), ee_response(logical(Node, First), Scope, false).
ee_logic(Node, Scope, Operation, Rest, Combined) :-
    ee_logic(Node, Scope, Operation, [First | Rest], Missing), ee_response(logical(Node, First), Scope, unknown(Names)), ee_append(Missing, Names, Combined).
ee_value(Node, Scope, true) :- ee_logic(Node, Scope, "AND", [], []).
ee_value(Node, Scope, false) :- ee_logic(Node, Scope, "OR", [], []).
ee_value(Node, Scope, unknown([Name | Names])) :- ee_logic(Node, Scope, Operation, [], [Name | Names]).

% FOREACH gives each element its own scope. The ordered collection retains
% duplicate elements, while the reasoner's facts themselves have set semantics.
ee_need(Collection, Scope) :- ee_need(Node, Scope), ee_foreach(Node, Collection, Filter, Body, As, Combine).
ee_request(collection(Node), Scope, collection(Value, As)) :-
    ee_need(Node, Scope), ee_foreach(Node, Collection, Filter, Body, As, Combine), ee_value(Collection, Scope, Value).
ee_value(Node, Scope, unknown(Missing)) :-
    ee_need(Node, Scope), ee_foreach(Node, Collection, Filter, Body, As, Combine), ee_response(collection(Node), Scope, unknown(Missing)).
ee_iterations(Node, Scope, Entries) :- ee_need(Node, Scope), ee_response(collection(Node), Scope, entries(Entries)).
ee_iteration(Node, Scope, Child) :- ee_iterations(Node, Scope, [Child | Rest]).
ee_iterations(Node, Scope, Rest) :- ee_iterations(Node, Scope, [Child | Rest]).
ee_need(Filter, Child) :- ee_iteration(Node, Scope, Child), ee_foreach(Node, Collection, Filter, Body, As, Combine).
ee_request(filter(Node, Child), Scope, condition("FOREACH filter", Value)) :-
    ee_iteration(Node, Scope, Child), ee_foreach(Node, Collection, Filter, Body, As, Combine), ee_value(Filter, Child, Value).
ee_need(Body, Child) :-
    ee_iteration(Node, Scope, Child), ee_foreach(Node, Collection, Filter, Body, As, Combine), ee_response(filter(Node, Child), Scope, true).
ee_item(Node, Scope, Child, keep(Value)) :-
    ee_iteration(Node, Scope, Child), ee_foreach(Node, Collection, Filter, Body, As, Combine), ee_response(filter(Node, Child), Scope, true), ee_value(Body, Child, Value).
ee_item(Node, Scope, Child, skip) :- ee_iteration(Node, Scope, Child), ee_response(filter(Node, Child), Scope, false).
ee_item(Node, Scope, Child, unknown(Missing)) :- ee_iteration(Node, Scope, Child), ee_response(filter(Node, Child), Scope, unknown(Missing)).
ee_collected(Node, Scope, Entries, [], []) :- ee_need(Node, Scope), ee_response(collection(Node), Scope, entries(Entries)).
ee_collected(Node, Scope, Rest, [Value | Values], Missing) :-
    ee_collected(Node, Scope, [Child | Rest], Values, Missing), ee_item(Node, Scope, Child, keep(Value)).
ee_collected(Node, Scope, Rest, Values, Missing) :-
    ee_collected(Node, Scope, [Child | Rest], Values, Missing), ee_item(Node, Scope, Child, skip).
ee_collected(Node, Scope, Rest, Values, Combined) :-
    ee_collected(Node, Scope, [Child | Rest], Values, Missing), ee_item(Node, Scope, Child, unknown(Names)), ee_append(Missing, Names, Combined).
ee_request(Node, Scope, combine(Combine, Values, Missing)) :-
    ee_collected(Node, Scope, [], Values, Missing), ee_foreach(Node, Collection, Filter, Body, As, Combine).
