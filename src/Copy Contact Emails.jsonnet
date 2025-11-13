local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.contacts', name='Contacts', params={
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'DAEF965D-F998-484D-BDA6-508E7411742F',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Contacts')),
    }),

    sc.Action('is.workflow.actions.properties.contacts', name='Email Addresses', params={
      WFContentItemPropertyName: 'Email Addresses',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      WFChooseFromListActionPrompt: sc.Str(['Which email for ', sc.Ref('Vars.Repeat Item'), '?']),
      WFInput: sc.Attach(sc.Ref('Email Addresses')),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'DAEF965D-F998-484D-BDA6-508E7411742F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      text: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: sc.Attach(sc.Ref('Combined Text')),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
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
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorShowError',
    Parameters: {
      Error: 'No contacts in input',
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
    'Watch',
  ],
}
