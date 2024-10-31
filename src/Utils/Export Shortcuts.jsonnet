local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getmyworkflows', name='My Shortcuts'),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3C39F304-C709-4042-8340-B48B1B383EB8',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('My Shortcuts')),
    }),

    sc.Action('is.workflow.actions.documentpicker.save', {
      WFAskWhereToSave: false,
      WFFileDestinationPath: sc.Str(['/', {
        Aggrandizements: [
          {
            PropertyName: 'Folder',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFSaveFileOverwrite: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '3C39F304-C709-4042-8340-B48B1B383EB8',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.output', {
      WFOutput: sc.Str([sc.Ref('Repeat Results')]),
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
