-module(counter_proc).
-compile([export_all]).

start_process(InitialValue) ->
  receive
    {From, ping} -> 
      From ! pong,
      start_process(InitialValue);
    {From, inc, N} -> 
      From ! ok,
      start_process(InitialValue + N);
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
