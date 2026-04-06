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
  P1 = spawn(process_1()),
  P2 = spawn(process_2()),

  P1 ! {P2, M * 2}.