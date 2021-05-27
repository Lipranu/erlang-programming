-module(my_lists).
-export([filter/2, reverse/1, concatenate/1, flatten/1]).

% Exercise 3-5

filter([], _) ->
    [];
filter([X | Xs], N) when is_integer(X), is_integer(N), X =< N ->
    [X | filter(Xs, N)];
filter([X | Xs], N) when is_integer(X), is_integer(N) ->
    filter(Xs, N).

reverse(Xs) when is_list(Xs) ->
    reverse_inner(Xs, []).

reverse_inner([], Acc) ->
    Acc;
reverse_inner([X | Xs], Acc) ->
    reverse_inner(Xs, [X | Acc]).

concatenate([]) ->
    [];
concatenate([X | Xs]) when is_list(X) ->
    concatenate_inner(X,Xs).

concatenate_inner([],Xs) ->
    concatenate(Xs);
concatenate_inner([X | Xs], Ys) ->
    [X | concatenate_inner(Xs, Ys)].

flatten([]) ->
    [];
flatten([X | []]) when is_list(X) ->
    flatten(X);
flatten([X | Xs]) when is_list(X) ->
    concatenate([flatten(X), flatten(Xs)]);
flatten([X | []]) ->
    [X];
flatten([X | Xs]) ->
    concatenate([[X], flatten(Xs)]).
