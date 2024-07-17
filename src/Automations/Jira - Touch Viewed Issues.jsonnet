local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: '10096',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Text', att=true),
      WFVariableName: 'FID',
    }),

    sc.Action('is.workflow.actions.gettext', name='JQL', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{30, 1}': function(state) sc.Ref(state, 'Vars.FID'),
          },
          string: 'lastViewed is not EMPTY or cf[￼] is EMPTY',
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
              WFKey: sc.Val('method'),
              WFValue: sc.Val('GET'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('path'),
              WFValue: sc.Val('search'),
            },
            {
              WFItemType: 1,
              WFKey: sc.Val('params'),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('jql'),
                        WFValue: function(state) sc.Val('${JQL}', state),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('fields'),
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{31, 1}': function(state) sc.Ref(state, 'Vars.FID'),
                            },
                            string: 'updated,lastViewed,customfield_￼',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('maxResults'),
                        WFValue: sc.Val('1000'),
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
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '6F192F82-E28B-4DA5-8E9D-3595CEE96F87',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Get Viewed Issues Result', aggs=[
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

    sc.Action('is.workflow.actions.gettext', name='jq', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{57, 1}': function(state) sc.Ref(state, 'Vars.FID'),
          },
          string: '([.fields[]] | max) as $max\n| (\n  if .fields.customfield_￼ == $max\n  then empty\n  else { key, newValue: $max }\n  end\n)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      jqQuery: function(state) sc.Val('${jq}', state),
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FAC0F958-C6D7-4969-9830-1BE2C0B6472C',
      WFCondition: 100,
      WFConditionalActionString: function(state) sc.Val('${Updated}', state),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Result', att=true),
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
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
                    '{6, 1}': function(state) sc.Ref(state, 'Result', aggs=[
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
                                  WFItemType: 0,
                                  WFKey: {
                                    Value: {
                                      attachmentsByRange: {
                                        '{12, 1}': function(state) sc.Ref(state, 'Vars.FID'),
                                      },
                                      string: 'customfield_￼',
                                    },
                                    WFSerializationType: 'WFTextTokenString',
                                  },
                                  WFValue: function(state) sc.Val('${Result}', state),
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
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'Shortcut Result', att=true),
      WFVariableName: 'Updated Issues',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FAC0F958-C6D7-4969-9830-1BE2C0B6472C',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '6F192F82-E28B-4DA5-8E9D-3595CEE96F87',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: function(state) sc.Ref(state, 'Vars.Updated Issues', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '732DECE0-5E84-43B1-A972-8FEC52FECF86',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Count', att=true),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.notification', {
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{8, 1}': function(state) sc.Ref(state, 'Count'),
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
