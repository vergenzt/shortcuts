local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      WFCondition: 4,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Device Model', att=true),
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: 'https',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: 'googlesheets',
    }),

    sc.Action('is.workflow.actions.conditional', name='Scheme', params={
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      'Show-WFURLActionURL': true,
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Scheme'),
            '{35, 1}': function(state) sc.Ref(state, 'Shortcut Input'),
          },
          string: '￼://docs.google.com/spreadsheets/d/￼/edit',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      'Show-WFInput': true,
      WFInput: function(state) sc.Ref(state, 'URL', att=true),
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
