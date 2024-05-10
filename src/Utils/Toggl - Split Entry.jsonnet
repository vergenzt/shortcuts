local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.ask', {
      CustomOutputName: 'Split Time',
      UUID: 'A811604E-CC89-44DD-A385-8E5DED2C743B',
      WFAskActionPrompt: 'At what date/time would you like to split the active Toggl Track entry?',
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.converttimezone', {
      CustomOutputName: 'Split Time (UTC)',
      Date: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Split Time',
              OutputUUID: 'A811604E-CC89-44DD-A385-8E5DED2C743B',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      DestinationTimeZone: {
        alCityIdentifier: 302,
        localizedCityName: 'UTC',
        timeZone: 'GMT',
      },
      UUID: 'EF98993B-F786-4D94-AF6E-5B91C94FB57D',
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: '75415028-8D0D-4C67-9FA9-AF434C27DBD1',
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
                  string: 'me/time_entries',
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
                            string: 'before',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{0, 1}': {
                                Aggrandizements: [
                                  {
                                    Type: 'WFDateFormatVariableAggrandizement',
                                    WFDateFormatStyle: 'ISO 8601',
                                    WFISO8601IncludeTime: true,
                                  },
                                ],
                                OutputName: 'Split Time (UTC)',
                                OutputUUID: 'EF98993B-F786-4D94-AF6E-5B91C94FB57D',
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
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      CustomOutputName: 'Time Entries',
      UUID: '9AA600EA-135E-475F-A6CA-2722D17ED7EA',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '75415028-8D0D-4C67-9FA9-AF434C27DBD1',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'D7676A00-FF48-4BCC-AD06-21D893C2BFE9',
        workflowName: 'Toggl API',
      },
      WFWorkflowName: 'Toggl API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D9C206AD-C252-455D-A994-9C52097C95F0',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Time Entries',
          OutputUUID: '9AA600EA-135E-475F-A6CA-2722D17ED7EA',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.list', {
      CustomOutputName: 'Endpoint Keys',
      UUID: 'F9E57020-1F00-4D8C-885B-2A6AA5EE5F9C',
      WFItems: [
        'start',
        'stop',
      ],
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B6878FDB-F12E-4BE9-8FA0-198D4A57DA40',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Endpoint Keys',
          OutputUUID: 'F9E57020-1F00-4D8C-885B-2A6AA5EE5F9C',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Endpoint Text',
      UUID: '7433DD8B-C783-4CD3-8DB0-C75E0ED2636C',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item 2',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '96AB6539-120D-4246-A24B-80C6F2F3758E',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Endpoint Text',
            OutputUUID: '7433DD8B-C783-4CD3-8DB0-C75E0ED2636C',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.detect.date', {
      CustomOutputName: 'Endpoint',
      UUID: 'B126D226-C0C3-4820-9125-18CAF76E43AD',
      WFInput: {
        Value: {
          OutputName: 'Endpoint Text',
          OutputUUID: '7433DD8B-C783-4CD3-8DB0-C75E0ED2636C',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', {
      CustomOutputName: 'Endpoint Interval',
      UUID: '843C6FDF-BFBA-4984-BE07-61C63A5F6185',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Split Time (UTC)',
              OutputUUID: 'EF98993B-F786-4D94-AF6E-5B91C94FB57D',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFTimeUntilFromDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Endpoint',
              OutputUUID: 'B126D226-C0C3-4820-9125-18CAF76E43AD',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AF919587-F239-4E2F-8061-D205AF6AC302',
      WFCondition: 5,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Endpoint Interval',
            OutputUUID: '843C6FDF-BFBA-4984-BE07-61C63A5F6185',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.calculateexpression', {
      Input: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Endpoint Interval',
              OutputUUID: '843C6FDF-BFBA-4984-BE07-61C63A5F6185',
              Type: 'ActionOutput',
            },
            '{8, 1}': {
              OutputName: 'Endpoint Interval',
              OutputUUID: '843C6FDF-BFBA-4984-BE07-61C63A5F6185',
              Type: 'ActionOutput',
            },
          },
          string: '￼ / abs(￼)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      UUID: '1B43C2F8-E577-41C5-BB03-54A8B45FE46E',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AF919587-F239-4E2F-8061-D205AF6AC302',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.number', {
      WFNumberActionNumber: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AF919587-F239-4E2F-8061-D205AF6AC302',
      UUID: 'F1EFD8B6-B287-4CF6-81C4-B30E10ED26A5',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '96AB6539-120D-4246-A24B-80C6F2F3758E',
      UUID: '0C50116D-E13F-4EB7-86BB-235F6F3F738A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item 2',
            },
            '{2, 1}': {
              OutputName: 'If Result',
              OutputUUID: '0C50116D-E13F-4EB7-86BB-235F6F3F738A',
              Type: 'ActionOutput',
            },
          },
          string: '￼:￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B6878FDB-F12E-4BE9-8FA0-198D4A57DA40',
      UUID: '6419CC18-A1A5-40BA-8264-34FF8E213420',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', {
      UUID: '3E40CF90-EA78-4A73-8A11-F4EC4FF7DAB1',
      WFTextCustomSeparator: ', ',
      WFTextSeparator: 'Custom',
      text: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '6419CC18-A1A5-40BA-8264-34FF8E213420',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: 'C5D3AD5D-CBFA-4C5A-B385-377BD20A14C9',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'start:1, stop:',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'yes (start < split, stop empty)',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'start:1, stop:-1',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'yes (start < split, stop > split)',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      UUID: '4B850803-62ED-4746-8871-D18DEEB15110',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Combined Text',
              OutputUUID: '3E40CF90-EA78-4A73-8A11-F4EC4FF7DAB1',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: 'C5D3AD5D-CBFA-4C5A-B385-377BD20A14C9',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4FAF4B8F-8164-4849-B48A-32D3A32C12FC',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Dictionary Value',
            OutputUUID: '4B850803-62ED-4746-8871-D18DEEB15110',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Split Time splits Repeat Item\n→ create new pre-split entry\n→ update Repeat Item entry to set start time to Split Time',
    }),

    sc.Action('is.workflow.actions.dictionary', {
      CustomOutputName: 'New Entry Request',
      UUID: '48641CD5-6BD1-435A-AB85-8DC42F13D91E',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'start',
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
                          DictionaryKey: 'start',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
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
                  string: 'stop',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Split Time (UTC)',
                      OutputUUID: 'EF98993B-F786-4D94-AF6E-5B91C94FB57D',
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
                  string: 'created_with',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'Shortcuts',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'description',
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
                          DictionaryKey: 'description',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
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
                  string: 'project_id',
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
                          DictionaryKey: 'project_id',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
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
                  string: 'task_id',
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
                          DictionaryKey: 'task_id',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 4,
              WFKey: {
                Value: {
                  string: 'billable',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  Value: {
                    Aggrandizements: [
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'billable',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ],
                    Type: 'Variable',
                    VariableName: 'Repeat Item',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
                WFSerializationType: 'WFNumberSubstitutableState',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', {
      CustomOutputName: 'Updated JSON',
      UUID: '857FD33C-3955-48A3-B1A5-2BFF26C31275',
      WFDictionary: {
        Value: {
          Aggrandizements: [
            {
              DictionaryKey: 'json',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          OutputName: 'New Entry Request',
          OutputUUID: '48641CD5-6BD1-435A-AB85-8DC42F13D91E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: 'tag_ids',
      WFDictionaryValue: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'tag_ids',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', {
      CustomOutputName: 'Updated New Entry Request',
      UUID: '4A06E49F-E7DB-413A-BCBB-1A0E80778567',
      WFDictionary: {
        Value: {
          OutputName: 'New Entry Request',
          OutputUUID: '48641CD5-6BD1-435A-AB85-8DC42F13D91E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: 'json',
      WFDictionaryValue: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Updated JSON',
              OutputUUID: '857FD33C-3955-48A3-B1A5-2BFF26C31275',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', {
      CustomOutputName: 'New Entry Request',
      UUID: '60DB5854-C6D2-409A-AE94-0402E8C31850',
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
                  string: 'POST',
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
                    '{11, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'workspace_id',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: 'workspaces/￼/time_entries',
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
                        WFItemType: 0,
                        WFKey: {
                          Value: {
                            string: 'start',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{0, 1}': {
                                OutputName: 'Split Time (UTC)',
                                OutputUUID: 'EF98993B-F786-4D94-AF6E-5B91C94FB57D',
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
                            string: 'stop',
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
                                    DictionaryKey: 'stop',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
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
                            string: 'created_with',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            string: 'Shortcuts',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                      {
                        WFItemType: 0,
                        WFKey: {
                          Value: {
                            string: 'description',
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
                                    DictionaryKey: 'description',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
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
                            string: 'project_id',
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
                                    DictionaryKey: 'project_id',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
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
                            string: 'task_id',
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
                                    DictionaryKey: 'task_id',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
                              },
                            },
                            string: '￼',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                      {
                        WFItemType: 4,
                        WFKey: {
                          Value: {
                            string: 'billable',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            Value: {
                              Aggrandizements: [
                                {
                                  CoercionItemClass: 'WFDictionaryContentItem',
                                  Type: 'WFCoercionVariableAggrandizement',
                                },
                                {
                                  DictionaryKey: 'billable',
                                  Type: 'WFDictionaryValueVariableAggrandizement',
                                },
                              ],
                              Type: 'Variable',
                              VariableName: 'Repeat Item',
                            },
                            WFSerializationType: 'WFTextTokenAttachment',
                          },
                          WFSerializationType: 'WFNumberSubstitutableState',
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
      WFInput: {
        Value: {
          OutputName: 'Updated New Entry Request',
          OutputUUID: '4A06E49F-E7DB-413A-BCBB-1A0E80778567',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'D7676A00-FF48-4BCC-AD06-21D893C2BFE9',
        workflowName: 'Toggl API',
      },
      WFWorkflowName: 'Toggl API',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4FAF4B8F-8164-4849-B48A-32D3A32C12FC',
      UUID: '3CA70578-5B32-40D1-99EB-2F22E6EF67E3',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D9C206AD-C252-455D-A994-9C52097C95F0',
      UUID: 'A67CC02F-0ACC-4D93-A430-F4B5DEBE59F2',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -12365313,
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
