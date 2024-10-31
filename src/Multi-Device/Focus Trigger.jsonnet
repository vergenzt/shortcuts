local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', name='Device ID', params={
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '43EF6A71-8D2A-4204-BF21-39EFA01C7A62',
        workflowName: 'Get Device ID',
      },
      WFWorkflowName: 'Get Device ID',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: sc.Str(['Focus Trigger.Queues.', sc.Ref('Device ID')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '23449FBD-0A9C-42FE-9761-C27AA43B3FE4',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Value')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Target Input', params={
      WFDictionaryKey: 'Input',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Target Shortcut', params={
      WFDictionaryKey: 'Shortcut',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Turn Automation Trigger off *inside* the loop so that only device receiving the message turns it off.',
    }),

    sc.Action('is.workflow.actions.dnd.set', {
      Enabled: 0,
      FocusModes: {
        DisplayString: 'Automation Trigger',
        Identifier: 'com.apple.donotdisturb.mode.emoji.face.grinning',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Target Input')),
      WFWorkflow: sc.Attach(sc.Ref('Target Shortcut')),
      WFWorkflowName: sc.Attach(sc.Ref('Target Shortcut')),
    }),

    sc.Action('dk.simonbs.DataJar.DeleteValueIntent', {
      deleteStrategy: 'alwaysAllow',
      errorWhenValueNotFound: true,
      keyPath: sc.Str(['Focus Trigger.Queues.', sc.Ref('Device ID'), '.1']),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '23449FBD-0A9C-42FE-9761-C27AA43B3FE4',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 431817727,
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
  WFWorkflowTypes: [],
}
