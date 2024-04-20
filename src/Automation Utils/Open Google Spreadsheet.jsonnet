local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.getdevicedetails', {
      UUID: '70BF179B-0520-4404-9E01-FB6D891D5536',
      WFDeviceDetail: 'Device Model',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      WFCondition: 4,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Device Model',
            OutputUUID: '70BF179B-0520-4404-9E01-FB6D891D5536',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', {
      UUID: '4C33B873-50CF-44E1-8A8F-5A6EA03F6C26',
      WFTextActionText: 'https',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      WFControlFlowMode: 1,
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', {
      UUID: 'C32F3A03-E30D-4B85-9944-FEEEF866251E',
      WFTextActionText: 'googlesheets',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', label='Scheme', params={
      GroupingIdentifier: '2607D75E-2498-4367-B38D-ECE360DB437F',
      UUID: '316906E6-934C-40B3-8165-F27AFBE00983',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.url', {
      'Show-WFURLActionURL': true,
      UUID: 'E493CEF0-9ABF-4261-9968-304EC2EE7798',
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Scheme',
              OutputUUID: '316906E6-934C-40B3-8165-F27AFBE00983',
              Type: 'ActionOutput',
            },
            '{35, 1}': {
              Type: 'ExtensionInput',
            },
          },
          string: '￼://docs.google.com/spreadsheets/d/￼/edit',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.openurl', {
      'Show-WFInput': true,
      UUID: 'D60C6ACE-FD01-47BF-B159-F075667CEBFD',
      WFInput: {
        Value: {
          OutputName: 'URL',
          OutputUUID: 'E493CEF0-9ABF-4261-9968-304EC2EE7798',
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
    WFWorkflowIconGlyphNumber: 59749,
    WFWorkflowIconStartColor: 4292093695,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFPhotoMediaContentItem',
      SerializedParameters: {},
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
