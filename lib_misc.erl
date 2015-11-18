-module(lib_misc).
-export([for/3, qsort/1, pythag/1, perms/1, max/2, odds_and_evens1/1,
          odds_and_evens2/1, odds_and_evens_no_case/1, count_characters/1,
          sqrt/1]).
for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I)|for(I+1, Max, F)].
qsort([]) -> []; % Just beautiful.
qsort([Pivot|T]) ->
  qsort([X || X <- T, X < Pivot])
  ++[Pivot]++
  qsort([X || X <- T, X >= Pivot]).
pythag(N) ->
  [{A,B,C} ||
    A <- lists:seq(1,N),
    B <- lists:seq(1,N),
    C <- lists:seq(1,N),
    A+B+C =< N,
    A*A+B*B =:= C*C].
perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].
max(X, Y) when X > Y -> X;
max(_, Y) -> Y.
% odds_and_evens1
odds_and_evens1(L) ->
  Odds = [X || X <- L, (X rem 2) =:= 1],
  Evens = [X || X <- L, (X rem 2) =:= 0],
  {Odds, Evens}.
% odds_and_evens2
odds_and_evens2(L) ->
  odds_and_evens_acc(L, [], []).
odds_and_evens_acc([H|T], Odds, Evens) ->
  case (H rem 2) of
    1 -> odds_and_evens_acc(T, [H|Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H|Evens])
  end;
odds_and_evens_acc([], Odds, Evens) ->
  {lists:reverse(Odds), lists:reverse(Evens)}.
% odds_and_evens_no_case
odds_and_evens_no_case(L) -> odds_and_evens_acc1(L, [], []).
odds_and_evens_acc1([H|T], Odds, Evens) ->
  odds_and_evens_acc1_help(H rem 2, H, T, Odds, Evens);
odds_and_evens_acc1([], Odds, Evens) ->
  {lists:reverse(Odds), lists:reverse(Evens)}.
odds_and_evens_acc1_help(1, H, T, Odds, Evens) ->
  odds_and_evens_acc1(T, [H|Odds], Evens);
odds_and_evens_acc1_help(0, H, T, Odds, Evens) ->
  odds_and_evens_acc1(T, Odds, [H|Evens]).
% count_characters
count_characters(Str) -> count_characters(Str, #{}).
count_characters([H|T], X) ->
  case (maps:is_key(H, X)) of
    true -> N = maps:get(H, X), count_characters(T, X#{H:=N+1});
    false -> count_characters(T, X#{H=>1})
  end;
count_characters([], X) -> X.
% count_characters([H|T], #{ H := N }=X) -> count_characters(T, X#{ H := N+1 });
% count_characters([H|T], X) -> count_characters(T, X#{ H => 1 });
% count_characters([], X) -> X.
sqrt(X) when X < 0 ->
  error({sqaureRootNegativeArgument, X});
sqrt(X) ->
  math:sqrt(X).
