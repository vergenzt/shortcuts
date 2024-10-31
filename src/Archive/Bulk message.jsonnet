local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionDefaultAnswer: sc.Str(['Hey {{First Name}}! ', sc.Input]),
      WFAskActionPrompt: 'What’s the message?',
      WFInputType: 'Text',
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: '(?<=\\{\\{)[\\w ]+(?=\\}\\})',
      text: sc.Str([sc.Ref('Provided Input')]),
    }),

    sc.Action('is.workflow.actions.selectcontacts', name='Contacts', params={
      WFSelectMultiple: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '4CC0F7FC-67E5-4A99-9E5B-355E2F0B56ED',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Contacts')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '55D8D462-8872-4045-9F46-91174853FBC0',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Matches')),
    }),

    sc.Action('is.workflow.actions.properties.contacts', name='Details of Contacts', params={
      WFContentItemPropertyName: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([sc.Ref('Provided Input')]),
      WFReplaceTextCaseSensitive: false,
      WFReplaceTextFind: sc.Str(['{{', sc.Ref('Vars.Repeat Item 2'), '}}']),
      WFReplaceTextReplace: sc.Str([sc.Ref('Details of Contacts')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '55D8D462-8872-4045-9F46-91174853FBC0',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.sendmessage', {
      IntentAppDefinition: {
        BundleIdentifier: 'com.apple.MobileSMS',
        Name: 'Messages',
        TeamIdentifier: '0000000000',
      },
      WFSendMessageActionRecipients: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFSendMessageContent: sc.Str([sc.Ref('Updated Text')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '4CC0F7FC-67E5-4A99-9E5B-355E2F0B56ED',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
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
    'Watch',
  ],
}
