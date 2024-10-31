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
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: sc.Str(['https://vergenz.atlassian.net/browse/', {
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
      }]),
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: sc.Attach(sc.Ref('URL')),
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
              WFKey: sc.Str(['method']),
              WFValue: sc.Str(['GET']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['path']),
              WFValue: sc.Str(['issue/', {
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
              }]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Get Issue Result', params={
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Do you want to review?', params={
      WFDictionaryKey: 'review_prompt_optional',
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6C91002C-93EC-4B86-8427-F5C7EE4EC8EF',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Do you want to review?')),
      },
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        'Yes',
        'No',
      ],
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: sc.Str([sc.Ref('Do you want to review?'), ' [', sc.Ref('Get Issue Result', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'key',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFInput: sc.Attach(sc.Ref('List')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6900C0B4-3E34-4A84-9B58-320F50893101',
      WFCondition: 4,
      WFConditionalActionString: 'No',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item')),
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
      WFAlertActionMessage: sc.Str(['Press OK to review the issue in Jira, ', {
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
      }, 'then return to Shortcuts to continue.']),
      WFAlertActionTitle: sc.Str([{
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
      }, '[', sc.Ref('Get Issue Result', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'key',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Browse URL', params={
      WFInput: sc.Str([{
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
      }]),
      WFReplaceTextFind: '/rest/api/.*$',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: sc.Str(['/browse/', {
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
      }]),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='filter', params={
      WFDictionaryKey: 'filter',
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE978332-38D0-467A-BA94-F5D047219387',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('filter')),
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str(['?filter=', {
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
      }]),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'AE978332-38D0-467A-BA94-F5D047219387',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: sc.Str([sc.Ref('Browse URL')]),
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: sc.Attach(sc.Ref('URL')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='skip_return', params={
      WFDictionaryKey: 'skip_return',
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2DD74F72-F042-47FF-8317-8749CC2A2A5A',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('skip_return')),
      },
    }),

    sc.Action('is.workflow.actions.waittoreturn'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2DD74F72-F042-47FF-8317-8749CC2A2A5A',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
