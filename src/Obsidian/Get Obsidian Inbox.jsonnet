local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', name='Vault Path', params={
      WFInput: sc.Attach(sc.Input),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'F9603A60-27B0-4FA8-AAE3-D958D9F7121E',
        workflowName: 'Get Obsidian Vault Path',
      },
      WFWorkflowName: 'Get Obsidian Vault Path',
    }),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '14D3C7FB-6CB6-4E50-98A5-FEB8D79961F5',
      WFCondition: 4,
      WFConditionalActionString: 'iPhone',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '14D3C7FB-6CB6-4E50-98A5-FEB8D79961F5',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.file.createfolder', {
      WFFilePath: sc.Str([sc.Ref('Vault Path')]),
      WFFolder: {
        displayName: 'Macintosh HD',
        fileLocation: {
          WFFileLocationType: 'Absolute',
          relativeSubpath: '/',
        },
        filename: '/',
      },
    }),

    sc.Action('is.workflow.actions.conditional', name='Folder Path', params={
      GroupingIdentifier: '14D3C7FB-6CB6-4E50-98A5-FEB8D79961F5',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.documentpicker.open', name='File', params={
      WFFile: sc.Attach(sc.Ref('Folder Path')),
      WFGetFilePath: '.obsidian/app.json',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: 'newFileFolderPath',
      WFInput: sc.Attach(sc.Ref('File')),
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: sc.Str([sc.Ref('Dictionary Value')]),
      WFResponse: sc.Str([sc.Ref('Dictionary Value')]),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: true,
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
  WFWorkflowOutputContentItemClasses: [
    'WFBooleanContentItem',
    'WFDateContentItem',
    'WFDictionaryContentItem',
    'WFNumberContentItem',
    'WFStringContentItem',
  ],
  WFWorkflowTypes: [
    'ActionExtension',
    'Watch',
  ],
}
