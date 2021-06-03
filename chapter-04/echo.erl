-module(echo).
-export([start/0, stop/0, print/1, loop/0]).

% exercise 4-1

start() ->
    try register(echo, spawn(echo, loop, [])) of
        true -> {ok, start}
    catch
        _:_ -> {ok, start}
    end.

stop() ->
    try echo ! stop of
        stop -> {ok, stop}
    catch
        _:_ -> {error, stop}
    end.

print(Msg) ->
    try echo ! {print, Msg} of
        _ -> {ok, print}
    catch
        _:_ -> {error, print}
    end.

loop() ->
    receive
        stop -> ok;
        {print, Msg} ->
            io:format("~s~n", [Msg]),
            loop()
    end.
