-module(restarter).
-export([start_link/1, status/1, stop/1]).

start_link({Module, Function, Args}) ->
  spawn(?MODULE, new_process, [ok, child_pid, monitor_ref, {Module, Function, Args}]).

new_process(State, _, _, {Module, Function, Args}) ->
  {NewChildPid, NewMonitorRef} = spawn_monitor(Module, Function, Args),

  receive
    {From, state} ->
      From ! {State, NewChildPid},
      new_process(State, NewChildPid, NewMonitorRef, {Module, Function, Args});
    {From, stop} ->
      % It's enough to do it to stop the current process and
      % also the monitor?
      From ! {ok, NewChildPid};
    {'DOWN', _, process, _, _} ->
      % How can we return a state here if the messages are processed in queue format?
      {SpawnedChildPid, SpawnedMonitorRef} = spawn_monitor(Module, Function, Args),

      new_process(ok, SpawnedChildPid, SpawnedMonitorRef, {Module, Function, Args})
  end.

status(Pid) ->
  Pid ! {self(), state}.

stop(Pid) ->
  Pid ! {self(), stop}.

