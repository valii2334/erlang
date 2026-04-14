-module(restarter_tests).
-include_lib("eunit/include/eunit.hrl").

spawns_a_new_process_and_monitor_test() ->
  % Given I have a MFA which I want to be in a process and monitored
  MFA = {add, add_two, [0]},

  % When I execute start_link(MFA)
  Pid = restarter:start_link(MFA),

  % Then I should receive a Pid and a Ref to the monitor
  ?assert(is_pid(Pid)).

should_be_able_to_see_ok_if_a_child_is_alive_test() ->
  % Given I have just started the process
  MFA = {add, add_two, [0]},
  Pid = restarter:start_link(MFA),

  % When I get it's status
  restarter:status(Pid),

  % Then I should receive ok and child pid
  receive
    {ok, ChildPid} ->
      % And I should get the childs Pid
      ?assert(is_pid(ChildPid)),
      ?assertNotEqual(ChildPid, Pid)
  after 1000 ->
    ?assert(false)
  end.

should_be_able_to_stop_the_process_test() ->
  % Given I have just started the process
  MFA = {add, add_two, [0]},
  Pid = restarter:start_link(MFA),

  % When I want to stop
  restarter:stop(Pid),

  % Then I should receive ok and child pid
  receive
    {ok, ChildPid} ->
      % And both pids should not be alive
      ?assertNot(erlang:is_process_alive(Pid)),
      ?assertNot(erlang:is_process_alive(ChildPid))
  after 1000 ->
    ?assert(false)
  end.

should_be_able_to_get_the_pid_of_the_new_child_process_test() ->
  % Given I have just started the process
  MFA = {add, add_two, [0]},
  Pid = restarter:start_link(MFA),

  % And I get it's status
  restarter:status(Pid),

  receive
    {ok, ChildPid} ->
      % When I forcefully stop the child process
      exit(ChildPid, kill),

      % And I get it's status
      restarter:status(Pid),
      receive

        % Then I get ok
        {ok, _} ->
          ?assert(true)
      after 1000 ->
        ?assert(false)
      end
  after 1000 ->
    ?assert(false)
  end.
