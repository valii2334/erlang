-module(list_foldl).
-compile([export_all]).

foldl(_, Acc, []) -> Acc;
foldl(Fun, Acc, [H|T]) -> foldl(Fun, Fun(Acc, H), T).
