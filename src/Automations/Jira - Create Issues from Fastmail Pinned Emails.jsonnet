local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', {
      CustomOutputName: 'Jira API Config',
      UUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '86996835-A1EC-421B-92A1-1F21056EC7EC',
        workflowName: 'Jira Auth',
      },
      WFWorkflowName: 'Jira Auth',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      CustomOutputName: 'Fastmail Auth',
      UUID: '7A1515E8-1853-4E94-9390-785941AFAB96',
      WFInput: {
        Value: {
          OutputName: 'Jira API Config',
          OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B82F5A3B-057F-4A18-B930-C1CF65BF732A',
        workflowName: 'Fastmail Auth',
      },
      WFWorkflowName: 'Fastmail Auth',
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'B98CCD44-FE23-4C66-BF69-075831D6BDAD',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{161, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'accountId',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Fastmail Auth',
              OutputUUID: '7A1515E8-1853-4E94-9390-785941AFAB96',
              Type: 'ActionOutput',
            },
            '{397, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'accountId',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Fastmail Auth',
              OutputUUID: '7A1515E8-1853-4E94-9390-785941AFAB96',
              Type: 'ActionOutput',
            },
          },
          string: '{\n  "using": [\n    "urn:ietf:params:jmap:core",\n    "urn:ietf:params:jmap:mail"\n  ],\n  "methodCalls": [\n    [\n      "Email/query",\n      {\n        "accountId": "￼",\n        "filter": {\n          "hasKeyword": "$flagged",\n          "notKeyword": "jira-created"\n        },\n        "sort": [{ "property": "receivedAt" }]\n      },\n      1\n    ],\n    [\n      "Email/get",\n      {\n        "accountId": "￼",\n        "#ids": {\n          "resultOf": 1,\n          "name": "Email/query",\n          "path": "/ids"\n        },\n        "properties": [\n          "messageId",\n          "threadId",\n          "subject",\n          "from",\n          "preview"\n        ]\n      },\n      2\n    ]\n  ]\n}\n',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      ShowHeaders: true,
      UUID: '460ABA80-0981-4C8C-9E51-45EFA42D53F1',
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
                    '{7, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'auth',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Fastmail Auth',
                      OutputUUID: '7A1515E8-1853-4E94-9390-785941AFAB96',
                      Type: 'ActionOutput',
                    },
                  },
                  string: 'Bearer ￼',
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
                            OutputName: 'Jira API Config',
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
      WFRequestVariable: {
        Value: {
          OutputName: 'Text',
          OutputUUID: 'B98CCD44-FE23-4C66-BF69-075831D6BDAD',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFURL: 'https://api.fastmail.com/jmap/api',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', {
      UUID: '2C0A6BB1-92BF-4E8D-89B8-E584E3205541',
      input: {
        Value: {
          OutputName: 'Contents of URL',
          OutputUUID: '460ABA80-0981-4C8C-9E51-45EFA42D53F1',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      jqQuery: '.methodResponses[-1][1].list[]',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '690887DA-1DDA-448F-B8E8-AED755477B11',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Result',
          OutputUUID: '2C0A6BB1-92BF-4E8D-89B8-E584E3205541',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'from',
      UUID: '5FFB9C89-F126-4ACB-9F51-F92A6575E36F',
      WFDictionaryKey: 'from',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      CustomOutputName: 'from[0]',
      UUID: 'C1AA495B-3781-48FF-BE63-4106C9686512',
      WFInput: {
        Value: {
          OutputName: 'from',
          OutputUUID: '5FFB9C89-F126-4ACB-9F51-F92A6575E36F',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
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
            OutputName: 'from[0]',
            OutputUUID: 'C1AA495B-3781-48FF-BE63-4106C9686512',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: 'name',
      WFInput: {
        Value: {
          OutputName: 'from[0]',
          OutputUUID: 'C1AA495B-3781-48FF-BE63-4106C9686512',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: 'email',
      WFInput: {
        Value: {
          OutputName: 'from[0]',
          OutputUUID: 'C1AA495B-3781-48FF-BE63-4106C9686512',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      CustomOutputName: 'From',
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      UUID: '942B0EF6-2704-4F96-A283-4BCBB9B78F76',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      CustomOutputName: 'messageId',
      UUID: 'A4D81673-3D44-4FDB-BF2C-C9F19942B7BD',
      WFInput: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'messageId',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.url', {
      UUID: 'F2E98093-2B12-4F73-BAC0-3AD2259B9DFF',
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{36, 1}': {
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
            '{38, 1}': {
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
              VariableName: 'Repeat Item',
            },
            '{42, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'accountId',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Fastmail Auth',
              OutputUUID: '7A1515E8-1853-4E94-9390-785941AFAB96',
              Type: 'ActionOutput',
            },
          },
          string: 'https://app.fastmail.com/mail/Inbox/￼.￼?u=￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      CustomOutputName: 'Create Issue Result',
      ShowHeaders: true,
      UUID: 'F8810E44-2873-4869-8A33-838B2C551216',
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
                      OutputName: 'Jira API Config',
                      OutputUUID: '3AA2C372-5227-4E9A-9941-DF5BAB93E16F',
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
                                          OutputName: 'Jira API Config',
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
                                          OutputName: 'Jira API Config',
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
                                OutputName: 'From',
                                OutputUUID: '942B0EF6-2704-4F96-A283-4BCBB9B78F76',
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
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
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
                                OutputName: 'Jira API Config',
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
                                OutputName: 'messageId',
                                OutputUUID: 'A4D81673-3D44-4FDB-BF2C-C9F19942B7BD',
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
                                    DictionaryKey: 'field_id: Email Link',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                OutputName: 'Jira API Config',
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
                                OutputName: 'URL',
                                OutputUUID: 'F2E98093-2B12-4F73-BAC0-3AD2259B9DFF',
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
                                OutputName: 'Jira API Config',
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
                                    DictionaryKey: 'preview',
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
      WFRequestVariable: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'jiraPostBody',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFURL: 'https://vergenz.atlassian.net/rest/api/3/issue',
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'A11FCCAD-2441-4104-8F98-64CF71741DDD',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{159, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'accountId',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Fastmail Auth',
              OutputUUID: '7A1515E8-1853-4E94-9390-785941AFAB96',
              Type: 'ActionOutput',
            },
            '{194, 1}': {
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
              VariableName: 'Repeat Item',
            },
          },
          string: '{\n  "using": [\n    "urn:ietf:params:jmap:core",\n    "urn:ietf:params:jmap:mail"\n  ],\n  "methodCalls": [\n    [\n      "Email/set",\n      {\n        "accountId": "￼",\n        "update": {\n          "￼": {\n            "keywords/jira-created": true\n          }\n        }\n      },\n      1\n    ]\n  ]\n}\n',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      ShowHeaders: true,
      UUID: '459B4E7F-38A9-4C92-8B8F-DD83A72F2798',
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
                    '{7, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'auth',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Fastmail Auth',
                      OutputUUID: '7A1515E8-1853-4E94-9390-785941AFAB96',
                      Type: 'ActionOutput',
                    },
                  },
                  string: 'Bearer ￼',
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
                            OutputName: 'Jira API Config',
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
      WFRequestVariable: {
        Value: {
          OutputName: 'Text',
          OutputUUID: 'A11FCCAD-2441-4104-8F98-64CF71741DDD',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFURL: 'https://api.fastmail.com/jmap/api',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '690887DA-1DDA-448F-B8E8-AED755477B11',
      UUID: 'E085D4AC-E5A5-4C77-A953-F1DA36D52468',
      WFControlFlowMode: 2,
    }),

  ]),
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
