-module(counter_proc_tests).
-include_lib("eunit/include/eunit.hrl").

process_responds_with_pong_test() ->
  % Given I have spawned a new process
  NewProcess = counter_proc:start(),

  % When I send ping
  NewProcess ! {self(), ping},

  % Then I should receive pong
  receive
    pong ->
      ?assert(true)
  after 1000 ->
    ?assert(false)
  end.

process_increments_state_test() ->
  % Given I have spawned a new process
  InitialValue = 0,
  NewProcess   = counter_proc:start(InitialValue),

  % When I send {inc, N}
  Increment = 2,
  NewProcess ! {self(), inc, Increment},

  % Then I should receive ok
  receive
    ok ->
      ?assert(true)
  after 1000 ->
    ?assert(false)
  end,

  % And when I get the state
  NewProcess ! {self(), get},

  % Then I should receive value
  ExpectedValue = InitialValue + Increment,

  receive
    {ok, ExpectedValue} ->
      ?assert(true)
  after 1000 ->
    ?assert(false)
  end.

process_stops_test() ->
  % Given I have spawned a new process
  NewProcess = counter_proc:start(),

  % When I send stop
  NewProcess ! {self(), stop},

  % Then I should receive stopped
  receive
    stopped ->
      ?assert(true)
  after 1000 ->
    ?assert(false)
  end,

  % And when I send again stopped
  NewProcess ! {self(), stop},

  % Then I should not reiceve stopped
  receive
    stopped ->
      ?assert(false)
  after 1000 ->
    ?assert(true)
  end.

process_returns_error_if_unsupported_message_test() ->
  % Given I have spawned a new process
  NewProcess = counter_proc:start(),

  % When I send an unsupported message
  NewProcess ! {self(), random_message},

  % Then I should receive unsupported message
  receive
    {error, unsupported} ->
      ?assert(true)
  after 1000 ->
    ?assert(false)
  end.
