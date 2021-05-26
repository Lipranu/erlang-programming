-module(functions).
-export([sum/1, sum/2, sumt/1, sumt/2]).
-export([create/1, create_reverse/1]).
-export([print_all/1, print_even/1, const_true/1, even/1]).

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

% Exercise 3-2

create(N) when is_integer(N) ->
    create_acc(1, N).

create_acc(N, M) when N > M ->
    [];
create_acc(N, M) ->
    [N | create_acc(N + 1, M)].

create_reverse(N) when N =< 0, is_integer(N) ->
    [];
create_reverse(N) when N > 0, is_integer(N) ->
    [N | create_reverse(N - 1)].

% Exercise 3-2

print_all(N) when is_integer(N), N > 0 ->
    print_all_inner(1, N, const_true).

print_even(N) when is_integer(N), N > 0 ->
    print_all_inner(1, N, even).

const_true(_) ->
    true.

even(N) when is_integer(N) ->
    N rem 2 == 0.

print_all_inner(N, M, _) when N > M ->
    ok;
print_all_inner(N, M, F) ->
    case apply(functions, F, [N]) of
      true -> io:format("Number:~p~n",[N]);
      false -> ok
    end,
    print_all_inner(N + 1, M, F).
