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
      local state = super.state,
      GroupingIdentifier: '06C7177F-0DD0-4EF7-8354-638BF3E43DE8',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Reminders', att=true),
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
      summary: sc.Val('${Vars.Repeat Item}', state),
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
      local state = super.state,
      issue: sc.Ref(state, 'Issue', att=true),
      setFieldName: 'Description',
      setFieldValue: sc.Val('${Text}', state),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      WFContentItemPropertyName: 'List',
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFReminderContentItemList: 'Added to Jira',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      local state = super.state,
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
            '{11, 1}': sc.Ref(state, 'Issue', aggs=[
              {
                PropertyName: 'site',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{34, 1}': sc.Ref(state, 'Issue', aggs=[
              {
                PropertyName: 'key',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
          },
          string: '￼\n\nhttps://￼.atlassian.net/browse/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      local state = super.state,
      Mode: 'Set',
      'Show-WFReminderContentItemTags': true,
      WFContentItemPropertyName: 'Notes',
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFReminderContentItemIsCompleted: 1,
      WFReminderContentItemNotes: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': sc.Ref(state, 'Text'),
          },
          string: ' ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '06C7177F-0DD0-4EF7-8354-638BF3E43DE8',
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
