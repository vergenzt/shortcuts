local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Input Dict', params={
      local state = super.state,
      WFInput: sc.Ref(state, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      local state = super.state,
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{35, 1}': sc.Ref(state, 'Input Dict', aggs=[
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
      local state = super.state,
      WFDictionaryKey: 'method',
      WFInput: sc.Ref(state, 'Input Dict', att=true),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Toggl Track API Token', params={
      local state = super.state,
      keyPath: 'Toggl Track.api_token',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      local state = super.state,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Toggl Track API Token'),
          },
          string: '￼:api_token',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.base64encode', name='Base64 Encoded', params={
      local state = super.state,
      WFBase64LineBreakMode: 'None',
      WFInput: sc.Ref(state, 'Text', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Query Params', params={
      local state = super.state,
      WFDictionaryKey: 'params',
      WFInput: sc.Ref(state, 'Input Dict', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Query Params', att=true),
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Query Params', aggs=[
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
      local state = super.state,
      WFInput: sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Value', params={
      local state = super.state,
      WFDictionaryKey: sc.Val('${Vars.Repeat Item}', state),
      WFInput: sc.Ref(state, 'Query Params', att=true),
    }),

    sc.Action('is.workflow.actions.urlencode', name='Value', params={
      local state = super.state,
      WFInput: sc.Val('${Value}', state),
    }),

    sc.Action('is.workflow.actions.gettext', {
      local state = super.state,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Key'),
            '{2, 1}': sc.Ref(state, 'Value'),
          },
          string: '￼=￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      local state = super.state,
      GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', {
      local state = super.state,
      WFTextCustomSeparator: '&',
      WFTextSeparator: 'Custom',
      text: sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', name='Query', params={
      local state = super.state,
      GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      local state = super.state,
      WFItems: [
        {
          WFItemType: 0,
          WFValue: sc.Val('${URL}', state),
        },
        {
          WFItemType: 0,
          WFValue: sc.Val('${Query}', state),
        },
      ],
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined URL', params={
      local state = super.state,
      WFTextCustomSeparator: '?',
      WFTextSeparator: 'Custom',
      text: sc.Ref(state, 'List', att=true),
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      local state = super.state,
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
                    '{6, 1}': sc.Ref(state, 'Base64 Encoded'),
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
      WFHTTPMethod: sc.Ref(state, 'Request Method', att=true),
      WFRequestVariable: sc.Ref(state, 'Input Dict', aggs=[
        {
          DictionaryKey: 'json',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ], att=true),
      WFURL: sc.Val('${Combined URL}', state),
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
