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

    sc.Action('is.workflow.actions.list', name='List', params={
      local state = super.state,
      WFItems: [
        {
          WFItemType: 0,
          WFValue: {
            Value: {
              attachmentsByRange: {
                '{0, 1}': {
                  Aggrandizements: [
                    {
                      PropertyName: 'Folder',
                      Type: 'WFPropertyVariableAggrandizement',
                    },
                  ],
                  Type: 'Variable',
                  VariableName: 'Repeat Item',
                },
              },
              string: '￼',
            },
            WFSerializationType: 'WFTextTokenString',
          },
        },
        {
          WFItemType: 0,
          WFValue: sc.Val('${Vars.Repeat Item}', state),
        },
      ],
    }),

    sc.Action('is.workflow.actions.text.combine', {
      local state = super.state,
      WFTextCustomSeparator: '/',
      WFTextSeparator: 'Custom',
      text: sc.Ref(state, 'List', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      local state = super.state,
      GroupingIdentifier: '3C39F304-C709-4042-8340-B48B1B383EB8',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      local state = super.state,
      text: sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.output', {
      local state = super.state,
      WFOutput: sc.Val('${Combined Text}', state),
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
    'WFFolderContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowTypes: [],
}
