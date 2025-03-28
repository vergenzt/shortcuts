local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'F88CABCB-35BA-4710-96DB-0FAD3F9743DD',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
    }),

    sc.Action('is.workflow.actions.filter.reminders', name='Reminders'),

    sc.Action('is.workflow.actions.choosefromlist', {
      WFChooseFromListActionPrompt: 'Select a reminder to get the UUID from.',
      WFInput: sc.Attach(sc.Ref('Reminders')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'F88CABCB-35BA-4710-96DB-0FAD3F9743DD',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'F88CABCB-35BA-4710-96DB-0FAD3F9743DD',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setitemname', name='Renamed Item', params={
      WFInput: sc.Attach(sc.Ref('If Result')),
      WFName: 'reminder.txt',
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      'Show-text': true,
      text: sc.Attach(sc.Ref('Renamed Item')),
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: 'UID:(.*)\\n',
      text: sc.Str([sc.Ref('Split Text')]),
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='UUID', params={
      matches: sc.Attach(sc.Ref('Matches')),
    }),

    sc.Action('is.workflow.actions.url', {
      WFURLActionURL: sc.Str(['x-apple-reminderkit://REMCDReminder/', sc.Ref('UUID')]),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59848,
    WFWorkflowIconStartColor: 1440408063,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'Watch',
  ],
}
