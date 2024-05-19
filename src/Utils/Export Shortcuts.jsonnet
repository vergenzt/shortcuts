local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getmyworkflows', name='My Shortcuts'),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: '3C39F304-C709-4042-8340-B48B1B383EB8',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'My Shortcuts', att=true),
    }),

    sc.Action('is.workflow.actions.documentpicker.save', {
      local state = super.state,
      WFAskWhereToSave: false,
      WFFileDestinationPath: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Folder',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
            '{3, 1}': sc.Ref(state, 'Vars.Repeat Item'),
          },
          string: '/￼/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFSaveFileOverwrite: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      local state = super.state,
      GroupingIdentifier: '3C39F304-C709-4042-8340-B48B1B383EB8',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.output', {
      local state = super.state,
      WFOutput: sc.Val('${Repeat Results}', state),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -2873601,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1106,
  WFWorkflowMinimumClientVersionString: '1106',
  WFWorkflowOutputContentItemClasses: [
    'WFGenericFileContentItem',
  ],
  WFWorkflowTypes: [],
}
