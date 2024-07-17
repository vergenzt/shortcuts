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
      GroupingIdentifier: '06C7177F-0DD0-4EF7-8354-638BF3E43DE8',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Reminders', att=true),
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
      summary: function(state) sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('Notes'),
              WFValue: {
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
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('Due'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          PropertyName: 'Due Date',
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
              WFKey: sc.Val('URL'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          PropertyName: 'URL',
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
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F24C9B98-1D8E-40A2-BE15-5494F2260456',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Dictionary', aggs=[
        {
          PropertyName: 'Keys',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ], att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: function(state) sc.Val('${Vars.Repeat Item 2}', state),
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9AE5FB23-74B1-44AD-B47A-D9977F4FCCAD',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Dictionary Value', att=true),
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Vars.Repeat Item 2'),
            '{3, 1}': function(state) sc.Ref(state, 'Dictionary Value'),
          },
          string: '￼: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9AE5FB23-74B1-44AD-B47A-D9977F4FCCAD',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9AE5FB23-74B1-44AD-B47A-D9977F4FCCAD',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'F24C9B98-1D8E-40A2-BE15-5494F2260456',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: '',
      WFTextSeparator: 'New Lines',
      text: function(state) sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('com.atlassian.jira.app.SetIssueFieldIntent', name='Issue', params={
      issue: function(state) sc.Ref(state, 'Issue', att=true),
      setFieldName: 'Description',
      setFieldValue: function(state) sc.Val('${Combined Text}', state),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      WFContentItemPropertyName: 'List',
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFReminderContentItemList: 'Added to Jira',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
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
            '{11, 1}': function(state) sc.Ref(state, 'Issue', aggs=[
              {
                PropertyName: 'site',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{34, 1}': function(state) sc.Ref(state, 'Issue', aggs=[
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
      Mode: 'Set',
      'Show-WFReminderContentItemTags': true,
      WFContentItemPropertyName: 'Notes',
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFReminderContentItemIsCompleted: 1,
      WFReminderContentItemNotes: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': function(state) sc.Ref(state, 'Text'),
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
