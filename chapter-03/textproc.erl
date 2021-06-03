-module(textproc).
-export([index/1]).

% exercise 3-9

index(Path) ->
    Doc = read_doc(Path),
    Dict = lists:foldl(fun({Index, Word}, Acc) ->
        dict:append(Word, Index, Acc) end,
        dict:new(),
        Doc),
    lists:map(fun(X) -> prettifier(X) end, dict:to_list(Dict)).

prettifier({Word, Indexes}) ->
    [_ | Tail] = lists:foldl(
        fun(X, Acc) -> pretty_range(X, Acc) end,
        [],
        lists:foldl(fun(X, Acc) -> to_range(X, Acc) end, [], Indexes)),
    io:format("~-20s~s~n", [Word ++ ":", Tail]).

pretty_range({X, X}, Acc) ->
    "," ++ integer_to_list(X) ++ Acc;
pretty_range({X, Y}, Acc) ->
    "," ++ integer_to_list(X) ++ "-" ++ integer_to_list(Y) ++ Acc.

to_range(Index, []) -> [{Index, Index}];
to_range(Index, [{X, Index} | Tail]) -> [{X, Index} | Tail];
to_range(Index, [{X, Y} | Tail]) when Y + 1 == Index -> [{X, Index} | Tail];
to_range(Index, List) -> [{Index, Index} | List].

read_doc(Path) ->
    {ok, Binary} = file:read_file(Path),
    RawDoc = string:tokens(binary_to_list(Binary), "\n"),
    Indexes = lists:seq(1, length(RawDoc)),
    lists:concat(lists:zipwith(
        fun(Line, Index) -> to_indexed(Line, Index) end,
        RawDoc,
        Indexes)).

to_indexed(Line, Index) ->
    Words = string:lexemes(Line, " "),
    lists:filtermap(fun(Word) -> check(Word, Index) end, Words).

check(Word, Index) ->
    case Word -- "\-,.:;?!\"" of
        [] -> false;
        NewWord -> {true, {Index, string:casefold(NewWord)}}
    end.
