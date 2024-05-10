{
  _uuid(ns, name):: std.native('UUIDv5')(ns, name),

  local _id = 'WFWorkflowActionIdentifier',
  local _params = 'WFWorkflowActionParameters',

  Action(id, params, name=null):: (
    local unidentifiedAction = (
      { [_id]: id }
      { [_params]: params }
    );
    unidentifiedAction + (
      if name != null
      then
        { [_params]+: { CustomOutputName: name } } +
        { [_params]+: { UUID: $._uuid('action', std.manifestJsonMinified(unidentifiedAction)) } }
      else
        {}
    )
  ),

  ActionsSeq(actions, outputs={}):: (
    if std.length(actions) == 0 then
      []
    else (
      local action = actions[0];
      local name = std.get(action[_params], 'CustomOutputName');
      local newOutputs = if name == null then outputs else outputs { [name]: action[_params].UUID };
      local newAction = { outputs:: newOutputs } + action;
      local rest = $.ActionsSeq(actions[1:], newOutputs);
      [newAction] + rest
    )
  ),

  Ref(outputs, name, aggs=[]):: {
    Type: 'ActionOutput',
    OutputUUID: outputs[name],
    OutputName: name,
    Aggrandizements: aggs,
  },

}
