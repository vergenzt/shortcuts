local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', name='Shortcut Result', params={
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '54A10E86-3149-4BDC-9C7C-F822194182D1',
        workflowName: 'Get Device Labels',
      },
      WFWorkflowName: 'Get Device Labels',
    }),

    sc.Action('is.workflow.actions.getwifi', name='Network Details', params={
      WFNetworkDetailsNetwork: 'Wi-Fi',
      WFWiFiDetail: 'Hardware MAC Address',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Network Details')]),
      WFInput: sc.Attach(sc.Ref('Shortcut Result')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '70681BE9-B13D-47A3-ADEB-4D9A2BFB7094',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Dictionary Value')),
      },
    }),

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAllowsMultilineText: false,
      WFAskActionDefaultAnswer: '',
      WFAskActionPrompt: 'Device not labeled! Would you like to label it?',
      WFInputType: 'Text',
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{14, 1}': sc.Ref('Network Details'),
          },
          string: 'Device Labels.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysDisallow',
      valueConversionMode: 'text',
      values: sc.Attach(sc.Ref('Provided Input')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '70681BE9-B13D-47A3-ADEB-4D9A2BFB7094',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Copy to Clipboard',
      WFOutput: sc.Str([sc.Ref('Network Details')]),
      WFResponse: sc.Str([sc.Ref('Network Details')]),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: true,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 431817727,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFAppContentItem',
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
  WFWorkflowOutputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowTypes: [],
}
