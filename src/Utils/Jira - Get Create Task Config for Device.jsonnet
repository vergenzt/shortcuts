local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', name='Shortcut Result', params={
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '735ECBCB-3D63-4F6E-ADAE-05434EB5DDEC',
        workflowName: 'Get Device Label',
      },
      WFWorkflowName: 'Get Device Label',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{49, 1}': sc.Ref('Shortcut Result'),
          },
          string: 'Jira Create Task Config.details-per-device-label.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.output', {
      WFOutput: sc.Str([sc.Ref('Value')]),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -1263359489,
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
    'WFGenericFileContentItem',
  ],
  WFWorkflowTypes: [],
}
