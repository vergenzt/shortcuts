{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.ask',
      WFWorkflowActionParameters: {
        UUID: '08745925-9D0E-4887-A37A-6DF8CCA06249',
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.match',
      WFWorkflowActionParameters: {
        UUID: 'AF8E2A17-3E43-4DDA-B9EF-449A886431AE',
        WFMatchTextCaseSensitive: false,
        WFMatchTextPattern: '(?<=\\{\\{)[\\w ]+(?=\\}\\})',
        text: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Provided Input',
                OutputUUID: '08745925-9D0E-4887-A37A-6DF8CCA06249',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.selectcontacts',
      WFWorkflowActionParameters: {
        UUID: '72B1CB92-840C-4804-9B47-3AD68EB93C3F',
        WFSelectMultiple: true,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '4CC0F7FC-67E5-4A99-9E5B-355E2F0B56ED',
        UUID: 'DADB7B38-37DE-47A8-AB9C-553B4DC5052F',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            OutputName: 'Contacts',
            OutputUUID: '72B1CB92-840C-4804-9B47-3AD68EB93C3F',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '55D8D462-8872-4045-9F46-91174853FBC0',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            OutputName: 'Matches',
            OutputUUID: 'AF8E2A17-3E43-4DDA-B9EF-449A886431AE',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.properties.contacts',
      WFWorkflowActionParameters: {
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.replace',
      WFWorkflowActionParameters: {
        UUID: 'D313D4E3-013F-4C4D-91F6-8E428F076FF5',
        WFInput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Provided Input',
                OutputUUID: '08745925-9D0E-4887-A37A-6DF8CCA06249',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '55D8D462-8872-4045-9F46-91174853FBC0',
        UUID: '1C368B7B-5A16-4607-A75B-EE757FD6C7C8',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.sendmessage',
      WFWorkflowActionParameters: {
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
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '4CC0F7FC-67E5-4A99-9E5B-355E2F0B56ED',
        UUID: 'E36736DB-A729-46A2-B903-C080A94B245B',
        WFControlFlowMode: 2,
      },
    },
  ],
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
