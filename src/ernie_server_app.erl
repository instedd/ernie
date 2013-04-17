-module(ernie_server_app).
-behaviour(application).

-export([boot/0, start/2, stop/1]).

boot() ->
  ok = lager:start(),
  ok = application:start(ernie_server).

start(_Type, _Args) ->
  case application:get_env(ernie_server, access_log) of
    {ok, AccessFile} ->
      ernie_access_logger_sup:start_link(AccessFile);
    undefined ->
      ernie_access_logger_sup:start_link(undefined)
  end,
  ernie_server_sup:start_link().

stop(_State) ->
  ok.
