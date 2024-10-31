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
              WFKey: sc.Str(['Nava']),
              WFValue: sc.Str(['18']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Tim']),
              WFValue: sc.Str(['20']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Routine']),
              WFValue: sc.Str(['0']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Health Reminders']),
              WFValue: sc.Str(['0']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Calendar Lead Times',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Nava']),
              WFValue: sc.Str(['Nava']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Tim']),
              WFValue: sc.Str(['Tim']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Routine']),
              WFValue: sc.Str(['Routine']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Health Reminders']),
              WFValue: sc.Str(['Meds']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Calendar Labels',
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: '|',
      WFTextSeparator: 'Custom',
      text: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'Values',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Calendar Labels',
      }),
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
      WFInput: sc.Attach(sc.Ref('Alarm')),
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: sc.Str(['(', sc.Ref('Combined Text'), ') 🗓️: (.*) at ([0-9: APM]+)']),
      text: sc.Str([{
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
      }]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Matches')),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Vars.Repeat Item')),
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
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
      WFVariableName: 'Calendar Alarms',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary'),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.date', name='Current Datetime'),

    sc.Action('is.workflow.actions.adjustdate', name='4 Hours Ago', params={
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Str([sc.Ref('Current Datetime')]),
      WFDuration: {
        Value: {
          Magnitude: '4',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.adjustdate', name='24 Hours Out', params={
      WFDate: sc.Str([sc.Ref('Current Datetime')]),
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
                AnotherDate: sc.Attach(sc.Ref('24 Hours Out')),
                Date: sc.Attach(sc.Ref('4 Hours Ago')),
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
      WFInput: sc.Attach(sc.Ref('Calendar Events')),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Calendar', params={
      WFContentItemPropertyName: 'Calendar',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Calendar Label', params={
      WFDictionaryKey: sc.Str([sc.Ref('Calendar')]),
      WFInput: sc.Attach(sc.Ref('Vars.Calendar Labels')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '427BCD5D-36BB-4074-BB69-2550C082A88F',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Calendar Label')),
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Title', params={
      WFContentItemPropertyName: 'Title',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Calendar Lead Time', params={
      WFDictionaryKey: sc.Str([sc.Ref('Calendar')]),
      WFInput: sc.Attach(sc.Ref('Vars.Calendar Lead Times')),
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Start Date', params={
      WFContentItemPropertyName: 'Start Date',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Desired Alarm Time', params={
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Str([sc.Ref('Start Date')]),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref('Calendar Lead Time'),
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Desired Alarm Time')),
      WFVariableName: 'Desired Alarm Time',
    }),

    sc.Action('is.workflow.actions.gettext', name='Desired Alarm Name', params={
      WFTextActionText: sc.Str([sc.Ref('Calendar Label'), ' 🗓️: ', sc.Ref('Start Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'None',
          WFISO8601IncludeTime: false,
          WFTimeFormatStyle: 'Short',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '96494FE3-384B-4E3D-A6BB-E7397D7E6D39',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Vars.Calendar Alarms')),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
      WFVariableName: 'Candidate Alarm',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '158A4D5F-D62E-4F00-9F76-3C5B2B144588',
      WFCondition: 4,
      WFConditionalActionString: sc.Str([sc.Ref('Desired Alarm Name')]),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              PropertyName: 'label',
              PropertyUserInfo: 'label',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item 2',
        }),
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Candidate Alarm')),
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Index 2')),
      WFVariableName: 'Alarm Index',
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      WFInput: sc.Str([sc.Ref('Start Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'None',
          WFISO8601IncludeTime: false,
          WFTimeFormatStyle: 'Short',
        },
      ])]),
      WFTimeUntilFromDate: sc.Str([{
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
      }]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFAnotherNumber: '240',
      WFCondition: 1003,
      WFConditionalActionString: sc.Str([sc.Ref('Desired Alarm Time', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'None',
          WFISO8601IncludeTime: false,
          WFTimeFormatStyle: 'Short',
        },
      ])]),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Time Between Dates')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: sc.Str(['Alarm name matched but alarm time minus event time was outside range of [-4hr, -0min]! ', {
        Aggrandizements: [
          {
            PropertyName: 'Name',
            PropertyUserInfo: 'WFItemName',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Alarm',
      }]),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', {
      Input: sc.Attach(sc.Ref('If Result')),
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
      WFInput: sc.Str([sc.Ref('Vars.Desired Alarm Time')]),
      WFTimeUntilFromDate: sc.Str([{
        Type: 'CurrentDate',
      }]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '61CA7EFD-5FDA-4C9C-A3F2-FEB84FA5E80C',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Time Between Dates')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Alarm')),
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
      dateComponents: sc.Str([sc.Ref('Desired Alarm Time')]),
      label: sc.Str([sc.Ref('Desired Alarm Name')]),
      name: sc.Str([sc.Ref('Desired Alarm Name')]),
      repeatSchedule: {
        displayString: 'Never',
        value: 0,
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      WFNotificationActionBody: sc.Str(['Created alarm ', sc.Ref('Desired Alarm Name')]),
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
      alarm: sc.Attach(sc.Ref('Vars.Alarm')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Vars.Matched Calendar Alarm Indices')),
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Alarm Index')]),
      WFDictionaryValue: 'yes',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
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
      Input: sc.Attach(sc.Ref('Vars.Calendar Alarms')),
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '70AA4591-58E4-4CB5-8C7E-09A82EB1495D',
      WFControlFlowMode: 0,
      WFRepeatCount: sc.Attach(sc.Ref('Count')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Index')]),
      WFInput: sc.Attach(sc.Ref('Vars.Matched Calendar Alarm Indices')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Dictionary Value')),
      },
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Vars.Repeat Index')),
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
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
      WFVariableName: 'Unmatched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FA4A18C4-308D-44AC-8E2E-31906FCC518F',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Vars.Unmatched Calendar Alarm Indices')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: sc.Attach(sc.Ref('Vars.Calendar Alarms')),
      WFItemIndex: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Item from List')),
      WFVariableName: 'Alarm to Disable',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '56DB22FA-EAD3-4625-A55E-D318797D0672',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              PropertyName: 'enabled',
              PropertyUserInfo: 'enabled',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Alarm to Disable',
        }),
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Attach(sc.Ref('Item from List')),
      WFNotificationActionBody: sc.Str(['Disabling alarm ', {
        Aggrandizements: [
          {
            PropertyName: 'label',
            PropertyUserInfo: 'label',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Alarm to Disable',
      }]),
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      alarm: sc.Attach(sc.Ref('Vars.Alarm to Disable')),
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
  WFWorkflowClientVersion: '2607.1',
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
