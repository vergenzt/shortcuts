local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Empty Dictionary'),

    sc.Action('is.workflow.actions.detect.dictionary', name='Input As Dict', params={
      WFInput: {
        Value: sc.Input,
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref('Input As Dict', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: 'issue_key',
      WFInput: sc.Ref('Input As Dict', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      WFInput: sc.Str([sc.Input]),
      WFReplaceTextFind: '.*\\b([A-Z]+-[1-9][0-9]*)\\b.*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1',
    }),

    sc.Action('is.workflow.actions.conditional', name='Issue key', params={
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '1D9BEA05-EA73-49E7-A495-B0566729ABA0',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref('Issue key', att=true),
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Ref('Issue key', att=true),
      WFNotificationActionBody: 'No issue key provided!',
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '1D9BEA05-EA73-49E7-A495-B0566729ABA0',
      WFControlFlowMode: 2,
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: 'jira-config.issueLinkTypes',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Link Type IDs by Inward String', params={
      input: sc.Ref('Value', att=true),
      jqQuery: '.issueLinkTypes | map(select(.name | contains("*") | not) | { key: .inward, value: { id, name } }) | from_entries',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen String', params={
      WFChooseFromListActionPrompt: "What's the relationship?",
      WFInput: sc.Ref('Link Type IDs by Inward String', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          PropertyName: 'Keys',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ], att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Link Type', params={
      WFDictionaryKey: sc.Str([sc.Ref('Chosen String')]),
      WFInput: sc.Ref('Link Type IDs by Inward String', att=true),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Link Type Name', params={
      WFInput: sc.Str([sc.Ref('Link Type', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'name',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFReplaceTextFind: '^[\\d\\*\\. ]*',
      WFReplaceTextRegularExpression: true,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['path']),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': sc.Ref('Issue key'),
                  },
                  string: 'issue/￼?fields=summary,parent',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['method']),
              WFValue: sc.Str(['GET']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Origin Issue', params={
      WFInput: sc.Ref('Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.ask', name='New Issue Summary', params={
      WFAllowsMultilineText: false,
      WFAskActionDefaultAnswer: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Link Type Name'),
            '{5, 1}': sc.Ref('Origin Issue', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'fields.summary',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼ to ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: 'What’s the connected issue summary?',
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: sc.Ref('New Issue Summary', att=true),
    }),

    sc.Action('is.workflow.actions.text.replace', {
      WFInput: sc.Str([sc.Ref('New Issue Summary')]),
      WFReplaceTextFind: '"',
      WFReplaceTextReplace: '\\"',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Create Issue Request', params={
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
              WFValue: sc.Str(['issue']),
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
                        WFKey: sc.Str(['fields']),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 1,
                                  WFKey: sc.Str(['project']),
                                  WFValue: {
                                    Value: {
                                      Value: {
                                        WFDictionaryFieldValueItems: [
                                          {
                                            WFItemType: 0,
                                            WFKey: sc.Str(['key']),
                                            WFValue: sc.Str(['TIM']),
                                          },
                                        ],
                                      },
                                      WFSerializationType: 'WFDictionaryFieldValue',
                                    },
                                    WFSerializationType: 'WFDictionaryFieldValue',
                                  },
                                },
                                {
                                  WFItemType: 1,
                                  WFKey: sc.Str(['issuetype']),
                                  WFValue: {
                                    Value: {
                                      Value: {
                                        WFDictionaryFieldValueItems: [
                                          {
                                            WFItemType: 0,
                                            WFKey: sc.Str(['name']),
                                            WFValue: sc.Str(['Task']),
                                          },
                                        ],
                                      },
                                      WFSerializationType: 'WFDictionaryFieldValue',
                                    },
                                    WFSerializationType: 'WFDictionaryFieldValue',
                                  },
                                },
                                {
                                  WFItemType: 0,
                                  WFKey: sc.Str(['summary']),
                                  WFValue: sc.Str([sc.Ref('New Issue Summary')]),
                                },
                                {
                                  WFItemType: 1,
                                  WFKey: sc.Str(['parent']),
                                  WFValue: {
                                    Value: {
                                      Value: {
                                        WFDictionaryFieldValueItems: [
                                          {
                                            WFItemType: 0,
                                            WFKey: sc.Str(['key']),
                                            WFValue: sc.Str([sc.Ref('Origin Issue', aggs=[
                                              {
                                                CoercionItemClass: 'WFDictionaryContentItem',
                                                Type: 'WFCoercionVariableAggrandizement',
                                              },
                                              {
                                                DictionaryKey: 'fields.parent.key',
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
                      {
                        WFItemType: 1,
                        WFKey: sc.Str(['update']),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 2,
                                  WFKey: sc.Str(['issuelinks']),
                                  WFValue: {
                                    Value: [
                                      {
                                        WFItemType: 1,
                                        WFValue: {
                                          Value: {
                                            Value: {
                                              WFDictionaryFieldValueItems: [
                                                {
                                                  WFItemType: 1,
                                                  WFKey: sc.Str(['add']),
                                                  WFValue: {
                                                    Value: {
                                                      Value: {
                                                        WFDictionaryFieldValueItems: [
                                                          {
                                                            WFItemType: 1,
                                                            WFKey: sc.Str(['type']),
                                                            WFValue: {
                                                              Value: {
                                                                Value: {
                                                                  WFDictionaryFieldValueItems: [
                                                                    {
                                                                      WFItemType: 0,
                                                                      WFKey: sc.Str(['id']),
                                                                      WFValue: sc.Str([sc.Ref('Link Type', aggs=[
                                                                        {
                                                                          CoercionItemClass: 'WFDictionaryContentItem',
                                                                          Type: 'WFCoercionVariableAggrandizement',
                                                                        },
                                                                        {
                                                                          DictionaryKey: 'id',
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
                                                          {
                                                            WFItemType: 1,
                                                            WFKey: sc.Str(['outwardIssue']),
                                                            WFValue: {
                                                              Value: {
                                                                Value: {
                                                                  WFDictionaryFieldValueItems: [
                                                                    {
                                                                      WFItemType: 0,
                                                                      WFKey: sc.Str(['key']),
                                                                      WFValue: sc.Str([sc.Ref('Issue key')]),
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
                                          WFSerializationType: 'WFDictionaryFieldValue',
                                        },
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Create Issue Result', params={
      WFInput: sc.Ref('Create Issue Request', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getdevicedetails', {
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Ref('Empty Dictionary', att=true),
      WFDictionaryKey: 'issue',
      WFDictionaryValue: sc.Str([sc.Ref('Create Issue Result', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Ref('Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'DE45228B-5A30-4A30-AF37-DA40929C57C2',
        workflowName: 'Jira - Prompt to Review',
      },
      WFWorkflowName: 'Jira - Prompt to Review',
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -615917313,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFStringContentItem',
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
    'MenuBar',
    'QuickActions',
    'ReceivesOnScreenContent',
  ],
}
