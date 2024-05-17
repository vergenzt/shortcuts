local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'method',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'GET',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'path',
                },
                WFSerializationType: 'WFTextTokenString',
              },
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
      local outputs = super.outputs,
      WFInput: {
        Value: sc.Ref(outputs, 'Dictionary'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Do you want to review?', params={
      WFDictionaryKey: 'review_prompt_optional',
      WFInput: {
        Value: {
          Type: 'ExtensionInput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '6C91002C-93EC-4B86-8427-F5C7EE4EC8EF',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: sc.Ref(outputs, 'Do you want to review?'),
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        'Yes',
        'No',
      ],
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      local outputs = super.outputs,
      WFChooseFromListActionPrompt: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Do you want to review?'),
            '{3, 1}': sc.Ref(outputs, 'Get Issue Result', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'key',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{6, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.summary',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Get Issue Result',
              OutputUUID: 'A99B3D6A-D90B-4859-8B7F-4CC8D026CDE1',
              Type: 'ActionOutput',
            },
          },
          string: '￼ [￼] ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: sc.Ref(outputs, 'List'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '6900C0B4-3E34-4A84-9B58-320F50893101',
      WFCondition: 4,
      WFConditionalActionString: 'No',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: sc.Ref(outputs, 'Chosen Item'),
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6900C0B4-3E34-4A84-9B58-320F50893101',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6C91002C-93EC-4B86-8427-F5C7EE4EC8EF',
      UUID: '81348415-BF8C-40E8-B135-8DF7B567D2F7',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.alert', {
      local outputs = super.outputs,
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
            '{2, 1}': sc.Ref(outputs, 'Get Issue Result', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'key',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{5, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.summary',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Get Issue Result',
              OutputUUID: 'A99B3D6A-D90B-4859-8B7F-4CC8D026CDE1',
              Type: 'ActionOutput',
            },
          },
          string: '￼[￼] ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      CustomOutputName: 'Browse URL',
      UUID: '5D2E5E83-6C7F-4489-A5ED-CCE29647FF09',
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

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'filter',
      UUID: 'C4B88720-8C30-4636-99CC-4D05792657E4',
      WFDictionaryKey: 'filter',
      WFInput: {
        Value: {
          Type: 'ExtensionInput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE978332-38D0-467A-BA94-F5D047219387',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'filter',
            OutputUUID: 'C4B88720-8C30-4636-99CC-4D05792657E4',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'B4A76837-06F2-4A99-9CB8-DECD999D0466',
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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE978332-38D0-467A-BA94-F5D047219387',
      UUID: '0AD94A73-F0B0-41C4-AD12-909189ACC5E9',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.url', {
      UUID: '1D064DC3-9619-45D2-AE5C-A405644ED2CB',
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Browse URL',
              OutputUUID: '5D2E5E83-6C7F-4489-A5ED-CCE29647FF09',
              Type: 'ActionOutput',
            },
            '{1, 1}': {
              OutputName: 'If Result',
              OutputUUID: '0AD94A73-F0B0-41C4-AD12-909189ACC5E9',
              Type: 'ActionOutput',
            },
          },
          string: '￼￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      UUID: '53990257-DAE7-43A2-8220-DCE11098D224',
      WFInput: {
        Value: {
          OutputName: 'URL',
          OutputUUID: '1D064DC3-9619-45D2-AE5C-A405644ED2CB',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'skip_return',
      UUID: 'F239D23E-CDD4-4C65-B3E5-C38F6D16E614',
      WFDictionaryKey: 'skip_return',
      WFInput: {
        Value: {
          Type: 'ExtensionInput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2DD74F72-F042-47FF-8317-8749CC2A2A5A',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'skip_return',
            OutputUUID: 'F239D23E-CDD4-4C65-B3E5-C38F6D16E614',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
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
