local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: |||


        Automatically synced from Mass.gov calendar 
      |||,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Settings', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['src']),
              WFValue: sc.Str(['Calendar']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['dst']),
              WFValue: sc.Str(['Tim Nava']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['pfx']),
              WFValue: sc.Str(['Mass.gov: ']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['sfx']),
              WFValue: sc.Str([sc.Ref('Text')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
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
                  Value: sc.Attach(sc.Ref('Settings', aggs=[
                    {
                      DictionaryKey: 'src',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ])),
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
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '7507F84F-766C-45C2-B9F5-55FC5AD0E431',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Calendar Events')),
    }),

    sc.Action('is.workflow.actions.gettext', name='dst Title', params={
      WFTextActionText: sc.Str([sc.Ref('Settings', aggs=[
        {
          DictionaryKey: 'pfx',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.gettext', name='dst Notes', params={
      WFTextActionText: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'Notes',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='dst Events', params={
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
                  Value: sc.Attach(sc.Ref('Settings', aggs=[
                    {
                      DictionaryKey: 'dst',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ])),
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
              Property: 'Start Date',
              Removable: true,
              Values: {},
            },
            {
              Operator: 4,
              Property: 'End Date',
              Removable: true,
              Values: {},
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

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: sc.Attach(sc.Ref('dst Events')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE867DF5-AA0A-4A26-A835-F937EC63BBFA',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Count')),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('dst Events')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE867DF5-AA0A-4A26-A835-F937EC63BBFA',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '196531EF-7BBE-4E34-A7B3-946E61FCD3E6',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('dst Events')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7F450D70-D4B1-456C-8463-99DD41860120',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Repeat Index 2')),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
      WFNotificationActionBody: sc.Str(['Deleting duplicate event: ', sc.Ref('Vars.Repeat Item 2')]),
      WFNotificationActionSound: true,
    }),

    sc.Action('is.workflow.actions.removeevents', {
      WFInputEvents: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7F450D70-D4B1-456C-8463-99DD41860120',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '196531EF-7BBE-4E34-A7B3-946E61FCD3E6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      WFInput: sc.Attach(sc.Ref('dst Events')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE867DF5-AA0A-4A26-A835-F937EC63BBFA',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '8EA6249C-559F-4BC8-BE30-BD2B3FA17892',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.addnewevent', name='New Event', params={
      ShowWhenRun: false,
      WFCalendarDescriptor: sc.Attach(sc.Ref('Settings', aggs=[
        {
          DictionaryKey: 'dst',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
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

    sc.Action('is.workflow.actions.repeat.each', {
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
                  Value: sc.Attach(sc.Ref('Settings', aggs=[
                    {
                      DictionaryKey: 'dst',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ])),
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 8,
              Property: 'Title',
              Removable: true,
              Values: {
                String: sc.Str([sc.Ref('Settings', aggs=[
                  {
                    DictionaryKey: 'pfx',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ])]),
              },
            },
            {
              Operator: 9,
              Property: 'Notes',
              Removable: true,
              Values: {
                String: sc.Str([sc.Ref('Settings', aggs=[
                  {
                    DictionaryKey: 'sfx',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ])]),
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '75BEDD6D-58E1-42FC-8FAE-5047F52D58FF',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Calendar Events')),
    }),

    sc.Action('is.workflow.actions.text.replace', name='src Title', params={
      WFInput: sc.Str([sc.Ref('Vars.Repeat Item')]),
      WFReplaceTextFind: sc.Str(['^', sc.Ref('Settings', aggs=[
        {
          DictionaryKey: 'pfx',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFReplaceTextRegularExpression: true,
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='dst Events', params={
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
                  Value: sc.Attach(sc.Ref('Settings', aggs=[
                    {
                      DictionaryKey: 'src',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ])),
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 4,
              Property: 'Title',
              Removable: true,
              Values: {
                String: sc.Str([sc.Ref('src Title')]),
              },
            },
            {
              Operator: 4,
              Property: 'Start Date',
              Removable: true,
              Values: {},
            },
            {
              Operator: 4,
              Property: 'End Date',
              Removable: true,
              Values: {},
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
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '48CDD428-AF53-4FB3-8A93-651BB35509DE',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('dst Events')),
      },
    }),

    sc.Action('is.workflow.actions.removeevents', {
      WFInputEvents: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '48CDD428-AF53-4FB3-8A93-651BB35509DE',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '75BEDD6D-58E1-42FC-8FAE-5047F52D58FF',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
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
