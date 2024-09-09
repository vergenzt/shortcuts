local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.ask', name='N', params={
      WFAskActionPrompt: 'How many minutes?',
      WFInputType: 'Number',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='End Time', params={
      WFDate: sc.Str([{
        Type: 'CurrentDate',
      }]),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref('N'),
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.ask', name='Confirmed', params={
      WFAskActionDefaultAnswerDateAndTime: sc.Str([sc.Ref('End Time')]),
      WFAskActionPrompt: 'Confirm end time:',
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Confirmed')),
      WFVariableName: 'End Time',
    }),

    sc.Action('is.workflow.actions.list', name='Warnings', params={
      WFItems: [
        '0',
        '1',
        '2',
        '3',
        '5',
        '10',
        '15',
        '20',
        '30',
        '60',
        '90',
        '120',
      ],
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '5FA1F184-7575-4977-9FC7-F3D1979F89C1',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Warnings')),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Warning Time', params={
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Str([sc.Ref('Vars.End Time')]),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref('Vars.Repeat Item'),
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C8873D9E-7395-476B-9B3D-905A85EC35EE',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFDate: sc.Attach({
        Type: 'CurrentDate',
      }),
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Warning Time')),
      },
      WFNumberValue: sc.Attach(sc.Ref('N')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED0FE990-3E15-4138-9443-BCC1D8B3F4F8',
      WFCondition: 1,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              CoercionItemClass: 'WFNumberContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item',
        }),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: "Time's up!",
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED0FE990-3E15-4138-9443-BCC1D8B3F4F8',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Vars.Repeat Item'),
          },
          string: '￼ minutes left!',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'ED0FE990-3E15-4138-9443-BCC1D8B3F4F8',
      WFControlFlowMode: 2,
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      allowsSnooze: false,
      dateComponents: sc.Str([sc.Ref('Warning Time')]),
      name: sc.Str([sc.Ref('If Result')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C8873D9E-7395-476B-9B3D-905A85EC35EE',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'C8873D9E-7395-476B-9B3D-905A85EC35EE',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('If Result')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '5FA1F184-7575-4977-9FC7-F3D1979F89C1',
      WFControlFlowMode: 2,
    }),

    sc.Action('com.apple.mobiletimer.OpenTab', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'OpenTab',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      tab: 'alarm',
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 255,
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
