-module(puzzle01).

-export([start/0]).

start() ->
    Input = helpers:read_file("1.txt", <<"\n">>, numbers),
    io:format("Puzzle 1, part 1: ~p~n", [puzzle1(Input)]),
    io:format("Puzzle 1, part 2: ~p~n", [puzzle2(Input)]).

%%----------------------------------------------------------------------
%% Part 1
%%
%% Used a simple brute-force since the input is pretty small
%%----------------------------------------------------------------------
puzzle1(Input) -> puzzle1(Input, Input, Input).

puzzle1([H1 | _], [H2 | _], _) when H1 + H2 == 2020 ->
    H1 * H2;
puzzle1([], [_ | T], Input) -> puzzle1(Input, T, Input);
puzzle1([_ | T], L, Input) -> puzzle1(T, L, Input).

%%----------------------------------------------------------------------
%% Part 2
%%----------------------------------------------------------------------
puzzle2(Input) -> puzzle2(Input, Input, Input, Input).

puzzle2([H1 | _], [H2 | _], [H3 | _], _)
    when H1 + H2 + H3 == 2020 ->
    H1 * H2 * H3;
puzzle2([], [_ | T], L, Input) ->
    puzzle2(Input, T, L, L);
puzzle2(L, [], [_ | T], Input) ->
    puzzle2(L, Input, T, Input);
puzzle2([_ | T], L1, L2, Input) ->
    puzzle2(T, L1, L2, Input).

%%----------------------------------------------------------------------
%% Unit tests
%%----------------------------------------------------------------------
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

puzzle1_test() ->
    514579 = puzzle1([1721, 979, 366, 299, 675, 1456]).

puzzle2_test() ->
    241861950 = puzzle2([1721, 979, 366, 299, 675, 1456]).

-endif.
