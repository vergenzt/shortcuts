local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.dictionary', label='Calendars', params={
      UUID: 'E17254C9-251D-4D01-BA9D-CCA53796AF37',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Calendar',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'ICF',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Events',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'Tim',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Routine',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'Routine',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Medication Reminders',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'Meds',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.text.combine', {
      UUID: 'CAAB610A-9E1B-42F1-8BEC-ED595EC07840',
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
          OutputName: 'Calendars',
          OutputUUID: 'E17254C9-251D-4D01-BA9D-CCA53796AF37',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTGetAlarmsIntent', {
      ShowWhenRun: false,
      UUID: '96BFA7D2-40FE-48DE-A762-72BB69134F34',
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Alarm',
          OutputUUID: '96BFA7D2-40FE-48DE-A762-72BB69134F34',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.text.match', {
      UUID: '5424F246-989D-4B1D-862D-48CE6D8A7B04',
      WFMatchTextPattern: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': {
              OutputName: 'Combined Text',
              OutputUUID: 'CAAB610A-9E1B-42F1-8BEC-ED595EC07840',
              Type: 'ActionOutput',
            },
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

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Matches',
            OutputUUID: '5424F246-989D-4B1D-862D-48CE6D8A7B04',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.getvariable', {
      WFVariable: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      UUID: '13CCA2BD-9C22-4474-9954-7A68B3B4B444',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      UUID: 'F505E2A0-23F4-48A2-9B69-E0685C498FBA',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: 'F505E2A0-23F4-48A2-9B69-E0685C498FBA',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Calendar Alarms',
    }),

    [_()]: lib.Action('is.workflow.actions.dictionary', {
      UUID: '53A72E38-2837-4D4B-BC66-CF33E559EB7D',
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '53A72E38-2837-4D4B-BC66-CF33E559EB7D',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    [_()]: lib.Action('is.workflow.actions.date', label='Current Datetime', params={
      UUID: 'F1E39DC9-CAE8-458C-8B72-450D09704C59',
    }),

    [_()]: lib.Action('is.workflow.actions.adjustdate', label='4 Hours Ago', params={
      UUID: '9D0897C6-4877-4C09-B387-90503CC88144',
      WFAdjustOperation: 'Subtract',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Current Datetime',
              OutputUUID: 'F1E39DC9-CAE8-458C-8B72-450D09704C59',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDuration: {
        Value: {
          Magnitude: '4',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.adjustdate', label='24 Hours Out', params={
      UUID: '382EC078-69E3-4231-BBAC-6B1BC371D3BE',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Current Datetime',
              OutputUUID: 'F1E39DC9-CAE8-458C-8B72-450D09704C59',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDuration: {
        Value: {
          Magnitude: '24',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.filter.calendarevents', {
      UUID: '58E91960-056A-43F4-A3CA-61059329F2A5',
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
                AnotherDate: {
                  Value: {
                    OutputName: '24 Hours Out',
                    OutputUUID: '382EC078-69E3-4231-BBAC-6B1BC371D3BE',
                    Type: 'ActionOutput',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
                Date: {
                  Value: {
                    OutputName: '4 Hours Ago',
                    OutputUUID: '9D0897C6-4877-4C09-B387-90503CC88144',
                    Type: 'ActionOutput',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
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

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3A666097-90F9-4E2A-BBDC-A7A2F903EB04',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Calendar Events',
          OutputUUID: '58E91960-056A-43F4-A3CA-61059329F2A5',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFVariableName: 'Alarm',
    }),

    [_()]: lib.Action('is.workflow.actions.properties.calendarevents', {
      UUID: '9BEA2617-BB08-4044-A5F6-B4EC6E3A94F9',
      WFContentItemPropertyName: 'Calendar',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.getvalueforkey', label='Calendar Label', params={
      UUID: 'A7586AA4-688F-4160-9D7F-704FACF79C8B',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Calendar',
              OutputUUID: '9BEA2617-BB08-4044-A5F6-B4EC6E3A94F9',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          OutputName: 'Calendars',
          OutputUUID: 'E17254C9-251D-4D01-BA9D-CCA53796AF37',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '427BCD5D-36BB-4074-BB69-2550C082A88F',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Calendar Label',
            OutputUUID: 'A7586AA4-688F-4160-9D7F-704FACF79C8B',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.properties.calendarevents', {
      UUID: 'B89D6127-FEC4-4DC5-AC30-3F1A4AED7A23',
      WFContentItemPropertyName: 'Title',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.properties.calendarevents', {
      UUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
      WFContentItemPropertyName: 'Start Date',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.adjustdate', label='Desired Alarm Time', params={
      UUID: 'DBB8C07D-7933-4F5D-B072-778D1E32AA10',
      WFAdjustOperation: 'Subtract',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Start Date',
              OutputUUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDuration: {
        Value: {
          Magnitude: '20',
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', label='Desired Alarm Name', params={
      UUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Calendar Label',
              OutputUUID: 'A7586AA4-688F-4160-9D7F-704FACF79C8B',
              Type: 'ActionOutput',
            },
            '{12, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Start Date',
              OutputUUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
              Type: 'ActionOutput',
            },
            '{7, 1}': {
              OutputName: 'Title',
              OutputUUID: 'B89D6127-FEC4-4DC5-AC30-3F1A4AED7A23',
              Type: 'ActionOutput',
            },
          },
          string: '￼ 🗓️: ￼ at ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '96494FE3-384B-4E3D-A6BB-E7397D7E6D39',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item 2',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Candidate Alarm',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '158A4D5F-D62E-4F00-9F76-3C5B2B144588',
      WFCondition: 4,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
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

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Candidate Alarm',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm',
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Index 2',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm Index',
    }),

    [_()]: lib.Action('is.workflow.actions.gettimebetweendates', {
      UUID: 'C31DADE8-2948-443F-B725-1E1269312A17',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Start Date',
              OutputUUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
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

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFAnotherNumber: '240',
      WFCondition: 1003,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Desired Alarm Time',
              OutputUUID: 'DBB8C07D-7933-4F5D-B072-778D1E32AA10',
              Type: 'ActionOutput',
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
            OutputName: 'Time Between Dates',
            OutputUUID: 'C31DADE8-2948-443F-B725-1E1269312A17',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '0',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      WFControlFlowMode: 1,
    }),

    [_()]: lib.Action('is.workflow.actions.alert', {
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

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      UUID: '28F19A4B-4221-45C6-84ED-CCF7F336427E',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          OutputName: 'If Result',
          OutputUUID: '28F19A4B-4221-45C6-84ED-CCF7F336427E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '158A4D5F-D62E-4F00-9F76-3C5B2B144588',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '96494FE3-384B-4E3D-A6BB-E7397D7E6D39',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Type: 'Variable',
            VariableName: 'Alarm',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: '829E249D-B5D8-4917-AA5D-5780DF24F38E',
      dateComponents: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Time',
              OutputUUID: 'DBB8C07D-7933-4F5D-B072-778D1E32AA10',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      label: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      name: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      repeatSchedule: {
        displayString: 'Never',
        value: 0,
      },
    }),

    [_()]: lib.Action('is.workflow.actions.notification', {
      UUID: '90E06046-8E1F-4934-BF2E-E87DC095DD60',
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{14, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: 'Created alarm ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      WFControlFlowMode: 1,
    }),

    [_()]: lib.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: 'BEFD278C-C86C-453F-AD37-DC5053AF051F',
      alarm: {
        Value: {
          Type: 'Variable',
          VariableName: 'Alarm',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.setvalueforkey', {
      UUID: '8AC4C390-058D-4FA0-8DD8-3025C6C81A83',
      WFDictionary: {
        Value: {
          Type: 'Variable',
          VariableName: 'Matched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Alarm Index',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDictionaryValue: 'yes',
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '8AC4C390-058D-4FA0-8DD8-3025C6C81A83',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      UUID: 'AF3D58A7-32B2-40FB-8355-EDF7065E7EB6',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '427BCD5D-36BB-4074-BB69-2550C082A88F',
      UUID: '982B4BF0-DFD8-43CF-A0FD-4948007C42D4',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3A666097-90F9-4E2A-BBDC-A7A2F903EB04',
      UUID: '3504C0A3-9377-4F28-92D0-3E4E40D97D34',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      UUID: '86725A5F-9405-4490-B3C0-B1A8AB382C76',
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '70AA4591-58E4-4CB5-8C7E-09A82EB1495D',
      WFControlFlowMode: 0,
      WFRepeatCount: {
        Value: {
          OutputName: 'Count',
          OutputUUID: '86725A5F-9405-4490-B3C0-B1A8AB382C76',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.getvalueforkey', {
      UUID: 'B7C21E6D-7CE8-45ED-8670-A30CDF403BC7',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Matched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Dictionary Value',
            OutputUUID: 'B7C21E6D-7CE8-45ED-8670-A30CDF403BC7',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.nothing', {}),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFControlFlowMode: 1,
    }),

    [_()]: lib.Action('is.workflow.actions.getvariable', {
      WFVariable: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Index',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '70AA4591-58E4-4CB5-8C7E-09A82EB1495D',
      UUID: '4B00EF21-76FF-43BF-889F-2122E12A8C3E',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '4B00EF21-76FF-43BF-889F-2122E12A8C3E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Unmatched Calendar Alarm Indices',
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FA4A18C4-308D-44AC-8E2E-31906FCC518F',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Unmatched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.getitemfromlist', {
      UUID: 'BD8661D4-66B9-4DB3-9F96-1821F8F2D868',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFItemIndex: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFItemSpecifier: 'Item At Index',
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Item from List',
          OutputUUID: 'BD8661D4-66B9-4DB3-9F96-1821F8F2D868',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm to Disable',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
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

    [_()]: lib.Action('is.workflow.actions.notification', {
      UUID: '24AB86E4-59C0-4A43-A166-169FCFD79058',
      WFInput: {
        Value: {
          OutputName: 'Item from List',
          OutputUUID: 'BD8661D4-66B9-4DB3-9F96-1821F8F2D868',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
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

    [_()]: lib.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: 'C0C00086-D37E-45A4-A43B-471B8B150124',
      alarm: {
        Value: {
          Type: 'Variable',
          VariableName: 'Alarm to Disable',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      state: 0,
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '56DB22FA-EAD3-4625-A55E-D318797D0672',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FA4A18C4-308D-44AC-8E2E-31906FCC518F',
      UUID: '5A089C94-0944-459D-958C-1B72D48C0304',
      WFControlFlowMode: 2,
    }),
  }),
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
  WFWorkflowTypes: [],
}
