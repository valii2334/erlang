-module(stack).
-compile([export_all]).

-include("stack_record.hrl").

% push/2
push(Stack, Element) ->
  NewStackLength   = Stack#erl_stack.length + 1,
  NewStackElements = [ Element | Stack#erl_stack.elements ], 
  Stack#erl_stack{length = NewStackLength, elements = NewStackElements}.

% pop/1
pop(#erl_stack{ elements = [LastElementAdded | RemainingElements]}) ->
  NewStackLength = #erl_stack.length - 1,
  NewStack       = #erl_stack{length = NewStackLength, elements = RemainingElements },
  
  {LastElementAdded, NewStack};
pop(#erl_stack{elements = []}) ->
  {empty, #erl_stack{}}.

% peek/1
peek(#erl_stack{elements = [H | _]}) ->
  H;
peek(#erl_stack{elements = []}) ->
  empty.

length(Stack) ->
  Stack#erl_stack.length.
