-module(my_cache).

-export([create/1, insert/3, insert/4, lookup/2, delete_obsolete/1]).

create(TableName) ->
  ets:new(TableName, [public, ordered_set, named_table]).

insert(TableName, Key, Value) ->
  ets:insert(TableName, {Key, Value}).

insert(TableName, Key, Value, Ttl) ->
  EndDateSec = get_unixtime() + Ttl,
  ets:insert(TableName, {Key, Value, EndDateSec}).

lookup(TableName, Key) ->
  Value = ets:lookup(TableName, Key),
  CurrentUnixtime = get_unixtime(),
  case Value of
    [{Key, Value, EndDateSec}] when CurrentUnixtime =< EndDateSec -> Value;
    [{Key, _Value, _EndDateSec}] ->
      ets:delete(TableName, Key),
      undefined;
    [{Key, Value}] -> Value;
    _ -> undefined
  end.

delete_obsolete(TableName) ->
  CurrentUnixtime = get_unixtime(),
  FirstKey = ets:first(TableName),
  ok = delete_obsolete(TableName, FirstKey, CurrentUnixtime).

delete_obsolete(_TableName, '$end_of_table', _Unixtime) ->
  ok;
delete_obsolete(TableName, Key, Unixtime) ->
  case ets:lookup(TableName, Key) of
    [{Key, _Value, EndDateSec}] when Unixtime >= EndDateSec ->
      ets:delete(TableName, Key);
    _ -> true
  end,
  delete_obsolete(TableName, ets:next(TableName, Key), Unixtime).

get_unixtime() ->
  calendar:datetime_to_gregorian_seconds(calendar:local_time()).
