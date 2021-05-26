-module(functions).
-export([sum/1, sum/2, sumt/1, sumt/2]).

% Exercise 3-1

sum(0) ->
    0;
sum(N) when N > 0, is_integer(N) ->
    N + sum(N - 1).

sum(N, M) when N =:= M, is_integer(N), is_integer(M) ->
    N;
sum(N, M) when N < M, N >= 0, is_integer(N), is_integer(M) ->
    N + sum(N + 1, M).

sumt(N) when N >= 0, is_integer(N) ->
    sum_acc(0, N, 0).

sumt(N, M) when N =< M, is_integer(N), is_integer(M) ->
    sum_acc(N, M, 0).

sum_acc(N, M, Acc) when N =:= M ->
    Acc + N;
sum_acc(N, M, Acc) ->
    sum_acc(N + 1, M, Acc + N).
