local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.gettext', name='Content', params={
      WFTextActionText: sc.Str(['---\nupdated_at: ', {
        Aggrandizements: [
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ],
        Type: 'CurrentDate',
      }, '\ncreated_at: ', {
        Aggrandizements: [
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ],
        Type: 'CurrentDate',
      }]),
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Inbox Path', params={
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '8CE27821-6B97-4281-8779-6CA395A5C84F',
        workflowName: 'Get Obsidian Inbox Path',
      },
      WFWorkflowName: 'Get Obsidian Inbox Path',
    }),

    sc.Action('is.workflow.actions.gettext', name='New File Name', params={
      WFTextActionText: sc.Str(['@', {
        Aggrandizements: [
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormat: 'yyyyMMddHHmmssSSS',
            WFDateFormatStyle: 'Custom',
            WFISO8601IncludeTime: false,
          },
        ],
        Type: 'CurrentDate',
      }, '.md']),
    }),

    sc.Action('is.workflow.actions.documentpicker.save', name='Saved File', params={
      WFAskWhereToSave: false,
      WFFileDestinationPath: sc.Str([sc.Ref('Inbox Path')]),
      WFFolder: {
        displayName: 'brain',
        fileLocation: {
          WFFileLocationType: 'LocalStorage',
          appContainerBundleIdentifier: 'md.obsidian',
          crossDeviceItemID: 'deviceSpecific:CB3CF8B9-7192-4227-9973-42070585C008:fp:/gRNihUUV8bXXEqkmVzRgIuZLozlkwwRifiVVznDPS2Y=/com.apple.FileProvider.LocalStorage//fid=13252279',
          fileProviderDomainID: 'com.apple.FileProvider.LocalStorage',
          relativeSubpath: 'brain',
        },
        filename: 'brain',
      },
      WFInput: sc.Attach(sc.Ref('Content')),
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: '^always seems to always set the file extension to .txt\n\nThis works around that:',
    }),

    sc.Action('is.workflow.actions.file.rename', {
      WFFile: sc.Attach(sc.Ref('Saved File')),
      WFNewFilename: sc.Str([sc.Ref('New File Name')]),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: sc.Str(['obsidian://open?vault=brain&file=', sc.Ref('New File Name')]),
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: sc.Str([sc.Ref('URL')]),
      WFResponse: sc.Str(['Added "', sc.Ref('Inbox Path')]),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: true,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61466,
    WFWorkflowIconStartColor: 2071128575,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFAppContentItem',
    'WFAppStoreAppContentItem',
    'WFContactContentItem',
    'WFDateContentItem',
    'WFEmailAddressContentItem',
    'WFiTunesProductContentItem',
    'WFPhoneNumberContentItem',
    'WFStringContentItem',
    'WFURLContentItem',
    'WFArticleContentItem',
    'WFSafariWebPageContentItem',
    'WFLocationContentItem',
    'WFDCMapsLinkContentItem',
    'WFImageContentItem',
    'WFAVAssetContentItem',
    'WFGenericFileContentItem',
    'WFFolderContentItem',
    'WFPDFContentItem',
    'WFRichTextContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFStringContentItem',
    },
  },
  WFWorkflowOutputContentItemClasses: [
    'WFURLContentItem',
  ],
  WFWorkflowTypes: [
    'ActionExtension',
    'Watch',
  ],
}
