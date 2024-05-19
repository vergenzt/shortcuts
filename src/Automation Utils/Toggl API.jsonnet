local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Input Dict', params={
      WFInput: sc.Ref(outputs, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      local outputs = super.outputs,
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{35, 1}': sc.Ref(outputs, 'Input Dict', aggs=[
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
      local outputs = super.outputs,
      WFDictionaryKey: 'method',
      WFInput: sc.Ref(outputs, 'Input Dict', att=true),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Toggl Track API Token', params={
      keyPath: 'Toggl Track.api_token',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Toggl Track API Token'),
          },
          string: '￼:api_token',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.base64encode', name='Base64 Encoded', params={
      local outputs = super.outputs,
      WFBase64LineBreakMode: 'None',
      WFInput: sc.Ref(outputs, 'Text', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Query Params', params={
      local outputs = super.outputs,
      WFDictionaryKey: 'params',
      WFInput: sc.Ref(outputs, 'Input Dict', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Query Params', att=true),
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Query Params', aggs=[
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
      WFInput: sc.Val('${Vars.Repeat Item}', outputs),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Value', params={
      local outputs = super.outputs,
      WFDictionaryKey: sc.Val('${Vars.Repeat Item}', outputs),
      WFInput: sc.Ref(outputs, 'Query Params', att=true),
    }),

    sc.Action('is.workflow.actions.urlencode', name='Value', params={
      local outputs = super.outputs,
      WFInput: sc.Val('${Value}', outputs),
    }),

    sc.Action('is.workflow.actions.gettext', {
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Key'),
            '{2, 1}': sc.Ref(outputs, 'Value'),
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
      local outputs = super.outputs,
      WFTextCustomSeparator: '&',
      WFTextSeparator: 'Custom',
      text: sc.Ref(outputs, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', name='Query', params={
      GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      local outputs = super.outputs,
      WFItems: [
        {
          WFItemType: 0,
          WFValue: sc.Val('${URL}', outputs),
        },
        {
          WFItemType: 0,
          WFValue: sc.Val('${Query}', outputs),
        },
      ],
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined URL', params={
      local outputs = super.outputs,
      WFTextCustomSeparator: '?',
      WFTextSeparator: 'Custom',
      text: sc.Ref(outputs, 'List', att=true),
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
                    '{6, 1}': sc.Ref(outputs, 'Base64 Encoded'),
                  },
                  string: 'Basic ￼',
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
      WFHTTPMethod: sc.Ref(outputs, 'Request Method', att=true),
      WFRequestVariable: sc.Ref(outputs, 'Input Dict', aggs=[
        {
          DictionaryKey: 'json',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ], att=true),
      WFURL: sc.Val('${Combined URL}', outputs),
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
