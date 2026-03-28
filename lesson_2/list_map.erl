-module(list_map).
-compile([export_all]).

map(Fun, Array) -> map(Fun, Array, []).

map(_, [], Acc) -> lists:reverse(Acc);
map(Fun, [H|T], Acc) -> map(Fun, T, [Fun(H)|Acc]).