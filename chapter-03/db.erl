-module(db).
-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).

% Exercise 3-4

new() ->
    [].

destroy(_) ->
    ok.

write(Key, Element, Db) ->
    NewDb = delete(Key, Db),
    [{Key, Element} | NewDb].

delete(_, []) ->
    [];
delete(Key, [{Key, _} | Db]) ->
    Db;
delete(Key, [Head | Tail]) ->
    [Head | delete(Key, Tail)].

read(_, []) ->
    {error, instance};
read(Key, [{Key, Value} | _]) ->
    {ok, Value};
read(Key, [_ | Tail]) ->
    read(Key, Tail).

match(_, []) ->
    [];
match(Value, [{Key, Value} | Tail]) ->
    [Key | match(Value, Tail)];
match(Value, [_ | Tail]) ->
    match(Value, Tail).
