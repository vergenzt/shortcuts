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
                  Value: 'Reminders',
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 4,
              Property: 'Is Completed',
              Removable: true,
              Values: {
                Bool: false,
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
      local outputs = super.outputs,
      GroupingIdentifier: '06C7177F-0DD0-4EF7-8354-638BF3E43DE8',
      WFControlFlowMode: 0,
      WFInput: {
        Value: sc.Ref(outputs, 'Reminders'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('com.atlassian.jira.app.CreateIssueIntent', name='Issue', params={
      account: 'vergenzt@gmail.com',
      issueType: {
        displayString: 'Task',
        identifier: '10072',
      },
      project: {
        displayString: 'Cards',
        identifier: '10008',
      },
      site: 'vergenz',
      summary: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{15, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Due Date',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
            '{22, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'URL',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
            '{7, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Notes',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: 'Notes:\n￼\n\nDue: ￼\nURL: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.atlassian.jira.app.SetIssueFieldIntent', name='Issue', params={
      local outputs = super.outputs,
      issue: {
        Value: sc.Ref(outputs, 'Issue'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      setFieldName: 'Description',
      setFieldValue: sc.Val('${Text}', outputs),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      UUID: 'C86E9AB3-CE48-45B0-B0A9-F723BD913903',
      WFContentItemPropertyName: 'List',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFReminderContentItemList: 'Added to Jira',
    }),

    sc.Action('is.workflow.actions.gettext', {
      local outputs = super.outputs,
      UUID: '7AFF23E1-2035-4D5B-AF32-A6222A5BA909',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Notes',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
            '{11, 1}': sc.Ref(outputs, 'Issue', aggs=[
              {
                PropertyName: 'site',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{34, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'key',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Issue',
              OutputUUID: '59B2D1C3-7557-4932-9EAF-BADCDC0C77B8',
              Type: 'ActionOutput',
            },
          },
          string: '￼\n\nhttps://￼.atlassian.net/browse/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      'Show-WFReminderContentItemTags': true,
      UUID: '67E3BB42-CF2A-45CC-9740-39D45C4E40E0',
      WFContentItemPropertyName: 'Notes',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFReminderContentItemIsCompleted: 1,
      WFReminderContentItemNotes: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': {
              OutputName: 'Text',
              OutputUUID: '7AFF23E1-2035-4D5B-AF32-A6222A5BA909',
              Type: 'ActionOutput',
            },
          },
          string: ' ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '06C7177F-0DD0-4EF7-8354-638BF3E43DE8',
      UUID: '0A5023FF-3BE0-4FD6-95F4-D7FDA0FB2A00',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59695,
    WFWorkflowIconStartColor: 463140863,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
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
