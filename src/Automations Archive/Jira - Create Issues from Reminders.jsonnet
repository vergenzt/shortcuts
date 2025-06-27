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
                  Value: 'Jira',
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
      GroupingIdentifier: '06C7177F-0DD0-4EF7-8354-638BF3E43DE8',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Reminders')),
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
      summary: sc.Str([sc.Ref('Vars.Repeat Item')]),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Notes']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'Notes',
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Due']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'Due Date',
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['URL']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'URL',
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F24C9B98-1D8E-40A2-BE15-5494F2260456',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Dictionary', aggs=[
        {
          PropertyName: 'Keys',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item 2')]),
      WFInput: sc.Attach(sc.Ref('Dictionary')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9AE5FB23-74B1-44AD-B47A-D9977F4FCCAD',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Dictionary Value')),
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str([sc.Ref('Vars.Repeat Item 2')]),
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
      text: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('com.atlassian.jira.app.SetIssueFieldIntent', name='Issue', params={
      issue: sc.Attach(sc.Ref('Issue')),
      setFieldName: 'Description',
      setFieldValue: sc.Str([sc.Ref('Combined Text')]),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      WFContentItemPropertyName: 'List',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFReminderContentItemList: 'Added to Jira',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'Notes',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }, '\n\nhttps://', sc.Ref('Issue', aggs=[
        {
          PropertyName: 'site',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      'Show-WFReminderContentItemTags': true,
      WFContentItemPropertyName: 'Notes',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFReminderContentItemIsCompleted: 1,
      WFReminderContentItemNotes: sc.Str([' ', sc.Ref('Text')]),
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
