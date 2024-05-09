local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.gettext', {
      UUID: 'DDC72E39-4309-44F3-9CF8-5363F365A6CE',
      WFTextActionText: '10096',
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Text',
          OutputUUID: 'DDC72E39-4309-44F3-9CF8-5363F365A6CE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'FID',
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', label='JQL', params={
      UUID: '265915F4-5E67-47DE-915D-1A00F0928D3F',
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

    [_()]: lib.Action('is.workflow.actions.dictionary', {
      UUID: '88D0D22C-5C6D-465B-B196-7FCCC743A09C',
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
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{0, 1}': {
                                OutputName: 'JQL',
                                OutputUUID: '265915F4-5E67-47DE-915D-1A00F0928D3F',
                                Type: 'ActionOutput',
                              },
                            },
                            string: '￼',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
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

    [_()]: lib.Action('is.workflow.actions.runworkflow', label='Get Viewed Issues Result', params={
      UUID: '0BC34C52-3304-4A72-8199-D233EFFF2D04',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '88D0D22C-5C6D-465B-B196-7FCCC743A09C',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '6F192F82-E28B-4DA5-8E9D-3595CEE96F87',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
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
          OutputName: 'Get Viewed Issues Result',
          OutputUUID: '0BC34C52-3304-4A72-8199-D233EFFF2D04',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', label='jq', params={
      UUID: 'E0BE9453-92FB-40ED-B03E-B9C6B46BC0B1',
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

    [_()]: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
      UUID: 'C3E456FC-B4AC-4548-8650-E06F7DCA6CE1',
      input: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      jqQuery: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'jq',
              OutputUUID: 'E0BE9453-92FB-40ED-B03E-B9C6B46BC0B1',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      queryType: 'jq',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
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
          Value: {
            OutputName: 'Result',
            OutputUUID: 'C3E456FC-B4AC-4548-8650-E06F7DCA6CE1',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.dictionary', {
      UUID: 'D340DC0F-B702-4938-9C37-36168D945BF1',
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
                      OutputName: 'Result',
                      OutputUUID: 'C3E456FC-B4AC-4548-8650-E06F7DCA6CE1',
                      Type: 'ActionOutput',
                    },
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
                                  WFValue: {
                                    Value: {
                                      attachmentsByRange: {
                                        '{0, 1}': {
                                          Aggrandizements: [
                                            {
                                              CoercionItemClass: 'WFDictionaryContentItem',
                                              Type: 'WFCoercionVariableAggrandizement',
                                            },
                                            {
                                              DictionaryKey: 'newValue',
                                              Type: 'WFDictionaryValueVariableAggrandizement',
                                            },
                                          ],
                                          OutputName: 'Result',
                                          OutputUUID: 'C3E456FC-B4AC-4548-8650-E06F7DCA6CE1',
                                          Type: 'ActionOutput',
                                        },
                                      },
                                      string: '￼',
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
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.runworkflow', {
      UUID: '5F5B077B-A275-4C29-AD81-ACBBB635E124',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: 'D340DC0F-B702-4938-9C37-36168D945BF1',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    [_()]: lib.Action('is.workflow.actions.appendvariable', {
      WFInput: {
        Value: {
          OutputName: 'Shortcut Result',
          OutputUUID: '5F5B077B-A275-4C29-AD81-ACBBB635E124',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Updated Issues',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FAC0F958-C6D7-4969-9830-1BE2C0B6472C',
      UUID: '8D9F8B76-6DCE-4FE1-9947-0DA9AECC8CCE',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '6F192F82-E28B-4DA5-8E9D-3595CEE96F87',
      UUID: '93C52995-3225-47BD-9DAE-68B78165FCC5',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          Type: 'Variable',
          VariableName: 'Updated Issues',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      UUID: '23180042-1F8E-4EC8-A828-ED3315DF5F7D',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
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

    [_()]: lib.Action('is.workflow.actions.notification', {
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

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '732DECE0-5E84-43B1-A972-8FEC52FECF86',
      WFControlFlowMode: 2,
    }),
  }),
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
