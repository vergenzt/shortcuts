local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.runworkflow', {
      UUID: '4497936E-1C1E-4C1A-B5CB-4CE2F5C6D206',
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '410F7B2D-3951-4BAE-A70D-514A8986662E',
        workflowName: 'Google OAuth',
      },
      WFWorkflowName: 'Google OAuth',
    }),

    [_()]: lib.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: 'AA396E6A-E9EE-4534-BA6E-1D6EF716A83C',
      keyPath: 'jira-config',
    }),

    [_()]: lib.Action('is.workflow.actions.url', {
      UUID: '1066C8E0-90E0-4FC0-9B25-BC32FFE55A8F',
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{46, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'spreadsheet_id',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: 'AA396E6A-E9EE-4534-BA6E-1D6EF716A83C',
              Type: 'ActionOutput',
            },
          },
          string: 'https://sheets.googleapis.com/v4/spreadsheets/￼/values',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('dk.simonbs.DataJar.GetValueIntent', label='Filters by First Issue Age', params={
      UUID: '5B3A3F04-4964-453A-B343-0F4736391F37',
      keyPath: 'jira-cache.Filters & Issues by First Issue Age',
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D61B3F28-18FE-47C0-87CB-8F871024AFE9',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ],
          OutputName: 'Filters by First Issue Age',
          OutputUUID: '5B3A3F04-4964-453A-B343-0F4736391F37',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.detect.dictionary', label='Filter Description Dictionary', params={
      UUID: '0FE23374-3316-4C7B-913C-DB6FBC3FBA14',
      WFInput: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'description',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E0CA601A-6D60-4670-B03D-08FB3BEAA176',
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
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.dictionary', {
      UUID: 'EBB3E40C-3309-4FE9-B471-8238CAE72D50',
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
                  string: 'POST',
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
                  string: 'jql/match',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 1,
              WFKey: {
                Value: {
                  string: 'json',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 2,
                        WFKey: {
                          Value: {
                            string: 'issueIds',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: [
                            {
                              WFItemType: 3,
                              WFValue: {
                                Value: {
                                  attachmentsByRange: {
                                    '{0, 1}': {
                                      Aggrandizements: [
                                        {
                                          CoercionItemClass: 'WFDictionaryContentItem',
                                          Type: 'WFCoercionVariableAggrandizement',
                                        },
                                        {
                                          DictionaryKey: 'id',
                                          Type: 'WFDictionaryValueVariableAggrandizement',
                                        },
                                      ],
                                      Type: 'Variable',
                                      VariableName: 'Repeat Item 2',
                                    },
                                  },
                                  string: '￼',
                                },
                                WFSerializationType: 'WFTextTokenString',
                              },
                            },
                          ],
                          WFSerializationType: 'WFArrayParameterState',
                        },
                      },
                      {
                        WFItemType: 2,
                        WFKey: {
                          Value: {
                            string: 'jqls',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: [
                            {
                              WFItemType: 0,
                              WFValue: {
                                Value: {
                                  attachmentsByRange: {
                                    '{0, 1}': {
                                      Aggrandizements: [
                                        {
                                          CoercionItemClass: 'WFDictionaryContentItem',
                                          Type: 'WFCoercionVariableAggrandizement',
                                        },
                                        {
                                          DictionaryKey: 'jql',
                                          Type: 'WFDictionaryValueVariableAggrandizement',
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
                          WFSerializationType: 'WFArrayParameterState',
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

    [_()]: lib.Action('is.workflow.actions.runworkflow', label='JQL Matches', params={
      UUID: '549E2EE9-7E5A-4EDE-8BCF-ED28146943AB',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: 'EBB3E40C-3309-4FE9-B471-8238CAE72D50',
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

    [_()]: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
      UUID: '8155851A-DB07-4452-8C78-BAEBAE5567AB',
      input: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ],
          OutputName: 'JQL Matches',
          OutputUUID: '549E2EE9-7E5A-4EDE-8BCF-ED28146943AB',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      jqQuery: '.matches[].matchedIssues[]',
      queryType: 'jq',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'DDA9A0FE-3ABA-4A9B-A939-1777995CE8E9',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFNumberContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            OutputName: 'Result',
            OutputUUID: '8155851A-DB07-4452-8C78-BAEBAE5567AB',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.dictionary', {
      UUID: '5F1412EE-D0E1-4722-8E9B-DBB92C30F0F1',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'review_prompt',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          DictionaryKey: 'prompt',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Filter Description Dictionary',
                      OutputUUID: '0FE23374-3316-4C7B-913C-DB6FBC3FBA14',
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
              WFKey: {
                Value: {
                  string: 'progress_info',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'name',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                    '{3, 1}': {
                      Type: 'Variable',
                      VariableName: 'Repeat Index 2',
                    },
                    '{5, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'total',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: '￼ (￼/￼) ',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.setvalueforkey', {
      UUID: '3CA9DD17-9B12-4EEB-993F-6F1D0A4A747E',
      WFDictionary: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '5F1412EE-D0E1-4722-8E9B-DBB92C30F0F1',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: 'filter',
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

    [_()]: lib.Action('is.workflow.actions.setvalueforkey', {
      UUID: 'C060FACB-7EC7-4CA8-87C3-01493C679DEF',
      WFDictionary: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '3CA9DD17-9B12-4EEB-993F-6F1D0A4A747E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: 'issue',
      WFDictionaryValue: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item 2',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.runworkflow', {
      UUID: '358CCB0F-EE50-4B64-8299-12EA1FE50BA3',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: 'C060FACB-7EC7-4CA8-87C3-01493C679DEF',
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

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A334B26F-D55D-429E-9239-81E9A45C3671',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                DictionaryKey: 'skip_add_connected_issues',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ],
            OutputName: 'Filter Description Dictionary',
            OutputUUID: '0FE23374-3316-4C7B-913C-DB6FBC3FBA14',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A334B26F-D55D-429E-9239-81E9A45C3671',
      UUID: '34834033-D933-4DDA-A8C6-3E7765568D4C',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'DDA9A0FE-3ABA-4A9B-A939-1777995CE8E9',
      UUID: '94339012-69AA-4BC5-A87A-0E1ACC0FD160',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E0CA601A-6D60-4670-B03D-08FB3BEAA176',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D61B3F28-18FE-47C0-87CB-8F871024AFE9',
      WFControlFlowMode: 2,
    }),
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
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
    'MenuBar',
  ],
}
