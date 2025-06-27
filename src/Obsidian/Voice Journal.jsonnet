local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('is.workflow.actions.gettext', name='Name', params={
      WFTextActionText: sc.Str(['@', sc.Ref('Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormat: 'YYYYMMDDHHmmssSSS',
          WFDateFormatStyle: 'Custom',
          WFISO8601IncludeTime: false,
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.recordaudio', name='Recorded Audio', params={
      WFRecordingEnd: 'On Tap',
      WFRecordingStart: 'On Tap',
    }),

    sc.Action('is.workflow.actions.documentpicker.save', {
      WFAskWhereToSave: false,
      WFFileDestinationPath: sc.Str(['Reference/Journal/', sc.Ref('Name'), '/audio.m4a']),
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
      WFInput: sc.Attach(sc.Ref('Recorded Audio')),
    }),

    sc.Action('com.apple.ShortcutsActions.TranscribeAudioAction', name='Transcribe Audio', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'TranscribeAudioAction',
        BundleIdentifier: 'com.apple.ShortcutsActions',
        Name: 'ShortcutsActions',
        TeamIdentifier: '0000000000',
      },
      audioFile: sc.Attach(sc.Ref('Recorded Audio')),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['---\ncreated_at: ', sc.Ref('Date'), '\nupdated_at: ', sc.Ref('Name'), '\nimport_source: Shortcut "Voice Journal"\n---\n# Voice journal entry from ', sc.Ref('Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'ISO 8601',
          WFISO8601IncludeTime: true,
        },
      ]), '\n\n![[', sc.Ref('Transcribe Audio')]),
    }),

    sc.Action('is.workflow.actions.documentpicker.save', name='Saved File', params={
      WFAskWhereToSave: false,
      WFFileDestinationPath: sc.Str(['Reference/Journal/', sc.Ref('Name'), '/_about_.md']),
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
      WFInput: sc.Attach(sc.Ref('Text')),
    }),

    sc.Action('is.workflow.actions.file.rename', {
      WFFile: sc.Attach(sc.Ref('Saved File')),
      WFNewFilename: '_about_.md',
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -2873601,
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
  WFWorkflowMinimumClientVersion: 1106,
  WFWorkflowMinimumClientVersionString: '1106',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
