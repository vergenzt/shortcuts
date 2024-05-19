local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Calendars', params={
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
              WFKey: sc.Val('Medication Reminders'),
              WFValue: sc.Val('Meds'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      local outputs = super.outputs,
      WFTextCustomSeparator: '|',
      WFTextSeparator: 'Custom',
      text: sc.Ref(outputs, 'Calendars', aggs=[
        {
          PropertyName: 'Values',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ], att=true),
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
      local outputs = super.outputs,
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Alarm', att=true),
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      local outputs = super.outputs,
      WFMatchTextPattern: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': sc.Ref(outputs, 'Combined Text'),
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
      local outputs = super.outputs,
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Matches', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Ref(outputs, 'Vars.Repeat Item', att=true),
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
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Repeat Results', att=true),
      WFVariableName: 'Calendar Alarms',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary'),

    sc.Action('is.workflow.actions.setvariable', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.date', name='Current Datetime'),

    sc.Action('is.workflow.actions.adjustdate', name='4 Hours Ago', params={
      local outputs = super.outputs,
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Val('${Current Datetime}', outputs),
      WFDuration: {
        Value: {
          Magnitude: '4',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.adjustdate', name='24 Hours Out', params={
      local outputs = super.outputs,
      WFDate: sc.Val('${Current Datetime}', outputs),
      WFDuration: {
        Value: {
          Magnitude: '24',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
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
                AnotherDate: sc.Ref(outputs, '24 Hours Out', att=true),
                Date: sc.Ref(outputs, '4 Hours Ago', att=true),
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
      local outputs = super.outputs,
      GroupingIdentifier: '3A666097-90F9-4E2A-BBDC-A7A2F903EB04',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Calendar Events', att=true),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Calendar', params={
      WFContentItemPropertyName: 'Calendar',
      WFInput: sc.Ref(outputs, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Calendar Label', params={
      local outputs = super.outputs,
      WFDictionaryKey: sc.Val('${Calendar}', outputs),
      WFInput: sc.Ref(outputs, 'Calendars', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '427BCD5D-36BB-4074-BB69-2550C082A88F',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Calendar Label', att=true),
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Title', params={
      WFContentItemPropertyName: 'Title',
      WFInput: sc.Ref(outputs, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Start Date', params={
      WFContentItemPropertyName: 'Start Date',
      WFInput: sc.Ref(outputs, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Desired Alarm Time', params={
      local outputs = super.outputs,
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Val('${Start Date}', outputs),
      WFDuration: {
        Value: {
          Magnitude: '20',
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Desired Alarm Time', att=true),
      WFVariableName: 'Desired Alarm Time',
    }),

    sc.Action('is.workflow.actions.gettext', name='Desired Alarm Name', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Calendar Label'),
            '{12, 1}': sc.Ref(outputs, 'Start Date', aggs=[
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'None',
                WFISO8601IncludeTime: false,
                WFTimeFormatStyle: 'Short',
              },
            ]),
            '{7, 1}': sc.Ref(outputs, 'Title'),
          },
          string: '￼ 🗓️: ￼ at ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '96494FE3-384B-4E3D-A6BB-E7397D7E6D39',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Vars.Calendar Alarms', att=true),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Ref(outputs, 'Vars.Repeat Item 2', att=true),
      WFVariableName: 'Candidate Alarm',
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '158A4D5F-D62E-4F00-9F76-3C5B2B144588',
      WFCondition: 4,
      WFConditionalActionString: sc.Val('${Desired Alarm Name}', outputs),
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
      WFInput: sc.Ref(outputs, 'Vars.Candidate Alarm', att=true),
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Ref(outputs, 'Vars.Repeat Index 2', att=true),
      WFVariableName: 'Alarm Index',
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      local outputs = super.outputs,
      WFInput: sc.Val('${Start Date}', outputs),
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
      local outputs = super.outputs,
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFAnotherNumber: '240',
      WFCondition: 1003,
      WFConditionalActionString: sc.Val('${Desired Alarm Time}', outputs),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Time Between Dates', att=true),
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
      local outputs = super.outputs,
      Input: sc.Ref(outputs, 'If Result', att=true),
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
      WFInput: sc.Val('${Vars.Desired Alarm Time}', outputs),
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
      local outputs = super.outputs,
      GroupingIdentifier: '61CA7EFD-5FDA-4C9C-A3F2-FEB84FA5E80C',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Time Between Dates', att=true),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Vars.Alarm', att=true),
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      local outputs = super.outputs,
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      dateComponents: sc.Val('${Desired Alarm Time}', outputs),
      label: sc.Val('${Desired Alarm Name}', outputs),
      name: sc.Val('${Desired Alarm Name}', outputs),
      repeatSchedule: {
        displayString: 'Never',
        value: 0,
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      local outputs = super.outputs,
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{14, 1}': sc.Ref(outputs, 'Desired Alarm Name'),
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
      alarm: sc.Ref(outputs, 'Vars.Alarm', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Ref(outputs, 'Vars.Matched Calendar Alarm Indices', att=true),
      WFDictionaryKey: sc.Val('${Vars.Alarm Index}', outputs),
      WFDictionaryValue: 'yes',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
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
      Input: sc.Ref(outputs, 'Vars.Calendar Alarms', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      local outputs = super.outputs,
      GroupingIdentifier: '70AA4591-58E4-4CB5-8C7E-09A82EB1495D',
      WFControlFlowMode: 0,
      WFRepeatCount: sc.Ref(outputs, 'Count', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Val('${Vars.Repeat Index}', outputs),
      WFInput: sc.Ref(outputs, 'Vars.Matched Calendar Alarm Indices', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Dictionary Value', att=true),
      },
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Ref(outputs, 'Vars.Repeat Index', att=true),
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
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Repeat Results', att=true),
      WFVariableName: 'Unmatched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FA4A18C4-308D-44AC-8E2E-31906FCC518F',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(outputs, 'Vars.Unmatched Calendar Alarm Indices', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: sc.Ref(outputs, 'Vars.Calendar Alarms', att=true),
      WFItemIndex: sc.Ref(outputs, 'Vars.Repeat Item', att=true),
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Item from List', att=true),
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
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Item from List', att=true),
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
      alarm: sc.Ref(outputs, 'Vars.Alarm to Disable', att=true),
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
