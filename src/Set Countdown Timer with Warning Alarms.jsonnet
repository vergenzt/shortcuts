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
        '2',
        '3',
        '5',
        '7',
        '10',
        '15',
        '20',
        '30',
        '45',
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

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Warning Time')),
      },
      '>',
      {
        WFDate: sc.Attach({
          Type: 'CurrentDate',
        }),
        WFNumberValue: sc.Attach(sc.Ref('N')),
      }
    )).Then_([

      sc.If_(sc.Cond(
        {
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
        '≤',
        {
          WFNumberValue: '0',
        }
      )).Then_([

        sc.Action('is.workflow.actions.gettext', {
          WFTextActionText: "Time's up!",
        }),

      ]).Else_([

        sc.Action('is.workflow.actions.gettext', {
          WFTextActionText: sc.Str([sc.Ref('Vars.Repeat Item'), ' minutes left!']),
        }),

      ]).EndIf_(name='Alarm Text'),

      sc.Action('is.workflow.actions.list', name='List', params={
        WFItems: [
          {
            WFItemType: 0,
            WFValue: sc.Str([sc.Ref('Alarm Text')]),
          },
          {
            WFItemType: 0,
            WFValue: sc.Str([sc.Ref('Warning Time', aggs=[
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'None',
                WFISO8601IncludeTime: false,
                WFTimeFormatStyle: 'Short',
              },
            ])]),
          },
        ],
      }),

      sc.Action('is.workflow.actions.text.combine', {
        WFTextCustomSeparator: ' — ',
        WFTextSeparator: 'Custom',
        text: sc.Attach(sc.Ref('List')),
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.nothing'),

    ]).EndIf_(name='If Result'),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('If Result')),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Warning Alarms', params={
      GroupingIdentifier: '5FA1F184-7575-4977-9FC7-F3D1979F89C1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Selected Item', params={
      WFChooseFromListActionPrompt: 'Which alarms would you like?',
      WFChooseFromListActionSelectAll: true,
      WFChooseFromListActionSelectMultiple: true,
      WFInput: sc.Attach(sc.Ref('Warning Alarms')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F2754B79-7EB4-4008-847C-7EA8373C0F63',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Selected Item')),
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      WFTextCustomSeparator: ' — ',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='First Item', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Last Item', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
      WFItemSpecifier: 'Last Item',
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      allowsSnooze: false,
      dateComponents: sc.Str([sc.Ref('Last Item', aggs=[
        {
          CoercionItemClass: 'WFDateContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'None',
          WFISO8601IncludeTime: false,
          WFTimeFormatStyle: 'Short',
        },
      ])]),
      name: sc.Str([sc.Ref('First Item')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F2754B79-7EB4-4008-847C-7EA8373C0F63',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      WFInput: sc.Str([sc.Ref('Vars.End Time')]),
      WFTimeUntilFromDate: sc.Str([{
        Type: 'CurrentDate',
      }]),
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.Action('is.workflow.actions.timer.start', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'INCreateTimerIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      IntentAppDefinition: {
        BundleIdentifier: 'com.apple.clock',
        ExtensionBundleIdentifier: 'com.apple.mobiletimer-framework.MobileTimerIntents',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      WFDuration: {
        Value: {
          Magnitude: sc.Ref('Time Between Dates'),
          Unit: 'sec',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59692,
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
    'MenuBar',
    'Watch',
  ],
}
