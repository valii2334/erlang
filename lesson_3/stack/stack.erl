-module(stack).
-export([push/2, pop/1, peek/1, length/1]).

-include("stack_record.hrl").

% push/2
push(Stack = #erl_stack{length = Length, elements = Elements}, Element) ->
  Stack#erl_stack{length = Length + 1, elements = [Element | Elements]}.

% pop/1
pop(Stack = #erl_stack{length = Length, elements = [LastElementAdded | RemainingElements]}) ->
  {LastElementAdded, Stack#erl_stack{length = Length - 1, elements = RemainingElements }};
pop(Stack = #erl_stack{elements = []}) ->
  {empty, Stack}.

% peek/1
peek(#erl_stack{elements = [H | _]}) ->
  H;
peek(#erl_stack{elements = []}) ->
  empty.

length(Stack) ->
  Stack#erl_stack.length.
