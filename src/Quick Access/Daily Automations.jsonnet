local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getmyworkflows', name='My Shortcuts', params={
      Folder: {
        DisplayString: 'Automations',
        Identifier: 'D53EB35E-8044-4094-97D9-BD272C132E32',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B4F3CD09-4BC6-4CBD-B8AC-2DC99998DBF2',
      WFControlFlowMode: 0,
      WFInput: sc.Ref('My Shortcuts', att=true),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Ref('Vars.Repeat Item', att=true),
      WFWorkflow: sc.Ref('Vars.Repeat Item', att=true),
      WFWorkflowName: sc.Ref('Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B4F3CD09-4BC6-4CBD-B8AC-2DC99998DBF2',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59699,
    WFWorkflowIconStartColor: -12365313,
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
