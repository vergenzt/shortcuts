local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      local state = super.state,
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      WFCondition: 4,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Device Model', att=true),
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      local state = super.state,
      WFTextActionText: 'https',
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      local state = super.state,
      WFTextActionText: 'googlesheets',
    }),

    sc.Action('is.workflow.actions.conditional', name='Scheme', params={
      local state = super.state,
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      local state = super.state,
      'Show-WFURLActionURL': true,
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Scheme'),
            '{35, 1}': sc.Ref(state, 'Shortcut Input'),
          },
          string: '￼://docs.google.com/spreadsheets/d/￼/edit',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      local state = super.state,
      'Show-WFInput': true,
      WFInput: sc.Ref(state, 'URL', att=true),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59749,
    WFWorkflowIconStartColor: 4292093695,
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
  WFWorkflowTypes: [],
}
