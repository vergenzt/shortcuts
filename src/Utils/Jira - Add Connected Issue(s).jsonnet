local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', {
      CustomOutputName: 'Empty Dictionary',
      UUID: 'D99BCD84-949B-49F8-9FF9-6C3335D183D2',
    }),

    sc.Action('is.workflow.actions.detect.dictionary', {
      CustomOutputName: 'Input As Dict',
      UUID: '2AD3A488-0CEF-4445-AB44-9959DAC1472F',
      WFInput: {
        Value: {
          Type: 'ExtensionInput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Input As Dict',
            OutputUUID: '2AD3A488-0CEF-4445-AB44-9959DAC1472F',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      UUID: '8BAFECD7-A17E-4FCC-8DBF-89A4B292C18F',
      WFDictionaryKey: 'issue_key',
      WFInput: {
        Value: {
          OutputName: 'Input As Dict',
          OutputUUID: '2AD3A488-0CEF-4445-AB44-9959DAC1472F',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: 'F5C1A2B2-6F88-4B40-8CD8-9948E2B2F762',
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
      WFReplaceTextFind: '.*\\b([A-Z]+-[1-9][0-9]*)\\b.*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1',
    }),

    sc.Action('is.workflow.actions.conditional', {
      CustomOutputName: 'Issue key',
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      UUID: '0136A062-CA5F-4107-8BC7-4AE815BEEE68',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: 'F25C44DC-481A-4936-847E-03A8DE5CC0FF',
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
                      OutputName: 'Issue key',
                      OutputUUID: '0136A062-CA5F-4107-8BC7-4AE815BEEE68',
                      Type: 'ActionOutput',
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

    sc.Action('is.workflow.actions.runworkflow', {
      CustomOutputName: 'Get Initial Issue Response',
      UUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: 'F25C44DC-481A-4936-847E-03A8DE5CC0FF',
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

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Initial Issue Key',
      UUID: 'F64A9F32-626F-4776-87A8-674454196E8E',
      WFDictionaryKey: 'key',
      WFInput: {
        Value: {
          OutputName: 'Get Initial Issue Response',
          OutputUUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: '33AEAE09-3079-4865-BC17-36661989C2FF',
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
                  string: 'issueLinkType',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      CustomOutputName: 'Get Link Types Result',
      UUID: '4088C2CB-BE97-4421-8CD1-7C940678AE98',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '33AEAE09-3079-4865-BC17-36661989C2FF',
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

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', {
      CustomOutputName: 'Link Type IDs by Inward String',
      UUID: 'DED77A96-D76F-41D8-8D0D-AF6E04B6DE84',
      input: {
        Value: {
          OutputName: 'Get Link Types Result',
          OutputUUID: '4088C2CB-BE97-4421-8CD1-7C940678AE98',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      jqQuery: '.issueLinkTypes | map(select(.name | contains("*") | not) | { key: .inward, value: .id }) | from_entries',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      CustomOutputName: 'Chosen String',
      UUID: '5E6E4F44-9FA5-4CA6-A888-CD1403D3D744',
      WFChooseFromListActionPrompt: "What's the relationship?",
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
          OutputName: 'Link Type IDs by Inward String',
          OutputUUID: 'DED77A96-D76F-41D8-8D0D-AF6E04B6DE84',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Link Type ID',
      UUID: 'C76A162D-C96B-4E02-9EB1-2F6AC61EF6A0',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Chosen String',
              OutputUUID: '5E6E4F44-9FA5-4CA6-A888-CD1403D3D744',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          OutputName: 'Link Type IDs by Inward String',
          OutputUUID: 'DED77A96-D76F-41D8-8D0D-AF6E04B6DE84',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'fields.summary',
      UUID: '77F5841A-5F54-4CB0-B6C2-BF2E890D4153',
      WFDictionaryKey: 'fields.summary',
      WFInput: {
        Value: {
          OutputName: 'Get Initial Issue Response',
          OutputUUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.ask', {
      CustomOutputName: 'New Issue Summary',
      UUID: '9639A5A1-6CB9-4744-8E09-641EECD0147E',
      WFAllowsMultilineText: false,
      WFAskActionDefaultAnswer: {
        Value: {
          attachmentsByRange: {
            '{19, 1}': {
              OutputName: 'fields.summary',
              OutputUUID: '77F5841A-5F54-4CB0-B6C2-BF2E890D4153',
              Type: 'ActionOutput',
            },
          },
          string: 'Issue connected to ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: 'What’s the connected issue summary?',
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      UUID: '22000F0C-A819-4ABF-AEBC-B11425E50A49',
      WFInput: {
        Value: {
          OutputName: 'New Issue Summary',
          OutputUUID: '9639A5A1-6CB9-4744-8E09-641EECD0147E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      CustomOutputName: 'Quoted New Issue Summary',
      UUID: 'EA18110B-B53A-487E-A84C-F27757B239A6',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'New Issue Summary',
              OutputUUID: '9639A5A1-6CB9-4744-8E09-641EECD0147E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '"',
      WFReplaceTextReplace: '\\"',
    }),

    sc.Action('is.workflow.actions.gettext', {
      CustomOutputName: 'Query',
      UUID: '3A78A6FD-4D7D-472C-8558-F4EFAF603C66',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{144, 1}': {
              OutputName: 'Quoted New Issue Summary',
              OutputUUID: 'EA18110B-B53A-487E-A84C-F27757B239A6',
              Type: 'ActionOutput',
            },
            '{323, 1}': {
              OutputName: 'Link Type ID',
              OutputUUID: 'C76A162D-C96B-4E02-9EB1-2F6AC61EF6A0',
              Type: 'ActionOutput',
            },
            '{361, 1}': {
              OutputName: 'Initial Issue Key',
              OutputUUID: 'F64A9F32-626F-4776-87A8-674454196E8E',
              Type: 'ActionOutput',
            },
          },
          string: '{\n  method: "POST",\n  path: "issue",\n  json: {\n    fields: ({\n      project: { key: "TIM" },\n      issuetype: { name: "Task" },\n      summary: "￼"\n    } + (\n      if .fields.parent then (.fields | { parent } | .parent |= { key }) else {} end\n    )),\n    update: {\n      issuelinks: [{\n        add: {\n          type: { id: "￼" },\n          outwardIssue: { key: "￼" },\n        }\n      }]\n    }\n  }\n}',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', {
      CustomOutputName: 'Create Issue Request',
      UUID: '8D834350-6F16-4B6F-B724-17809205EA0C',
      input: {
        Value: {
          OutputName: 'Get Initial Issue Response',
          OutputUUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      jqQuery: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Query',
              OutputUUID: '3A78A6FD-4D7D-472C-8558-F4EFAF603C66',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.dictionary', {
      CustomOutputName: 'Create Issue Request',
      UUID: 'D0DCBC56-D590-48B3-B37B-BA5E74A5FB7C',
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
                  string: 'issue',
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
                                                string: 'TIM',
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
                                                string: 'Task',
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
                                          OutputName: 'New Issue Summary',
                                          OutputUUID: '9639A5A1-6CB9-4744-8E09-641EECD0147E',
                                          Type: 'ActionOutput',
                                        },
                                      },
                                      string: '￼',
                                    },
                                    WFSerializationType: 'WFTextTokenString',
                                  },
                                },
                                {
                                  WFItemType: 1,
                                  WFKey: {
                                    Value: {
                                      string: 'parent',
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
                                                        DictionaryKey: 'fields.parent.key',
                                                        Type: 'WFDictionaryValueVariableAggrandizement',
                                                      },
                                                    ],
                                                    OutputName: 'Get Initial Issue Response',
                                                    OutputUUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
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
                          WFSerializationType: 'WFDictionaryFieldValue',
                        },
                      },
                      {
                        WFItemType: 1,
                        WFKey: {
                          Value: {
                            string: 'update',
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
                                      string: 'issuelinks',
                                    },
                                    WFSerializationType: 'WFTextTokenString',
                                  },
                                  WFValue: {
                                    Value: [
                                      {
                                        WFItemType: 1,
                                        WFValue: {
                                          Value: {
                                            Value: {
                                              WFDictionaryFieldValueItems: [
                                                {
                                                  WFItemType: 1,
                                                  WFKey: {
                                                    Value: {
                                                      string: 'add',
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
                                                                string: 'type',
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
                                                                          string: 'id',
                                                                        },
                                                                        WFSerializationType: 'WFTextTokenString',
                                                                      },
                                                                      WFValue: {
                                                                        Value: {
                                                                          attachmentsByRange: {
                                                                            '{0, 1}': {
                                                                              OutputName: 'Link Type ID',
                                                                              OutputUUID: 'C76A162D-C96B-4E02-9EB1-2F6AC61EF6A0',
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
                                                                string: 'outwardIssue',
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
                                                                              OutputName: 'Initial Issue Key',
                                                                              OutputUUID: 'F64A9F32-626F-4776-87A8-674454196E8E',
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
                                                    WFSerializationType: 'WFDictionaryFieldValue',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      CustomOutputName: 'Create Issue Result',
      UUID: '626C3B68-7142-47C4-BEC8-5C10807319A0',
      WFInput: {
        Value: {
          OutputName: 'Create Issue Request',
          OutputUUID: '8D834350-6F16-4B6F-B724-17809205EA0C',
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

    sc.Action('is.workflow.actions.getdevicedetails', {
      UUID: '520CB083-DCD8-4D42-9A88-A714363CC3F7',
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.setvalueforkey', {
      UUID: '718CE697-1C85-422E-A987-24A80A642E9B',
      WFDictionary: {
        Value: {
          OutputName: 'Empty Dictionary',
          OutputUUID: 'D99BCD84-949B-49F8-9FF9-6C3335D183D2',
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
              OutputName: 'Create Issue Result',
              OutputUUID: '626C3B68-7142-47C4-BEC8-5C10807319A0',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D4AC72F2-B4A7-45F9-9E9D-E4664B6D9B83',
      WFCondition: 5,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Device Model',
            OutputUUID: '520CB083-DCD8-4D42-9A88-A714363CC3F7',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      UUID: '41E5AF0C-6525-4378-990F-1B254805D942',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '718CE697-1C85-422E-A987-24A80A642E9B',
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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0ADD3BA5-12CD-4D5E-8562-1FF5ACE0856B',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                DictionaryKey: 'skip_base_rereview',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ],
            OutputName: 'Input As Dict',
            OutputUUID: '2AD3A488-0CEF-4445-AB44-9959DAC1472F',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: '19A9108A-BABC-4DC3-BA96-93F2E01CAF73',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'review_prompt_optional',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'Review initial issue one more time?',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', {
      UUID: '98D8B1CF-CA3A-47CF-93C6-ED3FF304F57A',
      WFDictionary: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '19A9108A-BABC-4DC3-BA96-93F2E01CAF73',
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
              OutputName: 'Get Initial Issue Response',
              OutputUUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      UUID: '8CA0C493-2B2D-4B75-AD13-548A69ED22BD',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '98D8B1CF-CA3A-47CF-93C6-ED3FF304F57A',
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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0ADD3BA5-12CD-4D5E-8562-1FF5ACE0856B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D4AC72F2-B4A7-45F9-9E9D-E4664B6D9B83',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.exit', {}),

    sc.Action('is.workflow.actions.setvalueforkey', {
      UUID: '2D3A587A-31A9-4D6B-8A30-9452FBEF375E',
      WFDictionary: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '718CE697-1C85-422E-A987-24A80A642E9B',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: 'skip_return',
      WFDictionaryValue: 'true',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      UUID: 'F220F8B8-4EFE-495E-B4B4-FDA195FA0522',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '2D3A587A-31A9-4D6B-8A30-9452FBEF375E',
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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D4AC72F2-B4A7-45F9-9E9D-E4664B6D9B83',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -615917313,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
    'WFStringContentItem',
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
  WFWorkflowTypes: [
    'ActionExtension',
    'MenuBar',
    'ReceivesOnScreenContent',
  ],
}
