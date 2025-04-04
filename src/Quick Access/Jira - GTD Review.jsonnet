local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', {
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '410F7B2D-3951-4BAE-A70D-514A8986662E',
        workflowName: 'Google OAuth',
      },
      WFWorkflowName: 'Google OAuth',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: 'jira-config',
    }),

    sc.Action('is.workflow.actions.url', {
      WFURLActionURL: sc.Str(['https://sheets.googleapis.com/v4/spreadsheets/', sc.Ref('Value', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'spreadsheet_id',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ]), '/values']),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Filters by First Issue Age', params={
      keyPath: 'jira-cache.Filters & Issues by First Issue Age',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D61B3F28-18FE-47C0-87CB-8F871024AFE9',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Filters by First Issue Age', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.detect.dictionary', name='Filter Description Dictionary', params={
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'description',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E0CA601A-6D60-4670-B03D-08FB3BEAA176',
      WFControlFlowMode: 0,
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'issues',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }),
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
              WFValue: sc.Str(['jql/match']),
            },
            {
              WFItemType: 1,
              WFKey: sc.Str(['json']),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 2,
                        WFKey: sc.Str(['issueIds']),
                        WFValue: {
                          Value: [
                            {
                              WFItemType: 3,
                              WFValue: sc.Str([{
                                Aggrandizements: [
                                  {
                                    CoercionItemClass: 'WFDictionaryContentItem',
                                    Type: 'WFCoercionVariableAggrandizement',
                                  },
                                  {
                                    DictionaryKey: 'id',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item 2',
                              }]),
                            },
                          ],
                          WFSerializationType: 'WFArrayParameterState',
                        },
                      },
                      {
                        WFItemType: 2,
                        WFKey: sc.Str(['jqls']),
                        WFValue: {
                          Value: [
                            {
                              WFItemType: 0,
                              WFValue: sc.Str([{
                                Aggrandizements: [
                                  {
                                    CoercionItemClass: 'WFDictionaryContentItem',
                                    Type: 'WFCoercionVariableAggrandizement',
                                  },
                                  {
                                    DictionaryKey: 'jql',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
                              }]),
                            },
                          ],
                          WFSerializationType: 'WFArrayParameterState',
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

    sc.Action('is.workflow.actions.runworkflow', name='JQL Matches', params={
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: sc.Attach(sc.Ref('JQL Matches', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])),
      jqQuery: '.matches[].matchedIssues[]',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'DDA9A0FE-3ABA-4A9B-A939-1777995CE8E9',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Result', aggs=[
          {
            CoercionItemClass: 'WFNumberContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['review_prompt']),
              WFValue: sc.Str([sc.Ref('Filter Description Dictionary', aggs=[
                {
                  DictionaryKey: 'prompt',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ])]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['progress_info']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'name',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }, ' (', sc.Ref('Vars.Repeat Index 2')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Dictionary')),
      WFDictionaryKey: 'filter',
      WFDictionaryValue: sc.Str([sc.Ref('Vars.Repeat Item')]),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Dictionary')),
      WFDictionaryKey: 'issue',
      WFDictionaryValue: sc.Str([{
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item 2',
      }]),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'DE45228B-5A30-4A30-AF37-DA40929C57C2',
        workflowName: 'Jira - Prompt to Review',
      },
      WFWorkflowName: 'Jira - Prompt to Review',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A334B26F-D55D-429E-9239-81E9A45C3671',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Filter Description Dictionary', aggs=[
          {
            DictionaryKey: 'skip_add_connected_issues',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A334B26F-D55D-429E-9239-81E9A45C3671',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'DDA9A0FE-3ABA-4A9B-A939-1777995CE8E9',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E0CA601A-6D60-4670-B03D-08FB3BEAA176',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D61B3F28-18FE-47C0-87CB-8F871024AFE9',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -2873601,
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
    'MenuBar',
    'Watch',
  ],
}
