local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='New File Name', params={
      WFTextActionText: sc.Str(['@', {
        Aggrandizements: [
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormat: 'yyyyMMddHHmmssSSS',
            WFDateFormatStyle: 'Custom',
            WFISO8601IncludeTime: false,
          },
        ],
        Type: 'CurrentDate',
      }, '.md']),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: sc.Str(['obsidian://new?vault=brain&name=', sc.Ref('New File Name')]),
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: sc.Attach(sc.Ref('URL')),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61466,
    WFWorkflowIconStartColor: 2071128575,
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
