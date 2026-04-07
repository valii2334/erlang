-module(ring).
-compile([export_all]).

ring_process(ProcessNumber) ->
  receive
    {Msg, To, [Next | RemainingProcesses], Processlist, NumberOfMessages} when NumberOfMessages > 0 ->
      io:format("I am process ~p. Got message ~p ~n", [ProcessNumber, Msg]),
      To ! {ProcessNumber, Next, RemainingProcesses, Processlist, NumberOfMessages - 1},
      ring_process(ProcessNumber);
    
    {Msg, To, [], [Next | RemainingProcesses], NumberOfMessages} when NumberOfMessages > 0 ->
      io:format("I am process ~p. Got message ~p ~n", [ProcessNumber, Msg]),
      To ! {ProcessNumber, Next, RemainingProcesses, [Next | RemainingProcesses], NumberOfMessages - 1},
      ring_process(ProcessNumber);

    {_, _, _, _, 0} ->
      io:format("Process ~p finished~n", [ProcessNumber]),
      ok
  end.

send_message(FirstProcess, [H | T], ProcessList, NumberOfLoops) ->
  FirstProcess ! {0, H, T, ProcessList, NumberOfLoops * length(ProcessList) + 1}.

start(0, [FirstProcess | Tail], NumberOfLoops) ->
  send_message(FirstProcess, Tail, [FirstProcess | Tail], NumberOfLoops);

start(RingSize, Processes, NumberOfLoops) ->
  P = spawn(ring, ring_process, [RingSize]),
  start(RingSize - 1, [P | Processes], NumberOfLoops).

