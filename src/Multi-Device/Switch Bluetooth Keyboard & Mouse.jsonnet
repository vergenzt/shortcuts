local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', name='ID', params={
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '9C34AB4F-DA8C-4F8A-A376-C4A9951C13BF',
        workflowName: 'Get Other Device ID by Label',
      },
      WFWorkflowName: 'Get Other Device ID by Label',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Shortcut']),
              WFValue: sc.Str(['Dis/Connect Bluetooth Keyboard & Mouse']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Input']),
              WFValue: sc.Str(['connect']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('dk.simonbs.DataJar.InsertValueInArrayIntent', {
      insertionPoint: 'end',
      keyPath: sc.Str(['Focus Trigger.Queues.', sc.Ref('ID')]),
      values: sc.Attach(sc.Ref('Dictionary')),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: 'disconnect',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '1F65399D-0C79-45B6-860B-12FBA782D5CC',
        workflowName: 'Dis/Connect Bluetooth Keyboard & Mouse',
      },
      WFWorkflowName: 'Dis/Connect Bluetooth Keyboard & Mouse',
    }),

    sc.Action('is.workflow.actions.dnd.set', {
      AssertionType: 'Turned Off',
      Enabled: 1,
      FocusModes: {
        DisplayString: 'Automation Trigger',
        Identifier: 'com.apple.donotdisturb.mode.emoji.face.grinning',
      },
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -23508481,
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
