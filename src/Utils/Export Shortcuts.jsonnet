local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.getmyworkflows', {
      UUID: '55A615C7-CCA1-473F-94D8-8894F9C6D59C',
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3C39F304-C709-4042-8340-B48B1B383EB8',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'My Shortcuts',
          OutputUUID: '55A615C7-CCA1-473F-94D8-8894F9C6D59C',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.documentpicker.save', {
      UUID: '959AFD4B-2BCF-4035-8985-8C5C32037D7F',
      WFAskWhereToSave: false,
      WFFileDestinationPath: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Folder',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
            '{3, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '/￼/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFSaveFileOverwrite: true,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3C39F304-C709-4042-8340-B48B1B383EB8',
      UUID: 'DC1645A2-F41F-4792-82B9-63D27E55753E',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.output', {
      WFOutput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Repeat Results',
              OutputUUID: 'DC1645A2-F41F-4792-82B9-63D27E55753E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -2873601,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1106,
  WFWorkflowMinimumClientVersionString: '1106',
  WFWorkflowOutputContentItemClasses: [
    'WFGenericFileContentItem',
  ],
  WFWorkflowTypes: [],
}
