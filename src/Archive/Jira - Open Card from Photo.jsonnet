local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.takephoto', {
      UUID: 'E5EEEC27-9961-4BA0-B494-2B5058A36E02',
      WFCameraCaptureShowPreview: true,
    }),

    sc.Action('is.workflow.actions.extracttextfromimage', {
      UUID: '2F5C059E-4286-4620-A2CB-4F546115B199',
      WFImage: {
        Value: {
          OutputName: 'Photo',
          OutputUUID: 'E5EEEC27-9961-4BA0-B494-2B5058A36E02',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.match', {
      UUID: '458A2E62-B389-4BC6-8588-628C795D0A48',
      WFMatchTextPattern: 'CARD-(\\d+)',
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text from Image',
              OutputUUID: '2F5C059E-4286-4620-A2CB-4F546115B199',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: {
        Value: {
          OutputName: 'Matches',
          OutputUUID: '458A2E62-B389-4BC6-8588-628C795D0A48',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('com.atlassian.jira.app.GetIssueIntent', {
      UUID: 'EC39AC83-4A91-45CA-8289-8DA1A5F1B284',
      account: 'vergenzt@gmail.com',
      issueKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Matches',
              OutputUUID: '458A2E62-B389-4BC6-8588-628C795D0A48',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      site: 'vergenz',
    }),

    sc.Action('com.atlassian.jira.app.OpenIssueIntent', {
      UUID: 'D8CDAE08-ED1E-4814-8EB1-AB8E73B25C29',
      issue: {
        Value: {
          OutputName: 'Issue',
          OutputUUID: 'EC39AC83-4A91-45CA-8289-8DA1A5F1B284',
          Type: 'ActionOutput',
        },
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
