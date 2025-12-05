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
  _resolveState(x, state, override=false):: (
    if std.isFunction(x) then
      if override then null
      else if std.length(x) == 1 then $._resolveState(x(state), std.trace(state, state), override)
      else error 'Cannot resolve non-unary action function'
    else if std.isObject(x) then std.mapWithKey(function(k, v) $._resolveState(v, state, override), x)
    else if std.isArray(x) then std.map(function(v) $._resolveState(v, state, override), x)
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
        else error ('warning: output `%s` not found in state' % name)
      ),
      OutputName: name,
      [if aggs == [] then null else 'Aggrandizements']: aggs,
    }
  ),

  // Dict(dict):: {
  //   WFSerializationType: 'WFDictionaryFieldValue',
  //   Value: {
  //     WFDictionaryFieldValueItems: [
  //       {
  //         WFItemType: (
  //           local type = dict[WFSerializationType];
  //           local typeNumsByType = {
  //             WFTextTokenString: 0,
  //             WFDictionaryFieldValue: 1,
  //             WFArrayParameterState: 2,
  //             WFNumberSubstitutableState: 3,

  //           };
  //           typeNumsByType[type]
  //         )

  // //     string: 0,
  // //     object: 1,
  // //     array: 2,
  // //     number: 3,
  // //     boolean: 4,
  //         },
  //         WFKey: $.Str([key]),

  //       }
  //       for key in std.objectFields(dict)
  //     ]
  //   },
  // },

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

  _interpJoiner:: std.char(65532),

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
      Value: std.prune({
        string: std.join('', partStrs),
        attachmentsByRange: attachments,
      }),
      WFSerializationType: 'WFTextTokenString',
    }
  ),

  Input:: {
    Type: 'ExtensionInput',
  },

  Attach(val):: {
    Value: val,
    WFSerializationType: 'WFTextTokenAttachment',
  },

  Ops:: {
    'is less than': 0,
    'is less than or equal to': 1,
    'is greater than': 2,
    'is greater than or equal to': 3,
    is: 4,
    'is not': 5,
    'starts with': 8,
    'ends with': 9,
    contains: 99,
    'does not contain': 100,
    'has any value': 101,
    'does not have any value': 999,
    'is between': 1003,  // dates! includes additional WFDate and WFAnotherDate params

    '<': self['is less than'],
    '≤': self['is less than or equal to'],
    '>': self['is greater than'],
    '≥': self['is greater than or equal to'],
    '=': self.is,
    '≠': self['is not'],
    '^': self['starts with'],
    '$': self['ends with'],
    '∈': self.contains,
    '∉': self['does not contain'],
    '∃': self['has any value'],
    '∄': self['does not have any value'],
    '⦷': self['is between'],
  },

  Cond(input, cond, operands={}):: operands {
    WFInput: input,
    WFCondition: std.get(
      {
        string: $.Ops[cond],
        number: cond,
      },
      std.type(cond),
      error 'invalid condition type: ' + std.type(cond),
    ),
  },

  ControlFlowMode:: {
    Begin: 0,
    Else: 1,
    End: 2,
  },

  _CombineConditions(filter_pfx, conds):: (
    if std.assertEqual(std.type(filter_pfx), 'number')
       && std.assertEqual(std.type(conds), 'array') then
      {
        WFConditions: {
          Value: {
            WFActionParameterFilterPrefix: filter_pfx,
            WFActionParameterFilterTemplates: conds,
            WFContentPredicateBoundedDate: false,
          },
          WFSerializationType: 'WFContentPredicateTableTemplate',
        },
      }
  ),

  AnyOf(conds):: $._CombineConditions(0, conds),
  AllOf(conds):: $._CombineConditions(1, conds),

  If_(cond, name=null):: (

    local ifActionWithoutId = (
      $.Action('is.workflow.actions.conditional', name=name, params=(
        {
          WFControlFlowMode: $.ControlFlowMode.Begin,
        }
        + cond
      ))
    );

    local id = $._uuid('conditional', std.manifestJsonMinified($._resolveState(ifActionWithoutId, {}, override=true)));

    local ifAction = ifActionWithoutId { [_params]+: { GroupingIdentifier: id } };

    local elseAction = (
      $.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: id,
        WFControlFlowMode: $.ControlFlowMode.Else,
      })
    );

    {
      Then_(actions):: self + { _then_:: actions },
      Else_(actions):: self + { _else_:: actions },

      EndIf_(name=null):: (
        local thenActions = std.get(self, '_then_', []);
        local elseActions = std.get(self, '_else_', []);
        local endIfAction = (
          $.Action('is.workflow.actions.conditional', name=name, params={
            GroupingIdentifier: id,
            WFControlFlowMode: $.ControlFlowMode.End,
          })
        );

        (
          [ifAction]
          + thenActions
          + (
            if std.length(elseActions) > 0
            then [elseAction] + elseActions
            else []
          )
          + [endIfAction]
        )
      ),
    }
  ),

}
