local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
      'does not have any value'
    )).Then_([

      sc.Action('is.workflow.actions.filter.reminders', name='Reminders', params={
        WFContentItemFilter: {
          Value: {
            WFActionParameterFilterPrefix: 1,
            WFActionParameterFilterTemplates: [
              {
                Operator: 4,
                Property: 'List',
                Removable: true,
                Values: {
                  Enumeration: {
                    Value: 'Reminders',
                    WFSerializationType: 'WFStringSubstitutableState',
                  },
                },
              },
            ],
            WFContentPredicateBoundedDate: false,
          },
          WFSerializationType: 'WFContentPredicateTableTemplate',
        },
      }),

      sc.Action('is.workflow.actions.choosefromlist', {
        WFChooseFromListActionPrompt: 'Select a reminder to get the UUID from.',
        WFInput: sc.Attach(sc.Ref('Reminders')),
      }),

    ]).Else_([

    ]).EndIf_(name='If Result'),

    sc.Action('is.workflow.actions.setitemname', name='Renamed Item', params={
      WFInput: sc.Attach(sc.Ref('If Result')),
      WFName: 'reminder.txt',
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: '\\nUID:(.*)\\n',
      text: sc.Str([sc.Ref('Renamed Item')]),
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='UUID', params={
      matches: sc.Attach(sc.Ref('Matches')),
    }),

    sc.Action('is.workflow.actions.url', {
      WFURLActionURL: sc.Str(['x-apple-reminderkit://REMCDReminder/', sc.Ref('UUID')]),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
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
