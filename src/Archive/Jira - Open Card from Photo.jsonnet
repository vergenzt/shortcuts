local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.takephoto', name='Photo', params={
      WFCameraCaptureShowPreview: true,
    }),

    sc.Action('is.workflow.actions.extracttextfromimage', name='Text from Image', params={
      WFImage: function(state) sc.Ref(state, 'Photo', att=true),
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: 'CARD-(\\d+)',
      text: function(state) sc.Val('${Text from Image}', state),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: function(state) sc.Ref(state, 'Matches', att=true),
    }),

    sc.Action('com.atlassian.jira.app.GetIssueIntent', name='Issue', params={
      account: 'vergenzt@gmail.com',
      issueKey: function(state) sc.Val('${Matches}', state),
      site: 'vergenz',
    }),

    sc.Action('com.atlassian.jira.app.OpenIssueIntent', {
      issue: function(state) sc.Ref(state, 'Issue', att=true),
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
