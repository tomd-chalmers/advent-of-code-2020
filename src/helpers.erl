-module(helpers).

-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

-endif.

-export([read_at_pos/2,
         read_file/1,
         read_file/3,
         replace_at_pos/3]).

binary_to_number(N) ->
    case binary:match(N, <<".">>, []) of
        nomatch -> binary_to_integer(N);
        _ -> binary_to_float(N)
    end.

read_file(File) ->
    Priv_dir = code:priv_dir(advent_of_code_2020),
    {ok, Binary} = file:read_file([Priv_dir, "/", File]),
    Binary.

read_file(File, Delimiter, Types) ->
    Priv_dir = code:priv_dir(advent_of_code_2020),
    {ok, Binary} = file:read_file([Priv_dir, "/", File]),
    List = binary:split(Binary, Delimiter, [global]),
    case Types of
        number ->
            lists:map(fun (L) -> binary_to_number(L) end, List);
        _ -> List
    end.

% Read at pos starting to count from 0
read_at_pos(List, Pos) -> lists:nth(Pos + 1, List).

% Replace at pos starting to count from 0
replace_at_pos(List, Pos, New_value) ->
    {Before, [_ | After]} = lists:split(Pos, List),
    lists:flatten([Before, [New_value], After]).

%%----------------------------------------------------------------------
%% Unit tests
%%----------------------------------------------------------------------

-ifdef(TEST).

binary_to_number_test() ->
    1 = binary_to_number(<<"1">>),
    1.1 = binary_to_number(<<"1.1">>).

read_file_test() ->
    <<"1,2,3,4,5,6,7,8,9">> = read_file("0.txt"),
    [1, 2, 3, 4, 5, 6, 7, 8, 9] = read_file("0.txt",
                                            <<",">>,
                                            number),
    [<<"1">>,
     <<"2">>,
     <<"3">>,
     <<"4">>,
     <<"5">>,
     <<"6">>,
     <<"7">>,
     <<"8">>,
     <<"9">>] =
        read_file("0.txt", <<",">>, any).

read_at_pos_test() ->
    0 = read_at_pos([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 0),
    2 = read_at_pos([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 2),
    5 = read_at_pos([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 5).

replace_at_pos_test() ->
    [ok, 1, 2, 3] = replace_at_pos([0, 1, 2, 3], 0, ok),
    [0, 1, ok, 3] = replace_at_pos([0, 1, 2, 3], 2, ok),
    [0, 1, 2, ok] = replace_at_pos([0, 1, 2, 3], 3, ok).

-endif.
