-module(list_filter_tests).
-include_lib("eunit/include/eunit.hrl").

empty_list_test() ->
  RandomFunction = fun(X) -> X end,
  ?assertEqual([], list_filter:filter(RandomFunction, [])).

filter_odds_test() ->
  OddsFunction  = fun (X) -> X rem 2 =:= 1 end,
  GivenArray    = [1,2,3,4,5],
  ExpectedArray = [1,3,5],
  ?assertEqual(ExpectedArray, list_filter:filter(OddsFunction, GivenArray)).

filter_attoms_test() ->
  AtomFunction  = fun erlang:is_atom/1,
  GivenArray    = [1, a, 3, {a, b}, 'World', foo],
  ExpectedArray = [a,'World',foo],
  ?assertEqual(ExpectedArray, list_filter:filter(AtomFunction, GivenArray)).