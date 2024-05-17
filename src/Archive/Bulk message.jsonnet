local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionDefaultAnswer: {
        Value: {
          attachmentsByRange: {
            '{20, 1}': {
              Type: 'ExtensionInput',
            },
          },
          string: 'Hey {{First Name}}! ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: 'What’s the message?',
      WFInputType: 'Text',
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      local outputs = super.outputs,
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: '(?<=\\{\\{)[\\w ]+(?=\\}\\})',
      text: sc.Val('${Provided Input}', outputs),
    }),

    sc.Action('is.workflow.actions.selectcontacts', name='Contacts', params={
      WFSelectMultiple: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: '4CC0F7FC-67E5-4A99-9E5B-355E2F0B56ED',
      UUID: 'DADB7B38-37DE-47A8-AB9C-553B4DC5052F',
      WFControlFlowMode: 0,
      WFInput: {
        Value: sc.Ref(outputs, 'Contacts'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: '55D8D462-8872-4045-9F46-91174853FBC0',
      WFControlFlowMode: 0,
      WFInput: {
        Value: sc.Ref(outputs, 'Matches'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.properties.contacts', {
      UUID: 'CB8E419C-2BCF-49B9-8460-3CB9899B8B0C',
      WFContentItemPropertyName: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item 2',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      local outputs = super.outputs,
      UUID: 'D313D4E3-013F-4C4D-91F6-8E428F076FF5',
      WFInput: sc.Val('${Provided Input}', outputs),
      WFReplaceTextCaseSensitive: false,
      WFReplaceTextFind: {
        Value: {
          attachmentsByRange: {
            '{2, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item 2',
            },
          },
          string: '{{￼}}',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextReplace: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Group',
              OutputUUID: 'CB8E419C-2BCF-49B9-8460-3CB9899B8B0C',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '55D8D462-8872-4045-9F46-91174853FBC0',
      UUID: '1C368B7B-5A16-4607-A75B-EE757FD6C7C8',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.sendmessage', {
      IntentAppDefinition: {
        BundleIdentifier: 'com.apple.MobileSMS',
        Name: 'Messages',
        TeamIdentifier: '0000000000',
      },
      UUID: 'E13828B9-47FA-4412-A7D7-121D69B92587',
      WFSendMessageActionRecipients: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFSendMessageContent: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Updated Text',
              OutputUUID: 'D313D4E3-013F-4C4D-91F6-8E428F076FF5',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '4CC0F7FC-67E5-4A99-9E5B-355E2F0B56ED',
      UUID: 'E36736DB-A729-46A2-B903-C080A94B245B',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -1263359489,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFImageContentItem',
    'WFStringContentItem',
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
  ],
}
