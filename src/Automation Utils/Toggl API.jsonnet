local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Input Dict', params={
      WFInput: {
        Value: sc.Input,
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{35, 1}': sc.Ref('Input Dict', aggs=[
              {
                DictionaryKey: 'path',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'https://api.track.toggl.com/api/v9/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Request Method', params={
      WFDictionaryKey: 'method',
      WFInput: sc.Ref('Input Dict', att=true),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Toggl Track API Token', params={
      keyPath: 'Toggl Track.api_token',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Toggl Track API Token'),
          },
          string: '￼:api_token',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.base64encode', name='Base64 Encoded', params={
      WFBase64LineBreakMode: 'None',
      WFInput: sc.Ref('Text', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Query Params', params={
      WFDictionaryKey: 'params',
      WFInput: sc.Ref('Input Dict', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref('Query Params', att=true),
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
      WFControlFlowMode: 0,
      WFInput: sc.Ref('Query Params', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          PropertyName: 'Keys',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ], att=true),
    }),

    sc.Action('is.workflow.actions.urlencode', name='Key', params={
      WFInput: sc.Str([sc.Ref('Vars.Repeat Item')]),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item')]),
      WFInput: sc.Ref('Query Params', att=true),
    }),

    sc.Action('is.workflow.actions.urlencode', name='Value', params={
      WFInput: sc.Str([sc.Ref('Value')]),
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Key'),
            '{2, 1}': sc.Ref('Value'),
          },
          string: '￼=￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', {
      WFTextCustomSeparator: '&',
      WFTextSeparator: 'Custom',
      text: sc.Ref('Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', name='Query', params={
      GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        {
          WFItemType: 0,
          WFValue: sc.Str([sc.Ref('URL')]),
        },
        {
          WFItemType: 0,
          WFValue: sc.Str([sc.Ref('Query')]),
        },
      ],
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined URL', params={
      WFTextCustomSeparator: '?',
      WFTextSeparator: 'Custom',
      text: sc.Ref('List', att=true),
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
                    '{6, 1}': sc.Ref('Base64 Encoded'),
                  },
                  string: 'Basic ￼',
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
      WFHTTPMethod: sc.Ref('Request Method', att=true),
      WFRequestVariable: sc.Ref('Input Dict', aggs=[
        {
          DictionaryKey: 'json',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ], att=true),
      WFURL: sc.Str([sc.Ref('Combined URL')]),
    }),

  ]),
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
