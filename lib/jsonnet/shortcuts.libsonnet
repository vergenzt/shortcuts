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
    std.sort(
      [
        actions_obj[name] + (
          // (if name is not hidden)
          if std.objectHas(actions_obj, name)
          then $._params({ CustomOutputName: name })
          else $._params({})
        )
        for name in std.objectFieldsAll(actions_obj)
      ],
      function(action) action[order_key],
    )
  ),

}
