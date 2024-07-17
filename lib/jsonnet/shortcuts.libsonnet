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

  ActionsSeq(actionsRawUnflat):: $._actionsSeqRecursive($._flattenDeepArray(actionsRawUnflat)),

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

  Ref(state, name, aggs=[], att=false):: (
    local ref = (
      if std.startsWith(name, 'Vars.') then {
        Type: 'Variable',
        VariableName: std.substr(name, 5, std.length(name)),
      }
      else if name == 'Shortcut Input' then {
        Type: 'ExtensionInput',
      }
      else {
        Type: 'ActionOutput',
        OutputUUID: std.get(state, name, std.trace('warning: output `%s` not found in state' % name, '???')),
        OutputName: name,
        [if aggs == [] then null else 'Aggrandizements']: aggs,
      }
    );
    if att then {
      WFSerializationType: 'WFTextTokenAttachment',
      Value: ref,
    }
    else ref
  ),

  _interpJoiner: std.char(65532),
  _interpStart: '${',
  _interpEnd: '}',
  _interpEscape: '\\',

  /**
  @returns [i, unesc] where:
    - i is the position of the next character after the pattern (null if no match), and
    - unesc is the unescaped string contents from start to pat start (or end of string)
  */
  _findNextNotEscaped(s, pat, iAcc=0, unescAcc=''):: (
    local esc = $._interpEscape;
    if pat == '' then error 'Pattern cannot be empty!'
    else if s == '' then
      [null, unescAcc]
    else if std.startsWith(s, pat) then
      [iAcc + std.length(pat), unescAcc]
    else if std.startsWith(s, esc) then
      local nextUnesc =
        if std.startsWith(s, esc + esc) then esc
        else if std.startsWith(s, esc + pat) then pat
        else error 'Invalid escape: ' + s
      ;
      local inc = std.length(esc) + std.length(nextUnesc);
      $._findNextNotEscaped(s[inc:], pat, iAcc + inc, unescAcc + nextUnesc) tailstrict
    else
      $._findNextNotEscaped(s[1:], pat, iAcc + 1, unescAcc + s[0]) tailstrict
  ),

  _resolveAttachment(var, state=null):: (
    if state == null then error ('Interpolation of `%s` missing state var' % var)
    else
      if var == '!Input' then { Type: 'ExtensionInput' }
      else $.Ref(state, var)
  ),

  /**
  @returns [str, atts] where:
    - str is the WFTextTokenString string with interpolations replaced with $._interpJoiner
    - atts is the mapping from '{X, 1}', where X is the position of a joiner, to the result of
      calling _resolver with the string inside the interpolation at X
  */
  _replaceAttachments(s, resolver, strAcc='', attsAcc={}):: (
    if s == '' then [strAcc, attsAcc]
    else
      local nextStart = $._findNextNotEscaped(s, $._interpStart), iNext = nextStart[0], strNext = nextStart[1];
      // no more interpolations
      if iNext == null then [strAcc + strNext, attsAcc]
      else
        local nextEnd = $._findNextNotEscaped(s[iNext:], $._interpEnd), jNext = nextEnd[0], varNext = nextEnd[1];
        if jNext == null then error ('Missing end `%s` for start `%s` at %d in `%s`' % [$._interpStart, $._interpEnd, iNext, s])
        else if varNext == '' then error ('Empty interpolation at %d in `%s`' % [iNext, s])
        else
          // add interpolation
          local strAccNext = strAcc + strNext + $._interpJoiner;
          local attsAccNext = attsAcc { ['{%d, 1}' % (std.length(strAccNext) - 1)]: resolver(varNext) };
          $._replaceAttachments(s[(iNext + jNext):], resolver, strAccNext, attsAccNext) tailstrict
  ),

  _wrapItem(f, state=null, key=null):: {
    [if key != null then 'WFKey']: $.Val(key),
    WFItemType: {
      string: 0,
      object: 1,
      array: 2,
      number: 3,
      boolean: 4,
      'null': error 'Cannot produce Shortcuts value for null',
    }[std.type(f)],
    WFValue: {
      string: $.Val(f, state),
      number: f,
      boolean: {
        WFSerializationType: 'WFNumberSubstitutableState',
        Value: $.Val(f, state),
      },
      object: {
        WFSerializationType: 'WFDictionaryFieldValue',
        Value: {
          WFDictionaryFieldValueItems: [
            $._wrapItem(item.value, state, key=item.key)
            for item in std.objectKeysValues(f)
          ],
        },
      },
      array: {
        WFSerializationType: 'WFArrayParameterState',
        Value: std.map($._wrapItem, f),
      },
    }[std.type(f)],
  },

  Val(x, state=null):: (
    if std.isString(x) then
      local resolver = function(var) $._resolveAttachment(var, state);  // close over Val's state
      local xWithAtts = $._replaceAttachments(x, resolver), xUnesc = xWithAtts[0], xAtts = xWithAtts[1];
      local attsObj = if xAtts == {} then {} else { attachmentsByRange: xAtts };
      {
        WFSerializationType: 'WFTextTokenString',
        Value: ({ string: xUnesc } + attsObj),
      }
    else
      x
  ),

  // Att(val):: ,

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
