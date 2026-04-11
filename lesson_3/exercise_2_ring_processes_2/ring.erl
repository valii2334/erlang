-module(ring).
-compile([export_all]).

%% Process loop
ring_process(Id, NextPid) ->
    receive
        {set_next, NewNext} ->
            ring_process(Id, NewNext);

        {Msg, 0} ->
            io:format("Process ~p stopping~n", [Id]);

        {Msg, Count} ->
            io:format("Process ~p got message ~p~n", [Id, Msg]),
            NextPid ! {Msg, Count - 1},
            ring_process(Id, NextPid)
    end.

%% Start the ring
start(RingSize, Loops) when RingSize > 0 ->
    %% Spawn processes with placeholder NextPid
    Pids = [spawn(?MODULE, ring_process, [Id, undefined]) || Id <- lists:seq(1, RingSize)],

    %% Connect processes in a circular ring
    connect_ring(Pids),

    %% Start sending the message
    [First | _] = Pids,
    First ! {"hello", RingSize * Loops}.

%% Connect processes in a ring
connect_ring(Pids) ->
    Pairs = lists:zip(Pids, tl(Pids) ++ [hd(Pids)]),
    lists:foreach(fun({P, Next}) -> P ! {set_next, Next} end, Pairs).