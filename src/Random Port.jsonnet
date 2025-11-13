local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.number.random', name='Random Number', params={
      WFRandomNumberMaximum: '49151',
      WFRandomNumberMinimum: '1024',
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: sc.Attach(sc.Ref('Random Number')),
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: sc.Str([sc.Ref('Random Number')]),
      WFResponse: sc.Str(['Copied ', sc.Ref('Random Number'), ' to clipboard.']),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: true,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 2071128575,
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
    'WFNumberContentItem',
  ],
  WFWorkflowTypes: [],
}
