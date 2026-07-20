local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
      'does not have any value'
    )).Then_([

      sc.Action('dk.simonbs.DataJar.GetKeysIntent', name='Keys', params={
        keyPath: 'Obsidian.vault-ids',
      }),

      sc.Action('is.workflow.actions.count', name='Count', params={
        Input: sc.Attach(sc.Ref('Keys')),
      }),

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Count')),
        },
        '>',
        {
          WFNumberValue: '1',
        }
      )).Then_([

        sc.Action('is.workflow.actions.choosefromlist', {
          WFChooseFromListActionPrompt: 'Which Obsidian vault?',
          WFInput: sc.Attach(sc.Ref('Keys')),
        }),

      ]).Else_([

        sc.Action('is.workflow.actions.getvariable', {
          WFVariable: sc.Attach(sc.Ref('Keys')),
        }),

      ]).EndIf_(),

    ]).EndIf_(name='Shortcut Input'),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: '^[0-9a-f]{16}$',
      text: sc.Str([sc.Ref('Shortcut Input')]),
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Matches')),
      },
      'does not have any value'
    )).Then_([

      sc.Action('dk.simonbs.DataJar.GetValueIntent', {
        keyPath: sc.Str(['Obsidian.vault-ids.', sc.Ref('Shortcut Input')]),
      }),

    ]).EndIf_(name='Vault ID'),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
      'is',
      {
        WFConditionalActionString: 'iPhone',
      }
    )).Then_([

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

    ]).Else_([

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

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Vault Prefs')),
        },
        'has any value'
      )).Then_([

        sc.Action('is.workflow.actions.getvalueforkey', {
          WFDictionaryKey: 'path',
          WFInput: sc.Attach(sc.Ref('Vault Prefs')),
        }),

      ]).EndIf_(),

    ]).EndIf_(name='Device Dependent Result'),

    sc.Action('is.workflow.actions.output', {
      WFOutput: sc.Str([sc.Ref('Device Dependent Result')]),
    }),

  ]),
  WFWorkflowClientVersion: '4610',
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
  WFWorkflowTypes: [
    'WFWorkflowTypeShowInSearch',
  ],
}
