-module(advent_of_code_2020).

-export([start/0]).

start() ->
    puzzle1:start(),
    loop().

loop() ->
    receive _ -> ok end,
    loop().
