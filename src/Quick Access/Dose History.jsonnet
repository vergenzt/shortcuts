{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'dk.simonbs.DataJar.GetValueIntent',
      WFWorkflowActionParameters: {
        UUID: '33258B4E-F713-463A-BB6A-44039131D019',
        keyPath: 'dose-recorder',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.runworkflow',
      WFWorkflowActionParameters: {
        UUID: '1CEEAC73-E5EA-4E73-BD39-B5F7F2B05175',
        WFInput: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'spreadsheetId',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ],
            OutputName: 'Value',
            OutputUUID: '33258B4E-F713-463A-BB6A-44039131D019',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFWorkflow: {
          isSelf: false,
          workflowIdentifier: 'B96A6DDC-DDD1-4684-9AC3-BFF4D9C8DC54',
          workflowName: 'Open Google Spreadsheet',
        },
        WFWorkflowName: 'Open Google Spreadsheet',
      },
    },
  ],
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59461,
    WFWorkflowIconStartColor: 255,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFAppStoreAppContentItem',
    'WFArticleContentItem',
    'WFContactContentItem',
    'WFDateContentItem',
    'WFEmailAddressContentItem',
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
