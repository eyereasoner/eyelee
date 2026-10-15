% An illustrative allowance, not a statement of any current entitlement.
% Amounts are exact eurocents. The clauses below run directly in eyelang.
law(illustrative_benefit).
law_property("valid_from", "2025-01-01").
article("1", "An illustrative allowance covers the shortfall below 200000 eurocents.").
parameter("1", "income", number, true, false).
output("1", "eligible", boolean, false).
output("1", "amount", number, false).
rule("1", "eligible", eligibility, ["income"]).
rule("1", "amount", allowance, ["income"]).

eligibility(Scope, true) :-
    binding(Scope, "income", decimal(Mantissa, Scale)),
    Limit is 200000 * 10^Scale,
    Mantissa < Limit.
eligibility(Scope, false) :-
    binding(Scope, "income", decimal(Mantissa, Scale)),
    Limit is 200000 * 10^Scale,
    Mantissa >= Limit.
eligibility(Scope, unknown(Missing)) :- binding(Scope, "income", unknown(Missing)).

allowance(Scope, decimal(Shortfall, Scale)) :-
    binding(Scope, "income", decimal(Mantissa, Scale)),
    Limit is 200000 * 10^Scale,
    Shortfall is max(0, Limit - Mantissa).
allowance(Scope, unknown(Missing)) :- binding(Scope, "income", unknown(Missing)).
