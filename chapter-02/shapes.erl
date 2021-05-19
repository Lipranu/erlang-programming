-module(shapes).

-export([area/1]).

-import(math, [pi/0, sqrt/1]).

area({square, Area}) ->
    Area * Area;
area({circle, Radius}) ->
    pi() * Radius * Radius;
area({triangle, A, B, C}) ->
    S = (A + B + C) / 2,
    sqrt(S * (S - A) * (S - B) * (S - C));
area(_Other) ->
    {error, invalid_object}.