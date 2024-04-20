local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.text.replace', {
      UUID: '13278899-1561-4A4A-999E-19767E063DB6',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'ExtensionInput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextCaseSensitive: false,
      WFReplaceTextFind: '^<|>$',
      WFReplaceTextRegularExpression: true,
    }),

    [_()]: lib.Action('is.workflow.actions.dictionary', {
      UUID: '246E18EF-0D58-426F-9C1C-A8BCF722743E',
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
                  string: 'search',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 1,
              WFKey: {
                Value: {
                  string: 'params',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: {
                          Value: {
                            string: 'jql',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{22, 1}': {
                                OutputName: 'Updated Text',
                                OutputUUID: '13278899-1561-4A4A-999E-19767E063DB6',
                                Type: 'ActionOutput',
                              },
                            },
                            string: '"Email Message ID" ~ "￼"',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                    ],
                  },
                  WFSerializationType: 'WFDictionaryFieldValue',
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.runworkflow', {
      UUID: 'F3CCC957-0D57-43D8-9C9E-C2E5155637B4',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '246E18EF-0D58-426F-9C1C-A8BCF722743E',
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
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '9A814540-129A-4AE3-A0FA-CCA13EBE28DC',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'issues',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          OutputName: 'Shortcut Result',
          OutputUUID: 'F3CCC957-0D57-43D8-9C9E-C2E5155637B4',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.dictionary', {
      UUID: '8BDE32CA-93CB-4386-A0CF-E5CEB856517B',
    }),

    [_()]: lib.Action('is.workflow.actions.setvalueforkey', {
      UUID: '79E8DADA-59AB-4780-BC35-884415545438',
      WFDictionary: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '8BDE32CA-93CB-4386-A0CF-E5CEB856517B',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: 'issue',
      WFDictionaryValue: {
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

    [_()]: lib.Action('is.workflow.actions.runworkflow', {
      UUID: '991068DD-ABE6-4C1A-83CF-7CBD3C9D26BD',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '79E8DADA-59AB-4780-BC35-884415545438',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'DE45228B-5A30-4A30-AF37-DA40929C57C2',
        workflowName: 'Jira - Prompt to Review',
      },
      WFWorkflowName: 'Jira - Prompt to Review',
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '9A814540-129A-4AE3-A0FA-CCA13EBE28DC',
      WFControlFlowMode: 2,
    }),
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -23508481,
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
    Name: 'WFWorkflowNoInputBehaviorGetClipboard',
    Parameters: {},
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
    'MenuBar',
    'Watch',
  ],
}
