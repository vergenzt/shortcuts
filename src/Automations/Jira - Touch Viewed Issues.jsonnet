local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: '10096',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      local outputs = super.outputs,
      WFInput: {
        Value: sc.Ref(outputs, 'Text'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'FID',
    }),

    sc.Action('is.workflow.actions.gettext', name='JQL', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{30, 1}': {
              Type: 'Variable',
              VariableName: 'FID',
            },
          },
          string: 'lastViewed is not EMPTY or cf[￼] is EMPTY',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      local outputs = super.outputs,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'method',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'GET',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'path',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'search',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 1,
              WFKey: {
                Value: {
                  string: 'params',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: {
                          Value: {
                            string: 'jql',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: sc.Val('${JQL}', outputs),
                      },
                      {
                        WFItemType: 0,
                        WFKey: {
                          Value: {
                            string: 'fields',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{31, 1}': {
                                Type: 'Variable',
                                VariableName: 'FID',
                              },
                            },
                            string: 'updated,lastViewed,customfield_￼',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                      {
                        WFItemType: 0,
                        WFKey: {
                          Value: {
                            string: 'maxResults',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            string: '1000',
                          },
                          WFSerializationType: 'WFTextTokenString',
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

    sc.Action('is.workflow.actions.runworkflow', name='Get Viewed Issues Result', params={
      local outputs = super.outputs,
      WFInput: {
        Value: sc.Ref(outputs, 'Dictionary'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local outputs = super.outputs,
      GroupingIdentifier: '6F192F82-E28B-4DA5-8E9D-3595CEE96F87',
      WFControlFlowMode: 0,
      WFInput: {
        Value: sc.Ref(outputs, 'Get Viewed Issues Result', aggs=[
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'issues',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ]),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='jq', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{57, 1}': {
              Type: 'Variable',
              VariableName: 'FID',
            },
          },
          string: '([.fields[]] | max) as $max\n| (\n  if .fields.customfield_￼ == $max\n  then empty\n  else { key, newValue: $max }\n  end\n)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      local outputs = super.outputs,
      input: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      jqQuery: sc.Val('${jq}', outputs),
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: 'FAC0F958-C6D7-4969-9830-1BE2C0B6472C',
      WFCondition: 100,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Updated',
              OutputUUID: 'B5A89EBA-AE74-4E15-A2ED-DCD19586F84E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: sc.Ref(outputs, 'Result'),
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      local outputs = super.outputs,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'method',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'PUT',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'path',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': sc.Ref(outputs, 'Result', aggs=[
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'key',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ]),
                  },
                  string: 'issue/￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 1,
              WFKey: {
                Value: {
                  string: 'json',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 1,
                        WFKey: {
                          Value: {
                            string: 'fields',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            Value: {
                              WFDictionaryFieldValueItems: [
                                {
                                  WFItemType: 0,
                                  WFKey: {
                                    Value: {
                                      attachmentsByRange: {
                                        '{12, 1}': {
                                          Type: 'Variable',
                                          VariableName: 'FID',
                                        },
                                      },
                                      string: 'customfield_￼',
                                    },
                                    WFSerializationType: 'WFTextTokenString',
                                  },
                                  WFValue: sc.Val('${Result}', outputs),
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

    sc.Action('is.workflow.actions.runworkflow', name='Shortcut Result', params={
      local outputs = super.outputs,
      WFInput: {
        Value: sc.Ref(outputs, 'Dictionary'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      local outputs = super.outputs,
      WFInput: {
        Value: sc.Ref(outputs, 'Shortcut Result'),
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Updated Issues',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FAC0F958-C6D7-4969-9830-1BE2C0B6472C',
      UUID: '8D9F8B76-6DCE-4FE1-9947-0DA9AECC8CCE',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '6F192F82-E28B-4DA5-8E9D-3595CEE96F87',
      UUID: '93C52995-3225-47BD-9DAE-68B78165FCC5',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          Type: 'Variable',
          VariableName: 'Updated Issues',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      UUID: '23180042-1F8E-4EC8-A828-ED3315DF5F7D',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '732DECE0-5E84-43B1-A972-8FEC52FECF86',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Count',
            OutputUUID: '23180042-1F8E-4EC8-A828-ED3315DF5F7D',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.notification', {
      UUID: '3944118D-3424-4F5F-870F-4FAD5931EB7E',
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{8, 1}': {
              OutputName: 'Count',
              OutputUUID: '23180042-1F8E-4EC8-A828-ED3315DF5F7D',
              Type: 'ActionOutput',
            },
          },
          string: 'Updated ￼ issues',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '732DECE0-5E84-43B1-A972-8FEC52FECF86',
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
  WFWorkflowTypes: [],
}
