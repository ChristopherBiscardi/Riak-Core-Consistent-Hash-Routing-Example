-module(chapp).
-include("chapp.hrl").
-include_lib("riak_core/include/riak_core_vnode.hrl").

-export([
         ping/0,
         pingsame/0,
         pinginput/1
        ]).

%% Public API

%% @doc Pings a random vnode 
ping() ->
    DocIdx = riak_core_util:chash_key({<<"ping">>, term_to_binary(now())}),
    PrefList = riak_core_apl:get_primary_apl(DocIdx, 1, chapp),
    [{IndexNode, _Type}] = PrefList,
    riak_core_vnode_master:sync_spawn_command(IndexNode, ping, chapp_vnode_master).

%% @doc Pings the same vnode every time
pingsame() ->
  DocIdx = riak_core_util:chash_key({<<"ping">>, <<"same">>}), 
    PrefList = riak_core_apl:get_primary_apl(DocIdx, 1, chapp),
    [{IndexNode, _Type}] = PrefList,
    riak_core_vnode_master:sync_spawn_command(IndexNode, ping, chapp_vnode_master).

%% @doc Pings the same vnode, based on user input.
pinginput(X) ->
  DocIdx = riak_core_util:chash_key({<<"ping">>, term_to_binary(X)}), 
    PrefList = riak_core_apl:get_primary_apl(DocIdx, 1, chapp),
    [{IndexNode, _Type}] = PrefList,
    riak_core_vnode_master:sync_spawn_command(IndexNode, ping, chapp_vnode_master).
