-module(compare).

-author("Andre").

-export([compare/0]).

-record(person, {name = "Andrew", gender = m, age = 20}).

compare() ->
  io:format("Dict:\n"),
  Dict = dict:new(),
  {DictTime1, _} = timer:tc(fun() -> dict:append(key1, value1, Dict) end),
  {DictTime2, _} = timer:tc(fun() -> dict:append(key2, value2, Dict) end),
  {DictTime3, _} = timer:tc(fun() -> dict:append(key3, value3, Dict) end),
  io:format("~p~n", [DictTime1]),
  io:format("~p~n", [DictTime2]),
  io:format("~p~n", [DictTime3]),

  io:format("proplist:\n"),
  Proplist = [{key1, value1}, {key2, value2}, {key3, value3}],
  {PropListGetValueTime1, _} = timer:tc(fun() -> proplists:get_value(key1, Proplist) end),
  {PropListGetValueTime2, _} = timer:tc(fun() -> proplists:get_value(key2, Proplist) end),
  {PropListGetValueTime3, _} = timer:tc(fun() -> proplists:get_value(key3, Proplist) end),
  io:format("~p~n", [PropListGetValueTime1]),
  io:format("~p~n", [PropListGetValueTime2]),
  io:format("~p~n", [PropListGetValueTime3]),

  io:format("\nmaps:\n"),
  Map = #{key1 => value, key2 => value2, key3 => value3},
  {MapGetValueTime1, _} = timer:tc(fun() -> maps:get(key1, Map) end),
  {MapGetValueTime2, _} = timer:tc(fun() -> maps:get(key2, Map) end),
  {MapGetValueTime3, _} = timer:tc(fun() -> maps:get(key3, Map) end),
  io:format("Get Value time:\n"),
  io:format("~p~n", [MapGetValueTime1]),
  io:format("~p~n", [MapGetValueTime2]),
  io:format("~p~n", [MapGetValueTime3]),

  io:format("\nets:\n"),
  Table1 = ets:new(table1, [public, set]),
  io:format("insert value time\n"),
  {EtsInsertValueTime1, _} = timer:tc(fun() -> ets:insert(Table1, {key1, value1}) end),
  {EtsInsertValueTime2, _} = timer:tc(fun() -> ets:insert(Table1, {key2, value2}) end),
  {EtsInsertValueTime3, _} = timer:tc(fun() -> ets:insert(Table1, {key3, value3}) end),
  io:format("~p~n", [EtsInsertValueTime1]),
  io:format("~p~n", [EtsInsertValueTime2]),
  io:format("~p~n", [EtsInsertValueTime3]),
  {EtsGetValueTime1, _} = timer:tc(fun() -> ets:lookup(Table1, key1) end),
  {EtsGetValueTime2, _} = timer:tc(fun() -> ets:lookup(Table1, key2) end),
  {EtsGetValueTime3, _} = timer:tc(fun() -> ets:lookup(Table1, key3) end),
  io:format("get value time\n"),
  io:format("~p~n", [EtsGetValueTime1]),
  io:format("~p~n", [EtsGetValueTime2]),
  io:format("~p~n", [EtsGetValueTime3]),

  io:format("Process Dictionary\n"),
  {PdInsertValueTime1, _} = timer:tc(fun() -> put(key1, value1) end),
  {PdInsertValueTime2, _} = timer:tc(fun() -> put(key2, value1) end),
  {PdInsertValueTime3, _} = timer:tc(fun() -> put(key3, value1) end),
  {PdGetValueTime, _} = timer:tc(fun() -> get() end),
  {PdEraseValueTime, _} = timer:tc(fun() -> erase() end),
  io:format("insert value:\n"),
  io:format("~p~n", [PdInsertValueTime1]),
  io:format("~p~n", [PdInsertValueTime2]),
  io:format("~p~n", [PdInsertValueTime3]),
  io:format("get value:\n"),
  io:format("~p~n", [PdGetValueTime]),
  io:format("erase values:\n"),
  io:format("~p~n", [PdEraseValueTime])
%%  {EtsGetValueTime, _} = timer:tc(fun() -> io:format("~p~n", [ets:tab2list(Table1)]) end)
  .
