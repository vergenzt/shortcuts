{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    [lib.anon()]: lib.Action('is.workflow.actions.getmyworkflows', {
        Folder: {
          DisplayString: 'Automations',
          Identifier: 'D53EB35E-8044-4094-97D9-BD272C132E32',
        },
        UUID: '54872846-4D52-466B-BA19-19ED5923760C',
      })
      ,
      {
        WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
        WFWorkflowActionParameters: {
          GroupingIdentifier: 'B4F3CD09-4BC6-4CBD-B8AC-2DC99998DBF2',
          WFControlFlowMode: 0,
          WFInput: {
            Value: {
              OutputName: 'My Shortcuts',
              OutputUUID: '54872846-4D52-466B-BA19-19ED5923760C',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
      {
        WFWorkflowActionIdentifier: 'is.workflow.actions.notification',
        WFWorkflowActionParameters: {
          UUID: '6F4FFBE5-5C68-4AA7-A0E4-00B77EEC6BC0',
          WFInput: {
            Value: {
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
          WFNotificationActionBody: {
            Value: {
              attachmentsByRange: {
                '{8, 1}': {
                  Type: 'Variable',
                  VariableName: 'Repeat Item',
                },
              },
              string: 'Running ￼',
            },
            WFSerializationType: 'WFTextTokenString',
          },
          WFNotificationActionSound: false,
        },
      },
      [lib.anon()]: lib.Action('is.workflow.actions.runworkflow', {
        UUID: 'BE981082-DE33-4103-81E7-3841C8ECFD19',
        WFInput: {
          Value: {
            Type: 'Variable',
            VariableName: 'Repeat Item',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFWorkflow: {
          Value: {
            Type: 'Variable',
            VariableName: 'Repeat Item',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFWorkflowName: {
          Value: {
            Type: 'Variable',
            VariableName: 'Repeat Item',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'B4F3CD09-4BC6-4CBD-B8AC-2DC99998DBF2',
        UUID: 'BACD74D6-7EB6-4E23-84B5-BDCC69BBD6F4',
        WFControlFlowMode: 2,
      })
      ,
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59699,
    WFWorkflowIconStartColor: -12365313,
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
