{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    ['Jira Auth']: lib.Action('is.workflow.actions.runworkflow', {
              CustomOutputName: 'Jira Auth',
              UUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
              WFWorkflow: {
                isSelf: false,
                workflowIdentifier: '86996835-A1EC-421B-92A1-1F21056EC7EC',
                workflowName: 'Jira Auth',
              },
              WFWorkflowName: 'Jira Auth',
            })
      ,
      ['Google Auth']: lib.Action('is.workflow.actions.runworkflow', {
              CustomOutputName: 'Google Auth',
              UUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
              WFWorkflow: {
                isSelf: false,
                workflowIdentifier: '410F7B2D-3951-4BAE-A70D-514A8986662E',
                workflowName: 'Google OAuth',
              },
              WFWorkflowName: 'Google OAuth',
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.url', {
        'Show-WFURLActionURL': true,
        UUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
        WFURLActionURL: 'https://gmail.googleapis.com/gmail/v1/users/me',
      })
      ,
      ['list']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'list',
              ShowHeaders: true,
              UUID: '3A577FEA-918C-47B1-8869-1E6B65D903CF',
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
                            '{0, 1}': {
                              OutputName: 'Google Auth',
                              OutputUUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'URL',
                      OutputUUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/messages?labelIds=STARRED',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: '7BF99E34-CFDA-4271-B767-6362755075E4',
        UUID: 'E1BA0AD6-63CF-4A35-9B79-E107549A4848',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'messages',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ],
            OutputName: 'list',
            OutputUUID: '3A577FEA-918C-47B1-8869-1E6B65D903CF',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      })
      ,
      ['thread']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'thread',
              ShowHeaders: true,
              UUID: '31B2CB46-2CCB-466D-A724-86E6871F3817',
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
                            '{0, 1}': {
                              OutputName: 'Google Auth',
                              OutputUUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'URL',
                      OutputUUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
                      Type: 'ActionOutput',
                    },
                    '{10, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'threadId',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: '￼/threads/￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      ['Messages By ID']: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
              CustomOutputName: 'Messages By ID',
              UUID: '2E18E63D-6D34-405E-B043-4E3C2D618095',
              input: {
                Value: {
                  OutputName: 'thread',
                  OutputUUID: '31B2CB46-2CCB-466D-A724-86E6871F3817',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
              jqQuery: '.messages | map(\n  .headers = ( .payload.headers | map({ key: (.name | ascii_downcase), value }) | from_entries )\n  | { key: .headers["message-id"], value: . }\n) | from_entries',
              queryType: 'jq',
            })
      ,
      ['JQL']: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
              CustomOutputName: 'JQL',
              UUID: 'C3C132D0-7F31-4FFB-A143-8279E2C26077',
              input: {
                Value: {
                  OutputName: 'Messages By ID',
                  OutputUUID: '2E18E63D-6D34-405E-B043-4E3C2D618095',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
              jqQuery: 'keys | map("\\"Email Message ID\\" ~ \\"\\(.)\\"") | join(" OR ")',
              queryType: 'jq',
            })
      ,
      ['Search Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Search Result',
              ShowHeaders: true,
              UUID: '33F90208-F4B7-49C6-BCA2-06AFE1B4423C',
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
                            '{0, 1}': {
                              Aggrandizements: [
                                {
                                  CoercionItemClass: 'WFDictionaryContentItem',
                                  Type: 'WFCoercionVariableAggrandizement',
                                },
                                {
                                  DictionaryKey: 'authorization',
                                  Type: 'WFDictionaryValueVariableAggrandizement',
                                },
                              ],
                              OutputName: 'Jira Auth',
                              OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'POST',
              WFJSONValues: {
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
                            '{0, 1}': {
                              OutputName: 'JQL',
                              OutputUUID: 'C3C132D0-7F31-4FFB-A143-8279E2C26077',
                              Type: 'ActionOutput',
                            },
                          },
                          string: '￼',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                    },
                    {
                      WFItemType: 2,
                      WFKey: {
                        Value: {
                          string: 'fields',
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
                                        DictionaryKey: 'field_id: Email Message ID',
                                        Type: 'WFDictionaryValueVariableAggrandizement',
                                      },
                                    ],
                                    OutputName: 'Jira Auth',
                                    OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                                    Type: 'ActionOutput',
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
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'rest_api_url',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Jira Auth',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/search',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvariable', {
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
            OutputName: 'Search Result',
            OutputUUID: '33F90208-F4B7-49C6-BCA2-06AFE1B4423C',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Issues',
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '1FCEC359-D94D-4B3A-8498-5D3689F52068',
        UUID: 'C3AE509F-DDE1-4996-8B5A-BDDB9B8C40C2',
        WFCondition: 101,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              Type: 'Variable',
              VariableName: 'Issues',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      })
      ,
      ['Headers']: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
              CustomOutputName: 'Headers',
              UUID: 'B3271B6C-8E7B-44A8-8AF5-5E0A942B0BAF',
              input: {
                Value: {
                  OutputName: 'Messages By ID',
                  OutputUUID: '2E18E63D-6D34-405E-B043-4E3C2D618095',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
              jqQuery: 'first(values[]\n| select(any(.labelIds[]; . == "STARRED"))\n| .headers)',
              queryType: 'jq',
            })
      ,
      ['Updated From']: lib.Action('is.workflow.actions.text.replace', {
              CustomOutputName: 'Updated From',
              UUID: '58C1532A-474F-400E-AA50-40E150BDC418',
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
                          DictionaryKey: 'from',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Headers',
                      OutputUUID: 'B3271B6C-8E7B-44A8-8AF5-5E0A942B0BAF',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFReplaceTextCaseSensitive: false,
              WFReplaceTextFind: '(.*) <.*@.*>',
              WFReplaceTextRegularExpression: true,
              WFReplaceTextReplace: '$1',
            })
      ,
      ['Create Issue Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Create Issue Result',
              ShowHeaders: true,
              UUID: 'D779E6F9-AC20-4AE5-A286-059216B3CA0A',
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
                            '{0, 1}': {
                              Aggrandizements: [
                                {
                                  CoercionItemClass: 'WFDictionaryContentItem',
                                  Type: 'WFCoercionVariableAggrandizement',
                                },
                                {
                                  DictionaryKey: 'authorization',
                                  Type: 'WFDictionaryValueVariableAggrandizement',
                                },
                              ],
                              OutputName: 'Jira Auth',
                              OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'POST',
              WFJSONValues: {
                Value: {
                  WFDictionaryFieldValueItems: [
                    {
                      WFItemType: 1,
                      WFKey: {
                        Value: {
                          string: 'fields',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                      WFValue: {
                        Value: {
                          Value: {
                            WFDictionaryFieldValueItems: [
                              {
                                WFItemType: 1,
                                WFKey: {
                                  Value: {
                                    string: 'project',
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
                                              string: 'key',
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
                                                      DictionaryKey: 'project_key',
                                                      Type: 'WFDictionaryValueVariableAggrandizement',
                                                    },
                                                  ],
                                                  OutputName: 'Jira Auth',
                                                  OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
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
                                    WFSerializationType: 'WFDictionaryFieldValue',
                                  },
                                  WFSerializationType: 'WFDictionaryFieldValue',
                                },
                              },
                              {
                                WFItemType: 1,
                                WFKey: {
                                  Value: {
                                    string: 'issuetype',
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
                                              string: 'name',
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
                                                      DictionaryKey: 'issuetype_name',
                                                      Type: 'WFDictionaryValueVariableAggrandizement',
                                                    },
                                                  ],
                                                  OutputName: 'Jira Auth',
                                                  OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
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
                                    WFSerializationType: 'WFDictionaryFieldValue',
                                  },
                                  WFSerializationType: 'WFDictionaryFieldValue',
                                },
                              },
                              {
                                WFItemType: 0,
                                WFKey: {
                                  Value: {
                                    string: 'summary',
                                  },
                                  WFSerializationType: 'WFTextTokenString',
                                },
                                WFValue: {
                                  Value: {
                                    attachmentsByRange: {
                                      '{5, 1}': {
                                        OutputName: 'Updated From',
                                        OutputUUID: '58C1532A-474F-400E-AA50-40E150BDC418',
                                        Type: 'ActionOutput',
                                      },
                                      '{8, 1}': {
                                        Aggrandizements: [
                                          {
                                            CoercionItemClass: 'WFDictionaryContentItem',
                                            Type: 'WFCoercionVariableAggrandizement',
                                          },
                                          {
                                            DictionaryKey: 'subject',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Headers',
                                        OutputUUID: 'B3271B6C-8E7B-44A8-8AF5-5E0A942B0BAF',
                                        Type: 'ActionOutput',
                                      },
                                    },
                                    string: 'From ￼: ￼',
                                  },
                                  WFSerializationType: 'WFTextTokenString',
                                },
                              },
                              {
                                WFItemType: 0,
                                WFKey: {
                                  Value: {
                                    attachmentsByRange: {
                                      '{0, 1}': {
                                        Aggrandizements: [
                                          {
                                            CoercionItemClass: 'WFDictionaryContentItem',
                                            Type: 'WFCoercionVariableAggrandizement',
                                          },
                                          {
                                            DictionaryKey: 'field_id: Email Message ID',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Jira Auth',
                                        OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                                        Type: 'ActionOutput',
                                      },
                                    },
                                    string: '￼',
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
                                            DictionaryKey: 'message-id',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Headers',
                                        OutputUUID: 'B3271B6C-8E7B-44A8-8AF5-5E0A942B0BAF',
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
                          WFSerializationType: 'WFDictionaryFieldValue',
                        },
                        WFSerializationType: 'WFDictionaryFieldValue',
                      },
                    },
                  ],
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'rest_api_url',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Jira Auth',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/issue',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      ['Get Issue Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Get Issue Result',
              ShowHeaders: false,
              UUID: '546A1FB1-BBAB-4EDD-AD31-B17C6DF9916C',
              WFHTTPBodyType: 'JSON',
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
                            '{0, 1}': {
                              Aggrandizements: [
                                {
                                  CoercionItemClass: 'WFDictionaryContentItem',
                                  Type: 'WFCoercionVariableAggrandizement',
                                },
                                {
                                  DictionaryKey: 'authorization',
                                  Type: 'WFDictionaryValueVariableAggrandizement',
                                },
                              ],
                              OutputName: 'Jira Auth',
                              OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'GET',
              WFJSONValues: {
                Value: {
                  WFDictionaryFieldValueItems: [
                    {
                      WFItemType: 1,
                      WFKey: {
                        Value: {
                          string: 'fields',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                      WFValue: {
                        Value: {
                          Value: {
                            WFDictionaryFieldValueItems: [
                              {
                                WFItemType: 1,
                                WFKey: {
                                  Value: {
                                    string: 'project',
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
                                              string: 'key',
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
                                                      DictionaryKey: 'project_key',
                                                      Type: 'WFDictionaryValueVariableAggrandizement',
                                                    },
                                                  ],
                                                  OutputName: 'Jira Config',
                                                  OutputUUID: '9E95FB01-8912-495B-883C-A91F87901816',
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
                                    WFSerializationType: 'WFDictionaryFieldValue',
                                  },
                                  WFSerializationType: 'WFDictionaryFieldValue',
                                },
                              },
                              {
                                WFItemType: 1,
                                WFKey: {
                                  Value: {
                                    string: 'issuetype',
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
                                              string: 'name',
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
                                                      DictionaryKey: 'issuetype_name',
                                                      Type: 'WFDictionaryValueVariableAggrandizement',
                                                    },
                                                  ],
                                                  OutputName: 'Jira Config',
                                                  OutputUUID: '9E95FB01-8912-495B-883C-A91F87901816',
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
                                    WFSerializationType: 'WFDictionaryFieldValue',
                                  },
                                  WFSerializationType: 'WFDictionaryFieldValue',
                                },
                              },
                              {
                                WFItemType: 0,
                                WFKey: {
                                  Value: {
                                    string: 'summary',
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
                                            DictionaryKey: 'subject',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Headers',
                                        OutputUUID: 'B3271B6C-8E7B-44A8-8AF5-5E0A942B0BAF',
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
                                    attachmentsByRange: {
                                      '{0, 1}': {
                                        Aggrandizements: [
                                          {
                                            CoercionItemClass: 'WFDictionaryContentItem',
                                            Type: 'WFCoercionVariableAggrandizement',
                                          },
                                          {
                                            DictionaryKey: 'field_id: Email Message ID',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Jira Config',
                                        OutputUUID: '9E95FB01-8912-495B-883C-A91F87901816',
                                        Type: 'ActionOutput',
                                      },
                                    },
                                    string: '￼',
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
                                            DictionaryKey: 'message-id',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Headers',
                                        OutputUUID: 'B3271B6C-8E7B-44A8-8AF5-5E0A942B0BAF',
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
                          WFSerializationType: 'WFDictionaryFieldValue',
                        },
                        WFSerializationType: 'WFDictionaryFieldValue',
                      },
                    },
                  ],
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'rest_api_url',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Jira Auth',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                      Type: 'ActionOutput',
                    },
                    '{17, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'field_id: Email Message ID',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Jira Auth',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                      Type: 'ActionOutput',
                    },
                    '{8, 1}': {
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
                      OutputName: 'Create Issue Result',
                      OutputUUID: 'D779E6F9-AC20-4AE5-A286-059216B3CA0A',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/issue/￼?fields=￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.list', {
        UUID: '9143DD38-C350-45AD-8D12-3231B4D8FDEB',
        WFItems: [
          {
            WFItemType: 0,
            WFValue: {
              Value: {
                attachmentsByRange: {
                  '{0, 1}': {
                    OutputName: 'Get Issue Result',
                    OutputUUID: '546A1FB1-BBAB-4EDD-AD31-B17C6DF9916C',
                    Type: 'ActionOutput',
                  },
                },
                string: '￼',
              },
              WFSerializationType: 'WFTextTokenString',
            },
          },
        ],
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvariable', {
        WFInput: {
          Value: {
            OutputName: 'List',
            OutputUUID: '9143DD38-C350-45AD-8D12-3231B4D8FDEB',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Issues',
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '1FCEC359-D94D-4B3A-8498-5D3689F52068',
        UUID: 'E6E21B14-E295-4565-9A71-092F3DEAB44D',
        WFControlFlowMode: 2,
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: '45042209-F563-4EF4-9F92-BBCCB83F50A0',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            Type: 'Variable',
            VariableName: 'Issues',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvariable', {
        UUID: '2D8FA5DB-578B-4CC7-BD2B-64F2505E793E',
        WFInput: {
          Value: {
            Type: 'Variable',
            VariableName: 'Repeat Item 2',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Issue',
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvariable', {
        WFInput: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'fields',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Issue',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Issue Fields',
      })
      ,
      ['Issue Message ID']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Issue Message ID',
              UUID: '741CD477-223B-433B-99D0-C367F2E314BB',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'field_id: Email Message ID',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Jira Auth',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFInput: {
                Value: {
                  Type: 'Variable',
                  VariableName: 'Issue Fields',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
            })
      ,
      ['Message']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Message',
              UUID: '57EB82F4-C032-4E3A-93E2-0396C62179FE',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Issue Message ID',
                      OutputUUID: '741CD477-223B-433B-99D0-C367F2E314BB',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFGetDictionaryValueType: 'Value',
              WFInput: {
                Value: {
                  OutputName: 'Messages By ID',
                  OutputUUID: '2E18E63D-6D34-405E-B043-4E3C2D618095',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvariable', {
        WFInput: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'headers',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ],
            OutputName: 'Message',
            OutputUUID: '57EB82F4-C032-4E3A-93E2-0396C62179FE',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Headers',
      })
      ,
      ['Email with Issue Link']: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
              CustomOutputName: 'Email with Issue Link',
              UUID: '94DA6780-F287-4279-8387-085044467399',
              input: {
                Value: {
                  OutputName: 'Messages By ID',
                  OutputUUID: '2E18E63D-6D34-405E-B043-4E3C2D618095',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
              jqQuery: {
                Value: {
                  attachmentsByRange: {
                    '{51, 1}': {
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
                      Type: 'Variable',
                      VariableName: 'Issue',
                    },
                  },
                  string: 'values[] | select(.headers["x-jira-issue-key"] == "￼")',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              queryType: 'jq',
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '10711455-8C96-46D3-BD91-8512ACDA3D84',
        UUID: '66A1F68C-D9D6-4ED4-840B-5407B0218C60',
        WFCondition: 101,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Email with Issue Link',
              OutputUUID: '94DA6780-F287-4279-8387-085044467399',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.gettext', {
        UUID: '5DA05CC3-077B-4442-A0E8-A44C05A09256',
        WFTextActionText: {
          Value: {
            attachmentsByRange: {
              '{105, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'subject',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Headers',
              },
              '{120, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'message-id',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Headers',
              },
              '{134, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'message-id',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Headers',
              },
              '{154, 1}': {
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
                Type: 'Variable',
                VariableName: 'Issue',
              },
              '{219, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'site_url',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                OutputName: 'Jira Auth',
                OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                Type: 'ActionOutput',
              },
              '{228, 1}': {
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
                Type: 'Variable',
                VariableName: 'Issue',
              },
              '{231, 1}': {
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
                Type: 'Variable',
                VariableName: 'Issue',
              },
            },
            string: 'From: Tim Vergenz (via Shortcuts) <vergenzt@gmail.com>\nTo: Tim Vergenz <vergenzt@gmail.com>\nSubject: Re: ￼\nIn-Reply-To: ￼\nReferences: ￼\nX-Jira-Issue-Key: ￼\nX-Jira-Issue-Action: Created\nContent-Type: text/html\n\n<a href="￼/browse/￼">￼</a>',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.base64encode', {
        UUID: 'AD792A7F-E055-4DD8-BD1A-33AD9865D69C',
        WFBase64LineBreakMode: 'None',
        WFEncodeMode: 'Encode',
        WFInput: {
          Value: {
            OutputName: 'Text',
            OutputUUID: '5DA05CC3-077B-4442-A0E8-A44C05A09256',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.text.replace', {
        UUID: '9EE51588-2B84-46B8-A1F3-7983BF64BA64',
        WFInput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Base64 Encoded',
                OutputUUID: 'AD792A7F-E055-4DD8-BD1A-33AD9865D69C',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFReplaceTextFind: '+',
        WFReplaceTextReplace: '-',
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.text.replace', {
        UUID: 'AFA6E5C6-8F39-4FE5-85A0-9C3FE41B9604',
        WFInput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Updated Text',
                OutputUUID: '9EE51588-2B84-46B8-A1F3-7983BF64BA64',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFReplaceTextFind: '/',
        WFReplaceTextReplace: '_',
      })
      ,
      ['Send result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Send result',
              ShowHeaders: false,
              UUID: 'A257C6AB-8AB7-4E17-9CC5-E44DA0F65DBB',
              WFHTTPBodyType: 'JSON',
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
                            '{0, 1}': {
                              OutputName: 'Google Auth',
                              OutputUUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'POST',
              WFJSONValues: {
                Value: {
                  WFDictionaryFieldValueItems: [
                    {
                      WFItemType: 0,
                      WFKey: {
                        Value: {
                          string: 'raw',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                      WFValue: {
                        Value: {
                          attachmentsByRange: {
                            '{0, 1}': {
                              OutputName: 'Updated Text',
                              OutputUUID: 'AFA6E5C6-8F39-4FE5-85A0-9C3FE41B9604',
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
                          string: 'threadId',
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
                                  DictionaryKey: 'threadId',
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
                    {
                      WFItemType: 2,
                      WFKey: {
                        Value: {
                          string: 'labelIds',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                      WFValue: {
                        Value: [
                          'SENT',
                        ],
                        WFSerializationType: 'WFArrayParameterState',
                      },
                    },
                  ],
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'URL',
                      OutputUUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/messages/send',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      ['Send result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Send result',
              ShowHeaders: false,
              UUID: '8EAB0D50-4733-4DF4-B154-BC2023544E50',
              WFHTTPBodyType: 'JSON',
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
                            '{0, 1}': {
                              OutputName: 'Google Auth',
                              OutputUUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'POST',
              WFJSONValues: {
                Value: {
                  WFDictionaryFieldValueItems: [
                    {
                      WFItemType: 2,
                      WFKey: {
                        Value: {
                          string: 'removeLabelIds',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                      WFValue: {
                        Value: [
                          'UNREAD',
                        ],
                        WFSerializationType: 'WFArrayParameterState',
                      },
                    },
                  ],
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'URL',
                      OutputUUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
                      Type: 'ActionOutput',
                    },
                    '{11, 1}': {
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
                      OutputName: 'Send result',
                      OutputUUID: 'A257C6AB-8AB7-4E17-9CC5-E44DA0F65DBB',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/messages/￼/modify',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '10711455-8C96-46D3-BD91-8512ACDA3D84',
        UUID: 'D72BDC8C-F2B5-43A1-98B5-8A8587B375AB',
        WFControlFlowMode: 2,
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: '45042209-F563-4EF4-9F92-BBCCB83F50A0',
        UUID: 'C02C7F41-1099-46D6-B096-CCF1D1C8AA22',
        WFControlFlowMode: 2,
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: '7BF99E34-CFDA-4271-B767-6362755075E4',
        UUID: '28097E31-4D64-447A-AFB1-2C44041EB464',
        WFControlFlowMode: 2,
      })
      ,
      ['JQL']: lib.Action('is.workflow.actions.gettext', {
              CustomOutputName: 'JQL',
              UUID: '2F50117A-0DAA-43B6-B8B5-3F14C1286448',
              WFTextActionText: '"Email Message ID" is not empty',
            })
      ,
      ['Search Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Search Result',
              ShowHeaders: true,
              UUID: '460ABA80-0981-4C8C-9E51-45EFA42D53F1',
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
                            '{0, 1}': {
                              Aggrandizements: [
                                {
                                  CoercionItemClass: 'WFDictionaryContentItem',
                                  Type: 'WFCoercionVariableAggrandizement',
                                },
                                {
                                  DictionaryKey: 'authorization',
                                  Type: 'WFDictionaryValueVariableAggrandizement',
                                },
                              ],
                              OutputName: 'Jira Auth',
                              OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'POST',
              WFJSONValues: {
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
                            '{0, 1}': {
                              OutputName: 'JQL',
                              OutputUUID: '2F50117A-0DAA-43B6-B8B5-3F14C1286448',
                              Type: 'ActionOutput',
                            },
                          },
                          string: '￼',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                    },
                    {
                      WFItemType: 2,
                      WFKey: {
                        Value: {
                          string: 'fields',
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
                                        DictionaryKey: 'field_id: Email Message ID',
                                        Type: 'WFDictionaryValueVariableAggrandizement',
                                      },
                                    ],
                                    OutputName: 'Jira Auth',
                                    OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                                    Type: 'ActionOutput',
                                  },
                                },
                                string: '￼',
                              },
                              WFSerializationType: 'WFTextTokenString',
                            },
                          },
                          'resolution',
                        ],
                        WFSerializationType: 'WFArrayParameterState',
                      },
                    },
                  ],
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'rest_api_url',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Jira Auth',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/search',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: '63E1ED33-CD5A-4F8E-B603-A313EA957E3A',
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
            OutputName: 'Search Result',
            OutputUUID: '460ABA80-0981-4C8C-9E51-45EFA42D53F1',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      })
      ,
      ['Email Message ID']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Email Message ID',
              UUID: '097372A9-8051-43F5-84C7-0661C9972B30',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'field_id: Email Message ID',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Jira Auth',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFInput: {
                Value: {
                  Aggrandizements: [
                    {
                      CoercionItemClass: 'WFDictionaryContentItem',
                      Type: 'WFCoercionVariableAggrandizement',
                    },
                    {
                      DictionaryKey: 'fields',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ],
                  Type: 'Variable',
                  VariableName: 'Repeat Item',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.urlencode', {
        UUID: '7E390DDA-C643-4679-BCE8-C316290AEA2A',
        WFInput: {
          Value: {
            attachmentsByRange: {
              '{12, 1}': {
                OutputName: 'Email Message ID',
                OutputUUID: '097372A9-8051-43F5-84C7-0661C9972B30',
                Type: 'ActionOutput',
              },
            },
            string: 'rfc822msgid:￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      })
      ,
      ['List Emails Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'List Emails Result',
              ShowHeaders: true,
              UUID: '399CA12A-76E3-49CC-BC97-308F4ACC16FD',
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
                            '{0, 1}': {
                              OutputName: 'Google Auth',
                              OutputUUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'URL',
                      OutputUUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
                      Type: 'ActionOutput',
                    },
                    '{13, 1}': {
                      OutputName: 'URL Encoded Text',
                      OutputUUID: '7E390DDA-C643-4679-BCE8-C316290AEA2A',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/messages?q=￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      ['Email']: lib.Action('is.workflow.actions.getitemfromlist', {
              CustomOutputName: 'Email',
              UUID: '5E5A69DC-940A-4CFC-A309-083EE207BA70',
              WFInput: {
                Value: {
                  Aggrandizements: [
                    {
                      CoercionItemClass: 'WFDictionaryContentItem',
                      Type: 'WFCoercionVariableAggrandizement',
                    },
                    {
                      DictionaryKey: 'messages',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ],
                  OutputName: 'List Emails Result',
                  OutputUUID: '399CA12A-76E3-49CC-BC97-308F4ACC16FD',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
            })
      ,
      ['Issue Resolution']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Issue Resolution',
              UUID: '1590BD40-6F46-43B8-A742-F1476E738969',
              WFDictionaryKey: 'resolution',
              WFInput: {
                Value: {
                  Aggrandizements: [
                    {
                      CoercionItemClass: 'WFDictionaryContentItem',
                      Type: 'WFCoercionVariableAggrandizement',
                    },
                    {
                      DictionaryKey: 'fields',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ],
                  Type: 'Variable',
                  VariableName: 'Repeat Item',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: 'F5A004E6-95DA-4F0A-A59A-EC031D14E686',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Issue Resolution',
              OutputUUID: '1590BD40-6F46-43B8-A742-F1476E738969',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      })
      ,
      ['Get Email Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Get Email Result',
              ShowHeaders: true,
              UUID: 'A62A6C7D-CC8B-4D2C-B503-FDEFEAD95F9D',
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
                            '{0, 1}': {
                              OutputName: 'Google Auth',
                              OutputUUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'POST',
              WFJSONValues: {
                Value: {
                  WFDictionaryFieldValueItems: [
                    {
                      WFItemType: 2,
                      WFKey: {
                        Value: {
                          string: 'removeLabelIds',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                      WFValue: {
                        Value: [
                          'STARRED',
                        ],
                        WFSerializationType: 'WFArrayParameterState',
                      },
                    },
                  ],
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'URL',
                      OutputUUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
                      Type: 'ActionOutput',
                    },
                    '{11, 1}': {
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
                      OutputName: 'Email',
                      OutputUUID: '5E5A69DC-940A-4CFC-A309-083EE207BA70',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/messages/￼/modify',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: 'F5A004E6-95DA-4F0A-A59A-EC031D14E686',
        WFControlFlowMode: 1,
      })
      ,
      ['Get Email Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Get Email Result',
              ShowHeaders: true,
              UUID: 'E5F7B7F5-C927-4282-B27A-87B91113E28E',
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
                            '{0, 1}': {
                              OutputName: 'Google Auth',
                              OutputUUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'POST',
              WFJSONValues: {
                Value: {
                  WFDictionaryFieldValueItems: [
                    {
                      WFItemType: 2,
                      WFKey: {
                        Value: {
                          string: 'addLabelIds',
                        },
                        WFSerializationType: 'WFTextTokenString',
                      },
                      WFValue: {
                        Value: [
                          'STARRED',
                        ],
                        WFSerializationType: 'WFArrayParameterState',
                      },
                    },
                  ],
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'URL',
                      OutputUUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
                      Type: 'ActionOutput',
                    },
                    '{11, 1}': {
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
                      OutputName: 'Email',
                      OutputUUID: '5E5A69DC-940A-4CFC-A309-083EE207BA70',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/messages/￼/modify',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: 'F5A004E6-95DA-4F0A-A59A-EC031D14E686',
        UUID: '703C3380-4C21-46DB-9974-3E8CDDF49A9B',
        WFControlFlowMode: 2,
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '4CDE9B38-9F0B-46B2-B1D0-2DF2BEC24146',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Email',
              OutputUUID: '5E5A69DC-940A-4CFC-A309-083EE207BA70',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      })
      ,
      ['Get Email Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Get Email Result',
              ShowHeaders: true,
              UUID: '7084C0A5-A585-4E2B-A279-247F089E8271',
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
                            '{0, 1}': {
                              OutputName: 'Google Auth',
                              OutputUUID: '2A7CE8F8-9D65-4BA8-BAA0-2B13F9FDCA8A',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'URL',
                      OutputUUID: '551214D3-509E-40D4-8256-2798EF0EFAC7',
                      Type: 'ActionOutput',
                    },
                    '{11, 1}': {
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
                      OutputName: 'Email',
                      OutputUUID: '5E5A69DC-940A-4CFC-A309-083EE207BA70',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼/messages/￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
        UUID: '3A8647AD-E7D1-4ECB-91D8-44B75A3BD4BD',
        input: {
          Value: {
            OutputName: 'Get Email Result',
            OutputUUID: '7084C0A5-A585-4E2B-A279-247F089E8271',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: ' .headers = ( .payload.headers | map({ key: (.name | ascii_downcase), value }) | from_entries )',
        queryType: 'jq',
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvariable', {
        WFInput: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'headers',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ],
            OutputName: 'Result',
            OutputUUID: '3A8647AD-E7D1-4ECB-91D8-44B75A3BD4BD',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Headers',
      })
      ,
      ['Email Link']: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
              CustomOutputName: 'Email Link',
              UUID: '56DF1C40-09BB-42D4-AF10-4425679776C5',
              input: {
                Value: {
                  Type: 'Variable',
                  VariableName: 'Headers',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
              jqQuery: '@uri "message://\\(.["message-id"])"',
              queryType: 'jq',
            })
      ,
      ['Search Result']: lib.Action('is.workflow.actions.downloadurl', {
              CustomOutputName: 'Search Result',
              ShowHeaders: true,
              UUID: '95275595-19E1-4470-89B2-483E40217434',
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
                            '{0, 1}': {
                              Aggrandizements: [
                                {
                                  CoercionItemClass: 'WFDictionaryContentItem',
                                  Type: 'WFCoercionVariableAggrandizement',
                                },
                                {
                                  DictionaryKey: 'authorization',
                                  Type: 'WFDictionaryValueVariableAggrandizement',
                                },
                              ],
                              OutputName: 'Jira Auth',
                              OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFHTTPMethod: 'PUT',
              WFJSONValues: {
                Value: {
                  WFDictionaryFieldValueItems: [
                    {
                      WFItemType: 1,
                      WFKey: {
                        Value: {
                          string: 'fields',
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
                                    attachmentsByRange: {
                                      '{0, 1}': {
                                        Aggrandizements: [
                                          {
                                            CoercionItemClass: 'WFDictionaryContentItem',
                                            Type: 'WFCoercionVariableAggrandizement',
                                          },
                                          {
                                            DictionaryKey: 'field_id: Email Link',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Jira Auth',
                                        OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                                        Type: 'ActionOutput',
                                      },
                                    },
                                    string: '￼',
                                  },
                                  WFSerializationType: 'WFTextTokenString',
                                },
                                WFValue: {
                                  Value: {
                                    attachmentsByRange: {
                                      '{0, 1}': {
                                        OutputName: 'Email Link',
                                        OutputUUID: '56DF1C40-09BB-42D4-AF10-4425679776C5',
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
                                    attachmentsByRange: {
                                      '{0, 1}': {
                                        Aggrandizements: [
                                          {
                                            CoercionItemClass: 'WFDictionaryContentItem',
                                            Type: 'WFCoercionVariableAggrandizement',
                                          },
                                          {
                                            DictionaryKey: 'field_id: Email Snippet',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Jira Auth',
                                        OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                                        Type: 'ActionOutput',
                                      },
                                    },
                                    string: '￼',
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
                                            DictionaryKey: 'snippet',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Email',
                                        OutputUUID: '5E5A69DC-940A-4CFC-A309-083EE207BA70',
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
                                    attachmentsByRange: {
                                      '{0, 1}': {
                                        Aggrandizements: [
                                          {
                                            CoercionItemClass: 'WFDictionaryContentItem',
                                            Type: 'WFCoercionVariableAggrandizement',
                                          },
                                          {
                                            DictionaryKey: 'field_id: Email Subject',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        OutputName: 'Jira Auth',
                                        OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                                        Type: 'ActionOutput',
                                      },
                                    },
                                    string: '￼',
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
                                            DictionaryKey: 'subject',
                                            Type: 'WFDictionaryValueVariableAggrandizement',
                                          },
                                        ],
                                        Type: 'Variable',
                                        VariableName: 'Headers',
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
                        WFSerializationType: 'WFDictionaryFieldValue',
                      },
                    },
                  ],
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
              WFURL: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'rest_api_url',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Jira Auth',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
                      Type: 'ActionOutput',
                    },
                    '{8, 1}': {
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
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: '￼/issue/￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '4CDE9B38-9F0B-46B2-B1D0-2DF2BEC24146',
        WFControlFlowMode: 2,
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: '63E1ED33-CD5A-4F8E-B603-A313EA957E3A',
        WFControlFlowMode: 2,
      })
      ,
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59695,
    WFWorkflowIconStartColor: 255,
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
