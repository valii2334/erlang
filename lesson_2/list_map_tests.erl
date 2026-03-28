-module(list_map_tests).
-include_lib("eunit/include/eunit.hrl").

empty_list_test() ->
  RandomFunction = fun(X) -> X end,
  ?assertMatch([], list_map:map(RandomFunction, [])).

adds_one_test() ->
  AddsOneFunc   = fun(N) -> N + 1 end,
  GivenArray    = [1, 2, 3],
  ExpectedArray = [2, 3, 4],
  ?assertMatch(ExpectedArray, list_map:map(AddsOneFunc, GivenArray)).