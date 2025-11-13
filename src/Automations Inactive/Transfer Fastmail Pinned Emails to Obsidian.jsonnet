local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

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
      WFTextActionText: sc.Str(['{\n  "using": [\n    "urn:ietf:params:jmap:core",\n    "urn:ietf:params:jmap:mail"\n  ],\n  "methodCalls": [\n    [\n      "Email/query",\n      {\n        "accountId": "', sc.Ref('Fastmail Auth', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'accountId',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
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
              WFValue: sc.Str(['Bearer ', sc.Ref('Fastmail Auth', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'auth',
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

    sc.Action('is.workflow.actions.date', name='Email Received At', params={
      WFDateActionDate: sc.Str([{
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'receivedAt',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFDateActionMode: 'Specified Date',
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

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['<', sc.Ref('messageId'), '>']),
    }),

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      WFInput: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: sc.Str(['https://app.fastmail.com/mail/Inbox/', {
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
      }, '.', {
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
      }]),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['---\nupdated_at: ', sc.Ref('URL Encoded Text'), '\ncreated_at: ', sc.Ref('From'), '\nimported_at: ', {
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
      }, '\nimport_source: Fastmail Pinned Email\nfastmail_url: ', sc.Ref('Email Received At', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'ISO 8601',
          WFISO8601IncludeTime: true,
        },
      ]), '\nemail_message_url: message://', {
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
      }, '\n---\n# Email from ', sc.Ref('Email Received At', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'ISO 8601',
          WFISO8601IncludeTime: true,
        },
      ]), ': ', {
        Aggrandizements: [
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ],
        Type: 'CurrentDate',
      }]),
    }),

    sc.Action('is.workflow.actions.gettext', name='New File Name', params={
      WFTextActionText: sc.Str(['@', sc.Ref('Email Received At', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormat: 'yyyyMMddHHmmssSSS',
          WFDateFormatStyle: 'Custom',
          WFISO8601IncludeTime: false,
        },
      ]), '.md']),
    }),

    sc.Action('is.workflow.actions.documentpicker.save', name='Saved File', params={
      WFAskWhereToSave: false,
      WFFileDestinationPath: sc.Str(['Inbox/', sc.Ref('New File Name')]),
      WFFolder: {
        displayName: 'brain',
        fileLocation: {
          WFFileLocationType: 'LocalStorage',
          appContainerBundleIdentifier: 'md.obsidian',
          crossDeviceItemID: 'deviceSpecific:CB3CF8B9-7192-4227-9973-42070585C008:fp:/gRNihUUV8bXXEqkmVzRgIuZLozlkwwRifiVVznDPS2Y=/com.apple.FileProvider.LocalStorage//fid=13252279',
          fileProviderDomainID: 'com.apple.FileProvider.LocalStorage',
          relativeSubpath: 'brain',
        },
        filename: 'brain',
      },
      WFInput: sc.Attach(sc.Ref('Text')),
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: '^always seems to always set the file extension to .txt\n\nThis works around that:',
    }),

    sc.Action('is.workflow.actions.file.rename', {
      WFFile: sc.Attach(sc.Ref('Saved File')),
      WFNewFilename: sc.Str([sc.Ref('New File Name')]),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['{\n  "using": [\n    "urn:ietf:params:jmap:core",\n    "urn:ietf:params:jmap:mail"\n  ],\n  "methodCalls": [\n    [\n      "Email/set",\n      {\n        "accountId": "', sc.Ref('Fastmail Auth', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'accountId',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
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
              WFValue: sc.Str(['Bearer ', sc.Ref('Fastmail Auth', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'auth',
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
  WFWorkflowClientVersion: '3607.0.2',
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
  WFWorkflowMinimumClientVersion: 1106,
  WFWorkflowMinimumClientVersionString: '1106',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'Watch',
  ],
}
