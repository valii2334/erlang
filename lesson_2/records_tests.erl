-module(records_tests).
-include_lib("eunit/include/eunit.hrl").

-include("created_records.hrl").

first_robot_test() ->
  TestRobot = #robot{name = "Mechatron", type=handmade, details=["Moved by a small man inside"]},
  ?assertMatch(TestRobot, records:first_robot()).

first_robot_test_() ->
  TestRobot = #robot{name = "Mechatron", type=handmade, details=["Moved by a small man inside"]},
  ?_assertMatch(TestRobot, records:first_robot()).