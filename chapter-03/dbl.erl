-module(dbl).
-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).

% Exercise 3-7

new() ->
    [].

destroy(_) ->
    ok.

write(Key, Element, Db) ->
    lists:keystore(Key, 1, Db, {Key, Element}).

delete(Key, Db) ->
    lists:keydelete(Key, 1, Db).

read(Key, Db) ->
    case lists:keysearch(Key, 1, Db) of
        {value, {Key, Value}} -> {ok, Value};
        false -> {error, instance}
    end.

match(Value, Db) ->
    lists:filtermap(fun({K, V}) ->
            case Value =:= V of
                true -> {true, K};
                false -> false
            end
        end, Db).
