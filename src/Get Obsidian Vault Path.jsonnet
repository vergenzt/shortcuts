local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A5E6C1E6-1941-4DF1-99B5-CD7BCE59E836',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetKeysIntent', name='Keys', params={
      keyPath: 'Obsidian.vault-ids',
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: sc.Attach(sc.Ref('Keys')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '142EBE4F-E7A8-4440-BE33-A4418469082E',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Count')),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      WFChooseFromListActionPrompt: 'Which Obsidian vault?',
      WFInput: sc.Attach(sc.Ref('Keys')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '142EBE4F-E7A8-4440-BE33-A4418469082E',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Keys')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '142EBE4F-E7A8-4440-BE33-A4418469082E',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', name='Shortcut Input', params={
      GroupingIdentifier: 'A5E6C1E6-1941-4DF1-99B5-CD7BCE59E836',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: '^[0-9a-f]{16}$',
      text: sc.Str([sc.Ref('Shortcut Input')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '426FB853-329E-4E7A-93F4-569A70532655',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Matches')),
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      keyPath: sc.Str(['Obsidian.vault-ids.', sc.Ref('Shortcut Input')]),
    }),

    sc.Action('is.workflow.actions.conditional', name='Vault ID', params={
      GroupingIdentifier: '426FB853-329E-4E7A-93F4-569A70532655',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '727439B1-0FD7-40B8-ABCE-25C7EC72ECEA',
      WFCondition: 4,
      WFConditionalActionString: 'iPhone',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
    }),

    sc.Action('is.workflow.actions.file', {
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
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '727439B1-0FD7-40B8-ABCE-25C7EC72ECEA',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.file', name='File', params={
      WFFile: {
        displayName: 'obsidian',
        fileLocation: {
          WFFileLocationType: 'Home',
          relativeSubpath: 'Library/Application Support/obsidian',
        },
        filename: 'obsidian',
      },
    }),

    sc.Action('is.workflow.actions.documentpicker.open', name='Obsidian Preferences', params={
      WFFile: sc.Attach(sc.Ref('File')),
      WFGetFilePath: 'obsidian.json',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: 'vaults',
      WFInput: sc.Attach(sc.Ref('Obsidian Preferences', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Vault Prefs', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vault ID')]),
      WFInput: sc.Attach(sc.Ref('Dictionary Value')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '323C9248-D382-4BBB-9EF2-7A1DCB9CAAFC',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vault Prefs')),
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: 'path',
      WFInput: sc.Attach(sc.Ref('Vault Prefs')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '323C9248-D382-4BBB-9EF2-7A1DCB9CAAFC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', name='Device Dependent Result', params={
      GroupingIdentifier: '727439B1-0FD7-40B8-ABCE-25C7EC72ECEA',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.output', {
      WFOutput: sc.Str([sc.Ref('Device Dependent Result')]),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -1448498689,
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
    'WFBooleanContentItem',
    'WFDateContentItem',
    'WFDictionaryContentItem',
    'WFGenericFileContentItem',
    'WFNumberContentItem',
    'WFStringContentItem',
  ],
  WFWorkflowTypes: [],
}
