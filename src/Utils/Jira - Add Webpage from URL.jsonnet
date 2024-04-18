{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    [lib.anon()]: lib.Action('is.workflow.actions.getarticle', {
        UUID: '9D80FFB9-5ECC-495A-9CD5-5C04A03E09DA',
        WFWebPage: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Type: 'ExtensionInput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.previewdocument', {
        WFInput: {
          Value: {
            OutputName: 'Article',
            OutputUUID: '9D80FFB9-5ECC-495A-9CD5-5C04A03E09DA',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      })
      ,
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -43634177,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
    'WFArticleContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFStringContentItem',
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'MenuBar',
    'ReceivesOnScreenContent',
  ],
}
