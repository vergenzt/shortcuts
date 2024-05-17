local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Input Dict', params={
      WFInput: {
        Value: {
          Type: 'ExtensionInput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
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
      WFInput: {
        Value: sc.Ref(outputs, 'Input Dict', aggs=[
          {
            DictionaryKey: 'path',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ]),
        WFSerializationType: 'WFTextTokenAttachment',
      },
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
      WFInput: {
        Value: sc.Ref(outputs, 'Text'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Query Params', params={
      local outputs = super.outputs,
      WFDictionaryKey: 'params',
      WFInput: {
        Value: sc.Ref(outputs, 'Input Dict', aggs=[
          {
            DictionaryKey: 'path',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ]),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: sc.Ref(outputs, 'Query Params'),
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
      WFControlFlowMode: 0,
      WFInput: {
        Value: sc.Ref(outputs, 'Query Params', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            PropertyName: 'Keys',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ]),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.urlencode', name='Key', params={
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Value', params={
      local outputs = super.outputs,
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: sc.Ref(outputs, 'Query Params'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.urlencode', name='Value', params={
      local outputs = super.outputs,
      WFInput: sc.Val('${Value}', outputs),
    }),

    sc.Action('is.workflow.actions.gettext', {
      local outputs = super.outputs,
      UUID: '0A2FB96F-DDF1-493F-AF2D-53684A01A077',
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

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'CB0F08F7-D254-42C4-933F-CDCE8DCF4415',
      UUID: '6EB1C80A-F18C-474B-B085-71DBF93D3894',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', {
      UUID: '338434BD-529B-4AFD-AE22-B4B476F14066',
      WFTextCustomSeparator: '&',
      WFTextSeparator: 'Custom',
      text: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '6EB1C80A-F18C-474B-B085-71DBF93D3894',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      CustomOutputName: 'Query',
      GroupingIdentifier: '4C6CDAC1-3AF6-4835-87D8-C5348FA88848',
      UUID: '42A2218F-381B-42D3-B44D-E2B4D060246F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.list', {
      local outputs = super.outputs,
      UUID: '4F45D58D-5C50-4014-AF98-195EF3FBE96B',
      WFItems: [
        {
          WFItemType: 0,
          WFValue: sc.Val('${URL}', outputs),
        },
        {
          WFItemType: 0,
          WFValue: {
            Value: {
              attachmentsByRange: {
                '{0, 1}': {
                  OutputName: 'Query',
                  OutputUUID: '42A2218F-381B-42D3-B44D-E2B4D060246F',
                  Type: 'ActionOutput',
                },
              },
              string: '￼',
            },
            WFSerializationType: 'WFTextTokenString',
          },
        },
      ],
    }),

    sc.Action('is.workflow.actions.text.combine', {
      CustomOutputName: 'Combined URL',
      UUID: 'A5749BCB-5258-4A9A-8ED7-4ED4FAFC72B3',
      WFTextCustomSeparator: '?',
      WFTextSeparator: 'Custom',
      text: {
        Value: {
          OutputName: 'List',
          OutputUUID: '4F45D58D-5C50-4014-AF98-195EF3FBE96B',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      local outputs = super.outputs,
      ShowHeaders: true,
      UUID: '2B70C5DA-D255-41E1-ABB9-44F8303B5180',
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
                    '{6, 1}': sc.Ref(outputs, 'Base64 Encoded'),
                  },
                  string: 'Basic ￼',
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
      WFHTTPMethod: {
        Value: sc.Ref(outputs, 'Request Method'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFRequestVariable: {
        Value: {
          Aggrandizements: [
            {
              DictionaryKey: 'json',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          OutputName: 'Input Dict',
          OutputUUID: '89C08046-311F-4B52-90E3-C2A3DBFCF024',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Combined URL',
              OutputUUID: 'A5749BCB-5258-4A9A-8ED7-4ED4FAFC72B3',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
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
