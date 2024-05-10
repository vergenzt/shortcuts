local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '38e742ea-ca59-5279-adc4-32c6a7d8994f',
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: 'F505E2A0-23F4-48A2-9B69-E0685C498FBA',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Calendar Alarms',
    }),

    sc.Action('is.workflow.actions.dictionary', {
      CustomOutputName: 'Calendars',
      UUID: '0dad79b6-c4ff-58f1-b6fb-bc81c4adaa3c',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Calendar',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'ICF',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Events',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'Tim',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Routine',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'Routine',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Medication Reminders',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'Meds',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: 'b562d56b-f1b1-5960-83f7-412c562cbc3f',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '38e742ea-ca59-5279-adc4-32c6a7d8994f',
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: 'F505E2A0-23F4-48A2-9B69-E0685C498FBA',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Calendar Alarms',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '8d9296ce-bdce-5106-aee7-db78ae89a8d1',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '53A72E38-2837-4D4B-BC66-CF33E559EB7D',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: 'b562d56b-f1b1-5960-83f7-412c562cbc3f',
    }),

    sc.Action('is.workflow.actions.date', {
      CustomOutputName: 'Current Datetime',
      UUID: 'dc081c78-87ae-5114-b607-af80e2dca267',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '8d9296ce-bdce-5106-aee7-db78ae89a8d1',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '53A72E38-2837-4D4B-BC66-CF33E559EB7D',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.adjustdate', {
      CustomOutputName: '4 Hours Ago',
      UUID: '01fc62ae-4a63-57c8-9c83-2a146e04a5eb',
      WFAdjustOperation: 'Subtract',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Current Datetime',
              OutputUUID: 'F1E39DC9-CAE8-458C-8B72-450D09704C59',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDuration: {
        Value: {
          Magnitude: '4',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.date', {
      CustomOutputName: 'Current Datetime',
      UUID: 'dc081c78-87ae-5114-b607-af80e2dca267',
    }),

    sc.Action('is.workflow.actions.adjustdate', {
      CustomOutputName: '24 Hours Out',
      UUID: '45b3957a-5477-5171-b265-e20db5cf05dc',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Current Datetime',
              OutputUUID: 'F1E39DC9-CAE8-458C-8B72-450D09704C59',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDuration: {
        Value: {
          Magnitude: '24',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.adjustdate', {
      CustomOutputName: '4 Hours Ago',
      UUID: '01fc62ae-4a63-57c8-9c83-2a146e04a5eb',
      WFAdjustOperation: 'Subtract',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Current Datetime',
              OutputUUID: 'F1E39DC9-CAE8-458C-8B72-450D09704C59',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDuration: {
        Value: {
          Magnitude: '4',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', {
      UUID: '532eca69-72dc-5710-9c11-eec0a2fb4393',
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Bounded: true,
              Operator: 1003,
              Property: 'Start Date',
              Removable: false,
              Values: {
                AnotherDate: {
                  Value: {
                    OutputName: '24 Hours Out',
                    OutputUUID: '382EC078-69E3-4231-BBAC-6B1BC371D3BE',
                    Type: 'ActionOutput',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
                Date: {
                  Value: {
                    OutputName: '4 Hours Ago',
                    OutputUUID: '9D0897C6-4877-4C09-B387-90503CC88144',
                    Type: 'ActionOutput',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
                Number: 7,
                Unit: 16,
              },
            },
            {
              Operator: 4,
              Property: 'Is All Day',
              Removable: true,
              Values: {
                Bool: false,
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemInputParameter: 'Library',
      WFContentItemLimitEnabled: false,
    }),

    sc.Action('is.workflow.actions.adjustdate', {
      CustomOutputName: '24 Hours Out',
      UUID: '45b3957a-5477-5171-b265-e20db5cf05dc',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Current Datetime',
              OutputUUID: 'F1E39DC9-CAE8-458C-8B72-450D09704C59',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDuration: {
        Value: {
          Magnitude: '24',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3A666097-90F9-4E2A-BBDC-A7A2F903EB04',
      UUID: 'f476369e-82da-579f-876d-9f83fd2c603b',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Calendar Events',
          OutputUUID: '58E91960-056A-43F4-A3CA-61059329F2A5',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', {
      UUID: '532eca69-72dc-5710-9c11-eec0a2fb4393',
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Bounded: true,
              Operator: 1003,
              Property: 'Start Date',
              Removable: false,
              Values: {
                AnotherDate: {
                  Value: {
                    OutputName: '24 Hours Out',
                    OutputUUID: '382EC078-69E3-4231-BBAC-6B1BC371D3BE',
                    Type: 'ActionOutput',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
                Date: {
                  Value: {
                    OutputName: '4 Hours Ago',
                    OutputUUID: '9D0897C6-4877-4C09-B387-90503CC88144',
                    Type: 'ActionOutput',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
                Number: 7,
                Unit: 16,
              },
            },
            {
              Operator: 4,
              Property: 'Is All Day',
              Removable: true,
              Values: {
                Bool: false,
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemInputParameter: 'Library',
      WFContentItemLimitEnabled: false,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: 'f757def0-a298-56e6-8b48-b9e72802c716',
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D865DCEB-5B4B-4082-BF75-15D223D983F5',
      UUID: 'f476369e-82da-579f-876d-9f83fd2c603b',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Calendar Events',
          OutputUUID: '58E91960-056A-43F4-A3CA-61059329F2A5',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', {
      UUID: '7c0b8bd9-8fcf-59e7-8f98-cd7902074bc8',
      WFContentItemPropertyName: 'Calendar',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: 'f757def0-a298-56e6-8b48-b9e72802c716',
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.text.combine', {
      UUID: '13b51b90-f7a5-5a55-b86a-8e14de2e32c0',
      WFTextCustomSeparator: '|',
      WFTextSeparator: 'Custom',
      text: {
        Value: {
          Aggrandizements: [
            {
              PropertyName: 'Values',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          OutputName: 'Calendars',
          OutputUUID: 'E17254C9-251D-4D01-BA9D-CCA53796AF37',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', {
      UUID: '7c0b8bd9-8fcf-59e7-8f98-cd7902074bc8',
      WFContentItemPropertyName: 'Calendar',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Calendar Label',
      UUID: '9c0bb391-55c3-548d-92a3-1f4f9262fcf8',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Calendar',
              OutputUUID: '9BEA2617-BB08-4044-A5F6-B4EC6E3A94F9',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          OutputName: 'Calendars',
          OutputUUID: 'E17254C9-251D-4D01-BA9D-CCA53796AF37',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.combine', {
      UUID: '13b51b90-f7a5-5a55-b86a-8e14de2e32c0',
      WFTextCustomSeparator: '|',
      WFTextSeparator: 'Custom',
      text: {
        Value: {
          Aggrandizements: [
            {
              PropertyName: 'Values',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          OutputName: 'Calendars',
          OutputUUID: 'E17254C9-251D-4D01-BA9D-CCA53796AF37',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '427BCD5D-36BB-4074-BB69-2550C082A88F',
      UUID: '1261efcf-79a9-515d-bc2f-da8beff4a400',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Calendar Label',
            OutputUUID: 'A7586AA4-688F-4160-9D7F-704FACF79C8B',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Calendar Label',
      UUID: '9c0bb391-55c3-548d-92a3-1f4f9262fcf8',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Calendar',
              OutputUUID: '9BEA2617-BB08-4044-A5F6-B4EC6E3A94F9',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          OutputName: 'Calendars',
          OutputUUID: 'E17254C9-251D-4D01-BA9D-CCA53796AF37',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', {
      UUID: '0f02e65d-e2d0-542a-a85f-2c693829f9dc',
      WFContentItemPropertyName: 'Title',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B1026764-CD96-48C0-A460-7A39220D9A3C',
      UUID: '1261efcf-79a9-515d-bc2f-da8beff4a400',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Calendar Label',
            OutputUUID: 'A7586AA4-688F-4160-9D7F-704FACF79C8B',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', {
      UUID: '7d49b046-5703-5d30-8079-594b51c9601c',
      WFContentItemPropertyName: 'Start Date',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', {
      UUID: '0f02e65d-e2d0-542a-a85f-2c693829f9dc',
      WFContentItemPropertyName: 'Title',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', {
      UUID: '7d49b046-5703-5d30-8079-594b51c9601c',
      WFContentItemPropertyName: 'Start Date',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      CustomOutputName: 'Desired Alarm Name',
      UUID: 'eb386db1-f61b-5893-9d13-44a92f07b955',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Calendar Label',
              OutputUUID: 'A7586AA4-688F-4160-9D7F-704FACF79C8B',
              Type: 'ActionOutput',
            },
            '{12, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Start Date',
              OutputUUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
              Type: 'ActionOutput',
            },
            '{7, 1}': {
              OutputName: 'Title',
              OutputUUID: 'B89D6127-FEC4-4DC5-AC30-3F1A4AED7A23',
              Type: 'ActionOutput',
            },
          },
          string: '￼ 🗓️: ￼ at ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.adjustdate', {
      CustomOutputName: 'Desired Alarm Time',
      UUID: '9ce88c83-e93e-5ea4-9447-642bdde38e13',
      WFAdjustOperation: 'Subtract',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Start Date',
              OutputUUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDuration: {
        Value: {
          Magnitude: '20',
          Unit: 'min',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '96494FE3-384B-4E3D-A6BB-E7397D7E6D39',
      UUID: 'e3ea1cf2-8303-5c2d-a41e-229c834bffe8',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      CustomOutputName: 'Desired Alarm Name',
      UUID: 'eb386db1-f61b-5893-9d13-44a92f07b955',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Calendar Label',
              OutputUUID: 'A7586AA4-688F-4160-9D7F-704FACF79C8B',
              Type: 'ActionOutput',
            },
            '{12, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Start Date',
              OutputUUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
              Type: 'ActionOutput',
            },
            '{7, 1}': {
              OutputName: 'Title',
              OutputUUID: 'B89D6127-FEC4-4DC5-AC30-3F1A4AED7A23',
              Type: 'ActionOutput',
            },
          },
          string: '￼ 🗓️: ￼ at ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '07eae9e4-1227-5313-b34f-e436f7efa60f',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item 2',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Candidate Alarm',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'AE03D9A5-AE20-488D-8DF3-659B5538330B',
      UUID: 'e3ea1cf2-8303-5c2d-a41e-229c834bffe8',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '158A4D5F-D62E-4F00-9F76-3C5B2B144588',
      UUID: '8b12329b-a67c-517b-9969-b719668b73fd',
      WFCondition: 4,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
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
            Aggrandizements: [
              {
                PropertyName: 'label',
                PropertyUserInfo: 'label',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item 2',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '07eae9e4-1227-5313-b34f-e436f7efa60f',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item 2',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Candidate Alarm',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '5f64d0e6-29d5-546c-b33f-b1fbe0dc6acb',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Candidate Alarm',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '675201C0-5DE4-4E8E-8597-1D3EB5D3BEA9',
      UUID: '8b12329b-a67c-517b-9969-b719668b73fd',
      WFCondition: 4,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
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
            Aggrandizements: [
              {
                PropertyName: 'label',
                PropertyUserInfo: 'label',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item 2',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTGetAlarmsIntent', {
      ShowWhenRun: false,
      UUID: 'fa6af8d0-45c3-59b4-a42a-15e2158051e1',
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '5f64d0e6-29d5-546c-b33f-b1fbe0dc6acb',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Candidate Alarm',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '94db7187-147b-598b-9041-aad1b39bf8aa',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Index 2',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm Index',
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTGetAlarmsIntent', {
      ShowWhenRun: false,
      UUID: 'fa6af8d0-45c3-59b4-a42a-15e2158051e1',
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', {
      UUID: 'aa10b02a-a11e-5c46-9f16-7a7a460f2145',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Start Date',
              OutputUUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
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
              Aggrandizements: [
                {
                  PropertyName: 'dateComponents',
                  Type: 'WFPropertyVariableAggrandizement',
                },
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item 2',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '94db7187-147b-598b-9041-aad1b39bf8aa',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Index 2',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm Index',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      UUID: '0a1c4b06-fa73-5932-b38d-16ed08c0fa42',
      WFAnotherNumber: '240',
      WFCondition: 1003,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Desired Alarm Time',
              OutputUUID: 'DBB8C07D-7933-4F5D-B072-778D1E32AA10',
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
            OutputName: 'Time Between Dates',
            OutputUUID: 'C31DADE8-2948-443F-B725-1E1269312A17',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', {
      UUID: 'aa10b02a-a11e-5c46-9f16-7a7a460f2145',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Start Date',
              OutputUUID: 'B0E48D17-CB8B-42DC-BC70-56D5B3779E4C',
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
              Aggrandizements: [
                {
                  PropertyName: 'dateComponents',
                  Type: 'WFPropertyVariableAggrandizement',
                },
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item 2',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      UUID: 'a311e66f-0653-5d52-89b1-44396cad9897',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '68B63B19-0E04-4CCF-8068-2D0452B96721',
      UUID: '0a1c4b06-fa73-5932-b38d-16ed08c0fa42',
      WFAnotherNumber: '240',
      WFCondition: 1003,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormatStyle: 'None',
                  WFISO8601IncludeTime: false,
                  WFTimeFormatStyle: 'Short',
                },
              ],
              OutputName: 'Desired Alarm Time',
              OutputUUID: 'DBB8C07D-7933-4F5D-B072-778D1E32AA10',
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
            OutputName: 'Time Between Dates',
            OutputUUID: 'C31DADE8-2948-443F-B725-1E1269312A17',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.alert', {
      UUID: '4e425b34-555a-5c73-997f-64714a03ec88',
      WFAlertActionMessage: {
        Value: {
          attachmentsByRange: {
            '{87, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Name',
                  PropertyUserInfo: 'WFItemName',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Alarm',
            },
          },
          string: 'Alarm name matched but alarm time minus event time was outside range of [-4hr, -0min]! ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '68B63B19-0E04-4CCF-8068-2D0452B96721',
      UUID: 'a311e66f-0653-5d52-89b1-44396cad9897',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '68B63B19-0E04-4CCF-8068-2D0452B96721',
      UUID: '866c3755-90c0-5879-80ff-8ba58ea4577d',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.alert', {
      UUID: '4e425b34-555a-5c73-997f-64714a03ec88',
      WFAlertActionMessage: {
        Value: {
          attachmentsByRange: {
            '{87, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Name',
                  PropertyUserInfo: 'WFItemName',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Alarm',
            },
          },
          string: 'Alarm name matched but alarm time minus event time was outside range of [-4hr, -0min]! ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          OutputName: 'If Result',
          OutputUUID: '28F19A4B-4221-45C6-84ED-CCF7F336427E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      UUID: '5bb7955c-291f-56d9-a7c0-8bf506efffe9',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39E438DD-244C-452F-A903-9705E3730F13',
      UUID: '866c3755-90c0-5879-80ff-8ba58ea4577d',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '675201C0-5DE4-4E8E-8597-1D3EB5D3BEA9',
      UUID: 'be1ff911-6f41-5259-9823-4ab807638892',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          OutputName: 'If Result',
          OutputUUID: '28F19A4B-4221-45C6-84ED-CCF7F336427E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      UUID: '5bb7955c-291f-56d9-a7c0-8bf506efffe9',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '158A4D5F-D62E-4F00-9F76-3C5B2B144588',
      UUID: '6784757d-b1bc-5fb4-8810-fdb6ff0b0c15',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE03D9A5-AE20-488D-8DF3-659B5538330B',
      UUID: 'be1ff911-6f41-5259-9823-4ab807638892',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      UUID: '96f3768b-7d8d-56ca-bc2a-2ca6ffd72601',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Type: 'Variable',
            VariableName: 'Alarm',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '2A08F09E-877D-4A80-BE67-91123BE8A71A',
      UUID: '6784757d-b1bc-5fb4-8810-fdb6ff0b0c15',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '537DCEE3-7693-49E7-BF53-DDACE1C28417',
      UUID: '96f3768b-7d8d-56ca-bc2a-2ca6ffd72601',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Type: 'Variable',
            VariableName: 'Alarm',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: '1435ff58-f296-5db7-89e0-9ab77d5b02e3',
      dateComponents: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Time',
              OutputUUID: 'DBB8C07D-7933-4F5D-B072-778D1E32AA10',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      label: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      name: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      repeatSchedule: {
        displayString: 'Never',
        value: 0,
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      UUID: '7bf2b58b-5e59-5739-885d-e23ce04efeb2',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Alarm',
          OutputUUID: '96BFA7D2-40FE-48DE-A762-72BB69134F34',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      UUID: 'b54b0424-8c67-5fc0-ba9b-a6e7a7b14eeb',
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{14, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: 'Created alarm ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: '1435ff58-f296-5db7-89e0-9ab77d5b02e3',
      dateComponents: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Time',
              OutputUUID: 'DBB8C07D-7933-4F5D-B072-778D1E32AA10',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      label: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      name: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      repeatSchedule: {
        displayString: 'Never',
        value: 0,
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      UUID: 'df5915d8-fa25-506b-9832-00b6e30114ad',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.notification', {
      UUID: 'b54b0424-8c67-5fc0-ba9b-a6e7a7b14eeb',
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{14, 1}': {
              OutputName: 'Desired Alarm Name',
              OutputUUID: '827F3DBE-29D3-467B-8F7A-12F602A9389E',
              Type: 'ActionOutput',
            },
          },
          string: 'Created alarm ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: 'deeb222d-6780-5b62-aaae-12d81358ac29',
      alarm: {
        Value: {
          Type: 'Variable',
          VariableName: 'Alarm',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      UUID: 'df5915d8-fa25-506b-9832-00b6e30114ad',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.setvalueforkey', {
      UUID: '26bca01b-16ef-56b8-92a4-c8b042e9bc14',
      WFDictionary: {
        Value: {
          Type: 'Variable',
          VariableName: 'Matched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Alarm Index',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDictionaryValue: 'yes',
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: 'deeb222d-6780-5b62-aaae-12d81358ac29',
      alarm: {
        Value: {
          Type: 'Variable',
          VariableName: 'Alarm',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '6d368bd1-fb93-5379-af2d-6a801bfc229e',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '8AC4C390-058D-4FA0-8DD8-3025C6C81A83',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.setvalueforkey', {
      UUID: '26bca01b-16ef-56b8-92a4-c8b042e9bc14',
      WFDictionary: {
        Value: {
          Type: 'Variable',
          VariableName: 'Matched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Alarm Index',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDictionaryValue: 'yes',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      UUID: 'cf361995-b4e3-590f-b806-3f28bb20c066',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: '6d368bd1-fb93-5379-af2d-6a801bfc229e',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '8AC4C390-058D-4FA0-8DD8-3025C6C81A83',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Matched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '537DCEE3-7693-49E7-BF53-DDACE1C28417',
      UUID: '4f26d571-329e-5250-8054-11b3c8a92cb9',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '96494FE3-384B-4E3D-A6BB-E7397D7E6D39',
      UUID: 'cf361995-b4e3-590f-b806-3f28bb20c066',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B1026764-CD96-48C0-A460-7A39220D9A3C',
      UUID: '6cfadbc7-8756-50fd-8941-28bfb323a502',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '427BCD5D-36BB-4074-BB69-2550C082A88F',
      UUID: '4f26d571-329e-5250-8054-11b3c8a92cb9',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      UUID: '1d698cd8-0860-54c5-b1bb-4e4c398c6321',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D865DCEB-5B4B-4082-BF75-15D223D983F5',
      UUID: '6cfadbc7-8756-50fd-8941-28bfb323a502',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.match', {
      UUID: '03dafa62-eee1-537c-b708-6e1f4b3154ed',
      WFMatchTextPattern: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': {
              OutputName: 'Combined Text',
              OutputUUID: 'CAAB610A-9E1B-42F1-8BEC-ED595EC07840',
              Type: 'ActionOutput',
            },
          },
          string: '(￼) 🗓️: (.*) at ([0-9: APM]+)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFLinkEntityContentItem_com.apple.mobiletimer_AlarmEntity',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  PropertyName: 'label',
                  PropertyUserInfo: 'label',
                  Type: 'WFPropertyVariableAggrandizement',
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

    sc.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      UUID: '1d698cd8-0860-54c5-b1bb-4e4c398c6321',
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '70AA4591-58E4-4CB5-8C7E-09A82EB1495D',
      UUID: 'e283891c-96a1-5202-bad2-97d643d8d4d1',
      WFControlFlowMode: 0,
      WFRepeatCount: {
        Value: {
          OutputName: 'Count',
          OutputUUID: '86725A5F-9405-4490-B3C0-B1A8AB382C76',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.match', {
      UUID: '03dafa62-eee1-537c-b708-6e1f4b3154ed',
      WFMatchTextPattern: {
        Value: {
          attachmentsByRange: {
            '{1, 1}': {
              OutputName: 'Combined Text',
              OutputUUID: 'CAAB610A-9E1B-42F1-8BEC-ED595EC07840',
              Type: 'ActionOutput',
            },
          },
          string: '(￼) 🗓️: (.*) at ([0-9: APM]+)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFLinkEntityContentItem_com.apple.mobiletimer_AlarmEntity',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  PropertyName: 'label',
                  PropertyUserInfo: 'label',
                  Type: 'WFPropertyVariableAggrandizement',
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

    sc.Action('is.workflow.actions.getvalueforkey', {
      UUID: '34333da9-b2a0-5b84-979f-35acd9a25cae',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Matched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '798171BA-AC80-444B-B198-9C3BDD109924',
      UUID: 'e283891c-96a1-5202-bad2-97d643d8d4d1',
      WFControlFlowMode: 0,
      WFRepeatCount: {
        Value: {
          OutputName: 'Count',
          OutputUUID: '86725A5F-9405-4490-B3C0-B1A8AB382C76',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      UUID: '92443db1-b9f8-55d9-aa55-bb2bd96a2063',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Dictionary Value',
            OutputUUID: 'B7C21E6D-7CE8-45ED-8670-A30CDF403BC7',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      UUID: '34333da9-b2a0-5b84-979f-35acd9a25cae',
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Matched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.nothing', {
      UUID: '62887532-aee7-52ce-87f0-b8eb65ccd6ab',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4251D7C2-3D8A-4098-81BA-F77E24B06C2E',
      UUID: '92443db1-b9f8-55d9-aa55-bb2bd96a2063',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Dictionary Value',
            OutputUUID: 'B7C21E6D-7CE8-45ED-8670-A30CDF403BC7',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.nothing', {
      UUID: '62887532-aee7-52ce-87f0-b8eb65ccd6ab',
    }),

    sc.Action('is.workflow.actions.getvariable', {
      UUID: 'ec7c651e-8add-584c-8c29-4454053b7e7c',
      WFVariable: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Index',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4251D7C2-3D8A-4098-81BA-F77E24B06C2E',
      UUID: '0c2fec92-c036-5928-a9b6-d31d0369514f',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4251D7C2-3D8A-4098-81BA-F77E24B06C2E',
      UUID: '90342357-112b-58e8-bd91-9dc9129cde2e',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      UUID: 'ec7c651e-8add-584c-8c29-4454053b7e7c',
      WFVariable: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Index',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '671D206A-4570-40B9-BB1A-11FC898D8925',
      UUID: '18a04671-a61e-5edc-8162-89165d641e1c',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '798171BA-AC80-444B-B198-9C3BDD109924',
      UUID: '90342357-112b-58e8-bd91-9dc9129cde2e',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: 'f497af8d-f2ef-5888-87d9-c4d6760ef3aa',
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '4B00EF21-76FF-43BF-889F-2122E12A8C3E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Unmatched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '70AA4591-58E4-4CB5-8C7E-09A82EB1495D',
      UUID: '18a04671-a61e-5edc-8162-89165d641e1c',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FA4A18C4-308D-44AC-8E2E-31906FCC518F',
      UUID: '644b3b78-f2e4-5f5d-846a-e4a9a040690c',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Unmatched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: 'f497af8d-f2ef-5888-87d9-c4d6760ef3aa',
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '4B00EF21-76FF-43BF-889F-2122E12A8C3E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Unmatched Calendar Alarm Indices',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      UUID: 'c6a95146-84be-5c5d-8ce3-5fc577253655',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Matches',
            OutputUUID: '5424F246-989D-4B1D-862D-48CE6D8A7B04',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '09844388-5886-404C-A6C1-6A3A54FD6E79',
      UUID: '644b3b78-f2e4-5f5d-846a-e4a9a040690c',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Unmatched Calendar Alarm Indices',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      UUID: '244e75ea-b990-5803-a193-d725b412592d',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFItemIndex: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2BEC0716-9EE1-4B73-95AC-8005054733A8',
      UUID: 'c6a95146-84be-5c5d-8ce3-5fc577253655',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Matches',
            OutputUUID: '5424F246-989D-4B1D-862D-48CE6D8A7B04',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: 'ea2070ca-acd1-5672-8d13-70f3a1baa894',
      WFInput: {
        Value: {
          OutputName: 'Item from List',
          OutputUUID: 'BD8661D4-66B9-4DB3-9F96-1821F8F2D868',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm to Disable',
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      UUID: '244e75ea-b990-5803-a193-d725b412592d',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Calendar Alarms',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFItemIndex: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '56DB22FA-EAD3-4625-A55E-D318797D0672',
      UUID: '5f5a10dc-fb1d-5eef-ac37-b8a1170a9323',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'enabled',
                PropertyUserInfo: 'enabled',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Alarm to Disable',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      UUID: 'ea2070ca-acd1-5672-8d13-70f3a1baa894',
      WFInput: {
        Value: {
          OutputName: 'Item from List',
          OutputUUID: 'BD8661D4-66B9-4DB3-9F96-1821F8F2D868',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Alarm to Disable',
    }),

    sc.Action('is.workflow.actions.notification', {
      UUID: 'f61885d5-feb7-5ec0-be17-0e5c2005dbda',
      WFInput: {
        Value: {
          OutputName: 'Item from List',
          OutputUUID: 'BD8661D4-66B9-4DB3-9F96-1821F8F2D868',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'label',
                  PropertyUserInfo: 'label',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Alarm to Disable',
            },
          },
          string: 'Disabling alarm ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0BF286FD-E83A-4C3A-A591-98089A2AB13F',
      UUID: '5f5a10dc-fb1d-5eef-ac37-b8a1170a9323',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'enabled',
                PropertyUserInfo: 'enabled',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Alarm to Disable',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: '420a6bec-b2d8-5ad2-a106-899a52303cfd',
      alarm: {
        Value: {
          Type: 'Variable',
          VariableName: 'Alarm to Disable',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      state: 0,
    }),

    sc.Action('is.workflow.actions.notification', {
      UUID: 'f61885d5-feb7-5ec0-be17-0e5c2005dbda',
      WFInput: {
        Value: {
          OutputName: 'Item from List',
          OutputUUID: 'BD8661D4-66B9-4DB3-9F96-1821F8F2D868',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFNotificationActionBody: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'label',
                  PropertyUserInfo: 'label',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Alarm to Disable',
            },
          },
          string: 'Disabling alarm ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0BF286FD-E83A-4C3A-A591-98089A2AB13F',
      UUID: '30e4b92a-a490-5857-8625-0a9a66e7f828',
      WFControlFlowMode: 2,
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'ToggleAlarmIntent',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      ShowWhenRun: false,
      UUID: '420a6bec-b2d8-5ad2-a106-899a52303cfd',
      alarm: {
        Value: {
          Type: 'Variable',
          VariableName: 'Alarm to Disable',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      state: 0,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '56DB22FA-EAD3-4625-A55E-D318797D0672',
      UUID: '60241ae0-fd6a-5f05-b6e3-1b22458e0d56',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2BEC0716-9EE1-4B73-95AC-8005054733A8',
      UUID: '30e4b92a-a490-5857-8625-0a9a66e7f828',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      UUID: '48edf7a1-518a-5231-b55c-7c87e6d54c67',
      WFVariable: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '09844388-5886-404C-A6C1-6A3A54FD6E79',
      UUID: '60241ae0-fd6a-5f05-b6e3-1b22458e0d56',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '06187FD3-4E72-47D2-8626-3DFC096A3334',
      UUID: 'd41416b8-6551-5753-9945-1bd2c70dde09',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      UUID: '48edf7a1-518a-5231-b55c-7c87e6d54c67',
      WFVariable: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FA4A18C4-308D-44AC-8E2E-31906FCC518F',
      UUID: '88b72138-8639-5e17-814e-c41dc242f356',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3A666097-90F9-4E2A-BBDC-A7A2F903EB04',
      UUID: 'd41416b8-6551-5753-9945-1bd2c70dde09',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '25CDD183-1362-42B9-8712-863F0F571C6B',
      UUID: '88b72138-8639-5e17-814e-c41dc242f356',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 431817727,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
