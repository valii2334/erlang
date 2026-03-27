-module(records).
-compile([export_all]).

-record(robot, {name, type=industrial, hobbies, details=[]}).
-record(user,  {id, name, group, age}).

% rr() - to load records.
% rf() - remove records.
% rl() - print records.

first_robot() ->
  #robot{name = "Mechatron", type=handmade, details=["Moved by a small man inside"]}.

repairman(Rob) ->
  Details = Rob#robot.details,
  NewRob  = Rob#robot{details=["Repaired by repirman"|Details]},
  {repaired,NewRob}.

car_factory(CorpName) ->
  CarFactoryRobot = #robot{name=CorpName, hobbies = "building cars"},
  CarFactoryRobot#robot.name.

admin_panel(#user{name=Name, group=admin}) ->
  Name ++ " is allowed";
admin_panel(#user{name=Name}) ->
  Name ++ " it is not allowed".

adult_section(U = #user{}) when U#user.age >= 18 ->
  allowed;
adult_section(_) ->
  forbidden.