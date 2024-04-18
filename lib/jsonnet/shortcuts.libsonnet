local _ = import '_shortcuts_keys.libsonnet';

{

  _count(ns):: std.native('global_count')(ns),

  anon():: std.toString($._count("actionId")),

  _uuid(ns, name):: std.native('UUIDv5')(ns, name),

  _action(id):: {
    [_._order]:: $._count("actionsOrder"),
    [_.id]:: id,
  },


  _params(params):: {
    [_.params]+: params,
  },


  Action(id, params):: (
    local unidentifiedAction = $._action(id) + $._params(params);
    local UUID = $._uuid('action', std.manifestJsonMinified(unidentifiedAction));
    unidentifiedAction + $._params({ UUID: UUID })
  ),


  Actions(actions_obj):: (
    local actions_kv = std.objectKeysValuesAll(actions_obj);
    local action_from_kv(kv) = (
      local name = kv.key, action = kv.value;
      local isVisible = std.objectHas(actions_obj, name);
      action + (
        if isVisible then $._params({ CustomOutputName: name })
        else {}
      )
    );
    local action_order_key(action) = action[_._order];

    std.sort(std.map(action_from_kv, actions_kv), action_order_key)
  ),

}
