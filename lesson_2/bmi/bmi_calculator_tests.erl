-module(bmi_calculator_tests).
-include_lib("eunit/include/eunit.hrl").
-include("records.hrl").

calculate_bmi_test() ->
  Person      = #person{name="Valentin", weight=83, height=1.77},
  ExpectedBmi = 83 / (1.77 * 1.77),
  ?assertEqual(ExpectedBmi, bmi_calculator:calculate_bmi(Person)).

underweight_person() ->
  #person{name="Valentin", weight=30, height=1.77}.

normal_person() ->
  #person{name="Valentin", weight=70, height=1.77}.

overweight_person() ->
  #person{name="Valentin", weight=85, height=1.77}.

obese_person() ->
  #person{name="Valentin", weight=100, height=1.77}.

cleanup(_) ->
  ok.

bmi_classify_underweight_test_() ->
  {setup,
  fun underweight_person/0,
  fun cleanup/1,
  fun underweight_classify/1}.

underweight_classify(Person) ->
  [?_assertEqual(underweight, bmi_calculator:bmi_classify(Person))].

bmi_classify_normal_test_() ->
  {setup,
  fun normal_person/0,
  fun cleanup/1,
  fun normal_classify/1}.

normal_classify(Person) ->
  [?_assertEqual(normal, bmi_calculator:bmi_classify(Person))].

bmi_classify_overweight_test_() ->
  {setup,
  fun overweight_person/0,
  fun cleanup/1,
  fun overweight_classify/1}.

overweight_classify(Person) ->
  [?_assertEqual(overweight, bmi_calculator:bmi_classify(Person))].

bmi_classify_obese_test_() ->
  {setup,
  fun obese_person/0,
  fun cleanup/1,
  fun obese_classify/1}.

obese_classify(Person) ->
  [?_assertEqual(obese, bmi_calculator:bmi_classify(Person))].