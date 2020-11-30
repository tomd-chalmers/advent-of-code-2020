%%%-------------------------------------------------------------------
%% @doc advent_of_code_2020 public API
%% @end
%%%-------------------------------------------------------------------

-module(advent_of_code_2020_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    advent_of_code_2020_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
