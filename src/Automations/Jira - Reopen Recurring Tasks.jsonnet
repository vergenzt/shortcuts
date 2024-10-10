local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Empty Dictionary'),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Constants', params={
      keyPath: 'Jira - Reopen Recurring Tasks',
    }),

    sc.Action('is.workflow.actions.urlencode', name='JQL', params={
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Constants', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'Filter: Recurring Tasks',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼ and status = Done',
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
              WFKey: sc.Str(['method']),
              WFValue: sc.Str(['GET']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['path']),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{11, 1}': sc.Ref('JQL'),
                  },
                  string: 'search?jql=￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Search Issues Result', params={
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'AE423FC4-1D2B-4E43-AA6F-8E7BEDAEAFAB',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Search Issues Result', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'issues',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['method']),
              WFValue: sc.Str(['POST']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['path']),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'key',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: 'issue/￼/transitions',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 1,
              WFKey: sc.Str(['json']),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 1,
                        WFKey: sc.Str(['transition']),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 0,
                                  WFKey: sc.Str(['id']),
                                  WFValue: sc.Str([sc.Ref('Constants', aggs=[
                                    {
                                      CoercionItemClass: 'WFDictionaryContentItem',
                                      Type: 'WFCoercionVariableAggrandizement',
                                    },
                                    {
                                      DictionaryKey: 'Transition: Waiting For',
                                      Type: 'WFDictionaryValueVariableAggrandizement',
                                    },
                                  ])]),
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Reopen Basis Option ID', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref('Constants', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'Field: Reopen Basis',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'fields.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Reopen Delay', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref('Constants', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'Field: Reopen Delay',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'fields.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Reopen Basis Field Key', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref('Reopen Basis Option ID', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'id',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'Basis: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Attach(sc.Ref('Constants')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Reopen Basis Field Value', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref('Reopen Basis Field Key'),
          },
          string: 'fields.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.detect.date', name='Reopen Basis Date', params={
      WFInput: sc.Attach(sc.Ref('Reopen Basis Field Value')),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='New Start Date', params={
      WFDate: sc.Str([sc.Ref('Reopen Basis Date')]),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref('Reopen Delay'),
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str([sc.Ref('Constants', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'Field: Start Date',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ])]),
              WFValue: sc.Str([sc.Ref('New Start Date', aggs=[
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'ISO 8601',
                  WFISO8601IncludeTime: false,
                },
              ])]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'New Field Values',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Due Date', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref('Constants', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'Field: Due Date',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'fields.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Start Date', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref('Constants', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'Field: Start Date',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'fields.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '45D68504-844B-4442-A6C9-E2A4C53E75BC',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Due Date')),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4EBACF8B-4223-4128-B956-2E3076C9EF95',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Start Date')),
      },
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      WFInput: sc.Str([sc.Ref('Due Date')]),
      WFTimeUntilFromDate: sc.Str([sc.Ref('Start Date')]),
      WFTimeUntilUnit: 'Days',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='New Due Date', params={
      WFDate: sc.Str([sc.Ref('New Start Date')]),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref('Time Between Dates'),
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Vars.New Field Values')),
      WFDictionaryKey: sc.Str([sc.Ref('Constants', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'Field: Due Date',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFDictionaryValue: sc.Str([sc.Ref('New Due Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'ISO 8601',
          WFISO8601IncludeTime: false,
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'New Field Values',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4EBACF8B-4223-4128-B956-2E3076C9EF95',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '45D68504-844B-4442-A6C9-E2A4C53E75BC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Issue Edit Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['method']),
              WFValue: sc.Str(['PUT']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['path']),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'key',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: 'issue/￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Fields Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Empty Dictionary')),
      WFDictionaryKey: 'fields',
      WFDictionaryValue: sc.Str([sc.Ref('Vars.New Field Values')]),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Issue Edit Dictionary')),
      WFDictionaryKey: 'json',
      WFDictionaryValue: sc.Str([sc.Ref('Fields Dictionary')]),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'AE423FC4-1D2B-4E43-AA6F-8E7BEDAEAFAB',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -1448498689,
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
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'Watch',
  ],
}
