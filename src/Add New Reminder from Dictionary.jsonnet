local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Dictionary', params={
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.addnewreminder', {
      WFAlertCondition: 'At Time',
      WFAlertEnabled: 'No Alert',
      WFCalendarDescriptor: sc.Attach(sc.Ref('Dictionary', aggs=[
        {
          DictionaryKey: 'list',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
      WFCalendarItemNotes: sc.Str([sc.Ref('Dictionary', aggs=[
        {
          DictionaryKey: 'notes',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFCalendarItemTitle: sc.Str([sc.Ref('Dictionary', aggs=[
        {
          DictionaryKey: 'reminder',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFTags: '',
      WFURL: sc.Str([sc.Ref('Dictionary', aggs=[
        {
          DictionaryKey: 'url',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -20702977,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
    'WFRichTextContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorShowError',
    Parameters: {
      Error: 'No input',
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
