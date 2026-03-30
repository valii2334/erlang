-module(bmi_calculator).
-compile([export_all]).
-include("records.hrl").

calculate_bmi(Person) ->
    Weight = Person#person.weight,
    Height = Person#person.height,
    Weight / (Height * Height).

bmi_category(Bmi) when Bmi < 18.49 -> underweight;
bmi_category(Bmi) when Bmi >= 18.49, Bmi < 25.0 -> normal;
bmi_category(Bmi) when Bmi >= 25.0, Bmi =< 30.0 -> overweight;
bmi_category(Bmi) when Bmi > 30.0 -> obese.


bmi_classify(Person) ->
    Bmi = calculate_bmi(Person),
    bmi_category(Bmi).
    