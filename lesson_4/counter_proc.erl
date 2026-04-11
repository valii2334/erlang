-module(counter_proc).
-export([start/0, start/1]).

start_process(InitialValue) ->
  receive
    {From, ping} -> 
      From ! pong,
      start_process(InitialValue);
    {From, inc, N} ->
      case is_integer(N) of
        true ->
          From ! ok,
          start_process(InitialValue + N);
        false ->
          From ! {error, badarg},
          start_process(InitialValue)
      end;
    {From, get} -> 
      From ! {ok, InitialValue},
      start_process(InitialValue);
    {From, stop} -> 
      From ! stopped;
    {From, _} -> 
      From ! {error, unsupported},
      start_process(InitialValue)
  end.

start() ->
  spawn(?MODULE, start_process, [0]).

start(InitialValue) ->
  spawn(?MODULE, start_process, [InitialValue]).
