local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Is Locked', params={
      WFDeviceDetail: 'Device Is Locked',
    }),

    sc.Action('com.sindresorhus.Actions.ToggleBooleanIntent', name='Not Locked', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleBooleanIntent',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      boolean: sc.Attach(sc.Ref('Device Is Locked')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '63914A09-FF3C-4C62-B91A-E0D79A03A7A7',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Not Locked')),
      },
    }),

    sc.Action('com.sindresorhus.Actions.ShowNotificationIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ShowNotificationIntent',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      isTimeSensitive: true,
      sound: 'default',
      subtitle: '',
      title: 'Go to bed!',
    }),

    sc.Action('is.workflow.actions.delay', {
      WFDelayTime: 3.0,
    }),

    sc.Action('is.workflow.actions.lockscreen'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '63914A09-FF3C-4C62-B91A-E0D79A03A7A7',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59666,
    WFWorkflowIconStartColor: 946986751,
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
