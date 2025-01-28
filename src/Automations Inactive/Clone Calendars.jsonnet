local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '1956F603-0C15-4191-BB22-59822C2310F1',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: 'select * from pair_configs',
    }),

    sc.Action('is.workflow.actions.dictionary', {
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['db']),
              WFValue: sc.Str(['Clone Calendars.sqlite3']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['query']),
              WFValue: sc.Str([sc.Ref('Text')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('net.filippomaguolo.SQLiteMobile.RunScript2Intent', name='SQL Result', params={
      outputFormat: 'json',
      saveHistory: false,
      sql: 'select * from pair_configs',
      sqliteDatabaseName: 'Clone Calendars.sqlite3',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'DF2CE90A-0B7A-432D-AE42-9D0DA638A372',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('SQL Result', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: 'D33414F8-5B8B-4EF8-9B28-06B8436D550B',
        workflowName: 'Clone Calendars',
      },
      WFWorkflowName: 'Clone Calendars',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'DF2CE90A-0B7A-432D-AE42-9D0DA638A372',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '1956F603-0C15-4191-BB22-59822C2310F1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='Calendar Events', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Bounded: true,
              Operator: 1000,
              Property: 'Start Date',
              Removable: false,
              Values: {},
            },
            {
              Operator: 4,
              Property: 'Calendar',
              Removable: true,
              Values: {
                Enumeration: {
                  Value: sc.Attach({
                    Aggrandizements: [
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'src_calendar',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ],
                    Type: 'ExtensionInput',
                  }),
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 4,
              Property: 'Canceled',
              Removable: true,
              Values: {},
            },
            {
              Operator: 5,
              Property: 'My Status',
              Removable: true,
              Values: {
                Enumeration: {
                  Value: 'Declined',
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemLimitEnabled: false,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '7507F84F-766C-45C2-B9F5-55FC5AD0E431',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Calendar Events')),
    }),

    sc.Action('is.workflow.actions.gettext', name='dst Title', params={
      WFTextActionText: sc.Str([{
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'dst_title_pfx',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }]),
    }),

    sc.Action('is.workflow.actions.gettext', name='dst Notes', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Notes',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
            '{1, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'dst_desc_sfx',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'ExtensionInput',
            },
            '{4, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'pair_id',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'ExtensionInput',
            },
          },
          string: |||
            ￼￼

            ￼
          |||,
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='dst Events', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Bounded: true,
              Operator: 4,
              Property: 'Start Date',
              Removable: false,
              Values: {},
            },
            {
              Operator: 4,
              Property: 'Calendar',
              Removable: true,
              Values: {
                Enumeration: {
                  Value: sc.Attach({
                    Aggrandizements: [
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'dst_calendar',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ],
                    Type: 'ExtensionInput',
                  }),
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 4,
              Property: 'Title',
              Removable: true,
              Values: {
                String: sc.Str([sc.Ref('dst Title')]),
              },
            },
            {
              Operator: 4,
              Property: 'End Date',
              Removable: true,
              Values: {},
            },
            {
              Operator: 4,
              Property: 'Notes',
              Removable: true,
              Values: {
                String: sc.Str([sc.Ref('dst Notes')]),
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '8EA6249C-559F-4BC8-BE30-BD2B3FA17892',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('dst Events')),
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      WFInput: sc.Attach(sc.Ref('dst Events')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '8EA6249C-559F-4BC8-BE30-BD2B3FA17892',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.addnewevent', name='New Event', params={
      ShowWhenRun: false,
      WFCalendarDescriptor: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'dst_calendar',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }),
      WFCalendarItemAllDay: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'Is All Day',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }),
      WFCalendarItemEndDate: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'End Date',
            Type: 'WFPropertyVariableAggrandizement',
          },
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFCalendarItemLocation: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'Location',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFCalendarItemNotes: sc.Str([sc.Ref('dst Notes')]),
      WFCalendarItemStartDate: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'Start Date',
            Type: 'WFPropertyVariableAggrandizement',
          },
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFCalendarItemTitle: sc.Str([sc.Ref('dst Title')]),
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Attach(sc.Ref('New Event')),
      WFNotificationActionBody: sc.Str(['Created synced event: ', sc.Ref('New Event')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '8EA6249C-559F-4BC8-BE30-BD2B3FA17892',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Synced Events', params={
      GroupingIdentifier: '7507F84F-766C-45C2-B9F5-55FC5AD0E431',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='Calendar Events', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Bounded: true,
              Operator: 1000,
              Property: 'Start Date',
              Removable: false,
              Values: {},
            },
            {
              Operator: 4,
              Property: 'Calendar',
              Removable: true,
              Values: {
                Enumeration: {
                  Value: sc.Attach({
                    Aggrandizements: [
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'dst_calendar',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ],
                    Type: 'ExtensionInput',
                  }),
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 99,
              Property: 'Notes',
              Removable: true,
              Values: {
                String: sc.Str([{
                  Aggrandizements: [
                    {
                      CoercionItemClass: 'WFDictionaryContentItem',
                      Type: 'WFCoercionVariableAggrandizement',
                    },
                    {
                      DictionaryKey: 'pair_id',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ],
                  Type: 'ExtensionInput',
                }]),
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('com.sindresorhus.Actions.TransformListsIntent', name='Difference', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'TransformListsIntent',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      list1: sc.Attach(sc.Ref('Calendar Events')),
      list2: sc.Attach(sc.Ref('Synced Events')),
      type: 'subtraction',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'DFC48677-B45C-49E8-B1E5-606B01E574D8',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Difference', aggs=[
        {
          CoercionItemClass: 'WFGenericFileContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.removeevents', {
      WFCalendarIncludeFutureEvents: true,
      WFInputEvents: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'DFC48677-B45C-49E8-B1E5-606B01E574D8',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -43634177,
  },
  WFWorkflowImportQuestions: [
    {
      ActionIndex: 1,
      Category: 'Parameter',
      ParameterKey: 'WFItems',
      Text: 'Settings',
    },
  ],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
