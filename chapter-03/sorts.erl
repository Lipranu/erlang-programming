-module(sorts).
-export([quick/1, merge/1]).

% Exercise 3-6

quick([]) ->
    [];
quick([X | Xs]) ->
    {L, R} = quick_inner(X, Xs, [], []),
    quick(L) ++ [X] ++ quick(R).

quick_inner(_, [], AccL, AccR) ->
    {AccL, AccR};
quick_inner(P, [X | Xs], AccL, AccR) when X =< P ->
    quick_inner(P, Xs, [X | AccL], AccR);
quick_inner(P, [X | Xs], AccL, AccR) when X > P ->
    quick_inner(P, Xs, AccL, [X | AccR]).

merge([]) ->
    [];
merge([X]) ->
    [X];
merge(Xs) when is_list(Xs) ->
    N = length(Xs),
    {L, R} = take(Xs, N div 2, []),
    merge_inner(merge(L), merge(R)).

take(Xs, 0, Acc) ->
    {Xs, Acc};
take([X | Xs], N, Acc) ->
    take(Xs, N - 1, [X | Acc]).

merge_inner([], Rs) ->
    Rs;
merge_inner(Ls, []) ->
    Ls;
merge_inner([L | Ls], [R | Rs]) ->
    case (L =< R) of
        true -> [L | merge_inner(Ls, [R | Rs])];
        false -> [R | merge_inner([L | Ls], Rs)]
    end.
