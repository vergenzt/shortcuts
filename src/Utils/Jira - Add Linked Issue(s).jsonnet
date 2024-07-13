local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Empty Dictionary'),

    sc.Action('is.workflow.actions.detect.dictionary', name='Input As Dict', params={
      local state = super.state,
      WFInput: sc.Ref(state, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Input As Dict', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      local state = super.state,
      WFDictionaryKey: 'issue_key',
      WFInput: sc.Ref(state, 'Input As Dict', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      local state = super.state,
      WFInput: sc.Val('${Shortcut Input}', state),
      WFReplaceTextFind: '.*\\b([A-Z]+-[1-9][0-9]*)\\b.*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1',
    }),

    sc.Action('is.workflow.actions.conditional', name='Issue key', params={
      local state = super.state,
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '1D9BEA05-EA73-49E7-A495-B0566729ABA0',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Issue key', att=true),
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Issue key', att=true),
      WFNotificationActionBody: 'No issue key provided!',
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '1D9BEA05-EA73-49E7-A495-B0566729ABA0',
      WFControlFlowMode: 2,
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      local state = super.state,
      keyPath: 'jira-config.issueLinkTypes',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Link Type IDs by Inward String', params={
      local state = super.state,
      input: sc.Ref(state, 'Value', att=true),
      jqQuery: '.issueLinkTypes | map(select(.name | contains("*") | not) | { key: .inward, value: { id, name } }) | from_entries',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen String', params={
      local state = super.state,
      WFChooseFromListActionPrompt: "What's the relationship?",
      WFInput: sc.Ref(state, 'Link Type IDs by Inward String', aggs=[
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
      local state = super.state,
      WFDictionaryKey: sc.Val('${Chosen String}', state),
      WFInput: sc.Ref(state, 'Link Type IDs by Inward String', att=true),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Link Type Name', params={
      local state = super.state,
      WFInput: sc.Val('${Link Type}', state),
      WFReplaceTextFind: '^[\\d\\*\\. ]*',
      WFReplaceTextRegularExpression: true,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      local state = super.state,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('path'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': sc.Ref(state, 'Issue key'),
                  },
                  string: 'issue/￼?fields=summary,parent',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('method'),
              WFValue: sc.Val('GET'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Origin Issue', params={
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.ask', name='New Issue Summary', params={
      local state = super.state,
      WFAllowsMultilineText: false,
      WFAskActionDefaultAnswer: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Link Type Name'),
            '{5, 1}': sc.Ref(state, 'Origin Issue', aggs=[
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
      local state = super.state,
      WFInput: sc.Ref(state, 'New Issue Summary', att=true),
    }),

    sc.Action('is.workflow.actions.text.replace', {
      local state = super.state,
      WFInput: sc.Val('${New Issue Summary}', state),
      WFReplaceTextFind: '"',
      WFReplaceTextReplace: '\\"',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Create Issue Request', params={
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
              WFValue: sc.Val('issue'),
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
                        WFKey: sc.Val('fields'),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 1,
                                  WFKey: sc.Val('project'),
                                  WFValue: {
                                    Value: {
                                      Value: {
                                        WFDictionaryFieldValueItems: [
                                          {
                                            WFItemType: 0,
                                            WFKey: sc.Val('key'),
                                            WFValue: sc.Val('TIM'),
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
                                  WFKey: sc.Val('issuetype'),
                                  WFValue: {
                                    Value: {
                                      Value: {
                                        WFDictionaryFieldValueItems: [
                                          {
                                            WFItemType: 0,
                                            WFKey: sc.Val('name'),
                                            WFValue: sc.Val('Task'),
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
                                  WFKey: sc.Val('summary'),
                                  WFValue: sc.Val('${New Issue Summary}', state),
                                },
                                {
                                  WFItemType: 1,
                                  WFKey: sc.Val('parent'),
                                  WFValue: {
                                    Value: {
                                      Value: {
                                        WFDictionaryFieldValueItems: [
                                          {
                                            WFItemType: 0,
                                            WFKey: sc.Val('key'),
                                            WFValue: sc.Val('${Origin Issue}', state),
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
                        WFKey: sc.Val('update'),
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 2,
                                  WFKey: sc.Val('issuelinks'),
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
                                                  WFKey: sc.Val('add'),
                                                  WFValue: {
                                                    Value: {
                                                      Value: {
                                                        WFDictionaryFieldValueItems: [
                                                          {
                                                            WFItemType: 1,
                                                            WFKey: sc.Val('type'),
                                                            WFValue: {
                                                              Value: {
                                                                Value: {
                                                                  WFDictionaryFieldValueItems: [
                                                                    {
                                                                      WFItemType: 0,
                                                                      WFKey: sc.Val('id'),
                                                                      WFValue: sc.Val('${Link Type}', state),
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
                                                            WFKey: sc.Val('outwardIssue'),
                                                            WFValue: {
                                                              Value: {
                                                                Value: {
                                                                  WFDictionaryFieldValueItems: [
                                                                    {
                                                                      WFItemType: 0,
                                                                      WFKey: sc.Val('key'),
                                                                      WFValue: sc.Val('${Issue key}', state),
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
      local state = super.state,
      WFInput: sc.Ref(state, 'Create Issue Request', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getdevicedetails', {
      local state = super.state,
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      local state = super.state,
      WFDictionary: sc.Ref(state, 'Empty Dictionary', att=true),
      WFDictionaryKey: 'issue',
      WFDictionaryValue: sc.Val('${Create Issue Result}', state),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
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