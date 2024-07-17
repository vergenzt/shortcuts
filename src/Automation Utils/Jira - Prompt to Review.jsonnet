local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '02B87892-2116-4AE0-8BE0-9FAC4433A3B7',
      WFCondition: 4,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Device Model', att=true),
      },
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{37, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'issue.key',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'ExtensionInput',
            },
          },
          string: 'https://vergenz.atlassian.net/browse/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: function(state) sc.Ref(state, 'URL', att=true),
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '02B87892-2116-4AE0-8BE0-9FAC4433A3B7',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('method'),
              WFValue: sc.Val('GET'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('path'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'issue.key',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'ExtensionInput',
                    },
                  },
                  string: 'issue/￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Get Issue Result', params={
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Do you want to review?', params={
      WFDictionaryKey: 'review_prompt_optional',
      WFInput: function(state) sc.Ref(state, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6C91002C-93EC-4B86-8427-F5C7EE4EC8EF',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Do you want to review?', att=true),
      },
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        'Yes',
        'No',
      ],
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Do you want to review?'),
            '{3, 1}': function(state) sc.Ref(state, 'Get Issue Result', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'key',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{6, 1}': function(state) sc.Ref(state, 'Get Issue Result', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'fields.summary',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼ [￼] ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: function(state) sc.Ref(state, 'List', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6900C0B4-3E34-4A84-9B58-320F50893101',
      WFCondition: 4,
      WFConditionalActionString: 'No',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Chosen Item', att=true),
      },
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6900C0B4-3E34-4A84-9B58-320F50893101',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6C91002C-93EC-4B86-8427-F5C7EE4EC8EF',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: {
        Value: {
          attachmentsByRange: {
            '{38, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'review_prompt',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'ExtensionInput',
            },
          },
          string: 'Press OK to review the issue in Jira, ￼then return to Shortcuts to continue.',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAlertActionTitle: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'progress_info',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'ExtensionInput',
            },
            '{2, 1}': function(state) sc.Ref(state, 'Get Issue Result', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'key',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{5, 1}': function(state) sc.Ref(state, 'Get Issue Result', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'fields.summary',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼[￼] ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', name='Browse URL', params={
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'issue.self',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'ExtensionInput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '/rest/api/.*$',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: {
        Value: {
          attachmentsByRange: {
            '{8, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'issue.key',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'ExtensionInput',
            },
          },
          string: '/browse/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='filter', params={
      WFDictionaryKey: 'filter',
      WFInput: function(state) sc.Ref(state, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE978332-38D0-467A-BA94-F5D047219387',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'filter', att=true),
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{8, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'filter.id',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'ExtensionInput',
            },
          },
          string: '?filter=￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'AE978332-38D0-467A-BA94-F5D047219387',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Browse URL'),
            '{1, 1}': function(state) sc.Ref(state, 'If Result'),
          },
          string: '￼￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: function(state) sc.Ref(state, 'URL', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='skip_return', params={
      WFDictionaryKey: 'skip_return',
      WFInput: function(state) sc.Ref(state, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2DD74F72-F042-47FF-8317-8749CC2A2A5A',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'skip_return', att=true),
      },
    }),

    sc.Action('is.workflow.actions.waittoreturn'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2DD74F72-F042-47FF-8317-8749CC2A2A5A',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -2873601,
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
