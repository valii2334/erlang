-module(list_foldl_tests).
-include_lib("eunit/include/eunit.hrl").

empty_list_test() ->
  Fun  = fun(X, Sum) -> Sum + X end,
  Acc  = 0,
  List = [],
  ?assertEqual(0, list_foldl:foldl(Fun, Acc, List)). 

sum_test() ->
  Fun  = fun(X, Sum) -> Sum + X end,
  Acc  = 0,
  List = [1, 2, 3, 4],
  ?assertEqual(10, list_foldl:foldl(Fun, Acc, List)). 

product_test() ->
  Fun  = fun(X, Prod) -> Prod * X end,
  Acc  = 1,
  List = [2, 2, 2],
  ?assertEqual(8, list_foldl:foldl(Fun, Acc, List)). 