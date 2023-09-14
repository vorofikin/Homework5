-module(my_cache).

-export([create/1, insert/3, insert/4, lookup/2, delete_obsolete/2]).

create(TableName) ->
  ets:new(TableName, [public, set]).

insert(TableName, Key, Value) ->
  ets:insert(TableName, {Key, Value}).

insert(TableName, Key, Value, Ttl) ->
  EndDateSec = get_unixtime() + Ttl,
  ets:insert(TableName, {Key, Value, EndDateSec}).

lookup(TableName, Key) ->
  Value = ets:lookup(TableName, Key),
  CurrentUnixtime = get_unixtime(),
  case Value of
    [{Key, Value, EndDateSec}] when CurrentUnixtime =< EndDateSec -> {ok, Value};
    [{Key, Value, _EndDateSec}] ->
      delete_obsolete(TableName, Key),
      undefined;
    X -> X;
    _ -> undefined
  end.

delete_obsolete(TableName, Key) ->
  ets:delete(TableName, Key).

get_unixtime() ->
  calendar:datetime_to_gregorian_seconds(calendar:local_time()).
