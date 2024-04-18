{
  _count(ns):: std.native('global_count')(ns),

  local order_key = std.native('UUIDv5')('actions_order', ''),
  local ordered() = { [order_key]:: $._count('actions_order') },

  anon():: std.toString($._count('actionId')),

  uuid(ns, name):: std.native('UUIDv5')(ns, name),

  _action(id):: ordered {
    WFWorkflowActionIdentifier: id,
  },

  _params(params):: {
    WFWorkflowActionParameters+: params,
  },

  Action(id, params):: (
    local unidentifiedAction = $._action(id) + $._params(params);
    local UUID = $.uuid('action', std.manifestJsonMinified(unidentifiedAction));
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

    std.sort(std.map(action_from_kv, actions_kv), order_key)
  ),

}
