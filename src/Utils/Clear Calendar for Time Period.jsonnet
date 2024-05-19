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
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'CurrentDate',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.ask', name='Date', params={
      local outputs = super.outputs,
      WFAskActionDefaultAnswerDateAndTime: sc.Val('${ BO Today}', outputs),
      WFAskActionPrompt: 'From what starting point would you like to remove calendar event(s)?',
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='BOD', params={
      local outputs = super.outputs,
      WFAdjustOperation: 'Get Start of Day',
      WFDate: sc.Val('${Date}', outputs),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='EOD', params={
      local outputs = super.outputs,
      WFDate: sc.Val('${BOD}', outputs),
      WFDuration: {
        Value: {
          Magnitude: '1',
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.adjustdate', name='EOD-1m', params={
      local outputs = super.outputs,
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Val('${EOD}', outputs),
      WFDuration: {
        Value: {
          Magnitude: '1',
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.ask', name='End date', params={
      local outputs = super.outputs,
      WFAskActionDefaultAnswerDateAndTime: sc.Val('${EOD-1m}', outputs),
      WFAskActionPrompt: {
        Value: {
          attachmentsByRange: {
            '{5, 1}': sc.Ref(outputs, 'Date'),
          },
          string: 'From ￼ until when?',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='Calendar Events', params={
      local outputs = super.outputs,
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
                AnotherDate: sc.Ref(outputs, 'End date', att=true),
                Date: sc.Ref(outputs, 'Date', att=true),
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
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Empty Dictionary', att=true),
      WFVariableName: 'Calendars',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: 'CBB4D415-7EAF-43E8-B6A7-1525C5C1C213',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Calendar Events', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Calendar',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Ref(outputs, 'Vars.Calendars', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '907D0584-C928-4F10-AB21-A7932B7DDF58',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Dictionary Value', att=true),
      },
    }),

    sc.Action('is.workflow.actions.math', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary Value', att=true),
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
      local outputs = super.outputs,
      WFDictionary: sc.Ref(outputs, 'Vars.Calendars', att=true),
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Calendar',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDictionaryValue: sc.Val('${If Result}', outputs),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
      WFVariableName: 'Calendars',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'CBB4D415-7EAF-43E8-B6A7-1525C5C1C213',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Empty Dictionary', att=true),
      WFVariableName: 'Calendar Labels',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'EBD046C5-2E6C-466F-99D6-E628B5EEF470',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Aggrandizements: [
            {
              PropertyName: 'Keys',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Calendars',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='# Events', params={
      WFDictionaryKey: sc.Val('${Vars.Repeat Item}', outputs),
      WFInput: sc.Ref(outputs, 'Vars.Calendars', att=true),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      local outputs = super.outputs,
      WFDictionary: sc.Ref(outputs, 'Vars.Calendar Labels', att=true),
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Vars.Repeat Item'),
            '{3, 1}': sc.Ref(outputs, '# Events'),
          },
          string: '￼ (￼ events)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDictionaryValue: sc.Val('${Vars.Repeat Item}', outputs),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
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
      WFInput: sc.Ref(outputs, 'Vars.Calendar Labels', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: '786CCF50-3303-4657-9611-7B2E70BC010B',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Calendar Events', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: 'E0F92588-4F66-4EE0-A829-7CAC87548509',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Chosen Item', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'CCFFDFAE-73C1-4ADD-BB35-FAA95260BB8D',
      WFCondition: 4,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Calendar',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item 2',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Ref(outputs, 'Vars.Repeat Item', att=true),
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
      local outputs = super.outputs,
      WFChooseFromListActionPrompt: 'Which calendar event(s) would you like to delete?',
      WFChooseFromListActionSelectMultiple: true,
      WFInput: sc.Ref(outputs, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.removeevents', {
      local outputs = super.outputs,
      WFInputEvents: sc.Ref(outputs, 'Chosen Item', att=true),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
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
