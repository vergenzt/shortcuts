local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'db',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }),
      WFVariableName: 'db',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'query',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }),
      WFVariableName: 'query',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'params',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }),
      WFVariableName: 'params',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.params')),
      },
      'has any value'
    )).Then_([

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'DF98410F-AE88-40E0-A3FB-D049469E195E',
        WFControlFlowMode: 0,
        WFInput: sc.Attach({
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              PropertyName: 'Keys',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'params',
        }),
      }),

      sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
        WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item')]),
        WFInput: sc.Attach(sc.Ref('Vars.params')),
      }),

      sc.Action('is.workflow.actions.dictionary', {
        WFItems: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 0,
                WFKey: sc.Str(['fmt']),
                WFValue: sc.Str(['(${name}, ${value})']),
              },
              {
                WFItemType: 1,
                WFKey: sc.Str(['params']),
                WFValue: {
                  Value: {
                    Value: {
                      WFDictionaryFieldValueItems: [
                        {
                          WFItemType: 0,
                          WFKey: sc.Str(['name']),
                          WFValue: sc.Str([sc.Ref('Vars.Repeat Item')]),
                        },
                        {
                          WFItemType: 0,
                          WFKey: sc.Str(['value']),
                          WFValue: sc.Str([sc.Ref('Dictionary Value')]),
                        },
                      ],
                    },
                    WFSerializationType: 'WFDictionaryFieldValue',
                  },
                  WFSerializationType: 'WFDictionaryFieldValue',
                },
              },
            ],
          },
          WFSerializationType: 'WFDictionaryFieldValue',
        },
      }),

      sc.Action('is.workflow.actions.repeat.each', name='Param Vals ', params={
        GroupingIdentifier: 'DF98410F-AE88-40E0-A3FB-D049469E195E',
        WFControlFlowMode: 2,
      }),

      sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
        WFTextCustomSeparator: ', ',
        WFTextSeparator: 'Custom',
        text: sc.Attach(sc.Ref('Param Vals ')),
      }),

      sc.Action('is.workflow.actions.gettext', name='Params Setup', params={
        WFTextActionText: {
          Value: {
            attachmentsByRange: {
              '{88, 1}': sc.Ref('Combined Text'),
            },
            string: |||
              create temp table params (name text primary key, value any);

                insert into params values ￼;
            |||,
          },
          WFSerializationType: 'WFTextTokenString',
        },
      }),

      sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
        WFItems: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 0,
                WFKey: sc.Str(['fmt']),
                WFValue: sc.Str([sc.Ref('Vars.query')]),
              },
              {
                WFItemType: 0,
                WFKey: sc.Str(['esc']),
                WFValue: sc.Str(['SQLite Get Param']),
              },
            ],
          },
          WFSerializationType: 'WFDictionaryFieldValue',
        },
      }),

      sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
        WFDictionary: sc.Attach(sc.Ref('Dictionary')),
        WFDictionaryKey: 'params',
        WFDictionaryValue: sc.Str([sc.Ref('Vars.params')]),
      }),

      sc.Action('is.workflow.actions.runworkflow', name='Formatted Query', params={
        WFInput: sc.Attach(sc.Ref('Dictionary')),
        WFWorkflow: {
          isSelf: false,
          workflowIdentifier: 'FEE8ADF9-6451-405B-B87D-C6363D62D345',
          workflowName: 'Format String',
        },
        WFWorkflowName: 'Format String',
      }),

      sc.Action('is.workflow.actions.gettext', {
        WFTextActionText: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': sc.Ref('Params Setup'),
              '{2, 1}': sc.Ref('Formatted Query'),
            },
            string: |||
              ￼
                ￼
            |||,
          },
          WFSerializationType: 'WFTextTokenString',
        },
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.getvariable', {
        WFVariable: sc.Attach(sc.Ref('Vars.query')),
      }),

    ]).EndIf_(name='Formatted Query'),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
      'is',
      {
        WFConditionalActionString: 'Mac',
      }
    )).Then_([

    ]).Else_([

      sc.Action('net.filippomaguolo.SQLiteMobile.RunScript2Intent', {
        formatterHtml: 'raw',
        outputFormat: 'json',
        sql: sc.Str([sc.Ref('Formatted Query')]),
        sqliteDatabaseName: sc.Attach(sc.Ref('Vars.db')),
      }),

    ]).EndIf_(),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -43634177,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
