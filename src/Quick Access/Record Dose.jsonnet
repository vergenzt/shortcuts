local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.runworkflow', label='Google OAuth', params={
      UUID: '09C69E37-59F0-4E5B-B93E-534E039A893A',
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '410F7B2D-3951-4BAE-A70D-514A8986662E',
        workflowName: 'Google OAuth',
      },
      WFWorkflowName: 'Google OAuth',
    }),

    [_()]: lib.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '57353387-EAC4-4E94-BC79-77002F6DC116',
      keyPath: 'dose-recorder',
    }),

    [_()]: lib.Action('is.workflow.actions.url', {
      UUID: '348BBF71-FD66-4818-B93C-DFDA9AB2C3CF',
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{46, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'spreadsheetId',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '57353387-EAC4-4E94-BC79-77002F6DC116',
              Type: 'ActionOutput',
            },
          },
          string: 'https://sheets.googleapis.com/v4/spreadsheets/￼/values',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.urlencode', label='menuRange', params={
      UUID: 'DD6409FC-FC37-4E71-9134-A39743C3603E',
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
                  DictionaryKey: 'menuRange',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '57353387-EAC4-4E94-BC79-77002F6DC116',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.downloadurl', {
      ShowHeaders: false,
      UUID: 'C47AC355-7C70-48B0-9F56-2FADFEB4A019',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Authorization',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Google OAuth',
                      OutputUUID: '09C69E37-59F0-4E5B-B93E-534E039A893A',
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
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'URL',
              OutputUUID: '348BBF71-FD66-4818-B93C-DFDA9AB2C3CF',
              Type: 'ActionOutput',
            },
            '{2, 1}': {
              OutputName: 'menuRange',
              OutputUUID: 'DD6409FC-FC37-4E71-9134-A39743C3603E',
              Type: 'ActionOutput',
            },
          },
          string: '￼/￼?valueRenderOption=FORMATTED_VALUE',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '12455693-4B6E-4486-BAD9-730E939E6984',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'values',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          OutputName: 'Contents of URL',
          OutputUUID: 'C47AC355-7C70-48B0-9F56-2FADFEB4A019',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.getitemfromlist', {
      UUID: '796988DD-F959-4F01-A4C9-EBBD16E96167',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '12455693-4B6E-4486-BAD9-730E939E6984',
      UUID: '7F605F6F-7084-4C8F-A3FB-E345647B513F',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.choosefromlist', {
      UUID: '309641A0-9081-4DD8-A60F-7E142B3E4E46',
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '7F605F6F-7084-4C8F-A3FB-E345647B513F',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.text.match', {
      UUID: 'FFC33375-004B-4559-961D-04E90725DD0F',
      WFMatchTextPattern: 'Other',
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Chosen Item',
              OutputUUID: '309641A0-9081-4DD8-A60F-7E142B3E4E46',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF4D8839-949A-412C-9955-483681D84092',
      WFCondition: 100,
      WFConditionalActionString: 'Other',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Matches',
            OutputUUID: 'FFC33375-004B-4559-961D-04E90725DD0F',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.ask', {
      UUID: '11D25B5E-144E-407B-96D2-4E6483D62DBE',
      WFAskActionPrompt: 'Other',
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Provided Input',
          OutputUUID: '11D25B5E-144E-407B-96D2-4E6483D62DBE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Med',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF4D8839-949A-412C-9955-483681D84092',
      WFControlFlowMode: 1,
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Chosen Item',
          OutputUUID: '309641A0-9081-4DD8-A60F-7E142B3E4E46',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Med',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF4D8839-949A-412C-9955-483681D84092',
      UUID: '5F07A628-CD45-4254-B2AB-87684FEB9F38',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.ask', {
      UUID: 'E870D204-6D15-45AF-8A7D-302D211C8E25',
      WFAskActionDefaultAnswerDateAndTime: '',
      WFInputType: 'Date and Time',
    }),

    [_()]: lib.Action('is.workflow.actions.format.date', {
      UUID: '43212188-F76D-40D5-A3F5-FF573F34800C',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Provided Input',
              OutputUUID: 'E870D204-6D15-45AF-8A7D-302D211C8E25',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDateFormat: 'yyyy-MM-dd HH:mm',
      WFDateFormatStyle: 'Custom',
      WFISO8601IncludeTime: true,
      WFTimeFormatStyle: 'Long',
    }),

    [_()]: lib.Action('is.workflow.actions.ask', {
      UUID: '1671F713-DC49-4D7C-9A15-3BF2F559587A',
      WFAskActionDefaultAnswer: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Variable',
              VariableName: 'Med',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: {
        Value: {
          attachmentsByRange: {
            '{13, 1}': {
              OutputName: 'Formatted Date',
              OutputUUID: '43212188-F76D-40D5-A3F5-FF573F34800C',
              Type: 'ActionOutput',
            },
          },
          string: 'Record dose? ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Provided Input',
          OutputUUID: '1671F713-DC49-4D7C-9A15-3BF2F559587A',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Med',
    }),

    [_()]: lib.Action('is.workflow.actions.urlencode', label='dataRange', params={
      UUID: '14227708-44D7-4EC8-AEAB-71AA558092E8',
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
                  DictionaryKey: 'dataRange',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '57353387-EAC4-4E94-BC79-77002F6DC116',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.downloadurl', {
      ShowHeaders: true,
      UUID: '4AB123A5-1C39-42B0-9264-BBC6DFB7DE2F',
      WFFormValues: {
        Value: {
          WFDictionaryFieldValueItems: [],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFHTTPBodyType: 'JSON',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'Authorization',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Google OAuth',
                      OutputUUID: '09C69E37-59F0-4E5B-B93E-534E039A893A',
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
      WFHTTPMethod: 'POST',
      WFJSONValues: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 2,
              WFKey: {
                Value: {
                  string: 'values',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: [
                  {
                    WFItemType: 2,
                    WFValue: {
                      Value: [
                        {
                          WFItemType: 0,
                          WFValue: {
                            Value: {
                              attachmentsByRange: {
                                '{0, 1}': {
                                  OutputName: 'Formatted Date',
                                  OutputUUID: '43212188-F76D-40D5-A3F5-FF573F34800C',
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
                          WFValue: {
                            Value: {
                              attachmentsByRange: {
                                '{0, 1}': {
                                  Type: 'Variable',
                                  VariableName: 'Med',
                                },
                              },
                              string: '￼',
                            },
                            WFSerializationType: 'WFTextTokenString',
                          },
                        },
                      ],
                      WFSerializationType: 'WFArrayParameterState',
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
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'URL',
              OutputUUID: '348BBF71-FD66-4818-B93C-DFDA9AB2C3CF',
              Type: 'ActionOutput',
            },
            '{2, 1}': {
              OutputName: 'dataRange',
              OutputUUID: '14227708-44D7-4EC8-AEAB-71AA558092E8',
              Type: 'ActionOutput',
            },
          },
          string: '￼/￼:append?valueInputOption=USER_ENTERED',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.alert', {
      WFAlertActionTitle: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Contents of URL',
              OutputUUID: '4AB123A5-1C39-42B0-9264-BBC6DFB7DE2F',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.runworkflow', {
      UUID: 'F004584E-2AC9-4A66-A039-0C5A8255D4BE',
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'D5DEBDFA-5540-4CBE-A707-122DDBF6E907',
        workflowName: 'Dose History',
      },
      WFWorkflowName: 'Dose History',
    }),

    [_()]: lib.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '0937D1D5-A680-418A-AD7E-0EE31DBAA43B',
      WFControlFlowMode: 0,
      WFMenuItems: [
        'I’d like an alarm. I’ll copy the time to clipboard and return to Shortcuts.',
        'No alarm please.',
      ],
      WFMenuPrompt: 'Would you like to set an alarm?',
    }),

    [_()]: lib.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '0937D1D5-A680-418A-AD7E-0EE31DBAA43B',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'I’d like an alarm. I’ll copy the time to clipboard and return to Shortcuts.',
    }),

    [_()]: lib.Action('is.workflow.actions.waittoreturn', {}),

    [_()]: lib.Action('is.workflow.actions.alert', {
      WFAlertActionTitle: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDateContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormat: 'yyyy-dd-MM H:mm',
                  WFDateFormatStyle: 'Custom',
                  WFISO8601IncludeTime: false,
                },
              ],
              Type: 'Clipboard',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.format.date', {
      UUID: 'B1E271A1-E39F-464A-AEF5-32DCDBCB756A',
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDateContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormat: 'yyyy-dd-MM H:mm',
                  WFDateFormatStyle: 'Custom',
                  WFISO8601IncludeTime: false,
                },
              ],
              Type: 'Clipboard',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDateFormat: 'h:mm:ss a',
      WFDateFormatStyle: 'Custom',
      WFISO8601IncludeTime: false,
    }),

    [_()]: lib.Action('is.workflow.actions.alert', {
      WFAlertActionTitle: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Formatted Date',
              OutputUUID: 'B1E271A1-E39F-464A-AEF5-32DCDBCB756A',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.ask', {
      UUID: '3CF87CAB-7F31-4867-B6AC-3CD889F413BC',
      WFAskActionDefaultAnswerDateAndTime: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Formatted Date',
              OutputUUID: 'B1E271A1-E39F-464A-AEF5-32DCDBCB756A',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionDefaultAnswerTime: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Formatted Date',
              OutputUUID: 'B1E271A1-E39F-464A-AEF5-32DCDBCB756A',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: 'Alarm time',
      WFInputType: 'Time',
    }),

    [_()]: lib.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.clock',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      UUID: '9414FB3E-D730-48FA-B8A0-BBA6F6D1E30B',
      dateComponents: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Provided Input',
              OutputUUID: '3CF87CAB-7F31-4867-B6AC-3CD889F413BC',
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
              Type: 'Variable',
              VariableName: 'Med',
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

    [_()]: lib.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '0937D1D5-A680-418A-AD7E-0EE31DBAA43B',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No alarm please.',
    }),

    [_()]: lib.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '0937D1D5-A680-418A-AD7E-0EE31DBAA43B',
      UUID: '389490C3-0427-4320-A79C-E3605929C7BD',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.detect.date', {
      WFInput: {
        Value: {
          OutputName: 'Menu Result',
          OutputUUID: '389490C3-0427-4320-A79C-E3605929C7BD',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59461,
    WFWorkflowIconStartColor: 1440408063,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFAppStoreAppContentItem',
    'WFArticleContentItem',
    'WFContactContentItem',
    'WFDateContentItem',
    'WFEmailAddressContentItem',
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
