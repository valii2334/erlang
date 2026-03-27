-module(record_drop).
-export([fall_velocity/1]).

-record(tower, {location, height=20, planemo=earth, name}).

fall_velocity(T = #tower{}) ->
  fall_velocity(T#tower.planemo, T#tower.height).

-define(EARTH_ACCELARATION, 9.8).
-define(MOON_ACCELARATION, 1.6).
-define(MARS_ACCELARATION, 3.71).

fall_velocity(earth, Distance) when Distance >= 0 ->
  math:sqrt(2 * ?EARTH_ACCELARATION * Distance);
fall_velocity(moon, Distance) when Distance >= 0 ->
  math:sqrt(2 * ?MOON_ACCELARATION * Distance);
fall_velocity(mars, Distance) when Distance >= 0 ->
  math:sqrt(2 * ?MARS_ACCELARATION * Distance).

