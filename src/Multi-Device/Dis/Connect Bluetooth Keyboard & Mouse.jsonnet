local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BE2BC4A8-F271-4966-8D15-C7CBBAD98231',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        'connect',
        'disconnect',
      ],
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      WFInput: sc.Attach(sc.Ref('List')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BE2BC4A8-F271-4966-8D15-C7CBBAD98231',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.conditional', name='Input', params={
      GroupingIdentifier: 'BE2BC4A8-F271-4966-8D15-C7CBBAD98231',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3D7D86FA-F465-4011-B3F0-CEE2EF145604',
      WFCondition: 4,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: 'mouse=10-94-bb-a9-41-7a\nkeybd=70-f0-87-36-14-6e',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '85E5E021-51C7-424D-B6DE-DD35C224E368',
      WFCondition: 4,
      WFConditionalActionString: 'disconnect',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Input', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.runshellscript', {
      Input: sc.Attach(sc.Ref('Text')),
      Script: "parallel --plain -t --tagstring='{1}' --colsep='=' \\\n  blueutil --unpair '{2}' '# {1}'",
      Shell: '/bin/bash',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '85E5E021-51C7-424D-B6DE-DD35C224E368',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.runshellscript', {
      Input: sc.Attach(sc.Ref('Text')),
      RunAsRoot: false,
      Script: "parallel --plain -t --tagstring='{1}' --colsep='=' \\\n  blueutil --pair '{2}' 0000 '# {1}'",
      Shell: '/bin/bash',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '85E5E021-51C7-424D-B6DE-DD35C224E368',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3D7D86FA-F465-4011-B3F0-CEE2EF145604',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2F619821-D7B7-420B-BBF4-1BD6F99E4B5A',
      WFCondition: 4,
      WFConditionalActionString: 'disconnect',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Input', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: "You will be taken Bluetooth Preferences. Please \"Forget\" Tim's Apple mouse & Tim's Keyboard, then return to Shortcuts.",
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2F619821-D7B7-420B-BBF4-1BD6F99E4B5A',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: "You will be taken Bluetooth Preferences. Please \"Pair\" Tim's Apple mouse & Tim's Keyboard.",
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '2F619821-D7B7-420B-BBF4-1BD6F99E4B5A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('If Result')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'F5C12AD8-86EC-4BC7-8E52-8564AB5EFDD4',
        workflowName: 'Open Bluetooth Preferences',
      },
      WFWorkflowName: 'Open Bluetooth Preferences',
    }),

    sc.Action('is.workflow.actions.waittoreturn'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3D7D86FA-F465-4011-B3F0-CEE2EF145604',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -43634177,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
