local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.getarticle', {
      UUID: '1B4A9A3E-E59C-413E-AF6A-1F2627C46F42',
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
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', {
      UUID: '58084029-5B88-4AE9-95C7-0506CA89C45D',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Article',
              OutputUUID: '1B4A9A3E-E59C-413E-AF6A-1F2627C46F42',
              Type: 'ActionOutput',
            },
            '{3, 1}': {
              Type: 'ExtensionInput',
            },
          },
          string: '￼: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.setclipboard', {
      UUID: 'F3D25BD5-457B-4392-975B-8354AFEC33D7',
      WFInput: {
        Value: {
          OutputName: 'Text',
          OutputUUID: '58084029-5B88-4AE9-95C7-0506CA89C45D',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59791,
    WFWorkflowIconStartColor: 255,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorShowError',
    Parameters: {},
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
  ],
}
