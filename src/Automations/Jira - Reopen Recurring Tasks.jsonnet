{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    ['Empty Dictionary']: lib.Action('is.workflow.actions.dictionary', {
              CustomOutputName: 'Empty Dictionary',
              UUID: 'D5EFC1CE-7228-4AC0-99DE-49F541F80220',
            })
      ,
      ['Constants']: lib.Action('dk.simonbs.DataJar.GetValueIntent', {
              CustomOutputName: 'Constants',
              UUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
              keyPath: 'Jira - Reopen Recurring Tasks',
            })
      ,
      ['JQL']: lib.Action('is.workflow.actions.urlencode', {
              CustomOutputName: 'JQL',
              UUID: 'A08868B5-A1BC-404D-B22C-777401A8FF63',
              WFInput: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'Filter: Recurring Tasks',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Constants',
                      OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼ and status = Done',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.dictionary', {
        UUID: 'D5F0A524-2708-4688-9C46-8948DC6682BD',
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
                    attachmentsByRange: {
                      '{11, 1}': {
                        OutputName: 'JQL',
                        OutputUUID: 'A08868B5-A1BC-404D-B22C-777401A8FF63',
                        Type: 'ActionOutput',
                      },
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
      })
      ,
      ['Search Issues Result']: lib.Action('is.workflow.actions.runworkflow', {
              CustomOutputName: 'Search Issues Result',
              UUID: 'E2E485F2-1930-467E-AF79-5689736108C4',
              WFInput: {
                Value: {
                  OutputName: 'Dictionary',
                  OutputUUID: 'D5F0A524-2708-4688-9C46-8948DC6682BD',
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
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'AE423FC4-1D2B-4E43-AA6F-8E7BEDAEAFAB',
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
            OutputName: 'Search Issues Result',
            OutputUUID: 'E2E485F2-1930-467E-AF79-5689736108C4',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.dictionary', {
        UUID: '8D0B6DF9-6F3B-424E-8BE4-D57C35186E26',
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
                              string: 'transition',
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
                                        string: 'id',
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
                                                DictionaryKey: 'Transition: Waiting For',
                                                Type: 'WFDictionaryValueVariableAggrandizement',
                                              },
                                            ],
                                            OutputName: 'Constants',
                                            OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
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
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.runworkflow', {
        UUID: 'F63A70B4-1128-4392-9E80-EA16886965F3',
        WFInput: {
          Value: {
            OutputName: 'Dictionary',
            OutputUUID: '8D0B6DF9-6F3B-424E-8BE4-D57C35186E26',
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
      })
      ,
      ['Reopen Basis Option ID']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Reopen Basis Option ID',
              UUID: '76C8346B-D727-49CB-8529-E1A4FF4BC841',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'Field: Reopen Basis',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Constants',
                      OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
                      Type: 'ActionOutput',
                    },
                  },
                  string: 'fields.￼',
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
            })
      ,
      ['Reopen Delay']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Reopen Delay',
              UUID: '79BB0600-7F52-42D9-8FD8-432F4681E74F',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'Field: Reopen Delay',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Constants',
                      OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
                      Type: 'ActionOutput',
                    },
                  },
                  string: 'fields.￼',
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
            })
      ,
      ['Reopen Basis Field Key']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Reopen Basis Field Key',
              UUID: 'F26BFE2E-7A32-431E-99AD-00B23A9239C9',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': {
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
                      OutputName: 'Reopen Basis Option ID',
                      OutputUUID: '76C8346B-D727-49CB-8529-E1A4FF4BC841',
                      Type: 'ActionOutput',
                    },
                  },
                  string: 'Basis: ￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFInput: {
                Value: {
                  OutputName: 'Constants',
                  OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
            })
      ,
      ['Reopen Basis Field Value']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Reopen Basis Field Value',
              UUID: '306180EF-7558-497D-835C-8A1163545149',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': {
                      OutputName: 'Reopen Basis Field Key',
                      OutputUUID: 'F26BFE2E-7A32-431E-99AD-00B23A9239C9',
                      Type: 'ActionOutput',
                    },
                  },
                  string: 'fields.￼',
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
            })
      ,
      ['Reopen Basis Date']: lib.Action('is.workflow.actions.detect.date', {
              CustomOutputName: 'Reopen Basis Date',
              UUID: '4AF2487E-2AA4-475B-8398-DCDC0834C0EE',
              WFInput: {
                Value: {
                  OutputName: 'Reopen Basis Field Value',
                  OutputUUID: '306180EF-7558-497D-835C-8A1163545149',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
            })
      ,
      ['New Start Date']: lib.Action('is.workflow.actions.adjustdate', {
              CustomOutputName: 'New Start Date',
              UUID: '7F977212-5AAD-4323-9135-FB89CA18059E',
              WFDate: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Reopen Basis Date',
                      OutputUUID: '4AF2487E-2AA4-475B-8398-DCDC0834C0EE',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFDuration: {
                Value: {
                  Magnitude: {
                    OutputName: 'Reopen Delay',
                    OutputUUID: '79BB0600-7F52-42D9-8FD8-432F4681E74F',
                    Type: 'ActionOutput',
                  },
                  Unit: 'days',
                },
                WFSerializationType: 'WFQuantityFieldValue',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.dictionary', {
        UUID: '0F1CEE81-35D7-45A0-A2B9-0B40FA5AFE79',
        WFItems: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 0,
                WFKey: {
                  Value: {
                    attachmentsByRange: {
                      '{0, 1}': {
                        Aggrandizements: [
                          {
                            CoercionItemClass: 'WFDictionaryContentItem',
                            Type: 'WFCoercionVariableAggrandizement',
                          },
                          {
                            DictionaryKey: 'Field: Start Date',
                            Type: 'WFDictionaryValueVariableAggrandizement',
                          },
                        ],
                        OutputName: 'Constants',
                        OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
                        Type: 'ActionOutput',
                      },
                    },
                    string: '￼',
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
                            WFISO8601IncludeTime: false,
                          },
                        ],
                        OutputName: 'New Start Date',
                        OutputUUID: '7F977212-5AAD-4323-9135-FB89CA18059E',
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
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvariable', {
        WFInput: {
          Value: {
            OutputName: 'Dictionary',
            OutputUUID: '0F1CEE81-35D7-45A0-A2B9-0B40FA5AFE79',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'New Field Values',
      })
      ,
      ['Due Date']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Due Date',
              UUID: '4E17AA7C-43E1-4E77-B54B-3F41EF0C628D',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'Field: Due Date',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Constants',
                      OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
                      Type: 'ActionOutput',
                    },
                  },
                  string: 'fields.￼',
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
            })
      ,
      ['Start Date']: lib.Action('is.workflow.actions.getvalueforkey', {
              CustomOutputName: 'Start Date',
              UUID: 'CE26BBD2-6344-4DF0-978B-DC2B65B8601F',
              WFDictionaryKey: {
                Value: {
                  attachmentsByRange: {
                    '{7, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'Field: Start Date',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      OutputName: 'Constants',
                      OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
                      Type: 'ActionOutput',
                    },
                  },
                  string: 'fields.￼',
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
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '45D68504-844B-4442-A6C9-E2A4C53E75BC',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Due Date',
              OutputUUID: '4E17AA7C-43E1-4E77-B54B-3F41EF0C628D',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '4EBACF8B-4223-4128-B956-2E3076C9EF95',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Start Date',
              OutputUUID: 'CE26BBD2-6344-4DF0-978B-DC2B65B8601F',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.gettimebetweendates', {
        UUID: '249F0F95-1358-42FF-B112-0D8E1D537E88',
        WFInput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Due Date',
                OutputUUID: '4E17AA7C-43E1-4E77-B54B-3F41EF0C628D',
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
                OutputName: 'Start Date',
                OutputUUID: 'CE26BBD2-6344-4DF0-978B-DC2B65B8601F',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFTimeUntilUnit: 'Days',
      })
      ,
      ['New Due Date']: lib.Action('is.workflow.actions.adjustdate', {
              CustomOutputName: 'New Due Date',
              UUID: '98656B9B-9678-4328-B8BC-53A3B50FA85C',
              WFDate: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'New Start Date',
                      OutputUUID: '7F977212-5AAD-4323-9135-FB89CA18059E',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFDuration: {
                Value: {
                  Magnitude: {
                    OutputName: 'Time Between Dates',
                    OutputUUID: '249F0F95-1358-42FF-B112-0D8E1D537E88',
                    Type: 'ActionOutput',
                  },
                  Unit: 'days',
                },
                WFSerializationType: 'WFQuantityFieldValue',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvalueforkey', {
        UUID: '8263691C-15E9-47DC-8517-48F6DF225E14',
        WFDictionary: {
          Value: {
            Type: 'Variable',
            VariableName: 'New Field Values',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFDictionaryKey: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'Field: Due Date',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                OutputName: 'Constants',
                OutputUUID: '27964F98-77F2-4D55-996B-92A1F7739C55',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFDictionaryValue: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Aggrandizements: [
                  {
                    Type: 'WFDateFormatVariableAggrandizement',
                    WFDateFormatStyle: 'ISO 8601',
                    WFISO8601IncludeTime: false,
                  },
                ],
                OutputName: 'New Due Date',
                OutputUUID: '98656B9B-9678-4328-B8BC-53A3B50FA85C',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvariable', {
        WFInput: {
          Value: {
            OutputName: 'Dictionary',
            OutputUUID: '8263691C-15E9-47DC-8517-48F6DF225E14',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'New Field Values',
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '4EBACF8B-4223-4128-B956-2E3076C9EF95',
        UUID: '4B95B280-44AA-455F-9914-C05FEBE9C5A7',
        WFControlFlowMode: 2,
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.conditional', {
        GroupingIdentifier: '45D68504-844B-4442-A6C9-E2A4C53E75BC',
        UUID: '150F27CF-7487-4463-A5FF-A5D4FB0D8E8E',
        WFControlFlowMode: 2,
      })
      ,
      ['Issue Edit Dictionary']: lib.Action('is.workflow.actions.dictionary', {
              CustomOutputName: 'Issue Edit Dictionary',
              UUID: 'AD055E42-C163-4091-936B-7DD3DE897DC6',
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
            })
      ,
      ['Fields Dictionary']: lib.Action('is.workflow.actions.setvalueforkey', {
              CustomOutputName: 'Fields Dictionary',
              UUID: '88E86D8E-5727-4F3E-97CF-13F1EC47272E',
              WFDictionary: {
                Value: {
                  OutputName: 'Empty Dictionary',
                  OutputUUID: 'D5EFC1CE-7228-4AC0-99DE-49F541F80220',
                  Type: 'ActionOutput',
                },
                WFSerializationType: 'WFTextTokenAttachment',
              },
              WFDictionaryKey: 'fields',
              WFDictionaryValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Type: 'Variable',
                      VariableName: 'New Field Values',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvalueforkey', {
        UUID: '10C2671F-B0ED-4A9D-B1EB-9EBFDD61E67E',
        WFDictionary: {
          Value: {
            OutputName: 'Issue Edit Dictionary',
            OutputUUID: 'AD055E42-C163-4091-936B-7DD3DE897DC6',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFDictionaryKey: 'json',
        WFDictionaryValue: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Fields Dictionary',
                OutputUUID: '88E86D8E-5727-4F3E-97CF-13F1EC47272E',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.runworkflow', {
        UUID: '48A16FCF-A72C-4558-BDDB-5FE2A9B0CCC7',
        WFInput: {
          Value: {
            OutputName: 'Dictionary',
            OutputUUID: '10C2671F-B0ED-4A9D-B1EB-9EBFDD61E67E',
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
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'AE423FC4-1D2B-4E43-AA6F-8E7BEDAEAFAB',
        UUID: 'A9502E68-7460-48D8-9D89-32A7FBF19F92',
        WFControlFlowMode: 2,
      })
      ,
  }),
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
