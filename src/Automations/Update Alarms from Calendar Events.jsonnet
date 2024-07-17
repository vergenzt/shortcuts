local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('Calendar'),
              WFValue: sc.Val('20'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('Events'),
              WFValue: sc.Val('20'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('Routine'),
              WFValue: sc.Val('0'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('Health Reminders'),
              WFValue: sc.Val('0'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Calendar Lead Times',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('Calendar'),
              WFValue: sc.Val('ICF'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('Events'),
              WFValue: sc.Val('Tim'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('Routine'),
              WFValue: sc.Val('Routine'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('Health Reminders'),
              WFValue: sc.Val('Meds'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Calendar Labels',
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: '|',
      WFTextSeparator: 'Custom',
      text: {
        Value: {
          Aggrandizements: [
            {
              PropertyName: 'Values',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Calendar Labels',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTGetAlarmsIntent', name='Alarm', params={
      ShowWhenRun: false,
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Alarm', att=true),
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': function(state) sc.Ref(state, 'Combined Text'),
          },
          string: '(￼) 🗓️: (.*) at ([0-9: APM]+)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFLinkEntityContentItem_com.apple.mobiletimer_AlarmEntity',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  PropertyName: 'label',
                  PropertyUserInfo: 'label',
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
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Matches', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Repeat Results', att=true),
      WFVariableName: 'Calendar Alarms',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary'),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.date', name='Current Datetime'),

    sc.Action('is.workflow.actions.adjustdate', name='4 Hours Ago', params={
      WFAdjustOperation: 'Subtract',
      WFDate: function(state) sc.Val('${Current Datetime}', state),
      WFDuration: {
        Value: {
          Magnitude: '4',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.adjustdate', name='24 Hours Out', params={
      WFDate: function(state) sc.Val('${Current Datetime}', state),
      WFDuration: {
        Value: {
          Magnitude: '24',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
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
                AnotherDate: function(state) sc.Ref(state, '24 Hours Out', att=true),
                Date: function(state) sc.Ref(state, '4 Hours Ago', att=true),
                Number: 7,
                Unit: 16,
              },
            },
            {
              Operator: 4,
              Property: 'Is All Day',
              Removable: true,
              Values: {
                Bool: false,
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemInputParameter: 'Library',
      WFContentItemLimitEnabled: false,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3A666097-90F9-4E2A-BBDC-A7A2F903EB04',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Calendar Events', att=true),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Calendar', params={
      WFContentItemPropertyName: 'Calendar',
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Calendar Label', params={
      WFDictionaryKey: function(state) sc.Val('${Calendar}', state),
      WFInput: function(state) sc.Ref(state, 'Vars.Calendar Labels', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '427BCD5D-36BB-4074-BB69-2550C082A88F',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Calendar Label', att=true),
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Title', params={
      WFContentItemPropertyName: 'Title',
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Calendar Lead Time', params={
      WFDictionaryKey: function(state) sc.Val('${Calendar}', state),
      WFInput: function(state) sc.Ref(state, 'Vars.Calendar Lead Times', att=true),
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Start Date', params={
      WFContentItemPropertyName: 'Start Date',
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Desired Alarm Time', params={
      WFAdjustOperation: 'Subtract',
      WFDate: function(state) sc.Val('${Start Date}', state),
      WFDuration: {
        Value: {
          Magnitude: function(state) sc.Ref(state, 'Calendar Lead Time'),
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Desired Alarm Time', att=true),
      WFVariableName: 'Desired Alarm Time',
    }),

    sc.Action('is.workflow.actions.gettext', name='Desired Alarm Name', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Calendar Label'),
            '{12, 1}': function(state) sc.Ref(state, 'Start Date', aggs=[
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'None',
                WFISO8601IncludeTime: false,
                WFTimeFormatStyle: 'Short',
              },
            ]),
            '{7, 1}': function(state) sc.Ref(state, 'Title'),
          },
          string: '￼ 🗓️: ￼ at ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '96494FE3-384B-4E3D-A6BB-E7397D7E6D39',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Vars.Calendar Alarms', att=true),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item 2', att=true),
      WFVariableName: 'Candidate Alarm',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '158A4D5F-D62E-4F00-9F76-3C5B2B144588',
      WFCondition: 4,
      WFConditionalActionString: function(state) sc.Val('${Desired Alarm Name}', state),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'label',
                PropertyUserInfo: 'label',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item 2',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Vars.Candidate Alarm', att=true),
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Index 2', att=true),
      WFVariableName: 'Alarm Index',
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      WFInput: function(state) sc.Val('${Start Date}', state),
      WFTimeUntilFromDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'dateComponents',
                  Type: 'WFPropertyVariableAggrandizement',
                },
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item 2',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFAnotherNumber: '240',
      WFCondition: 1003,
      WFConditionalActionString: function(state) sc.Val('${Desired Alarm Time}', state),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Time Between Dates', att=true),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: {
        Value: {
          attachmentsByRange: {
            '{87, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Name',
                  PropertyUserInfo: 'WFItemName',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Alarm',
            },
          },
          string: 'Alarm name matched but alarm time minus event time was outside range of [-4hr, -0min]! ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', {
      Input: function(state) sc.Ref(state, 'If Result', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '158A4D5F-D62E-4F00-9F76-3C5B2B144588',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '96494FE3-384B-4E3D-A6BB-E7397D7E6D39',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      WFInput: function(state) sc.Val('${Vars.Desired Alarm Time}', state),
      WFTimeUntilFromDate: {
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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '61CA7EFD-5FDA-4C9C-A3F2-FEB84FA5E80C',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Time Between Dates', att=true),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Vars.Alarm', att=true),
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      dateComponents: function(state) sc.Val('${Desired Alarm Time}', state),
      label: function(state) sc.Val('${Desired Alarm Name}', state),
      name: function(state) sc.Val('${Desired Alarm Name}', state),
      repeatSchedule: {
        displayString: 'Never',
        value: 0,
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{14, 1}': function(state) sc.Ref(state, 'Desired Alarm Name'),
          },
          string: 'Created alarm ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFControlFlowMode: 1,
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      alarm: function(state) sc.Ref(state, 'Vars.Alarm', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: function(state) sc.Ref(state, 'Vars.Matched Calendar Alarm Indices', att=true),
      WFDictionaryKey: function(state) sc.Val('${Vars.Alarm Index}', state),
      WFDictionaryValue: 'yes',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '61CA7EFD-5FDA-4C9C-A3F2-FEB84FA5E80C',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '427BCD5D-36BB-4074-BB69-2550C082A88F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3A666097-90F9-4E2A-BBDC-A7A2F903EB04',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: function(state) sc.Ref(state, 'Vars.Calendar Alarms', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '70AA4591-58E4-4CB5-8C7E-09A82EB1495D',
      WFControlFlowMode: 0,
      WFRepeatCount: function(state) sc.Ref(state, 'Count', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: function(state) sc.Val('${Vars.Repeat Index}', state),
      WFInput: function(state) sc.Ref(state, 'Vars.Matched Calendar Alarm Indices', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Dictionary Value', att=true),
      },
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: function(state) sc.Ref(state, 'Vars.Repeat Index', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.count', name='Repeat Results', params={
      GroupingIdentifier: '70AA4591-58E4-4CB5-8C7E-09A82EB1495D',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Repeat Results', att=true),
      WFVariableName: 'Unmatched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FA4A18C4-308D-44AC-8E2E-31906FCC518F',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Vars.Unmatched Calendar Alarm Indices', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: function(state) sc.Ref(state, 'Vars.Calendar Alarms', att=true),
      WFItemIndex: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Item from List', att=true),
      WFVariableName: 'Alarm to Disable',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '56DB22FA-EAD3-4625-A55E-D318797D0672',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'enabled',
                PropertyUserInfo: 'enabled',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Alarm to Disable',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: function(state) sc.Ref(state, 'Item from List', att=true),
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'label',
                  PropertyUserInfo: 'label',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Alarm to Disable',
            },
          },
          string: 'Disabling alarm ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      alarm: function(state) sc.Ref(state, 'Vars.Alarm to Disable', att=true),
      state: 0,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '56DB22FA-EAD3-4625-A55E-D318797D0672',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FA4A18C4-308D-44AC-8E2E-31906FCC518F',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 431817727,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'Watch',
  ],
}
