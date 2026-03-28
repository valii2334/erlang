-module(list_filter).
-compile([export_all]).

filter(Fun, Array) -> filter(Fun, Array, []).

filter(_, [], Acc) -> lists:reverse(Acc);
filter(Fun, [H|T], Acc) ->
  Result = Fun(H),
  if 
    Result -> filter(Fun, T, [H|Acc]);
    true -> 
      filter(Fun, T, Acc)
  end.