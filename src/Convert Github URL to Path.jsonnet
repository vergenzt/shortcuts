local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: 'https://github.com/(?:\\w+)/(?:\\w+)/(?:blob|tree)/(?:[0-9a-f]+/)(.*)',
      text: sc.Str([sc.Input]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '37FACB10-90AE-4291-8398-BEA591C7E341',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Matches')),
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Attach(sc.Input),
      WFNotificationActionBody: sc.Str(['No Github URL detected: ', sc.Input]),
      WFNotificationActionSound: false,
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '37FACB10-90AE-4291-8398-BEA591C7E341',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='Text', params={
      WFGroupIndex: '1',
      matches: sc.Attach(sc.Ref('Matches')),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'path',
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Attach(sc.Input),
      WFNotificationActionBody: sc.Str([sc.Ref('Vars.path')]),
      WFNotificationActionSound: false,
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Copy to Clipboard',
      WFOutput: sc.Str([sc.Ref('Vars.path')]),
      WFResponse: sc.Str([sc.Ref('Text')]),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: true,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 463140863,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorGetClipboard',
    Parameters: {},
  },
  WFWorkflowOutputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowTypes: [
    'QuickActions',
    'ReceivesOnScreenContent',
  ],
}
