local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dnd.getfocus', name='Current Focus'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6FD56B0C-8DAD-4E1D-8D81-7EDD616A30E2',
      WFCondition: 4,
      WFConditionalActionString: 'Do Not Disturb',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Current Focus', aggs=[
          {
            PropertyName: 'Name',
            PropertyUserInfo: 'WFItemName',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Current Focus')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '7E7C366E-33CB-4140-BA10-E70031A1AFDD',
        workflowName: 'Turn Off All Alarms',
      },
      WFWorkflowName: 'Turn Off All Alarms',
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6FD56B0C-8DAD-4E1D-8D81-7EDD616A30E2',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Alarm Times Config', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['📅Tim Nava']),
              WFValue: sc.Str(['18']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['📅Tim']),
              WFValue: sc.Str(['20']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['📅Routine']),
              WFValue: sc.Str(['20']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['📅Health Reminders']),
              WFValue: sc.Str(['0']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['📅Calendar']),
              WFValue: sc.Str(['18']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['🏷️⏱️']),
              WFValue: sc.Str(['-0,-15@,-30@,-60@,-120@,-180@,-240@,-360@']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['🏷️swim']),
              WFValue: sc.Str(['60']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Alarm Times Config')),
      WFVariableName: 'Alarm Times Config',
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: '^Explanation:\n\nKeys must start with either a "📅" or a "🏷️" emoji.\n\n- "📅" means that the rest of the key represents a calendar name, which must match the calendar name in the Calendar app for an alarm to be created.\n\n- "🏷️" means that the rest of the key is a string which must be contained within the calendar event’s name for an alarm to be created.\n\nValues are then comma-separated strings which must be digits with an optional leading "-" (minus sign) and an optional trailing "@" (‘at’-sign). Each such value designates when an individual alarm should be set for.\n\nA positive number (i.e. with no leading minus sign) designates the number of minutes before the *start* of an event that an alarm should be created for.\n\nA negative number (i.e. with a leading minus sign) designates the number of minutes before the *end* of an event that an alarm should be created for.\n\nBy default, these alarms are created with snooze ENABLED. To disable snooze for an alarm time, append an "@" to the end of the number.',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: '^(-?)(0|[1-9]\\d*)(@?)$',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Alarm Time Config Element Regex',
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        'negative?',
        'minutes',
        'disable_snooze?',
      ],
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('List')),
      WFVariableName: 'Alarm Time Config Element Regex Group Names',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Tim Nava']),
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
            {
              WFItemType: 0,
              WFKey: sc.Str(['Calendar']),
              WFValue: sc.Str(['Mass.gov']),
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

    sc.Action('is.workflow.actions.text.combine', {
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
      AppIntentDescriptor: {
        ActionRequiresAppInstallation: true,
        AppIntentIdentifier: 'AlarmEntity',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      WFCondition: 99,
      WFConditionalActionString: '🗓️',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              PropertyName: 'label',
              PropertyUserInfo: {
                WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'label',
              },
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item',
        }),
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

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'ACE36F44-6D0B-475E-8E4D-F780A5B944BB',
      WFControlFlowMode: 0,
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'Keys',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Alarm Times Config',
      }),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7B056210-F3D9-4027-8BAC-4D62500D8CCA',
      WFCondition: 4,
      WFConditionalActionString: '🏷️',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Repeat Item')),
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      WFInput: sc.Str([sc.Ref('Vars.Repeat Item')]),
      WFReplaceTextFind: '^🏷️',
      WFReplaceTextRegularExpression: true,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7B056210-F3D9-4027-8BAC-4D62500D8CCA',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'ACE36F44-6D0B-475E-8E4D-F780A5B944BB',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: '|',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['(', sc.Ref('Combined Text'), ')']),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Event Name Regex',
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

    sc.Action('is.workflow.actions.properties.calendarevents', name='Calendar', params={
      WFContentItemPropertyName: 'Calendar',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Title', params={
      WFContentItemPropertyName: 'Title',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='Start Time', params={
      WFContentItemPropertyName: 'Start Date',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', name='End Time', params={
      WFContentItemPropertyName: 'End Date',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Calendar Label', params={
      WFDictionaryKey: sc.Str([sc.Ref('Calendar')]),
      WFInput: sc.Attach(sc.Ref('Vars.Calendar Labels')),
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Get configured event start/end alarm lead time(s):',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '58522BAD-FED6-42BB-835A-73209163B579',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Type: 'CurrentDate',
        }),
      },
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: sc.Str([sc.Ref('Vars.Event Name Regex')]),
      text: sc.Str([sc.Ref('Vars.Repeat Item')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '895468FF-7E20-487A-89AD-E70C326A2764',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Matches')),
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str(['🏷️', sc.Ref('Vars.Repeat Item 2')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '895468FF-7E20-487A-89AD-E70C326A2764',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
      WFVariableName: 'Calendar Config Keys',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['📅', sc.Ref('Calendar')]),
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Calendar Config Keys',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '58522BAD-FED6-42BB-835A-73209163B579',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FB2F79AD-6D58-44A1-A5DF-93D34853F7A1',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Vars.Calendar Config Keys')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Config Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item 2')]),
      WFInput: sc.Attach(sc.Ref('Vars.Alarm Times Config')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3FE0964F-D9A3-4925-B15F-547FED5EB698',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Config Value')),
      },
    }),

    sc.Action('is.workflow.actions.text.split', name='Config Value Element', params={
      WFTextCustomSeparator: ',',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Config Value')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FF052C83-6254-49EB-A0B2-C9FEC9A59824',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Config Value Element')),
    }),

    sc.Action('is.workflow.actions.text.match', name='Alarm Time Config Element', params={
      WFMatchTextPattern: sc.Str([sc.Ref('Vars.Alarm Time Config Element Regex')]),
      text: sc.Str([sc.Ref('Vars.Repeat Item 3')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '566FE023-99F0-44A1-9B6C-825E52B52886',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Alarm Time Config Element')),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: sc.Str(['Error: Invalid alarm config element "', sc.Ref('Vars.Repeat Item 3')]),
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '566FE023-99F0-44A1-9B6C-825E52B52886',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Alarm Time Config Element Dict',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3948B1E1-A04F-427D-9F03-A888B52BA34F',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Vars.Alarm Time Config Element Regex Group Names')),
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='Text', params={
      WFGroupIndex: sc.Attach(sc.Ref('Vars.Repeat Index 4')),
      matches: sc.Attach(sc.Ref('Alarm Time Config Element')),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Vars.Alarm Time Config Element Dict')),
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item 4')]),
      WFDictionaryValue: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Alarm Time Config Element Dict',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3948B1E1-A04F-427D-9F03-A888B52BA34F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Vars.Alarm Time Config Element Dict')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '566FE023-99F0-44A1-9B6C-825E52B52886',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FF052C83-6254-49EB-A0B2-C9FEC9A59824',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3FE0964F-D9A3-4925-B15F-547FED5EB698',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'FB2F79AD-6D58-44A1-A5DF-93D34853F7A1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
      WFVariableName: 'Alarm Time Config Element Dicts',
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Set alarms:',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '9CB4758E-3308-4B8B-9053-ECAEBE629FC9',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Vars.Alarm Time Config Element Dicts')),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
      WFVariableName: 'Alarm Time Config Element Dict',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['-']),
              WFValue: sc.Str([sc.Ref('End Time')]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['']),
              WFValue: sc.Str([sc.Ref('Start Time')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Alarm Event Anchor Time', params={
      WFDictionaryKey: sc.Str([{
        Aggrandizements: [
          {
            DictionaryKey: 'negative?',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item 2',
      }]),
      WFInput: sc.Attach(sc.Ref('Dictionary')),
    }),

    sc.Action('is.workflow.actions.number', name='Minutes', params={
      WFNumberActionNumber: sc.Attach({
        Aggrandizements: [
          {
            DictionaryKey: 'minutes',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item 2',
      }),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Desired Alarm Time', params={
      WFAdjustOperation: 'Subtract',
      WFDate: sc.Str([sc.Ref('Alarm Event Anchor Time')]),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref('Minutes'),
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Desired Alarm Time')),
      WFVariableName: 'Desired Alarm Time',
    }),

    sc.Action('is.workflow.actions.detect.text', name='Negative?', params={
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            DictionaryKey: 'negative?',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Alarm Time Config Element Dict',
      }),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FC3F575B-CD25-41F1-8CBC-0659001E1F02',
      WFCondition: 4,
      WFConditionalActionString: '-',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Negative?')),
      },
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='|Start → Countdown Alarm|', params={
      WFInput: sc.Str([sc.Ref('Vars.Desired Alarm Time')]),
      WFTimeUntilFromDate: sc.Str([sc.Ref('Start Time')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FD59AB07-3ABD-41BC-B510-9FC8A5464E47',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('|Start → Countdown Alarm|')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: 'Okay to create countdown alarm',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FD59AB07-3ABD-41BC-B510-9FC8A5464E47',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: "Don't want to set end-anchored countdown alarms for before the event starts",
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FD59AB07-3ABD-41BC-B510-9FC8A5464E47',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FC3F575B-CD25-41F1-8CBC-0659001E1F02',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: 'Okay to create pre-event alarm',
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'FC3F575B-CD25-41F1-8CBC-0659001E1F02',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('If Result')),
      WFVariableName: 'Alarm ↔ Anchor Time Valid?',
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='|Now → Alarm Time|', params={
      WFInput: sc.Str([sc.Ref('Vars.Desired Alarm Time')]),
      WFTimeUntilFromDate: sc.Str([{
        Type: 'CurrentDate',
      }]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C7A5D413-B0CA-4695-8DC9-8EB8413F4756',
      WFConditions: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              WFCondition: 2,
              WFInput: {
                Type: 'Variable',
                Variable: sc.Attach(sc.Ref('|Now → Alarm Time|')),
              },
              WFNumberValue: '0',
            },
            {
              WFCondition: 100,
              WFInput: {
                Type: 'Variable',
                Variable: sc.Attach(sc.Ref('Vars.Alarm ↔ Anchor Time Valid?')),
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFControlFlowMode: 0,
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Confirmed we want the alarm to exist.',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str([sc.Ref('Calendar Label'), ' 🗓️: ', sc.Ref('Alarm Event Anchor Time', aggs=[
        {
          CoercionItemClass: 'WFDateContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          PropertyName: 'Time',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Desired Alarm Name',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0D8247B0-6D9A-44EF-B3C3-82D216245C6B',
      WFCondition: 4,
      WFConditionalActionString: '-',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Negative?')),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '01BF5E27-D25D-4730-95FF-3A4F2C4E4734',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Minutes')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['🏁Time to be done: ', sc.Ref('Vars.Desired Alarm Name')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Desired Alarm Name',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '01BF5E27-D25D-4730-95FF-3A4F2C4E4734',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['⏱️', sc.Ref('Minutes')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Desired Alarm Name',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '01BF5E27-D25D-4730-95FF-3A4F2C4E4734',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0D8247B0-6D9A-44EF-B3C3-82D216245C6B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', name='Disable Snooze?', params={
      Input: sc.Attach({
        Aggrandizements: [
          {
            DictionaryKey: 'disable_snooze?',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Alarm Time Config Element Dict',
      }),
      WFCountType: 'Characters',
    }),

    sc.Action('is.workflow.actions.calculateexpression', name='Calculation Result', params={
      Input: sc.Str(['1 - ', sc.Ref('Disable Snooze?')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Calculation Result')),
      WFVariableName: 'Should Allow Snooze',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '804CDB63-E1F6-4D01-B57C-5C520AF0C9EF',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Vars.Calendar Alarms')),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item 3')),
      WFVariableName: 'Candidate Alarm',
    }),

    sc.Action('is.workflow.actions.detect.number', name='Candidate Allows Snooze', params={
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'snooze',
            PropertyUserInfo: {
              WFLinkEntityContentPropertyUserInfoEnumMetadata: {
                __data__: {
                  '$archiver': 'NSKeyedArchiver',
                  '$objects': [
                    '$null',
                    {
                      '$class': {
                        __data__: 94,
                        __type__: 'uid',
                      },
                      assistantDefinedSchemas: {
                        __data__: 91,
                        __type__: 'uid',
                      },
                      availabilityAnnotations: {
                        __data__: 84,
                        __type__: 'uid',
                      },
                      cases: {
                        __data__: 12,
                        __type__: 'uid',
                      },
                      customIntentEnumTypeName: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      displayRepresentation: {
                        __data__: 3,
                        __type__: 'uid',
                      },
                      effectiveBundleIdentifiers: {
                        __data__: 77,
                        __type__: 'uid',
                      },
                      fullyQualifiedTypeName: {
                        __data__: 90,
                        __type__: 'uid',
                      },
                      identifier: {
                        __data__: 2,
                        __type__: 'uid',
                      },
                      mangledTypeName: {
                        __data__: 72,
                        __type__: 'uid',
                      },
                      mangledTypeNameByBundleIdentifier: {
                        __data__: 73,
                        __type__: 'uid',
                      },
                      system: {
                        __data__: 89,
                        __type__: 'uid',
                      },
                      visibilityMetadata: {
                        __data__: 92,
                        __type__: 'uid',
                      },
                    },
                    'RepeatDay',
                    {
                      '$class': {
                        __data__: 11,
                        __type__: 'uid',
                      },
                      name: {
                        __data__: 4,
                        __type__: 'uid',
                      },
                      numericFormat: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      synonyms: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 10,
                        __type__: 'uid',
                      },
                      bundleURL: {
                        __data__: 6,
                        __type__: 'uid',
                      },
                      defaultValue: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      key: {
                        __data__: 5,
                        __type__: 'uid',
                      },
                      table: {
                        __data__: 9,
                        __type__: 'uid',
                      },
                    },
                    'Repeat Day',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 7,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    {
                      '$classes': [
                        'NSURL',
                        'NSObject',
                      ],
                      '$classname': 'NSURL',
                    },
                    'AppIntents',
                    {
                      '$classes': [
                        'LNStaticDeferredLocalizedString',
                        'NSObject',
                      ],
                      '$classname': 'LNStaticDeferredLocalizedString',
                    },
                    {
                      '$classes': [
                        'LNTypeDisplayRepresentation',
                        'NSObject',
                      ],
                      '$classname': 'LNTypeDisplayRepresentation',
                    },
                    {
                      '$class': {
                        __data__: 71,
                        __type__: 'uid',
                      },
                      'NS.objects': [
                        {
                          __data__: 13,
                          __type__: 'uid',
                        },
                        {
                          __data__: 23,
                          __type__: 'uid',
                        },
                        {
                          __data__: 31,
                          __type__: 'uid',
                        },
                        {
                          __data__: 39,
                          __type__: 'uid',
                        },
                        {
                          __data__: 47,
                          __type__: 'uid',
                        },
                        {
                          __data__: 55,
                          __type__: 'uid',
                        },
                        {
                          __data__: 63,
                          __type__: 'uid',
                        },
                      ],
                    },
                    {
                      '$class': {
                        __data__: 22,
                        __type__: 'uid',
                      },
                      displayRepresentation: {
                        __data__: 15,
                        __type__: 'uid',
                      },
                      identifier: {
                        __data__: 14,
                        __type__: 'uid',
                      },
                    },
                    'sunday',
                    {
                      '$class': {
                        __data__: 21,
                        __type__: 'uid',
                      },
                      descriptionText: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      image: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      snippetPluginModel: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      subtitle: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      synonyms: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      title: {
                        __data__: 16,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 10,
                        __type__: 'uid',
                      },
                      bundleURL: {
                        __data__: 18,
                        __type__: 'uid',
                      },
                      defaultValue: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      key: {
                        __data__: 17,
                        __type__: 'uid',
                      },
                      table: {
                        __data__: 20,
                        __type__: 'uid',
                      },
                    },
                    'Sunday',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 19,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    'AppIntents',
                    {
                      '$classes': [
                        'LNDisplayRepresentation',
                        'NSObject',
                      ],
                      '$classname': 'LNDisplayRepresentation',
                    },
                    {
                      '$classes': [
                        'LNEnumCaseMetadata',
                        'NSObject',
                      ],
                      '$classname': 'LNEnumCaseMetadata',
                    },
                    {
                      '$class': {
                        __data__: 22,
                        __type__: 'uid',
                      },
                      displayRepresentation: {
                        __data__: 25,
                        __type__: 'uid',
                      },
                      identifier: {
                        __data__: 24,
                        __type__: 'uid',
                      },
                    },
                    'monday',
                    {
                      '$class': {
                        __data__: 21,
                        __type__: 'uid',
                      },
                      descriptionText: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      image: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      snippetPluginModel: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      subtitle: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      synonyms: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      title: {
                        __data__: 26,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 10,
                        __type__: 'uid',
                      },
                      bundleURL: {
                        __data__: 28,
                        __type__: 'uid',
                      },
                      defaultValue: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      key: {
                        __data__: 27,
                        __type__: 'uid',
                      },
                      table: {
                        __data__: 30,
                        __type__: 'uid',
                      },
                    },
                    'Monday',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 29,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    'AppIntents',
                    {
                      '$class': {
                        __data__: 22,
                        __type__: 'uid',
                      },
                      displayRepresentation: {
                        __data__: 33,
                        __type__: 'uid',
                      },
                      identifier: {
                        __data__: 32,
                        __type__: 'uid',
                      },
                    },
                    'tuesday',
                    {
                      '$class': {
                        __data__: 21,
                        __type__: 'uid',
                      },
                      descriptionText: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      image: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      snippetPluginModel: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      subtitle: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      synonyms: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      title: {
                        __data__: 34,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 10,
                        __type__: 'uid',
                      },
                      bundleURL: {
                        __data__: 36,
                        __type__: 'uid',
                      },
                      defaultValue: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      key: {
                        __data__: 35,
                        __type__: 'uid',
                      },
                      table: {
                        __data__: 38,
                        __type__: 'uid',
                      },
                    },
                    'Tuesday',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 37,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    'AppIntents',
                    {
                      '$class': {
                        __data__: 22,
                        __type__: 'uid',
                      },
                      displayRepresentation: {
                        __data__: 41,
                        __type__: 'uid',
                      },
                      identifier: {
                        __data__: 40,
                        __type__: 'uid',
                      },
                    },
                    'wednesday',
                    {
                      '$class': {
                        __data__: 21,
                        __type__: 'uid',
                      },
                      descriptionText: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      image: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      snippetPluginModel: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      subtitle: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      synonyms: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      title: {
                        __data__: 42,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 10,
                        __type__: 'uid',
                      },
                      bundleURL: {
                        __data__: 44,
                        __type__: 'uid',
                      },
                      defaultValue: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      key: {
                        __data__: 43,
                        __type__: 'uid',
                      },
                      table: {
                        __data__: 46,
                        __type__: 'uid',
                      },
                    },
                    'Wednesday',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 45,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    'AppIntents',
                    {
                      '$class': {
                        __data__: 22,
                        __type__: 'uid',
                      },
                      displayRepresentation: {
                        __data__: 49,
                        __type__: 'uid',
                      },
                      identifier: {
                        __data__: 48,
                        __type__: 'uid',
                      },
                    },
                    'thursday',
                    {
                      '$class': {
                        __data__: 21,
                        __type__: 'uid',
                      },
                      descriptionText: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      image: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      snippetPluginModel: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      subtitle: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      synonyms: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      title: {
                        __data__: 50,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 10,
                        __type__: 'uid',
                      },
                      bundleURL: {
                        __data__: 52,
                        __type__: 'uid',
                      },
                      defaultValue: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      key: {
                        __data__: 51,
                        __type__: 'uid',
                      },
                      table: {
                        __data__: 54,
                        __type__: 'uid',
                      },
                    },
                    'Thursday',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 53,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    'AppIntents',
                    {
                      '$class': {
                        __data__: 22,
                        __type__: 'uid',
                      },
                      displayRepresentation: {
                        __data__: 57,
                        __type__: 'uid',
                      },
                      identifier: {
                        __data__: 56,
                        __type__: 'uid',
                      },
                    },
                    'friday',
                    {
                      '$class': {
                        __data__: 21,
                        __type__: 'uid',
                      },
                      descriptionText: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      image: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      snippetPluginModel: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      subtitle: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      synonyms: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      title: {
                        __data__: 58,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 10,
                        __type__: 'uid',
                      },
                      bundleURL: {
                        __data__: 60,
                        __type__: 'uid',
                      },
                      defaultValue: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      key: {
                        __data__: 59,
                        __type__: 'uid',
                      },
                      table: {
                        __data__: 62,
                        __type__: 'uid',
                      },
                    },
                    'Friday',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 61,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    'AppIntents',
                    {
                      '$class': {
                        __data__: 22,
                        __type__: 'uid',
                      },
                      displayRepresentation: {
                        __data__: 65,
                        __type__: 'uid',
                      },
                      identifier: {
                        __data__: 64,
                        __type__: 'uid',
                      },
                    },
                    'saturday',
                    {
                      '$class': {
                        __data__: 21,
                        __type__: 'uid',
                      },
                      descriptionText: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      image: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      snippetPluginModel: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      subtitle: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      synonyms: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      title: {
                        __data__: 66,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 10,
                        __type__: 'uid',
                      },
                      bundleURL: {
                        __data__: 68,
                        __type__: 'uid',
                      },
                      defaultValue: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      key: {
                        __data__: 67,
                        __type__: 'uid',
                      },
                      table: {
                        __data__: 70,
                        __type__: 'uid',
                      },
                    },
                    'Saturday',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 69,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    'AppIntents',
                    {
                      '$classes': [
                        'NSArray',
                        'NSObject',
                      ],
                      '$classname': 'NSArray',
                    },
                    '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                    {
                      '$class': {
                        __data__: 76,
                        __type__: 'uid',
                      },
                      'NS.keys': [
                        {
                          __data__: 74,
                          __type__: 'uid',
                        },
                      ],
                      'NS.objects': [
                        {
                          __data__: 75,
                          __type__: 'uid',
                        },
                      ],
                    },
                    'com.apple.mobiletimer',
                    '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                    {
                      '$classes': [
                        'NSDictionary',
                        'NSObject',
                      ],
                      '$classname': 'NSDictionary',
                    },
                    {
                      '$class': {
                        __data__: 83,
                        __type__: 'uid',
                      },
                      'NS.object.0': {
                        __data__: 78,
                        __type__: 'uid',
                      },
                    },
                    {
                      '$class': {
                        __data__: 82,
                        __type__: 'uid',
                      },
                      bundleIdentifier: {
                        __data__: 79,
                        __type__: 'uid',
                      },
                      type: 0,
                      url: {
                        __data__: 80,
                        __type__: 'uid',
                      },
                    },
                    'com.apple.mobiletimer',
                    {
                      '$class': {
                        __data__: 8,
                        __type__: 'uid',
                      },
                      'NS.base': {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      'NS.relative': {
                        __data__: 81,
                        __type__: 'uid',
                      },
                    },
                    'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                    {
                      '$classes': [
                        'LNEffectiveBundleIdentifier',
                        'NSObject',
                      ],
                      '$classname': 'LNEffectiveBundleIdentifier',
                    },
                    {
                      '$classes': [
                        'NSOrderedSet',
                        'NSObject',
                      ],
                      '$classname': 'NSOrderedSet',
                    },
                    {
                      '$class': {
                        __data__: 76,
                        __type__: 'uid',
                      },
                      'NS.keys': [
                        {
                          __data__: 85,
                          __type__: 'uid',
                        },
                      ],
                      'NS.objects': [
                        {
                          __data__: 86,
                          __type__: 'uid',
                        },
                      ],
                    },
                    'LNPlatformNameWildcard',
                    {
                      '$class': {
                        __data__: 88,
                        __type__: 'uid',
                      },
                      deprecatedVersion: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                      introducedVersion: {
                        __data__: 87,
                        __type__: 'uid',
                      },
                      obsoletedVersion: {
                        __data__: 0,
                        __type__: 'uid',
                      },
                    },
                    '*',
                    {
                      '$classes': [
                        'LNAvailabilityAnnotation',
                        'NSObject',
                      ],
                      '$classname': 'LNAvailabilityAnnotation',
                    },
                    false,
                    'MobileTimerSupport.AlarmEntity.RepeatDay',
                    {
                      '$class': {
                        __data__: 71,
                        __type__: 'uid',
                      },
                      'NS.objects': [],
                    },
                    {
                      '$class': {
                        __data__: 93,
                        __type__: 'uid',
                      },
                      assistantOnly: false,
                      isDiscoverable: true,
                    },
                    {
                      '$classes': [
                        'LNVisibilityMetadata',
                        'NSObject',
                      ],
                      '$classname': 'LNVisibilityMetadata',
                    },
                    {
                      '$classes': [
                        'LNEnumMetadata',
                        'NSObject',
                      ],
                      '$classname': 'LNEnumMetadata',
                    },
                  ],
                  '$top': {
                    root: {
                      __data__: 1,
                      __type__: 'uid',
                    },
                  },
                  '$version': 100000,
                },
                __type__: 'data-bplist',
              },
              WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'snooze',
            },
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Candidate Alarm',
      }),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'F6C321C2-2285-47D6-87FB-6EEA935EF3FC',
      WFConditions: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              WFCondition: 4,
              WFConditionalActionString: sc.Str([sc.Ref('Vars.Desired Alarm Name')]),
              WFInput: {
                Type: 'Variable',
                Variable: sc.Attach({
                  Aggrandizements: [
                    {
                      PropertyName: 'label',
                      PropertyUserInfo: {
                        WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'label',
                      },
                      Type: 'WFPropertyVariableAggrandizement',
                    },
                  ],
                  Type: 'Variable',
                  VariableName: 'Candidate Alarm',
                }),
              },
            },
            {
              WFCondition: 4,
              WFConditionalActionString: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'Time',
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
                VariableName: 'Desired Alarm Time',
              }]),
              WFDate: sc.Attach(sc.Ref('Vars.Desired Alarm Time')),
              WFInput: {
                Type: 'Variable',
                Variable: sc.Attach({
                  Aggrandizements: [
                    {
                      PropertyName: 'dateComponents',
                      PropertyUserInfo: {
                        WFLinkEntityContentPropertyUserInfoEnumMetadata: {
                          __data__: {
                            '$archiver': 'NSKeyedArchiver',
                            '$objects': [
                              '$null',
                              {
                                '$class': {
                                  __data__: 94,
                                  __type__: 'uid',
                                },
                                assistantDefinedSchemas: {
                                  __data__: 91,
                                  __type__: 'uid',
                                },
                                availabilityAnnotations: {
                                  __data__: 84,
                                  __type__: 'uid',
                                },
                                cases: {
                                  __data__: 12,
                                  __type__: 'uid',
                                },
                                customIntentEnumTypeName: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                displayRepresentation: {
                                  __data__: 3,
                                  __type__: 'uid',
                                },
                                effectiveBundleIdentifiers: {
                                  __data__: 77,
                                  __type__: 'uid',
                                },
                                fullyQualifiedTypeName: {
                                  __data__: 90,
                                  __type__: 'uid',
                                },
                                identifier: {
                                  __data__: 2,
                                  __type__: 'uid',
                                },
                                mangledTypeName: {
                                  __data__: 72,
                                  __type__: 'uid',
                                },
                                mangledTypeNameByBundleIdentifier: {
                                  __data__: 73,
                                  __type__: 'uid',
                                },
                                system: {
                                  __data__: 89,
                                  __type__: 'uid',
                                },
                                visibilityMetadata: {
                                  __data__: 92,
                                  __type__: 'uid',
                                },
                              },
                              'RepeatDay',
                              {
                                '$class': {
                                  __data__: 11,
                                  __type__: 'uid',
                                },
                                name: {
                                  __data__: 4,
                                  __type__: 'uid',
                                },
                                numericFormat: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                synonyms: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 10,
                                  __type__: 'uid',
                                },
                                bundleURL: {
                                  __data__: 6,
                                  __type__: 'uid',
                                },
                                defaultValue: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                key: {
                                  __data__: 5,
                                  __type__: 'uid',
                                },
                                table: {
                                  __data__: 9,
                                  __type__: 'uid',
                                },
                              },
                              'Repeat Day',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 7,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              {
                                '$classes': [
                                  'NSURL',
                                  'NSObject',
                                ],
                                '$classname': 'NSURL',
                              },
                              'AppIntents',
                              {
                                '$classes': [
                                  'LNStaticDeferredLocalizedString',
                                  'NSObject',
                                ],
                                '$classname': 'LNStaticDeferredLocalizedString',
                              },
                              {
                                '$classes': [
                                  'LNTypeDisplayRepresentation',
                                  'NSObject',
                                ],
                                '$classname': 'LNTypeDisplayRepresentation',
                              },
                              {
                                '$class': {
                                  __data__: 71,
                                  __type__: 'uid',
                                },
                                'NS.objects': [
                                  {
                                    __data__: 13,
                                    __type__: 'uid',
                                  },
                                  {
                                    __data__: 23,
                                    __type__: 'uid',
                                  },
                                  {
                                    __data__: 31,
                                    __type__: 'uid',
                                  },
                                  {
                                    __data__: 39,
                                    __type__: 'uid',
                                  },
                                  {
                                    __data__: 47,
                                    __type__: 'uid',
                                  },
                                  {
                                    __data__: 55,
                                    __type__: 'uid',
                                  },
                                  {
                                    __data__: 63,
                                    __type__: 'uid',
                                  },
                                ],
                              },
                              {
                                '$class': {
                                  __data__: 22,
                                  __type__: 'uid',
                                },
                                displayRepresentation: {
                                  __data__: 15,
                                  __type__: 'uid',
                                },
                                identifier: {
                                  __data__: 14,
                                  __type__: 'uid',
                                },
                              },
                              'sunday',
                              {
                                '$class': {
                                  __data__: 21,
                                  __type__: 'uid',
                                },
                                descriptionText: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                image: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                snippetPluginModel: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                subtitle: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                synonyms: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                title: {
                                  __data__: 16,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 10,
                                  __type__: 'uid',
                                },
                                bundleURL: {
                                  __data__: 18,
                                  __type__: 'uid',
                                },
                                defaultValue: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                key: {
                                  __data__: 17,
                                  __type__: 'uid',
                                },
                                table: {
                                  __data__: 20,
                                  __type__: 'uid',
                                },
                              },
                              'Sunday',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 19,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              'AppIntents',
                              {
                                '$classes': [
                                  'LNDisplayRepresentation',
                                  'NSObject',
                                ],
                                '$classname': 'LNDisplayRepresentation',
                              },
                              {
                                '$classes': [
                                  'LNEnumCaseMetadata',
                                  'NSObject',
                                ],
                                '$classname': 'LNEnumCaseMetadata',
                              },
                              {
                                '$class': {
                                  __data__: 22,
                                  __type__: 'uid',
                                },
                                displayRepresentation: {
                                  __data__: 25,
                                  __type__: 'uid',
                                },
                                identifier: {
                                  __data__: 24,
                                  __type__: 'uid',
                                },
                              },
                              'monday',
                              {
                                '$class': {
                                  __data__: 21,
                                  __type__: 'uid',
                                },
                                descriptionText: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                image: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                snippetPluginModel: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                subtitle: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                synonyms: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                title: {
                                  __data__: 26,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 10,
                                  __type__: 'uid',
                                },
                                bundleURL: {
                                  __data__: 28,
                                  __type__: 'uid',
                                },
                                defaultValue: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                key: {
                                  __data__: 27,
                                  __type__: 'uid',
                                },
                                table: {
                                  __data__: 30,
                                  __type__: 'uid',
                                },
                              },
                              'Monday',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 29,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              'AppIntents',
                              {
                                '$class': {
                                  __data__: 22,
                                  __type__: 'uid',
                                },
                                displayRepresentation: {
                                  __data__: 33,
                                  __type__: 'uid',
                                },
                                identifier: {
                                  __data__: 32,
                                  __type__: 'uid',
                                },
                              },
                              'tuesday',
                              {
                                '$class': {
                                  __data__: 21,
                                  __type__: 'uid',
                                },
                                descriptionText: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                image: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                snippetPluginModel: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                subtitle: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                synonyms: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                title: {
                                  __data__: 34,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 10,
                                  __type__: 'uid',
                                },
                                bundleURL: {
                                  __data__: 36,
                                  __type__: 'uid',
                                },
                                defaultValue: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                key: {
                                  __data__: 35,
                                  __type__: 'uid',
                                },
                                table: {
                                  __data__: 38,
                                  __type__: 'uid',
                                },
                              },
                              'Tuesday',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 37,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              'AppIntents',
                              {
                                '$class': {
                                  __data__: 22,
                                  __type__: 'uid',
                                },
                                displayRepresentation: {
                                  __data__: 41,
                                  __type__: 'uid',
                                },
                                identifier: {
                                  __data__: 40,
                                  __type__: 'uid',
                                },
                              },
                              'wednesday',
                              {
                                '$class': {
                                  __data__: 21,
                                  __type__: 'uid',
                                },
                                descriptionText: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                image: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                snippetPluginModel: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                subtitle: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                synonyms: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                title: {
                                  __data__: 42,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 10,
                                  __type__: 'uid',
                                },
                                bundleURL: {
                                  __data__: 44,
                                  __type__: 'uid',
                                },
                                defaultValue: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                key: {
                                  __data__: 43,
                                  __type__: 'uid',
                                },
                                table: {
                                  __data__: 46,
                                  __type__: 'uid',
                                },
                              },
                              'Wednesday',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 45,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              'AppIntents',
                              {
                                '$class': {
                                  __data__: 22,
                                  __type__: 'uid',
                                },
                                displayRepresentation: {
                                  __data__: 49,
                                  __type__: 'uid',
                                },
                                identifier: {
                                  __data__: 48,
                                  __type__: 'uid',
                                },
                              },
                              'thursday',
                              {
                                '$class': {
                                  __data__: 21,
                                  __type__: 'uid',
                                },
                                descriptionText: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                image: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                snippetPluginModel: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                subtitle: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                synonyms: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                title: {
                                  __data__: 50,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 10,
                                  __type__: 'uid',
                                },
                                bundleURL: {
                                  __data__: 52,
                                  __type__: 'uid',
                                },
                                defaultValue: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                key: {
                                  __data__: 51,
                                  __type__: 'uid',
                                },
                                table: {
                                  __data__: 54,
                                  __type__: 'uid',
                                },
                              },
                              'Thursday',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 53,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              'AppIntents',
                              {
                                '$class': {
                                  __data__: 22,
                                  __type__: 'uid',
                                },
                                displayRepresentation: {
                                  __data__: 57,
                                  __type__: 'uid',
                                },
                                identifier: {
                                  __data__: 56,
                                  __type__: 'uid',
                                },
                              },
                              'friday',
                              {
                                '$class': {
                                  __data__: 21,
                                  __type__: 'uid',
                                },
                                descriptionText: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                image: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                snippetPluginModel: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                subtitle: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                synonyms: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                title: {
                                  __data__: 58,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 10,
                                  __type__: 'uid',
                                },
                                bundleURL: {
                                  __data__: 60,
                                  __type__: 'uid',
                                },
                                defaultValue: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                key: {
                                  __data__: 59,
                                  __type__: 'uid',
                                },
                                table: {
                                  __data__: 62,
                                  __type__: 'uid',
                                },
                              },
                              'Friday',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 61,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              'AppIntents',
                              {
                                '$class': {
                                  __data__: 22,
                                  __type__: 'uid',
                                },
                                displayRepresentation: {
                                  __data__: 65,
                                  __type__: 'uid',
                                },
                                identifier: {
                                  __data__: 64,
                                  __type__: 'uid',
                                },
                              },
                              'saturday',
                              {
                                '$class': {
                                  __data__: 21,
                                  __type__: 'uid',
                                },
                                descriptionText: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                image: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                snippetPluginModel: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                subtitle: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                synonyms: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                title: {
                                  __data__: 66,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 10,
                                  __type__: 'uid',
                                },
                                bundleURL: {
                                  __data__: 68,
                                  __type__: 'uid',
                                },
                                defaultValue: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                key: {
                                  __data__: 67,
                                  __type__: 'uid',
                                },
                                table: {
                                  __data__: 70,
                                  __type__: 'uid',
                                },
                              },
                              'Saturday',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 69,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              'AppIntents',
                              {
                                '$classes': [
                                  'NSArray',
                                  'NSObject',
                                ],
                                '$classname': 'NSArray',
                              },
                              '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                              {
                                '$class': {
                                  __data__: 76,
                                  __type__: 'uid',
                                },
                                'NS.keys': [
                                  {
                                    __data__: 74,
                                    __type__: 'uid',
                                  },
                                ],
                                'NS.objects': [
                                  {
                                    __data__: 75,
                                    __type__: 'uid',
                                  },
                                ],
                              },
                              'com.apple.clock',
                              '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                              {
                                '$classes': [
                                  'NSDictionary',
                                  'NSObject',
                                ],
                                '$classname': 'NSDictionary',
                              },
                              {
                                '$class': {
                                  __data__: 83,
                                  __type__: 'uid',
                                },
                                'NS.object.0': {
                                  __data__: 78,
                                  __type__: 'uid',
                                },
                              },
                              {
                                '$class': {
                                  __data__: 82,
                                  __type__: 'uid',
                                },
                                bundleIdentifier: {
                                  __data__: 79,
                                  __type__: 'uid',
                                },
                                type: 0,
                                url: {
                                  __data__: 80,
                                  __type__: 'uid',
                                },
                              },
                              'com.apple.clock',
                              {
                                '$class': {
                                  __data__: 8,
                                  __type__: 'uid',
                                },
                                'NS.base': {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                'NS.relative': {
                                  __data__: 81,
                                  __type__: 'uid',
                                },
                              },
                              'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                              {
                                '$classes': [
                                  'LNEffectiveBundleIdentifier',
                                  'NSObject',
                                ],
                                '$classname': 'LNEffectiveBundleIdentifier',
                              },
                              {
                                '$classes': [
                                  'NSOrderedSet',
                                  'NSObject',
                                ],
                                '$classname': 'NSOrderedSet',
                              },
                              {
                                '$class': {
                                  __data__: 76,
                                  __type__: 'uid',
                                },
                                'NS.keys': [
                                  {
                                    __data__: 85,
                                    __type__: 'uid',
                                  },
                                ],
                                'NS.objects': [
                                  {
                                    __data__: 86,
                                    __type__: 'uid',
                                  },
                                ],
                              },
                              'LNPlatformNameWildcard',
                              {
                                '$class': {
                                  __data__: 88,
                                  __type__: 'uid',
                                },
                                deprecatedVersion: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                                introducedVersion: {
                                  __data__: 87,
                                  __type__: 'uid',
                                },
                                obsoletedVersion: {
                                  __data__: 0,
                                  __type__: 'uid',
                                },
                              },
                              '*',
                              {
                                '$classes': [
                                  'LNAvailabilityAnnotation',
                                  'NSObject',
                                ],
                                '$classname': 'LNAvailabilityAnnotation',
                              },
                              false,
                              'MobileTimerSupport.AlarmEntity.RepeatDay',
                              {
                                '$class': {
                                  __data__: 71,
                                  __type__: 'uid',
                                },
                                'NS.objects': [],
                              },
                              {
                                '$class': {
                                  __data__: 93,
                                  __type__: 'uid',
                                },
                                assistantOnly: false,
                                isDiscoverable: true,
                              },
                              {
                                '$classes': [
                                  'LNVisibilityMetadata',
                                  'NSObject',
                                ],
                                '$classname': 'LNVisibilityMetadata',
                              },
                              {
                                '$classes': [
                                  'LNEnumMetadata',
                                  'NSObject',
                                ],
                                '$classname': 'LNEnumMetadata',
                              },
                            ],
                            '$top': {
                              root: {
                                __data__: 1,
                                __type__: 'uid',
                              },
                            },
                            '$version': 100000,
                          },
                          __type__: 'data-bplist',
                        },
                        WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'dateComponents',
                      },
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
                  VariableName: 'Candidate Alarm',
                }),
              },
            },
            {
              WFCondition: 4,
              WFInput: {
                Type: 'Variable',
                Variable: sc.Attach(sc.Ref('Candidate Allows Snooze')),
              },
              WFNumberValue: sc.Attach(sc.Ref('Vars.Should Allow Snooze')),
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFControlFlowMode: 0,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Candidate Alarm')),
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Index 3')),
      WFVariableName: 'Alarm Index',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'F6C321C2-2285-47D6-87FB-6EEA935EF3FC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '804CDB63-E1F6-4D01-B57C-5C520AF0C9EF',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B7B035C1-805D-4467-AFC7-54FD5CE95166',
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
      allowsSnooze: sc.Attach(sc.Ref('Vars.Should Allow Snooze')),
      dateComponents: sc.Str([sc.Ref('Desired Alarm Time', aggs=[
        {
          PropertyName: 'Time',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ])]),
      label: sc.Str([sc.Ref('Desired Alarm Name')]),
      name: sc.Str([sc.Ref('Vars.Desired Alarm Name')]),
      repeatSchedule: {
        displayString: 'Never',
        value: 0,
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      WFNotificationActionBody: sc.Str(['Created ', sc.Ref('Vars.Desired Alarm Name')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B7B035C1-805D-4467-AFC7-54FD5CE95166',
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
      GroupingIdentifier: 'B7B035C1-805D-4467-AFC7-54FD5CE95166',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C7A5D413-B0CA-4695-8DC9-8EB8413F4756',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '9CB4758E-3308-4B8B-9053-ECAEBE629FC9',
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
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Dictionary Value')),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Vars.Repeat Index')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.nothing'),

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
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59846,
    WFWorkflowIconStartColor: 431817727,
  },
  WFWorkflowImportQuestions: [
    {
      ActionIndex: 5,
      Category: 'Parameter',
      ParameterKey: 'WFItems',
      Text: 'Map calendar names to alarm lead times in minutes',
    },
    {
      ActionIndex: 7,
      Category: 'Parameter',
      ParameterKey: 'WFItems',
      Text: 'Calendar labels for alarm names',
    },
  ],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 3010,
  WFWorkflowMinimumClientVersionString: '3010',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
