local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: '10096',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'FID',
    }),

    sc.Action('is.workflow.actions.gettext', name='JQL', params={
      WFTextActionText: sc.Str(['lastViewed is not EMPTY or cf[', sc.Ref('Vars.FID'), '] is EMPTY']),
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
              WFValue: sc.Str(['search']),
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
                        WFKey: sc.Str(['jql']),
                        WFValue: sc.Str([sc.Ref('JQL')]),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['fields']),
                        WFValue: sc.Str(['updated,lastViewed,customfield_', sc.Ref('Vars.FID')]),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['maxResults']),
                        WFValue: sc.Str(['1000']),
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
      WFInput: sc.Attach(sc.Ref('Dictionary')),
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
      WFInput: sc.Attach(sc.Ref('Get Viewed Issues Result', aggs=[
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

    sc.Action('is.workflow.actions.gettext', name='jq', params={
      WFTextActionText: sc.Str(['([.fields[]] | max) as $max\n| (\n  if .fields.customfield_', sc.Ref('Vars.FID'), ' == $max\n  then empty\n  else { key, newValue: $max }\n  end\n)']),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: sc.Attach(sc.Ref('Vars.Repeat Item')),
      jqQuery: sc.Str([sc.Ref('jq')]),
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FAC0F958-C6D7-4969-9830-1BE2C0B6472C',
      WFCondition: 100,
      WFConditionalActionString: sc.Str([sc.Ref('Updated')]),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Result')),
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
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
              WFValue: sc.Str(['issue/', sc.Ref('Result', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'key',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ])]),
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
                                  WFItemType: 0,
                                  WFKey: sc.Str(['customfield_', sc.Ref('Vars.FID')]),
                                  WFValue: sc.Str([sc.Ref('Result', aggs=[
                                    {
                                      CoercionItemClass: 'WFDictionaryContentItem',
                                      Type: 'WFCoercionVariableAggrandizement',
                                    },
                                    {
                                      DictionaryKey: 'newValue',
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

    sc.Action('is.workflow.actions.runworkflow', name='Shortcut Result', params={
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Shortcut Result')),
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
      Input: sc.Attach(sc.Ref('Vars.Updated Issues')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '732DECE0-5E84-43B1-A972-8FEC52FECF86',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Count')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.notification', {
      WFNotificationActionBody: sc.Str(['Updated ', sc.Ref('Count'), ' issues']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '732DECE0-5E84-43B1-A972-8FEC52FECF86',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
