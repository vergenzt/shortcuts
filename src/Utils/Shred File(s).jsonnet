{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    [lib.anon()]: lib.Action('is.workflow.actions.runshellscript', {
        Input: {
          Value: {
            Type: 'ExtensionInput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        InputMode: 'as arguments',
        Script: 'gshred -u "$@"',
        Shell: '/bin/bash',
        UUID: '6F16FCD4-8611-4C46-A4F2-2D76552BF163',
      })
      ,
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -314141441,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFGenericFileContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFGenericFileContentItem',
      SerializedParameters: {
        SelectMultiple: true,
      },
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
    'QuickActions',
  ],
}
