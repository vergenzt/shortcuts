local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.takephoto', name='Photo', params={
      WFCameraCaptureShowPreview: true,
    }),

    sc.Action('is.workflow.actions.extracttextfromimage', name='Text from Image', params={
      WFImage: sc.Ref('Photo', att=true),
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: 'CARD-(\\d+)',
      text: sc.Str([sc.Ref('Text from Image')]),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Ref('Matches', att=true),
    }),

    sc.Action('com.atlassian.jira.app.GetIssueIntent', name='Issue', params={
      account: 'vergenzt@gmail.com',
      issueKey: sc.Str([sc.Ref('Matches')]),
      site: 'vergenz',
    }),

    sc.Action('com.atlassian.jira.app.OpenIssueIntent', {
      issue: sc.Ref('Issue', att=true),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -615917313,
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
