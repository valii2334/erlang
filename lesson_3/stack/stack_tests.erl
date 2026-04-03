-module(stack_tests).
-include_lib("eunit/include/eunit.hrl").
-include("stack_record.hrl").

should_be_able_to_push_to_stack_test() ->
  % Given we have an empty stack
  EmptyStack = #erl_stack{},

  % When we add an element to the stack
  RandomElement = 1,
  StackWithOneElement = stack:push(EmptyStack, RandomElement),

  % Then we expect the stack length to be one
  ?assertEqual(stack:length(StackWithOneElement), 1),

  % And we expect the stack last element to be the last element added
  ?assertEqual(stack:peek(StackWithOneElement), RandomElement).

should_be_able_to_pop_from_stack_test() ->
  % Given we have an empty stack
  EmptyStack = #erl_stack{},
  
  % And we push two elements to stack
  FirstElement = 1,
  StackWithOneElement = stack:push(EmptyStack, FirstElement),

  SecondElement = atom,
  StackWithTwoElements = stack:push(StackWithOneElement, SecondElement),

  % When we pop one element
  {FirstPoppedElement, NewStack} = stack:pop(StackWithTwoElements),

  % Then we get the last element
  ?assertEqual(FirstPoppedElement, SecondElement),

  % And thew new stack length is 1
  NewStackLength = stack:length(NewStack),
  ?assertEqual(NewStackLength, 1).

should_get_empty_if_stack_empty_when_trying_to_peek_test() ->
  % Given we have an empty stack
  EmptyStack = #erl_stack{},

  % When we pop from the stack
  EmptyElement = stack:peek(EmptyStack),

  % Then EmptyElement should be empty
  ?assertEqual(EmptyElement, empty).

should_get_empty_if_stack_empty_when_trying_to_pop_test() ->
  % Given we have an empty stack
  EmptyStack = #erl_stack{},

  % When we pop from the stack
  {EmptyElement, _} = stack:pop(EmptyStack),

  % Then EmptyElement should be empty
  ?assertEqual(EmptyElement, empty),

  % And the stack length should be 0
  ?assertEqual(stack:length(EmptyStack), 0).
