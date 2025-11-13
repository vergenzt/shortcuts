local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.filter.reminders', name='Reminders', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Operator: 4,
              Property: 'List',
              Removable: true,
              Values: {
                Enumeration: {
                  Value: 'Perishable Food',
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 4,
              Property: 'Is Completed',
              Removable: true,
              Values: {
                Bool: {
                  Value: false,
                  WFSerializationType: 'WFBooleanSubstitutableState',
                },
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemInputParameter: 'Library',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'A3C7C977-62E5-4ECF-87BC-A8BA17E5F2CB',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Reminders')),
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: '^(\\d{4}-\\d{2}-\\d{2})\\b',
      text: sc.Str([sc.Ref('Vars.Repeat Item')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '5630081B-6738-4504-BA2E-C74F99F1FE1E',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Matches')),
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'Creation Date',
            PropertyUserInfo: 'WFFileCreationDate',
            Type: 'WFPropertyVariableAggrandizement',
          },
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormat: 'yyyy-MM-dd EEE',
            WFDateFormatStyle: 'Custom',
            WFISO8601IncludeTime: false,
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      WFContentItemPropertyName: 'Title',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFReminderContentItemTitle: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '5630081B-6738-4504-BA2E-C74F99F1FE1E',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'A3C7C977-62E5-4ECF-87BC-A8BA17E5F2CB',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -43634177,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFAppContentItem',
    'WFAppStoreAppContentItem',
    'WFArticleContentItem',
    'WFContactContentItem',
    'WFDateContentItem',
    'WFEmailAddressContentItem',
    'WFFolderContentItem',
    'WFGenericFileContentItem',
    'WFImageContentItem',
    'WFiTunesProductContentItem',
    'WFLocationContentItem',
    'WFDCMapsLinkContentItem',
    'WFAVAssetContentItem',
    'WFPDFContentItem',
    'WFPhoneNumberContentItem',
    'WFRichTextContentItem',
    'WFSafariWebPageContentItem',
    'WFStringContentItem',
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
