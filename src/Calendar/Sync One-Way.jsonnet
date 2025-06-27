local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Input dictionary with keys to sync Lists 1 and 2:\n- “Get List 1”: name of Shortcut to get list 1 (input: timestamp of sync start)\n- “Get List 2”: name of Shortcut to get list 2 (input: timestamp of sync start)\n- “ID of #1”: name of Shortcut returning string ID of a #1 (equal IDs are considered equivalent #1s and #2s); input: #1\n- “ID of #2”: name of Shortcut returning string ID of a #2; input: #2\n- “Create 2 from 1”: name of Shortcut to invoke when a #1 has no equivalent #2\n- “Remove orphaned 2”: name of Shortcut to invoke when a #2 has no equivalent #1',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Empty Dictionary'),

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('is.workflow.actions.detect.dictionary', {
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '1DD36090-71D0-4A2E-8298-27600CDC450F',
      WFControlFlowMode: 0,
      WFRepeatCount: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Empty Dictionary')),
      WFVariableName: 'Items by ID',
    }),

    sc.Action('is.workflow.actions.gettext', name='Get List #', params={
      WFTextActionText: sc.Str(['Get List ', sc.Ref('Vars.Repeat Index')]),
    }),

    sc.Action('is.workflow.actions.runworkflow', name='List #', params={
      WFInput: sc.Attach(sc.Ref('Date')),
      WFWorkflow: sc.Attach(sc.Ref('Get List #')),
      WFWorkflowName: sc.Attach(sc.Ref('Get List #')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '73D717D1-F784-4811-8140-C129A91D56CA',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('List #')),
    }),

    sc.Action('is.workflow.actions.gettext', name='ID of #', params={
      WFTextActionText: sc.Str(['ID of #', sc.Ref('Vars.Repeat Index')]),
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Item ID', params={
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
      WFWorkflow: sc.Attach(sc.Ref('ID of #')),
      WFWorkflowName: sc.Attach(sc.Ref('ID of #')),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', {
      WFDictionary: sc.Attach(sc.Ref('Vars.Items by ID')),
      WFDictionaryKey: sc.Str([sc.Ref('Item ID')]),
      WFDictionaryValue: sc.Str([sc.Ref('Vars.Repeat Item 2')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '73D717D1-F784-4811-8140-C129A91D56CA',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Items by ID')),
      WFVariableName: 'Lists by ID',
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '1DD36090-71D0-4A2E-8298-27600CDC450F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='List #1 by IDs', params={
      WFInput: sc.Attach(sc.Ref('Vars.Lists by ID')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='#1 IDs', params={
      WFGetDictionaryValueType: 'All Keys',
      WFInput: sc.Attach(sc.Ref('List #1 by IDs')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='List #2 by IDs', params={
      WFInput: sc.Attach(sc.Ref('Vars.Lists by ID')),
      WFItemSpecifier: 'Last Item',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='#2 IDs', params={
      WFGetDictionaryValueType: 'All Keys',
      WFInput: sc.Attach(sc.Ref('List #2 by IDs')),
    }),

    sc.Action('ke.bou.GizmoPack.CombineListsIntent', {
      firstList: sc.Attach(sc.Ref('#1 IDs')),
      operation: 'subtract',
      secondList: sc.Attach(sc.Ref('#2 IDs')),
    }),

    sc.Action('ke.bou.GizmoPack.CombineListsIntent', {
      firstList: sc.Attach(sc.Ref('#2 IDs')),
      operation: 'subtract',
      secondList: sc.Attach(sc.Ref('#1 IDs')),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59846,
    WFWorkflowIconStartColor: 431817727,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
