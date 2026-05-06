local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
      'is',
      {
        WFConditionalActionString: 'Mac',
      }
    )).Then_([

      sc.Action('is.workflow.actions.gettext', {
        WFTextActionText: 'https',
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.gettext', {
        WFTextActionText: 'googlesheets',
      }),

    ]).EndIf_(name='Scheme'),

    sc.Action('is.workflow.actions.url', name='URL', params={
      'Show-WFURLActionURL': true,
      WFURLActionURL: sc.Str([sc.Ref('Scheme')]),
    }),

    sc.Action('is.workflow.actions.openurl', {
      'Show-WFInput': true,
      WFInput: sc.Attach(sc.Ref('URL')),
    }),

  ]),
  WFWorkflowClientVersion: '4528.0.4.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59749,
    WFWorkflowIconStartColor: -2873601,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFPhotoMediaContentItem',
      SerializedParameters: {},
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'WFWorkflowTypeShowInSearch',
    'Watch',
  ],
}
