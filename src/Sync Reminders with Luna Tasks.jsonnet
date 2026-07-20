local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Config', params={
      keyPath: 'luna-reminders',
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.GetReminderListsIntent', name='Reminder Lists', params={
      getType: 'DetailsAsDict',
    }),

    sc.Action('com.sindresorhus.Actions.Boolean', name='Choose lists', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'Boolean',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Choose lists')),
      },
      'is',
      {
        UUID: '8C067722-F307-4FC7-B905-4013CD7BEBDA',
      }
    )).Then_([

      sc.Action('is.workflow.actions.number'),

      sc.Action('is.workflow.actions.choosefromlist', name='Selected Item', params={
        WFChooseFromListActionSelectMultiple: true,
        WFInput: sc.Attach(sc.Ref('Reminder Lists', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            PropertyName: 'Keys',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      }),

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'EDA2A82A-5498-4F96-8395-739D8AC230E4',
        WFControlFlowMode: 0,
        WFInput: sc.Attach(sc.Ref('Selected Item')),
      }),

      sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
        WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item')]),
        WFInput: sc.Attach(sc.Ref('Reminder Lists')),
      }),

      sc.Action('dk.simonbs.DataJar.SetValueIntent', {
        keyPath: sc.Str(['luna-reminders.lists.', sc.Ref('Vars.Repeat Item'), '.id']),
        overwriteStrategy: 'alwaysAllow',
        values: sc.Attach(sc.Ref('Dictionary Value', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'UUID',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      }),

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'EDA2A82A-5498-4F96-8395-739D8AC230E4',
        WFControlFlowMode: 2,
      }),

      sc.Action('dk.simonbs.DataJar.ViewValueIntent', {
        keyPath: 'luna-reminders.lists',
      }),

      sc.Action('is.workflow.actions.waittoreturn'),

      sc.Action('is.workflow.actions.alert'),

    ]).EndIf_(),

    sc.Action('com.sindresorhus.Actions.Boolean', name='Filter lists', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'Boolean',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      boolean: 1,
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Filter lists')),
      },
      'is',
      {
        UUID: '564C24F8-A835-4FBA-945B-75E6E568BF7C',
      }
    )).Then_([

      sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
        WFItems: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 1,
                WFKey: sc.Str(['config']),
                WFValue: {
                  Value: sc.Attach(sc.Ref('Config')),
                  WFSerializationType: 'WFDictionarySubstitutableParameterState',
                },
              },
              {
                WFItemType: 1,
                WFKey: sc.Str(['lists']),
                WFValue: {
                  Value: sc.Attach(sc.Ref('Reminder Lists')),
                  WFSerializationType: 'WFDictionarySubstitutableParameterState',
                },
              },
            ],
          },
          WFSerializationType: 'WFDictionaryFieldValue',
        },
      }),

      sc.Action('is.workflow.actions.setitemname', name='lists.json', params={
        WFInput: sc.Attach(sc.Ref('Dictionary')),
        WFName: 'lists',
      }),

      sc.Action('AsheKube.app.a-Shell-mini.PutFileIntent', {
        ShowWhenRun: false,
        file: sc.Attach(sc.Ref('lists.json')),
      }),

      sc.Action('AsheKube.app.a-Shell-mini.ExecuteCommandIntent', name='output', params={
        ShowWhenRun: false,
        command: "jq -r '. as {$config} | .lists | to_entries[] | select(.value.UUID == $config.lists[].id).key' lists.json",
        openWindow: 'close',
      }),

      sc.Action('is.workflow.actions.text.trimwhitespace', name='Updated Text', params={
        WFInput: sc.Str([sc.Ref('output')]),
      }),

      sc.Action('is.workflow.actions.text.split', name='List Names', params={
        text: sc.Attach(sc.Ref('Updated Text')),
      }),

    ]).EndIf_(),

    sc.Action('is.workflow.actions.filter.reminders', name='Reminders', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Operator: 4,
              Property: 'List',
              Removable: true,
              Values: {
                Enumeration: {
                  Value: sc.Attach(sc.Ref('List Names')),
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 4,
              Property: 'Is Completed',
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
      WFContentItemLimitEnabled: false,
      WFContentItemLimitNumber: 1.0,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Reminders')),
      WFVariableName: 'Reminders',
    }),

    sc.Action('com.sindresorhus.Actions.Boolean', name='Filter dates', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'Boolean',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      boolean: 1,
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Filter dates')),
      },
      'is',
      {
        UUID: 'B5E86AEE-B1E9-416C-94E8-E290793FC48C',
      }
    )).Then_([

      sc.Action('is.workflow.actions.detect.date', name='Date', params={
        WFInput: sc.Attach(sc.Ref('Config', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'last_sync_ts',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      }),

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Date')),
        },
        'has any value',
        {
          UUID: '32FF8BDB-EE29-4490-ACCF-28354494359F',
        }
      )).Then_([

        sc.Action('is.workflow.actions.filter.reminders', name='Reminders', params={
          WFContentItemFilter: {
            Value: {
              WFActionParameterFilterPrefix: 1,
              WFActionParameterFilterTemplates: [
                {
                  Operator: 2,
                  Property: 'Last Modified Date',
                  Removable: true,
                  Values: {
                    Date: sc.Attach(sc.Ref('Date')),
                  },
                },
              ],
              WFContentPredicateBoundedDate: false,
            },
            WFSerializationType: 'WFContentPredicateTableTemplate',
          },
          WFContentItemInputParameter: sc.Attach(sc.Ref('Date')),
        }),

        sc.Action('is.workflow.actions.setvariable', {
          WFInput: sc.Attach(sc.Ref('Reminders')),
          WFVariableName: 'Reminders',
        }),

      ]).EndIf_(),

    ]).EndIf_(),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '13FC32AD-2E75-4BE4-8D96-0EF2AB3EC6E3',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Vars.Reminders')),
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'https://lunatask.app/api/tasks-api/create',
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.GetReminderIDIntent', name='Reminder UUID', params={
      list: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'List',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }),
      reminder: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['name']),
              WFValue: sc.Str([sc.Ref('Vars.Repeat Item')]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['notes']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'Notes',
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['source']),
              WFValue: sc.Str(['Reminders']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['source_id']),
              WFValue: sc.Str([sc.Ref('Reminder UUID')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setitemname', name='Renamed Item', params={
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFName: sc.Str(['reminder-', sc.Ref('Reminder UUID')]),
    }),

    sc.Action('AsheKube.app.a-Shell-mini.PutFileIntent', {
      ShowWhenRun: false,
      file: sc.Attach(sc.Ref('Renamed Item')),
    }),

    sc.Action('AsheKube.app.a-Shell-mini.ExecuteCommandIntent', {
      ShowWhenRun: false,
      command: |||

        jq '
      |||,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '13FC32AD-2E75-4BE4-8D96-0EF2AB3EC6E3',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '4610',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -1263359489,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
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
  WFWorkflowMinimumClientVersion: 2025,
  WFWorkflowMinimumClientVersionString: '2025',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'WFWorkflowTypeShowInSearch',
    'Watch',
  ],
}
