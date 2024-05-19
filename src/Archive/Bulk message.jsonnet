local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      local state = super.state,
      WFAskActionDefaultAnswer: {
        Value: {
          attachmentsByRange: {
            '{20, 1}': sc.Ref(state, 'Shortcut Input'),
          },
          string: 'Hey {{First Name}}! ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: 'What’s the message?',
      WFInputType: 'Text',
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      local state = super.state,
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: '(?<=\\{\\{)[\\w ]+(?=\\}\\})',
      text: sc.Val('${Provided Input}', state),
    }),

    sc.Action('is.workflow.actions.selectcontacts', name='Contacts', params={
      local state = super.state,
      WFSelectMultiple: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: '4CC0F7FC-67E5-4A99-9E5B-355E2F0B56ED',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Contacts', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: '55D8D462-8872-4045-9F46-91174853FBC0',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Matches', att=true),
    }),

    sc.Action('is.workflow.actions.properties.contacts', name='Group', params={
      local state = super.state,
      WFContentItemPropertyName: sc.Ref(state, 'Vars.Repeat Item 2', att=true),
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      local state = super.state,
      WFInput: sc.Val('${Provided Input}', state),
      WFReplaceTextCaseSensitive: false,
      WFReplaceTextFind: {
        Value: {
          attachmentsByRange: {
            '{2, 1}': sc.Ref(state, 'Vars.Repeat Item 2'),
          },
          string: '{{￼}}',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextReplace: sc.Val('${Group}', state),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: '55D8D462-8872-4045-9F46-91174853FBC0',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.sendmessage', {
      local state = super.state,
      IntentAppDefinition: {
        BundleIdentifier: 'com.apple.MobileSMS',
        Name: 'Messages',
        TeamIdentifier: '0000000000',
      },
      WFSendMessageActionRecipients: sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFSendMessageContent: sc.Val('${Updated Text}', state),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: '4CC0F7FC-67E5-4A99-9E5B-355E2F0B56ED',
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
