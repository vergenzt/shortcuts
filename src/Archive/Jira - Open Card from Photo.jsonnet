local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.takephoto', name='Photo', params={
      WFCameraCaptureShowPreview: true,
    }),

    sc.Action('is.workflow.actions.extracttextfromimage', name='Text from Image', params={
      local outputs = super.outputs,
      WFImage: {
        Value: sc.Ref(outputs, 'Photo'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      local outputs = super.outputs,
      WFMatchTextPattern: 'CARD-(\\d+)',
      text: sc.Val('${Text from Image}', outputs),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      local outputs = super.outputs,
      WFInput: {
        Value: sc.Ref(outputs, 'Matches'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('com.atlassian.jira.app.GetIssueIntent', name='Issue', params={
      local outputs = super.outputs,
      account: 'vergenzt@gmail.com',
      issueKey: sc.Val('${Matches}', outputs),
      site: 'vergenz',
    }),

    sc.Action('com.atlassian.jira.app.OpenIssueIntent', {
      local outputs = super.outputs,
      UUID: 'D8CDAE08-ED1E-4814-8EB1-AB8E73B25C29',
      issue: {
        Value: sc.Ref(outputs, 'Issue'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
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
