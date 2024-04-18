{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
        WFControlFlowMode: 0,
        WFMenuItems: [
          'Yes',
          'No',
          'Cancel',
        ],
        WFMenuPrompt: 'Review calendar first?',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
        WFControlFlowMode: 1,
        WFMenuItemTitle: 'Yes',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.alert',
      WFWorkflowActionParameters: {
        WFAlertActionMessage: "Click Continue to open the calendar app and review the time period you'd like to clear. When you're ready, return to Shortcuts to continue.",
        WFAlertActionTitle: 'Clear Calendar for Time Period',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.openapp',
      WFWorkflowActionParameters: {
        UUID: '29111200-95CC-44C2-918E-DBF113385335',
        WFAppIdentifier: 'com.apple.iCal',
        WFSelectedApp: {
          BundleIdentifier: 'com.apple.iCal',
          Name: 'Calendar',
          TeamIdentifier: '0000000000',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.waittoreturn',
      WFWorkflowActionParameters: {},
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
        WFControlFlowMode: 1,
        WFMenuItemTitle: 'No',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
        WFControlFlowMode: 1,
        WFMenuItemTitle: 'Cancel',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.exit',
      WFWorkflowActionParameters: {},
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '2862782E-41E9-4DD1-B0E8-1A8D520D17A6',
        UUID: 'CA955319-F09C-4154-8780-0E62A39677AB',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.adjustdate',
      WFWorkflowActionParameters: {
        CustomOutputName: ' BO Today',
        UUID: '9C8832BD-D74E-4690-B2BA-B344446E1086',
        WFAdjustOperation: 'Get Start of Day',
        WFDate: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Type: 'CurrentDate',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.ask',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Date',
        UUID: '751EAB73-C760-4A40-9DDE-50CE049963E8',
        WFAskActionDefaultAnswerDateAndTime: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: ' BO Today',
                OutputUUID: '9C8832BD-D74E-4690-B2BA-B344446E1086',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFAskActionPrompt: 'From what starting point would you like to remove calendar event(s)?',
        WFInputType: 'Date and Time',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.adjustdate',
      WFWorkflowActionParameters: {
        CustomOutputName: 'BOD',
        UUID: 'B6227E43-DB3D-4BE7-9434-6FFB2DFBED82',
        WFAdjustOperation: 'Get Start of Day',
        WFDate: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Date',
                OutputUUID: '751EAB73-C760-4A40-9DDE-50CE049963E8',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.adjustdate',
      WFWorkflowActionParameters: {
        CustomOutputName: 'EOD',
        UUID: '50F1238A-5726-4B34-960A-D71A2E8CA595',
        WFDate: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'BOD',
                OutputUUID: 'B6227E43-DB3D-4BE7-9434-6FFB2DFBED82',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFDuration: {
          Value: {
            Magnitude: '1',
            Unit: 'days',
          },
          WFSerializationType: 'WFQuantityFieldValue',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.adjustdate',
      WFWorkflowActionParameters: {
        CustomOutputName: 'EOD-1m',
        UUID: 'BD071FCA-3F5E-45CD-B083-3D2E4F51BB12',
        WFAdjustOperation: 'Subtract',
        WFDate: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'EOD',
                OutputUUID: '50F1238A-5726-4B34-960A-D71A2E8CA595',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFDuration: {
          Value: {
            Magnitude: '1',
            Unit: 'min',
          },
          WFSerializationType: 'WFQuantityFieldValue',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.ask',
      WFWorkflowActionParameters: {
        CustomOutputName: 'End date',
        UUID: '3EAB2872-52EE-4793-A13C-E79794D3C722',
        WFAskActionDefaultAnswerDateAndTime: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'EOD-1m',
                OutputUUID: 'BD071FCA-3F5E-45CD-B083-3D2E4F51BB12',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFAskActionPrompt: {
          Value: {
            attachmentsByRange: {
              '{5, 1}': {
                OutputName: 'Date',
                OutputUUID: '751EAB73-C760-4A40-9DDE-50CE049963E8',
                Type: 'ActionOutput',
              },
            },
            string: 'From ￼ until when?',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFInputType: 'Date and Time',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.filter.calendarevents',
      WFWorkflowActionParameters: {
        UUID: '785EA6B4-C792-439A-82BE-4958C8D772B4',
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
                      OutputName: 'End date',
                      OutputUUID: '3EAB2872-52EE-4793-A13C-E79794D3C722',
                      Type: 'ActionOutput',
                    },
                    WFSerializationType: 'WFTextTokenAttachment',
                  },
                  Date: {
                    Value: {
                      OutputName: 'Date',
                      OutputUUID: '751EAB73-C760-4A40-9DDE-50CE049963E8',
                      Type: 'ActionOutput',
                    },
                    WFSerializationType: 'WFTextTokenAttachment',
                  },
                  Number: 7,
                  Unit: 16,
                },
              },
            ],
            WFContentPredicateBoundedDate: false,
          },
          WFSerializationType: 'WFContentPredicateTableTemplate',
        },
        WFContentItemLimitEnabled: false,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.dictionary',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Empty Dictionary',
        UUID: 'EB9450A0-4C44-4A8C-80EA-32FFD8239363',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.setvariable',
      WFWorkflowActionParameters: {
        WFInput: {
          Value: {
            OutputName: 'Empty Dictionary',
            OutputUUID: 'EB9450A0-4C44-4A8C-80EA-32FFD8239363',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Calendars',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'CBB4D415-7EAF-43E8-B6A7-1525C5C1C213',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            OutputName: 'Calendar Events',
            OutputUUID: '785EA6B4-C792-439A-82BE-4958C8D772B4',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvalueforkey',
      WFWorkflowActionParameters: {
        UUID: '8A9AF143-77BE-4BC6-AC99-FF8E59E0BA37',
        WFDictionaryKey: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Aggrandizements: [
                  {
                    PropertyName: 'Calendar',
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
        WFInput: {
          Value: {
            Type: 'Variable',
            VariableName: 'Calendars',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '907D0584-C928-4F10-AB21-A7932B7DDF58',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Dictionary Value',
              OutputUUID: '8A9AF143-77BE-4BC6-AC99-FF8E59E0BA37',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.math',
      WFWorkflowActionParameters: {
        WFInput: {
          Value: {
            OutputName: 'Dictionary Value',
            OutputUUID: '8A9AF143-77BE-4BC6-AC99-FF8E59E0BA37',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFMathOperand: '1',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '907D0584-C928-4F10-AB21-A7932B7DDF58',
        WFControlFlowMode: 1,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.number',
      WFWorkflowActionParameters: {
        UUID: 'A751C30F-98C4-4E65-8D0E-DE48745E3F40',
        WFNumberActionNumber: '1',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '907D0584-C928-4F10-AB21-A7932B7DDF58',
        UUID: 'BEADEB7F-5950-494E-8BBB-8677C0BD29B4',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.setvalueforkey',
      WFWorkflowActionParameters: {
        UUID: 'EE793AB2-10F6-4BC5-A388-00596589BD6B',
        WFDictionary: {
          Value: {
            Type: 'Variable',
            VariableName: 'Calendars',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFDictionaryKey: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Aggrandizements: [
                  {
                    PropertyName: 'Calendar',
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
        WFDictionaryValue: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'If Result',
                OutputUUID: 'BEADEB7F-5950-494E-8BBB-8677C0BD29B4',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.setvariable',
      WFWorkflowActionParameters: {
        WFInput: {
          Value: {
            OutputName: 'Dictionary',
            OutputUUID: 'EE793AB2-10F6-4BC5-A388-00596589BD6B',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Calendars',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'CBB4D415-7EAF-43E8-B6A7-1525C5C1C213',
        UUID: 'D560F024-3B43-4A34-B531-F808298BB40E',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.setvariable',
      WFWorkflowActionParameters: {
        WFInput: {
          Value: {
            OutputName: 'Empty Dictionary',
            OutputUUID: 'EB9450A0-4C44-4A8C-80EA-32FFD8239363',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Calendar Labels',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'EBD046C5-2E6C-466F-99D6-E628B5EEF470',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Keys',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Calendars',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvalueforkey',
      WFWorkflowActionParameters: {
        CustomOutputName: '# Events',
        UUID: 'A16846BD-83C8-4B46-B8FB-452A561BD3F4',
        WFDictionaryKey: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Type: 'Variable',
                VariableName: 'Repeat Item',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFInput: {
          Value: {
            Type: 'Variable',
            VariableName: 'Calendars',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.setvalueforkey',
      WFWorkflowActionParameters: {
        UUID: '755FFB2D-A505-47FF-ACE8-9827DAC4F205',
        WFDictionary: {
          Value: {
            Type: 'Variable',
            VariableName: 'Calendar Labels',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFDictionaryKey: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Type: 'Variable',
                VariableName: 'Repeat Item',
              },
              '{3, 1}': {
                OutputName: '# Events',
                OutputUUID: 'A16846BD-83C8-4B46-B8FB-452A561BD3F4',
                Type: 'ActionOutput',
              },
            },
            string: '￼ (￼ events)',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFDictionaryValue: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Type: 'Variable',
                VariableName: 'Repeat Item',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.setvariable',
      WFWorkflowActionParameters: {
        WFInput: {
          Value: {
            OutputName: 'Dictionary',
            OutputUUID: '755FFB2D-A505-47FF-ACE8-9827DAC4F205',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFVariableName: 'Calendar Labels',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'EBD046C5-2E6C-466F-99D6-E628B5EEF470',
        UUID: '9FFD183D-FBC1-483B-8A06-FF02516C9A5E',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefromlist',
      WFWorkflowActionParameters: {
        UUID: '8A3CE8F1-2D21-4EF2-A913-F6C5DB2C9A04',
        WFChooseFromListActionPrompt: 'Which calendar(s) would you like to remove events from?',
        WFChooseFromListActionSelectAll: true,
        WFChooseFromListActionSelectMultiple: true,
        WFInput: {
          Value: {
            Type: 'Variable',
            VariableName: 'Calendar Labels',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '786CCF50-3303-4657-9611-7B2E70BC010B',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            OutputName: 'Calendar Events',
            OutputUUID: '785EA6B4-C792-439A-82BE-4958C8D772B4',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'E0F92588-4F66-4EE0-A829-7CAC87548509',
        WFControlFlowMode: 0,
        WFInput: {
          Value: {
            OutputName: 'Chosen Item',
            OutputUUID: '8A3CE8F1-2D21-4EF2-A913-F6C5DB2C9A04',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'CCFFDFAE-73C1-4ADD-BB35-FAA95260BB8D',
        WFCondition: 4,
        WFConditionalActionString: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Aggrandizements: [
                  {
                    PropertyName: 'Calendar',
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
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFStringContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item 2',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getvariable',
      WFWorkflowActionParameters: {
        WFVariable: {
          Value: {
            Type: 'Variable',
            VariableName: 'Repeat Item',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'CCFFDFAE-73C1-4ADD-BB35-FAA95260BB8D',
        WFControlFlowMode: 1,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.nothing',
      WFWorkflowActionParameters: {},
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'CCFFDFAE-73C1-4ADD-BB35-FAA95260BB8D',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'E0F92588-4F66-4EE0-A829-7CAC87548509',
        UUID: 'D7335E23-47E5-4B5B-90CD-DD01D2AC2313',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.repeat.each',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '786CCF50-3303-4657-9611-7B2E70BC010B',
        UUID: 'E4D5A7B9-020D-4608-9D21-EE3F0E591B5F',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefromlist',
      WFWorkflowActionParameters: {
        UUID: '2A0A2510-F2CA-4C51-8DF9-77201E18D859',
        WFChooseFromListActionPrompt: 'Which calendar event(s) would you like to delete?',
        WFChooseFromListActionSelectMultiple: true,
        WFInput: {
          Value: {
            OutputName: 'Repeat Results',
            OutputUUID: 'E4D5A7B9-020D-4608-9D21-EE3F0E591B5F',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.removeevents',
      WFWorkflowActionParameters: {
        UUID: '8D176858-DB61-4DE6-AA23-E749EB2FA5C8',
        WFInputEvents: {
          Value: {
            OutputName: 'Chosen Item',
            OutputUUID: '2A0A2510-F2CA-4C51-8DF9-77201E18D859',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
  ],
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -20702977,
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