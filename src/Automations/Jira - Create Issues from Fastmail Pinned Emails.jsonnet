local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', name='Jira API Config', params={
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '86996835-A1EC-421B-92A1-1F21056EC7EC',
        workflowName: 'Jira Auth',
      },
      WFWorkflowName: 'Jira Auth',
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Fastmail Auth', params={
      local outputs = super.outputs,
      WFInput: {
        Value: sc.Ref(outputs, 'Jira API Config'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B82F5A3B-057F-4A18-B930-C1CF65BF732A',
        workflowName: 'Fastmail Auth',
      },
      WFWorkflowName: 'Fastmail Auth',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{161, 1}': sc.Ref(outputs, 'Fastmail Auth', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'accountId',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{397, 1}': sc.Ref(outputs, 'Fastmail Auth', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'accountId',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '{\n  "using": [\n    "urn:ietf:params:jmap:core",\n    "urn:ietf:params:jmap:mail"\n  ],\n  "methodCalls": [\n    [\n      "Email/query",\n      {\n        "accountId": "￼",\n        "filter": {\n          "hasKeyword": "$flagged",\n          "notKeyword": "jira-created"\n        },\n        "sort": [{ "property": "receivedAt" }]\n      },\n      1\n    ],\n    [\n      "Email/get",\n      {\n        "accountId": "￼",\n        "#ids": {\n          "resultOf": 1,\n          "name": "Email/query",\n          "path": "/ids"\n        },\n        "properties": [\n          "messageId",\n          "threadId",\n          "subject",\n          "from",\n          "preview"\n        ]\n      },\n      2\n    ]\n  ]\n}\n',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', name='Contents of URL', params={
      local outputs = super.outputs,
      ShowHeaders: true,
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
                    WFValue: sc.Val('${Jira API Config}', outputs),
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
        Value: sc.Ref(outputs, 'Text'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFURL: 'https://api.fastmail.com/jmap/api',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      local outputs = super.outputs,
      input: {
        Value: sc.Ref(outputs, 'Contents of URL'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      jqQuery: '.methodResponses[-1][1].list[]',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: '690887DA-1DDA-448F-B8E8-AED755477B11',
      WFControlFlowMode: 0,
      WFInput: {
        Value: sc.Ref(outputs, 'Result'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='from', params={
      WFDictionaryKey: 'from',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='from[0]', params={
      local outputs = super.outputs,
      WFInput: {
        Value: sc.Ref(outputs, 'from'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: sc.Ref(outputs, 'from[0]', aggs=[
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'name',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ]),
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      local outputs = super.outputs,
      WFDictionaryKey: 'name',
      WFInput: {
        Value: sc.Ref(outputs, 'from[0]', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'name',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ]),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      local outputs = super.outputs,
      WFDictionaryKey: 'email',
      WFInput: {
        Value: sc.Ref(outputs, 'from[0]', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'name',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ]),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', name='From', params={
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='messageId', params={
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

    sc.Action('is.workflow.actions.url', name='URL', params={
      local outputs = super.outputs,
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
            '{42, 1}': sc.Ref(outputs, 'Fastmail Auth', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'accountId',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'https://app.fastmail.com/mail/Inbox/￼.￼?u=￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      local outputs = super.outputs,
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
              WFValue: sc.Val('${Jira API Config}', outputs),
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
                                  WFValue: sc.Val('${Jira API Config}', outputs),
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
                                  WFValue: sc.Val('${Jira API Config}', outputs),
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
                              '{5, 1}': sc.Ref(outputs, 'From'),
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
                        WFKey: sc.Val('${Jira API Config}', outputs),
                        WFValue: sc.Val('${messageId}', outputs),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('${Jira API Config}', outputs),
                        WFValue: sc.Val('${URL}', outputs),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('${Jira API Config}', outputs),
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
      local outputs = super.outputs,
      UUID: 'A11FCCAD-2441-4104-8F98-64CF71741DDD',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{159, 1}': sc.Ref(outputs, 'Fastmail Auth', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'accountId',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
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
      local outputs = super.outputs,
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
                    WFValue: sc.Val('${Jira API Config}', outputs),
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
