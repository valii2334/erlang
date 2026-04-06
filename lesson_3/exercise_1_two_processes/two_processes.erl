-module(two_processes).
-compile([export_all]).

process_1() ->
  receive
    {Pid, M} when M > 0 ->
      io:format("In process 1!~n"),
      Pid ! {self(), M - 1},
      process_1()
  end.

process_2() ->
  receive
    {Pid, M} when M > 0 ->
      io:format("In process 2!~n"),
      Pid ! {self(), M - 1},
      process_2()
  end.

start(M) ->
  P1 = spawn(fun process_1/0),
  P2 = spawn(fun process_2/0),

  P1 ! {P2, M * 2}.