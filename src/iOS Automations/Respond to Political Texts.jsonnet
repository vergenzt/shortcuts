local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['Is the following text message a political ad? Message contents are included after the "---". Reply only "Yes" or "No". Do not explain your answer.\n\n---\n', {
        Aggrandizements: [
          {
            PropertyName: 'Content',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }]),
    }),

    sc.Action('com.openai.chat.AskIntent', name='ChatGPT Response', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'AskIntent',
        BundleIdentifier: 'com.openai.chat',
        Name: 'ChatGPT',
        TeamIdentifier: '2DC432GLL2',
      },
      ShowWhenRun: false,
      prompt: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6A3FF5BF-241B-46E1-84CF-3171C7A6BB23',
      WFCondition: 4,
      WFConditionalActionString: 'Yes',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('ChatGPT Response')),
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetChildCountIntent', name='Count', params={
      ShowWhenRun: false,
      keyPath: 'Political Texts.messages',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{183, 1}': sc.Ref('Count'),
          },
          string: "Just so you know, I will be donating $1 to the Harris-Walz campaign for every Republican campaign text message I receive between August 21, 2024 and the election. We're currently at $￼.",
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['received_at']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    Type: 'WFDateFormatVariableAggrandizement',
                    WFDateFormatStyle: 'ISO 8601',
                    WFISO8601IncludeTime: true,
                  },
                ],
                Type: 'CurrentDate',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['sender']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'Sender',
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'ExtensionInput',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['content']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'Content',
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'ExtensionInput',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['response']),
              WFValue: sc.Str([sc.Ref('Text')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('dk.simonbs.DataJar.InsertValueInArrayIntent', {
      ShowWhenRun: false,
      insertionPoint: 'end',
      keyPath: 'Political Texts.messages',
      values: sc.Attach(sc.Ref('Dictionary')),
    }),

    sc.Action('is.workflow.actions.sendmessage', {
      IntentAppDefinition: {
        BundleIdentifier: 'com.apple.MobileSMS',
        Name: 'Messages',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: true,
      WFSendMessageActionRecipients: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'Sender',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }),
      WFSendMessageContent: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6A3FF5BF-241B-46E1-84CF-3171C7A6BB23',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -2873601,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFAppContentItem',
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
