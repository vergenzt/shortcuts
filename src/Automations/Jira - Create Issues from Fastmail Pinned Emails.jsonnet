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
      WFInput: sc.Attach(sc.Ref('Jira API Config')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B82F5A3B-057F-4A18-B930-C1CF65BF732A',
        workflowName: 'Fastmail Auth',
      },
      WFWorkflowName: 'Fastmail Auth',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{161, 1}': sc.Ref('Fastmail Auth', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'accountId',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{397, 1}': sc.Ref('Fastmail Auth', aggs=[
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
      ShowHeaders: true,
      WFHTTPBodyType: 'File',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Authorization']),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': sc.Ref('Fastmail Auth', aggs=[
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'auth',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ]),
                  },
                  string: 'Bearer ￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Content-Type']),
              WFValue: sc.Str(['application/json']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFHTTPMethod: 'POST',
      WFJSONValues: {
        Value: {
          WFDictionaryFieldValueItems: [],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFRequestVariable: sc.Attach(sc.Ref('Text')),
      WFURL: 'https://api.fastmail.com/jmap/api',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: sc.Attach(sc.Ref('Contents of URL')),
      jqQuery: '.methodResponses[-1][1].list[]',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '690887DA-1DDA-448F-B8E8-AED755477B11',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Result')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='from', params={
      WFDictionaryKey: 'from',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='from[0]', params={
      WFInput: sc.Attach(sc.Ref('from')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('from[0]', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'name',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: 'name',
      WFInput: sc.Attach(sc.Ref('from[0]')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: 'email',
      WFInput: sc.Attach(sc.Ref('from[0]')),
    }),

    sc.Action('is.workflow.actions.conditional', name='From', params={
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='messageId', params={
      WFInput: sc.Attach({
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
      }),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
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
            '{42, 1}': sc.Ref('Fastmail Auth', aggs=[
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
      ShowHeaders: true,
      WFHTTPBodyType: 'JSON',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Authorization']),
              WFValue: sc.Str([sc.Ref('Jira API Config', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'authorization',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ])]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Content-Type']),
              WFValue: sc.Str(['application/json']),
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
              WFKey: sc.Str(['fields']),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 1,
                        WFKey: sc.Str(['project']),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 0,
                                  WFKey: sc.Str(['key']),
                                  WFValue: sc.Str([sc.Ref('Jira API Config', aggs=[
                                    {
                                      CoercionItemClass: 'WFDictionaryContentItem',
                                      Type: 'WFCoercionVariableAggrandizement',
                                    },
                                    {
                                      DictionaryKey: 'project_key',
                                      Type: 'WFDictionaryValueVariableAggrandizement',
                                    },
                                  ])]),
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
                        WFKey: sc.Str(['issuetype']),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 0,
                                  WFKey: sc.Str(['name']),
                                  WFValue: sc.Str([sc.Ref('Jira API Config', aggs=[
                                    {
                                      CoercionItemClass: 'WFDictionaryContentItem',
                                      Type: 'WFCoercionVariableAggrandizement',
                                    },
                                    {
                                      DictionaryKey: 'issuetype_name',
                                      Type: 'WFDictionaryValueVariableAggrandizement',
                                    },
                                  ])]),
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
                        WFKey: sc.Str(['summary']),
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{5, 1}': sc.Ref('From'),
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
                        WFKey: sc.Str([sc.Ref('Jira API Config', aggs=[
                          {
                            CoercionItemClass: 'WFDictionaryContentItem',
                            Type: 'WFCoercionVariableAggrandizement',
                          },
                          {
                            DictionaryKey: 'field_id: Email Message ID',
                            Type: 'WFDictionaryValueVariableAggrandizement',
                          },
                        ])]),
                        WFValue: sc.Str([sc.Ref('messageId')]),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str([sc.Ref('Jira API Config', aggs=[
                          {
                            CoercionItemClass: 'WFDictionaryContentItem',
                            Type: 'WFCoercionVariableAggrandizement',
                          },
                          {
                            DictionaryKey: 'field_id: Email Link',
                            Type: 'WFDictionaryValueVariableAggrandizement',
                          },
                        ])]),
                        WFValue: sc.Str([sc.Ref('URL')]),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str([sc.Ref('Jira API Config', aggs=[
                          {
                            CoercionItemClass: 'WFDictionaryContentItem',
                            Type: 'WFCoercionVariableAggrandizement',
                          },
                          {
                            DictionaryKey: 'field_id: Email Snippet',
                            Type: 'WFDictionaryValueVariableAggrandizement',
                          },
                        ])]),
                        WFValue: sc.Str([{
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
                        }]),
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
      WFRequestVariable: sc.Attach({
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
      }),
      WFURL: 'https://vergenz.atlassian.net/rest/api/3/issue',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{159, 1}': sc.Ref('Fastmail Auth', aggs=[
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
      ShowHeaders: true,
      WFHTTPBodyType: 'File',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Authorization']),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': sc.Ref('Fastmail Auth', aggs=[
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'auth',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ]),
                  },
                  string: 'Bearer ￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Content-Type']),
              WFValue: sc.Str(['application/json']),
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
              WFKey: sc.Str(['jql']),
              WFValue: sc.Str([sc.Ref('JQL')]),
            },
            {
              WFItemType: 2,
              WFKey: sc.Str(['fields']),
              WFValue: {
                Value: [
                  {
                    WFItemType: 0,
                    WFValue: sc.Str([sc.Ref('Jira API Config', aggs=[
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'field_id: Email Message ID',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ])]),
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
      WFRequestVariable: sc.Attach(sc.Ref('Text')),
      WFURL: 'https://api.fastmail.com/jmap/api',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '690887DA-1DDA-448F-B8E8-AED755477B11',
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
