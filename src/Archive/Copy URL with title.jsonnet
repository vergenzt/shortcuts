local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getarticle', name='Article', params={
      WFWebPage: sc.Val('${Shortcut Input}', outputs),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Article', aggs=[
              {
                PropertyName: 'Title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{3, 1}': sc.Ref(outputs, 'Shortcut Input'),
          },
          string: '￼: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Text', att=true),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59791,
    WFWorkflowIconStartColor: 255,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorShowError',
    Parameters: {},
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
  ],
}
