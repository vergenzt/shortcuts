{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.dictionary',
      WFWorkflowActionParameters: {
        UUID: '1C65FAB1-F478-4315-900D-777FDEA8EF02',
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.runworkflow',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Get Issue Result',
        UUID: 'A99B3D6A-D90B-4859-8B7F-4CC8D026CDE1',
        WFInput: {
          Value: {
            OutputName: 'Dictionary',
            OutputUUID: '1C65FAB1-F478-4315-900D-777FDEA8EF02',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFWorkflow: {
          isSelf: false,
          workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
          workflowName: 'Jira API',
        },
        WFWorkflowName: 'Jira API',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvalueforkey',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Do you want to review?',
        UUID: 'A5BB4DB3-C265-4836-9DF3-B1713FA8E73C',
        WFDictionaryKey: 'review_prompt_optional',
        WFInput: {
          Value: {
            Type: 'ExtensionInput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '6C91002C-93EC-4B86-8427-F5C7EE4EC8EF',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Do you want to review?',
              OutputUUID: 'A5BB4DB3-C265-4836-9DF3-B1713FA8E73C',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.list',
      WFWorkflowActionParameters: {
        UUID: '7B19EA63-CF1A-4A8C-B394-A3EC6B63BE90',
        WFItems: [
          'Yes',
          'No',
        ],
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefromlist',
      WFWorkflowActionParameters: {
        UUID: 'C9107E71-A022-4B3D-AF36-AA871DBE0891',
        WFChooseFromListActionPrompt: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Do you want to review?',
                OutputUUID: 'A5BB4DB3-C265-4836-9DF3-B1713FA8E73C',
                Type: 'ActionOutput',
              },
              '{3, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'key',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                OutputName: 'Get Issue Result',
                OutputUUID: 'A99B3D6A-D90B-4859-8B7F-4CC8D026CDE1',
                Type: 'ActionOutput',
              },
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
          Value: {
            OutputName: 'List',
            OutputUUID: '7B19EA63-CF1A-4A8C-B394-A3EC6B63BE90',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '6900C0B4-3E34-4A84-9B58-320F50893101',
        WFCondition: 4,
        WFConditionalActionString: 'No',
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Chosen Item',
              OutputUUID: 'C9107E71-A022-4B3D-AF36-AA871DBE0891',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.exit',
      WFWorkflowActionParameters: {},
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '6900C0B4-3E34-4A84-9B58-320F50893101',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '6C91002C-93EC-4B86-8427-F5C7EE4EC8EF',
        UUID: '81348415-BF8C-40E8-B135-8DF7B567D2F7',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.alert',
      WFWorkflowActionParameters: {
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
              '{2, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'key',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                OutputName: 'Get Issue Result',
                OutputUUID: 'A99B3D6A-D90B-4859-8B7F-4CC8D026CDE1',
                Type: 'ActionOutput',
              },
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.replace',
      WFWorkflowActionParameters: {
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvalueforkey',
      WFWorkflowActionParameters: {
        CustomOutputName: 'filter',
        UUID: 'C4B88720-8C30-4636-99CC-4D05792657E4',
        WFDictionaryKey: 'filter',
        WFInput: {
          Value: {
            Type: 'ExtensionInput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.gettext',
      WFWorkflowActionParameters: {
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'AE978332-38D0-467A-BA94-F5D047219387',
        UUID: '0AD94A73-F0B0-41C4-AD12-909189ACC5E9',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.url',
      WFWorkflowActionParameters: {
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.openurl',
      WFWorkflowActionParameters: {
        UUID: '53990257-DAE7-43A2-8220-DCE11098D224',
        WFInput: {
          Value: {
            OutputName: 'URL',
            OutputUUID: '1D064DC3-9619-45D2-AE5C-A405644ED2CB',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvalueforkey',
      WFWorkflowActionParameters: {
        CustomOutputName: 'skip_return',
        UUID: 'F239D23E-CDD4-4C65-B3E5-C38F6D16E614',
        WFDictionaryKey: 'skip_return',
        WFInput: {
          Value: {
            Type: 'ExtensionInput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.waittoreturn',
      WFWorkflowActionParameters: {},
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '2DD74F72-F042-47FF-8317-8749CC2A2A5A',
        WFControlFlowMode: 2,
      },
    },
  ],
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
