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
      local state = super.state,
      WFAskActionDefaultAnswerDateAndTime: sc.Val('${ BO Today}', state),
      WFAskActionPrompt: 'From what starting point would you like to remove calendar event(s)?',
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='BOD', params={
      local state = super.state,
      WFAdjustOperation: 'Get Start of Day',
      WFDate: sc.Val('${Date}', state),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='EOD', params={
      local state = super.state,
      WFDate: sc.Val('${BOD}', state),
      WFDuration: {
        Value: {
          Magnitude: '1',
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.adjustdate', name='EOD-1m', params={
      local state = super.state,
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Val('${EOD}', state),
      WFDuration: {
        Value: {
          Magnitude: '1',
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.ask', name='End date', params={
      local state = super.state,
      WFAskActionDefaultAnswerDateAndTime: sc.Val('${EOD-1m}', state),
      WFAskActionPrompt: {
        Value: {
          attachmentsByRange: {
            '{5, 1}': sc.Ref(state, 'Date'),
          },
          string: 'From ￼ until when?',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='Calendar Events', params={
      local state = super.state,
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
                AnotherDate: sc.Ref(state, 'End date', att=true),
                Date: sc.Ref(state, 'Date', att=true),
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
      local state = super.state,
      WFInput: sc.Ref(state, 'Empty Dictionary', att=true),
      WFVariableName: 'Calendars',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: 'CBB4D415-7EAF-43E8-B6A7-1525C5C1C213',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Calendar Events', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      local state = super.state,
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
      WFInput: sc.Ref(state, 'Vars.Calendars', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '907D0584-C928-4F10-AB21-A7932B7DDF58',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Dictionary Value', att=true),
      },
    }),

    sc.Action('is.workflow.actions.math', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary Value', att=true),
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
      local state = super.state,
      WFDictionary: sc.Ref(state, 'Vars.Calendars', att=true),
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
      WFDictionaryValue: sc.Val('${If Result}', state),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Calendars',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'CBB4D415-7EAF-43E8-B6A7-1525C5C1C213',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Empty Dictionary', att=true),
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
      local state = super.state,
      WFDictionaryKey: sc.Val('${Vars.Repeat Item}', state),
      WFInput: sc.Ref(state, 'Vars.Calendars', att=true),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      local state = super.state,
      WFDictionary: sc.Ref(state, 'Vars.Calendar Labels', att=true),
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Vars.Repeat Item'),
            '{3, 1}': sc.Ref(state, '# Events'),
          },
          string: '￼ (￼ events)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDictionaryValue: sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Calendar Labels',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'EBD046C5-2E6C-466F-99D6-E628B5EEF470',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      local state = super.state,
      WFChooseFromListActionPrompt: 'Which calendar(s) would you like to remove events from?',
      WFChooseFromListActionSelectAll: true,
      WFChooseFromListActionSelectMultiple: true,
      WFInput: sc.Ref(state, 'Vars.Calendar Labels', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: '786CCF50-3303-4657-9611-7B2E70BC010B',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Calendar Events', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: 'E0F92588-4F66-4EE0-A829-7CAC87548509',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Chosen Item', att=true),
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
      local state = super.state,
      WFVariable: sc.Ref(state, 'Vars.Repeat Item', att=true),
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
      local state = super.state,
      WFChooseFromListActionPrompt: 'Which calendar event(s) would you like to delete?',
      WFChooseFromListActionSelectMultiple: true,
      WFInput: sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.removeevents', {
      local state = super.state,
      WFInputEvents: sc.Ref(state, 'Chosen Item', att=true),
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
