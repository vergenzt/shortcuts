local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
      WFControlFlowMode: 0,
      WFMenuItems: [
        'Yes',
        'No',
        'Cancel',
      ],
      WFMenuPrompt: 'Review calendar first?',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'Yes',
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: "Click Continue to open the calendar app and review the time period you'd like to clear. When you're ready, return to Shortcuts to continue.",
      WFAlertActionTitle: 'Clear Calendar for Time Period',
    }),

    sc.Action('is.workflow.actions.openapp', {
      WFAppIdentifier: 'com.apple.iCal',
      WFSelectedApp: {
        BundleIdentifier: 'com.apple.iCal',
        Name: 'Calendar',
        TeamIdentifier: '0000000000',
      },
    }),

    sc.Action('is.workflow.actions.waittoreturn'),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'Cancel',
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.adjustdate', name=' BO Today', params={
      WFAdjustOperation: 'Get Start of Day',
      WFDate: sc.Str([{
        Type: 'CurrentDate',
      }]),
    }),

    sc.Action('is.workflow.actions.ask', name='Date', params={
      WFAskActionDefaultAnswerDateAndTime: sc.Str([sc.Ref(' BO Today')]),
      WFAskActionPrompt: 'From what starting point would you like to remove calendar event(s)?',
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='BOD', params={
      WFAdjustOperation: 'Get Start of Day',
      WFDate: sc.Str([sc.Ref('Date')]),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='EOD', params={
      WFDate: sc.Str([sc.Ref('BOD')]),
      WFDuration: {
        Value: {
          Magnitude: '1',
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.adjustdate', name='EOD-1m', params={
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Str([sc.Ref('EOD')]),
      WFDuration: {
        Value: {
          Magnitude: '1',
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.ask', name='End date', params={
      WFAskActionDefaultAnswerDateAndTime: sc.Str([sc.Ref('EOD-1m')]),
      WFAskActionPrompt: sc.Str(['From ', sc.Ref('Date'), ' until when?']),
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='Calendar Events', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Bounded: true,
              Operator: 1003,
              Property: 'Start Date',
              Removable: false,
              Values: {
                AnotherDate: sc.Attach(sc.Ref('End date')),
                Date: sc.Attach(sc.Ref('Date')),
                Number: 7,
                Unit: 16,
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemLimitEnabled: false,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Empty Dictionary'),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Empty Dictionary')),
      WFVariableName: 'Calendars',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'CBB4D415-7EAF-43E8-B6A7-1525C5C1C213',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Calendar Events')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'Calendar',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFInput: sc.Attach(sc.Ref('Vars.Calendars')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '907D0584-C928-4F10-AB21-A7932B7DDF58',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Dictionary Value')),
      },
    }),

    sc.Action('is.workflow.actions.math', {
      WFInput: sc.Attach(sc.Ref('Dictionary Value')),
      WFMathOperand: '1',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '907D0584-C928-4F10-AB21-A7932B7DDF58',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.number', {
      WFNumberActionNumber: '1',
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '907D0584-C928-4F10-AB21-A7932B7DDF58',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Vars.Calendars')),
      WFDictionaryKey: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'Calendar',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFDictionaryValue: sc.Str([sc.Ref('If Result')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Calendars',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'CBB4D415-7EAF-43E8-B6A7-1525C5C1C213',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Empty Dictionary')),
      WFVariableName: 'Calendar Labels',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'EBD046C5-2E6C-466F-99D6-E628B5EEF470',
      WFControlFlowMode: 0,
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'Keys',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Calendars',
      }),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='# Events', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item')]),
      WFInput: sc.Attach(sc.Ref('Vars.Calendars')),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Vars.Calendar Labels')),
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item')]),
      WFDictionaryValue: sc.Str([sc.Ref('Vars.Repeat Item')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Calendar Labels',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'EBD046C5-2E6C-466F-99D6-E628B5EEF470',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: 'Which calendar(s) would you like to remove events from?',
      WFChooseFromListActionSelectAll: true,
      WFChooseFromListActionSelectMultiple: true,
      WFInput: sc.Attach(sc.Ref('Vars.Calendar Labels')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '786CCF50-3303-4657-9611-7B2E70BC010B',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Calendar Events')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E0F92588-4F66-4EE0-A829-7CAC87548509',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Chosen Item')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'CCFFDFAE-73C1-4ADD-BB35-FAA95260BB8D',
      WFCondition: 4,
      WFConditionalActionString: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'Calendar',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              CoercionItemClass: 'WFStringContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item 2',
        }),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'CCFFDFAE-73C1-4ADD-BB35-FAA95260BB8D',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'CCFFDFAE-73C1-4ADD-BB35-FAA95260BB8D',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E0F92588-4F66-4EE0-A829-7CAC87548509',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '786CCF50-3303-4657-9611-7B2E70BC010B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: 'Which calendar event(s) would you like to delete?',
      WFChooseFromListActionSelectMultiple: true,
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('is.workflow.actions.removeevents', {
      WFInputEvents: sc.Attach(sc.Ref('Chosen Item')),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -20702977,
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
