-module(mylists).
-export([sum/1, map/2, filter/2, filter_no_case/2]).
sum([]) -> 0;
sum([H|T]) -> H + sum(T).
map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F,T)].
filter(P, [H|T]) ->
  case P(H) of
    true -> [H|filter(P, T)];
    false -> filter(P,T)
  end;
filter(_, []) -> [].
filter_no_case(P, [H|T]) -> filter_1(P(H), H, P, T);
filter_no_case(_, []) -> [].
filter_1(true, H, P, T) -> [H|filter_no_case(P, T)];
filter_1(false, _, P, T) -> filter_no_case(P, T).
