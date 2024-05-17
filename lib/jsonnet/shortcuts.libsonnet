{
  _uuid(ns, name):: std.native('UUIDv5')(ns, name),

  local _id = 'WFWorkflowActionIdentifier',
  local _params = 'WFWorkflowActionParameters',

  Action(id, params={}, name=null):: (
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
    local actions_flat = std.flattenArrays(actions);
    if std.length(actions_flat) == 0 then
      []
    else (
      local action = actions_flat[0];
      local name = std.get(action[_params], 'CustomOutputName');
      local newOutputs = if name == null then outputs else outputs { [name]: action[_params].UUID };
      local newAction = { outputs:: newOutputs } + action;
      local rest = $.ActionsSeq(actions_flat[1:], newOutputs);
      [newAction] + rest
    )
  ),

  Ref(outputs, name, aggs=[]):: {
    Type: 'ActionOutput',
    OutputUUID: outputs[name],
    OutputName: name,
    Aggrandizements: aggs,
  },

  /**
    returns [i, unesc] where:
     - i is the start pos of next pat (null if no match), and
     - unesc is the unescaped version of string contents scanned so far
  */
  _findNextNotEscaped(s, pat, start=0, unescAcc=''):: (
    if start >= std.length(s) then
      [null, unescAcc]
    else
      local len = std.length(pat);
      // unescaped pattern: return start and accumulated unescaped string
      if std.substr(s, start, len) == pat then
        [start, unescAcc]
      // escaped pattern: skip and accumulate unescaped
      else if std.substr(s, start, len + 1) == '\\' + pat then
        $._findNextNotEscaped(s, pat, start + len + 1, unescAcc + pat) tailstrict
      // neither: accumulate
      else
        $._findNextNotEscaped(s, pat, start + 1, unescAcc) tailstrict
  ),

  _resolveAttachment(var, outputs=null) {
    if outputs == null then error ('Interpolation of `%s` missing outputs var' % var)
    else
      if var == '!Input' then { Type: 'ExtensionInput' }
      else sc.Ref(var, outputs)
  },

  _joiner: std.char(65532),

  _replaceAttachments(s, resolver, joiner=$._joiner, start=0, strAcc='', attsAcc={}):: (
    if s == '' then [strAcc, attsAcc]
    else
      local nextStart = $._findNextNotEscaped(s, '${', start), iNext = nextStart[0], strNext = nextStart[1];
      // no more interpolations
      if iNext == null then [strAcc + strNext, attsAcc]
      else
        local nextEnd = $._findNextNotEscaped(s, '}', start), jNext = nextEnd[0], varNext = nextEnd[1];
        if jNext == null then error ('Missing end `%s` for start `%s` at %d in `%s`' % [']', '${', iNext, s])
        else if varNext == '' then error ('Empty interpolation at %d in `%s`' % iNext, s)
        else
          // add interpoltation
          local startNext = jNext + 1;
          local strAccNext = strAcc + strNext + joiner;
          local attsAccNext = attsAcc + { ['{%d, 1}' % (std.length(strAccNext) - 1)]: resolver(varNext) };
          $._replaceAttachments(s, joiner, startNext, strAccNext, attsAccNext) tailstrict
  )

  _wrapItem(f, outputs=null, key=null):: {
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
      string: $.Val(f, outputs),
      number: ...,
      boolean: {
        WFSerializationType: 'WFNumberSubstitutableState',
        Value: $.Val(f, outputs)
      },
      object: {
        WFSerializationType: 'WFDictionaryFieldValue',
        Value: {
          WFDictionaryFieldValueItems: [
            $._wrapItem(item.value, outputs, key=item.key)
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

  Val(x, outputs=null):: {

    // string serialization
    string: (
      local resolver = function(var) $._resolveAttachment(var, outputs); // close over Val's outputs
      local xWithAtts = $._replaceAttachments(x, resolver), xUnesc = xWithAtts[0], xAtts = xWithAtts[1];
      if xUnesc == $._joiner then
        assert std.length(xAtts) == 1 : 'single attachment';
        {
          WFSerializationType: 'WFTextTokenAttachment',
          Value: std.objectValues(xAtts)[0],
        }
      else
        local attsObj = if xAtts == {} then { attachmentsbyRange: xAtts } else {};
        {
          WFSerializationType: 'WFTextTokenString',
          Value: ({ string: xUnesc } + attsObj),
        }
    )

    // dict serialization
    object: {
      // TODO
    },

    // list serialization (to itself)
    array: [

    ],

  }[
    std.type(x)
  ],

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
  //         Value: sc.Ref(outputs, 'Matches'),
  //         WFSerializationType: 'WFTextTokenAttachment',
  //       },
  //     },
  //   }),
    

  // ),

}
