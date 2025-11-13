local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      WFInput: sc.Str([sc.Input]),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['message://', sc.Ref('URL Encoded Text')]),
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: sc.Attach(sc.Ref('Text')),
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Copy to Clipboard',
      WFOutput: sc.Str([sc.Ref('Text')]),
      WFResponse: sc.Str([sc.Ref('Text')]),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: true,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 62041,
    WFWorkflowIconStartColor: 3031607807,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
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
    'ActionExtension',
    'Watch',
  ],
}
