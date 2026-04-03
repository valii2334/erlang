-module(stack).
-compile([export_all]).

-include("stack_record.hrl").

% push/2
push(Stack = #erl_stack{ length = Length, elements = Elements}, Element) ->
  Stack#erl_stack{length = Length + 1, elements = [Element | Elements]}.

% pop/1
pop(#erl_stack{ length = Length, elements = [LastElementAdded | RemainingElements]}) ->
  Stack = #erl_stack{length = Length - 1, elements = RemainingElements },
  
  {LastElementAdded, Stack};
pop(Stack = #erl_stack{elements = []}) ->
  {empty, Stack}.

% peek/1
peek(#erl_stack{elements = [H | _]}) ->
  H;
peek(#erl_stack{elements = []}) ->
  empty.

length(Stack) ->
  Stack#erl_stack.length.
