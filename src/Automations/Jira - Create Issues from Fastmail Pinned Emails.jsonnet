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
      WFInput: sc.Ref(outputs, 'Jira API Config', att=true),
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
              WFKey: sc.Val('Authorization'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': sc.Ref(outputs, 'Fastmail Auth', aggs=[
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
              WFKey: sc.Val('Content-Type'),
              WFValue: sc.Val('application/json'),
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
              WFKey: sc.Val('jql'),
              WFValue: sc.Val('${JQL}', outputs),
            },
            {
              WFItemType: 2,
              WFKey: sc.Val('fields'),
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
      WFRequestVariable: sc.Ref(outputs, 'Text', att=true),
      WFURL: 'https://api.fastmail.com/jmap/api',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      local outputs = super.outputs,
      input: sc.Ref(outputs, 'Contents of URL', att=true),
      jqQuery: '.methodResponses[-1][1].list[]',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: '690887DA-1DDA-448F-B8E8-AED755477B11',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Result', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='from', params={
      WFDictionaryKey: 'from',
      WFInput: sc.Ref(outputs, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='from[0]', params={
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'from', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'from[0]', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'name',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ], att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      local outputs = super.outputs,
      WFDictionaryKey: 'name',
      WFInput: sc.Ref(outputs, 'from[0]', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C8492311-4C65-4A50-BAA1-5C18CAC7EF4F',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      local outputs = super.outputs,
      WFDictionaryKey: 'email',
      WFInput: sc.Ref(outputs, 'from[0]', att=true),
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
      ShowHeaders: true,
      WFHTTPBodyType: 'JSON',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('Authorization'),
              WFValue: sc.Val('${Jira API Config}', outputs),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('Content-Type'),
              WFValue: sc.Val('application/json'),
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
              WFKey: sc.Val('fields'),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 1,
                        WFKey: sc.Val('project'),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 0,
                                  WFKey: sc.Val('key'),
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
                        WFKey: sc.Val('issuetype'),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 0,
                                  WFKey: sc.Val('name'),
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
                        WFKey: sc.Val('summary'),
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

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      local outputs = super.outputs,
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
      WFHTTPBodyType: 'File',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('Authorization'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': sc.Ref(outputs, 'Fastmail Auth', aggs=[
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
              WFKey: sc.Val('Content-Type'),
              WFValue: sc.Val('application/json'),
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
              WFKey: sc.Val('jql'),
              WFValue: sc.Val('${JQL}', outputs),
            },
            {
              WFItemType: 2,
              WFKey: sc.Val('fields'),
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
      WFRequestVariable: sc.Ref(outputs, 'Text', att=true),
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
  WFWorkflowTypes: [],
}
