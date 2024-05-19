local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Empty Dictionary'),

    sc.Action('is.workflow.actions.detect.dictionary', name='Input As Dict', params={
      WFInput: sc.Ref(outputs, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Input As Dict', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      local outputs = super.outputs,
      WFDictionaryKey: 'issue_key',
      WFInput: sc.Ref(outputs, 'Input As Dict', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      WFInput: sc.Val('${Shortcut Input}', outputs),
      WFReplaceTextFind: '.*\\b([A-Z]+-[1-9][0-9]*)\\b.*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1',
    }),

    sc.Action('is.workflow.actions.conditional', name='Issue key', params={
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      local outputs = super.outputs,
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
                    '{6, 1}': sc.Ref(outputs, 'Issue key'),
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

    sc.Action('is.workflow.actions.runworkflow', name='Get Initial Issue Response', params={
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Initial Issue Key', params={
      local outputs = super.outputs,
      WFDictionaryKey: 'key',
      WFInput: sc.Ref(outputs, 'Get Initial Issue Response', att=true),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
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
              WFValue: sc.Val('issueLinkType'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Get Link Types Result', params={
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Link Type IDs by Inward String', params={
      local outputs = super.outputs,
      input: sc.Ref(outputs, 'Get Link Types Result', att=true),
      jqQuery: '.issueLinkTypes | map(select(.name | contains("*") | not) | { key: .inward, value: .id }) | from_entries',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen String', params={
      local outputs = super.outputs,
      WFChooseFromListActionPrompt: "What's the relationship?",
      WFInput: sc.Ref(outputs, 'Link Type IDs by Inward String', aggs=[
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

    sc.Action('is.workflow.actions.getvalueforkey', name='Link Type ID', params={
      local outputs = super.outputs,
      WFDictionaryKey: sc.Val('${Chosen String}', outputs),
      WFInput: sc.Ref(outputs, 'Link Type IDs by Inward String', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='fields.summary', params={
      local outputs = super.outputs,
      WFDictionaryKey: 'fields.summary',
      WFInput: sc.Ref(outputs, 'Get Initial Issue Response', att=true),
    }),

    sc.Action('is.workflow.actions.ask', name='New Issue Summary', params={
      local outputs = super.outputs,
      WFAllowsMultilineText: false,
      WFAskActionDefaultAnswer: {
        Value: {
          attachmentsByRange: {
            '{19, 1}': sc.Ref(outputs, 'fields.summary'),
          },
          string: 'Issue connected to ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: 'What’s the connected issue summary?',
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'New Issue Summary', att=true),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Quoted New Issue Summary', params={
      local outputs = super.outputs,
      WFInput: sc.Val('${New Issue Summary}', outputs),
      WFReplaceTextFind: '"',
      WFReplaceTextReplace: '\\"',
    }),

    sc.Action('is.workflow.actions.gettext', name='Query', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{144, 1}': sc.Ref(outputs, 'Quoted New Issue Summary'),
            '{323, 1}': sc.Ref(outputs, 'Link Type ID'),
            '{361, 1}': sc.Ref(outputs, 'Initial Issue Key'),
          },
          string: '{\n  method: "POST",\n  path: "issue",\n  json: {\n    fields: ({\n      project: { key: "TIM" },\n      issuetype: { name: "Task" },\n      summary: "￼"\n    } + (\n      if .fields.parent then (.fields | { parent } | .parent |= { key }) else {} end\n    )),\n    update: {\n      issuelinks: [{\n        add: {\n          type: { id: "￼" },\n          outwardIssue: { key: "￼" },\n        }\n      }]\n    }\n  }\n}',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Create Issue Request', params={
      local outputs = super.outputs,
      input: sc.Ref(outputs, 'Get Initial Issue Response', att=true),
      jqQuery: sc.Val('${Query}', outputs),
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.dictionary', {
      local outputs = super.outputs,
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
                                  WFValue: sc.Val('${New Issue Summary}', outputs),
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
                                            WFValue: sc.Val('${Get Initial Issue Response}', outputs),
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
                                                                      WFValue: sc.Val('${Link Type ID}', outputs),
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
                                                                      WFValue: sc.Val('${Initial Issue Key}', outputs),
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
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Create Issue Request', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      local outputs = super.outputs,
      WFDictionary: sc.Ref(outputs, 'Empty Dictionary', att=true),
      WFDictionaryKey: 'issue',
      WFDictionaryValue: sc.Val('${Create Issue Result}', outputs),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: 'D4AC72F2-B4A7-45F9-9E9D-E4664B6D9B83',
      WFCondition: 5,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Device Model', att=true),
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'DE45228B-5A30-4A30-AF37-DA40929C57C2',
        workflowName: 'Jira - Prompt to Review',
      },
      WFWorkflowName: 'Jira - Prompt to Review',
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: '0ADD3BA5-12CD-4D5E-8562-1FF5ACE0856B',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Input As Dict', aggs=[
          {
            DictionaryKey: 'skip_base_rereview',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ], att=true),
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('review_prompt_optional'),
              WFValue: sc.Val('Review initial issue one more time?'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      local outputs = super.outputs,
      WFDictionary: sc.Ref(outputs, 'Dictionary', att=true),
      WFDictionaryKey: 'issue',
      WFDictionaryValue: sc.Val('${Get Initial Issue Response}', outputs),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'DE45228B-5A30-4A30-AF37-DA40929C57C2',
        workflowName: 'Jira - Prompt to Review',
      },
      WFWorkflowName: 'Jira - Prompt to Review',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0ADD3BA5-12CD-4D5E-8562-1FF5ACE0856B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D4AC72F2-B4A7-45F9-9E9D-E4664B6D9B83',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      local outputs = super.outputs,
      WFDictionary: sc.Ref(outputs, 'Dictionary', att=true),
      WFDictionaryKey: 'skip_return',
      WFDictionaryValue: 'true',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'DE45228B-5A30-4A30-AF37-DA40929C57C2',
        workflowName: 'Jira - Prompt to Review',
      },
      WFWorkflowName: 'Jira - Prompt to Review',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D4AC72F2-B4A7-45F9-9E9D-E4664B6D9B83',
      WFControlFlowMode: 2,
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
    'ReceivesOnScreenContent',
  ],
}
