{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.detect.dictionary',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Input Dict',
        UUID: '89C08046-311F-4B52-90E3-C2A3DBFCF024',
        WFInput: {
          Value: {
            Type: 'ExtensionInput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.url',
      WFWorkflowActionParameters: {
        UUID: 'DE2D34E7-B006-4765-AB65-4526D023CDE9',
        WFURLActionURL: {
          Value: {
            attachmentsByRange: {
              '{35, 1}': {
                Aggrandizements: [
                  {
                    DictionaryKey: 'path',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                OutputName: 'Input Dict',
                OutputUUID: '89C08046-311F-4B52-90E3-C2A3DBFCF024',
                Type: 'ActionOutput',
              },
            },
            string: 'https://api.track.toggl.com/api/v9/￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvalueforkey',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Request Method',
        UUID: 'EDED189D-5D86-40A2-9470-42DB612B15D2',
        WFDictionaryKey: 'method',
        WFInput: {
          Value: {
            OutputName: 'Input Dict',
            OutputUUID: '89C08046-311F-4B52-90E3-C2A3DBFCF024',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'dk.simonbs.DataJar.GetValueIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Toggl Track API Token',
        UUID: '89A86341-ECE8-4BBA-B75E-EC3E951D9F57',
        keyPath: 'Toggl Track.api_token',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.gettext',
      WFWorkflowActionParameters: {
        UUID: 'C8E53456-5DEE-4F2F-B813-77F344DF8EC4',
        WFTextActionText: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Toggl Track API Token',
                OutputUUID: '89A86341-ECE8-4BBA-B75E-EC3E951D9F57',
                Type: 'ActionOutput',
              },
            },
            string: '￼:api_token',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.base64encode',
      WFWorkflowActionParameters: {
        UUID: '4B219ECF-AB3E-4392-B8E9-56BD3299316C',
        WFBase64LineBreakMode: 'None',
        WFInput: {
          Value: {
            OutputName: 'Text',
            OutputUUID: 'C8E53456-5DEE-4F2F-B813-77F344DF8EC4',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvalueforkey',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Query Params',
        UUID: 'E768C8B5-9633-48CC-AB3F-5733EEB2306A',
        WFDictionaryKey: 'params',
        WFInput: {
          Value: {
            OutputName: 'Input Dict',
            OutputUUID: '89C08046-311F-4B52-90E3-C2A3DBFCF024',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Query Params',
              OutputUUID: 'E768C8B5-9633-48CC-AB3F-5733EEB2306A',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                PropertyName: 'Keys',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Query Params',
            OutputUUID: 'E768C8B5-9633-48CC-AB3F-5733EEB2306A',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.urlencode',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Key',
        UUID: '62069FEA-E890-412F-8DDB-6CE84248AB8E',
        WFInput: {
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvalueforkey',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Value',
        UUID: '54430E5A-9071-464D-820F-9AAD04CF1865',
        WFDictionaryKey: {
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
        WFInput: {
          Value: {
            OutputName: 'Query Params',
            OutputUUID: 'E768C8B5-9633-48CC-AB3F-5733EEB2306A',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.urlencode',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Value',
        UUID: '76C067DF-D86D-4617-8551-3F18A4FDA349',
        WFInput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Value',
                OutputUUID: '54430E5A-9071-464D-820F-9AAD04CF1865',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.gettext',
      WFWorkflowActionParameters: {
        UUID: '0A2FB96F-DDF1-493F-AF2D-53684A01A077',
        WFTextActionText: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Key',
                OutputUUID: '62069FEA-E890-412F-8DDB-6CE84248AB8E',
                Type: 'ActionOutput',
              },
              '{2, 1}': {
                OutputName: 'Value',
                OutputUUID: '76C067DF-D86D-4617-8551-3F18A4FDA349',
                Type: 'ActionOutput',
              },
            },
            string: '￼=￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
        UUID: '6EB1C80A-F18C-474B-B085-71DBF93D3894',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.combine',
      WFWorkflowActionParameters: {
        UUID: '338434BD-529B-4AFD-AE22-B4B476F14066',
        WFTextCustomSeparator: '&',
        WFTextSeparator: 'Custom',
        text: {
          Value: {
            OutputName: 'Repeat Results',
            OutputUUID: '6EB1C80A-F18C-474B-B085-71DBF93D3894',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Query',
        GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
        UUID: '42A2218F-381B-42D3-B44D-E2B4D060246F',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.list',
      WFWorkflowActionParameters: {
        UUID: '4F45D58D-5C50-4014-AF98-195EF3FBE96B',
        WFItems: [
          {
            WFItemType: 0,
            WFValue: {
              Value: {
                attachmentsByRange: {
                  '{0, 1}': {
                    OutputName: 'URL',
                    OutputUUID: 'DE2D34E7-B006-4765-AB65-4526D023CDE9',
                    Type: 'ActionOutput',
                  },
                },
                string: '￼',
              },
              WFSerializationType: 'WFTextTokenString',
            },
          },
          {
            WFItemType: 0,
            WFValue: {
              Value: {
                attachmentsByRange: {
                  '{0, 1}': {
                    OutputName: 'Query',
                    OutputUUID: '42A2218F-381B-42D3-B44D-E2B4D060246F',
                    Type: 'ActionOutput',
                  },
                },
                string: '￼',
              },
              WFSerializationType: 'WFTextTokenString',
            },
          },
        ],
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.combine',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Combined URL',
        UUID: 'A5749BCB-5258-4A9A-8ED7-4ED4FAFC72B3',
        WFTextCustomSeparator: '?',
        WFTextSeparator: 'Custom',
        text: {
          Value: {
            OutputName: 'List',
            OutputUUID: '4F45D58D-5C50-4014-AF98-195EF3FBE96B',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.downloadurl',
      WFWorkflowActionParameters: {
        ShowHeaders: true,
        UUID: '2B70C5DA-D255-41E1-ABB9-44F8303B5180',
        WFHTTPBodyType: 'File',
        WFHTTPHeaders: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 0,
                WFKey: {
                  Value: {
                    string: 'Authorization',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
                WFValue: {
                  Value: {
                    attachmentsByRange: {
                      '{6, 1}': {
                        OutputName: 'Base64 Encoded',
                        OutputUUID: '4B219ECF-AB3E-4392-B8E9-56BD3299316C',
                        Type: 'ActionOutput',
                      },
                    },
                    string: 'Basic ￼',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
              },
              {
                WFItemType: 0,
                WFKey: {
                  Value: {
                    string: 'Content-Type',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
                WFValue: {
                  Value: {
                    string: 'application/json',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
              },
            ],
          },
          WFSerializationType: 'WFDictionaryFieldValue',
        },
        WFHTTPMethod: {
          Value: {
            OutputName: 'Request Method',
            OutputUUID: 'EDED189D-5D86-40A2-9470-42DB612B15D2',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFRequestVariable: {
          Value: {
            Aggrandizements: [
              {
                DictionaryKey: 'json',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ],
            OutputName: 'Input Dict',
            OutputUUID: '89C08046-311F-4B52-90E3-C2A3DBFCF024',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFURL: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Combined URL',
                OutputUUID: 'A5749BCB-5258-4A9A-8ED7-4ED4FAFC72B3',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
  ],
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 4271458815,
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
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFStringContentItem',
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
