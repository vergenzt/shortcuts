local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Empty Dictionary'),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Constants', params={
      local state = super.state,
      keyPath: 'Jira - Reopen Recurring Tasks',
    }),

    sc.Action('is.workflow.actions.urlencode', name='JQL', params={
      local state = super.state,
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Constants', aggs=[
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
      local state = super.state,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('method'),
              WFValue: sc.Val('GET'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('path'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{11, 1}': sc.Ref(state, 'JQL'),
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
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: 'AE423FC4-1D2B-4E43-AA6F-8E7BEDAEAFAB',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Search Issues Result', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'issues',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ], att=true),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      local state = super.state,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('method'),
              WFValue: sc.Val('POST'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('path'),
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
              WFKey: sc.Val('json'),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 1,
                        WFKey: sc.Val('transition'),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 0,
                                  WFKey: sc.Val('id'),
                                  WFValue: sc.Val('${Constants}', state),
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
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Reopen Basis Option ID', params={
      local state = super.state,
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref(state, 'Constants', aggs=[
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
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Reopen Delay', params={
      local state = super.state,
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref(state, 'Constants', aggs=[
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
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Reopen Basis Field Key', params={
      local state = super.state,
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref(state, 'Reopen Basis Option ID', aggs=[
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
      WFInput: sc.Ref(state, 'Constants', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Reopen Basis Field Value', params={
      local state = super.state,
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref(state, 'Reopen Basis Field Key'),
          },
          string: 'fields.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.detect.date', name='Reopen Basis Date', params={
      local state = super.state,
      WFInput: sc.Ref(state, 'Reopen Basis Field Value', att=true),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='New Start Date', params={
      local state = super.state,
      WFDate: sc.Val('${Reopen Basis Date}', state),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref(state, 'Reopen Delay'),
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      local state = super.state,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('${Constants}', state),
              WFValue: sc.Val('${New Start Date}', state),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'New Field Values',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Due Date', params={
      local state = super.state,
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref(state, 'Constants', aggs=[
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
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Start Date', params={
      local state = super.state,
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{7, 1}': sc.Ref(state, 'Constants', aggs=[
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
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '45D68504-844B-4442-A6C9-E2A4C53E75BC',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Due Date', att=true),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '4EBACF8B-4223-4128-B956-2E3076C9EF95',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Start Date', att=true),
      },
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      local state = super.state,
      WFInput: sc.Val('${Due Date}', state),
      WFTimeUntilFromDate: sc.Val('${Start Date}', state),
      WFTimeUntilUnit: 'Days',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='New Due Date', params={
      local state = super.state,
      WFDate: sc.Val('${New Start Date}', state),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref(state, 'Time Between Dates'),
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      local state = super.state,
      WFDictionary: sc.Ref(state, 'Vars.New Field Values', att=true),
      WFDictionaryKey: sc.Val('${Constants}', state),
      WFDictionaryValue: sc.Val('${New Due Date}', state),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'New Field Values',
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '4EBACF8B-4223-4128-B956-2E3076C9EF95',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '45D68504-844B-4442-A6C9-E2A4C53E75BC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Issue Edit Dictionary', params={
      local state = super.state,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('method'),
              WFValue: sc.Val('PUT'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('path'),
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
      local state = super.state,
      WFDictionary: sc.Ref(state, 'Empty Dictionary', att=true),
      WFDictionaryKey: 'fields',
      WFDictionaryValue: sc.Val('${Vars.New Field Values}', state),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      local state = super.state,
      WFDictionary: sc.Ref(state, 'Issue Edit Dictionary', att=true),
      WFDictionaryKey: 'json',
      WFDictionaryValue: sc.Val('${Fields Dictionary}', state),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
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
  WFWorkflowTypes: [],
}
