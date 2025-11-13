local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTGetAlarmsIntent', name='Alarms', params={
      AppIntentDescriptor: {
        ActionRequiresAppInstallation: true,
        AppIntentIdentifier: 'AlarmEntity',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F8CC6CBC-E25D-4ADF-AE2B-81BCD99438AA',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Alarms')),
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      alarm: sc.Attach(sc.Ref('Vars.Repeat Item')),
      state: 0,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F8CC6CBC-E25D-4ADF-AE2B-81BCD99438AA',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -615917313,
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
