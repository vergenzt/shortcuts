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
                  Value: 'Home Maintenance',
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
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'C50725B5-1A7B-4FBE-80AC-28DFADDBD8DF',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Reminders')),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      WFContentItemPropertyName: 'Is Completed',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFReminderContentItemIsCompleted: 1,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'C50725B5-1A7B-4FBE-80AC-28DFADDBD8DF',
      WFControlFlowMode: 2,
    }),

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
                  Value: 'Home Maintenance',
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D83672DB-3976-48BC-8E57-4BE508D2A7C3',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Reminders')),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      WFContentItemPropertyName: 'Is Completed',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFReminderContentItemIsCompleted: 0,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D83672DB-3976-48BC-8E57-4BE508D2A7C3',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -12365313,
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
