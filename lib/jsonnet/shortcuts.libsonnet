{
  _uuid(ns, name):: std.native('UUIDv5')(ns, name),

  local _id = 'WFWorkflowActionIdentifier',
  local _params = 'WFWorkflowActionParameters',

  /**
    Waiting for https://github.com/google/jsonnet/commit/fe8179a8560de6908e52aeef48a03e6fc76035d8
    to be released to stdlib
   */
  _flattenDeepArray(value)::
    if std.isArray(value) then
      [y for x in value for y in $._flattenDeepArray(x)]
    else
      [value],

  Action(id, params={}, name=null):: (
    { [_id]: id }
    { [_params]: params }
    + (
      if name != null then
        {
          [_params]+: {
            CustomOutputName: name,
          },
        }
      else {}
    )
  ),

  ActionsSeq(actions):: $._actionsSeqRecursive($._flattenDeepArray(actions)),

  _actionsSeqRecursive(actionsRaw, prevActions=[], prevState={}):: (
    if actionsRaw == [] then
      prevActions
    else
      local nextActionRaw = actionsRaw[0];
      local nextActionNoID = $._resolveState(nextActionRaw, prevState);
      local nextActionName = std.get(nextActionNoID[_params], 'CustomOutputName');
      local nextActionUUID = if nextActionName != null then $._uuid('action', std.manifestJsonMinified(nextActionNoID));
      local nextAction = (
        nextActionNoID +
        if nextActionName != null then
          { [_params]+: { UUID: nextActionUUID } }
        else {}
      );
      local nextActions = prevActions + [nextAction];
      local nextState = (
        prevState +
        if nextActionName != null then
          { [nextActionName]: nextActionUUID }
        else {}
      );
      $._actionsSeqRecursive(actionsRaw[1:], nextActions, nextState) tailstrict
  ),

  /**
  Recursively updates `x`, passing `state` into any functions found and replacing with the result.
  Throws error if any functions do not have arity 1.
   */
  _resolveState(x, state):: (
    if std.isFunction(x) then
      if std.length(x) == 1 then $._resolveState(x(state), std.trace(state, state))
      else error 'Cannot resolve non-unary action function'
    else if std.isObject(x) then std.mapWithKey(function(k, v) $._resolveState(v, state), x)
    else if std.isArray(x) then std.map(function(v) $._resolveState(v, state), x)
    else x
  ),

  Ref(name, aggs=[]):: (
    if std.startsWith(name, 'Vars.') then {
      Type: 'Variable',
      VariableName: std.substr(name, 5, std.length(name)),
    }
    else {
      Type: 'ActionOutput',
      OutputUUID: function(state) (
        if std.objectHas(state, name) then state[name]
        else std.trace('warning: output `%s` not found in state' % name, '???')
      ),
      OutputName: name,
      [if aggs == [] then null else 'Aggrandizements']: aggs,
    }
  ),

  _interpJoiner: std.char(65532),

  // _wrapItem(f, state=null, key=null):: {
  //   [if key != null then 'WFKey']: $.Val(key),
  //   WFItemType: {
  //     string: 0,
  //     object: 1,
  //     array: 2,
  //     number: 3,
  //     boolean: 4,
  //     'null': error 'Cannot produce Shortcuts value for null',
  //   }[std.type(f)],
  //   WFValue: {
  //     string: $.Val(f, state),
  //     number: f,
  //     boolean: {
  //       WFSerializationType: 'WFNumberSubstitutableState',
  //       Value: $.Val(f, state),
  //     },
  //     object: {
  //       WFSerializationType: 'WFDictionaryFieldValue',
  //       Value: {
  //         WFDictionaryFieldValueItems: [
  //           $._wrapItem(item.value, state, key=item.key)
  //           for item in std.objectKeysValues(f)
  //         ],
  //       },
  //     },
  //     array: {
  //       WFSerializationType: 'WFArrayParameterState',
  //       Value: std.map($._wrapItem, f),
  //     },
  //   }[std.type(f)],
  // },

  Num(val):: {
    Value: val,
    WFSerializationType: 'WFNumberSubstitutableState',
  },

  Str(parts):: (
    local partStrs = std.map(function(part) if std.isString(part) then part else $._interpJoiner, parts);
    local partStrLens = std.map(std.length, partStrs);
    local partStrStarts = std.makeArray(std.length(parts), function(i) std.sum(partStrLens[:i]));
    local attachments = {
      ['{' + partStrStarts[i] + ', 1}']: parts[i]
      for i in std.range(0, std.length(parts) - 1)
      if !std.isString(parts[i])
    };
    {
      WFSerializationType: 'WFTextTokenString',
      Value: std.prune({
        string: std.join('', partStrs),
        attachmentsByRange: attachments,
      }),
    }
  ),

  Input:: {
    Type: 'ExtensionInput',
  },

  Attach(val):: {
    Value: val,
    WFSerializationType: 'WFTextTokenAttachment',
  },

  // Cond: {
  // 	LessThan:       0,
  // 	LessOrEqual:    1,
  // 	GreaterThan:    2,
  // 	GreaterOrEqual: 3,
  //   Is:             4,
  // 	Not:            5,
  // 	BeginsWith:     8,
  // 	EndsWith:       9,
  // 	Contains:       99,
  // 	Any:            100,
  // 	Empty:          101,
  // 	DoesNotContain: 999,
  // 	Between:        1003,
  // },

  // If(input, cond, then_acts, else_acts=[], name=null):: (

  //   sc.Action('is.workflow.actions.conditional', {
  //     GroupingIdentifier: '...',
  //     WFCondition: 100,
  //     WFControlFlowMode: 0,
  //     WFInput: {
  //       Type: 'Variable',
  //       Variable: {
  //         Value: sc.Ref(state, 'Matches'),
  //         WFSerializationType: 'WFTextTokenAttachment',
  //       },
  //     },
  //   }),


  // ),

}
