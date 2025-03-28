local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '02B0C132-DA76-49DD-AFCF-AC9773A461F1',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              CoercionItemClass: 'WFStringContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ],
          Type: 'ExtensionInput',
        }),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '02B0C132-DA76-49DD-AFCF-AC9773A461F1',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        'Personal',
        'System',
        'Tech',
        'Work-Nava',
      ],
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      WFChooseFromListActionPrompt: 'Which inbox?',
      WFInput: sc.Attach(sc.Ref('List')),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '02B0C132-DA76-49DD-AFCF-AC9773A461F1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettext', name='Inbox Path', params={
      WFTextActionText: sc.Str([sc.Ref('If Result'), '/Inbox']),
    }),

    sc.Action('is.workflow.actions.documentpicker.open', name='File', params={
      WFFile: {
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
      WFGetFilePath: '.obsidian/app.json',
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Updated Settings', params={
      WFDictionary: sc.Attach(sc.Ref('File')),
      WFDictionaryKey: 'newFileFolderPath',
      WFDictionaryValue: sc.Str([sc.Ref('Inbox Path')]),
    }),

    sc.Action('is.workflow.actions.documentpicker.save', {
      WFAskWhereToSave: false,
      WFFileDestinationPath: '.obsidian/app.json',
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
      WFInput: sc.Attach(sc.Ref('Updated Settings')),
      WFSaveFileOverwrite: true,
    }),

    sc.Action('is.workflow.actions.openapp', {
      WFAppIdentifier: 'md.obsidian',
      WFSelectedApp: {
        BundleIdentifier: 'md.obsidian',
        Name: 'Obsidian',
        TeamIdentifier: '6JSW4SJWN9',
      },
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -2873601,
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
  WFWorkflowMinimumClientVersion: 1106,
  WFWorkflowMinimumClientVersionString: '1106',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
    'Watch',
  ],
}
