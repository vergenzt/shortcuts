{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.gettext',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Input',
        UUID: '557C0901-48F1-4406-BB48-9BF1D341FDAC',
        WFTextActionText: 'Screen Time Passcode',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.gettext',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Num Repetitions',
        UUID: '13CD3D97-5F7C-460E-9E3C-B8C08DE7EB67',
        WFTextActionText: '500_000_000',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getdevicedetails',
      WFWorkflowActionParameters: {
        UUID: '8099AC4C-6BB9-4F62-A650-AA5B22EE4C55',
        WFDeviceDetail: 'Device Model',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.date',
      WFWorkflowActionParameters: {
        UUID: '192673B0-AC02-4FB9-8BA0-32844BE3836C',
      },
    },
    {
      WFWorkflowActionIdentifier: 'dk.simonbs.DataJar.SetValueIntent',
      WFWorkflowActionParameters: {
        UUID: '7FF4C2E6-FF50-47C3-B483-C1173C3D2986',
        keyPath: {
          Value: {
            attachmentsByRange: {
              '{23, 1}': {
                OutputName: 'Device Model',
                OutputUUID: '8099AC4C-6BB9-4F62-A650-AA5B22EE4C55',
                Type: 'ActionOutput',
              },
            },
            string: 'Repeat Hash Signatures.￼.started_at',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        values: {
          Value: {
            Aggrandizements: [
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'ISO 8601',
                WFISO8601IncludeTime: true,
              },
            ],
            OutputName: 'Date',
            OutputUUID: '192673B0-AC02-4FB9-8BA0-32844BE3836C',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'ch.marcela.ada.Pyto.RunCodeIntent',
      WFWorkflowActionParameters: {
        UUID: 'F9DFD763-FD68-42E7-AFF7-EC9AB00F46CB',
        arguments: [
          {
            Value: {
              attachmentsByRange: {
                '{0, 1}': {
                  OutputName: 'Input',
                  OutputUUID: '557C0901-48F1-4406-BB48-9BF1D341FDAC',
                  Type: 'ActionOutput',
                },
              },
              string: '￼',
            },
            WFSerializationType: 'WFTextTokenString',
          },
          {
            Value: {
              attachmentsByRange: {
                '{0, 1}': {
                  OutputName: 'Num Repetitions',
                  OutputUUID: '13CD3D97-5F7C-460E-9E3C-B8C08DE7EB67',
                  Type: 'ActionOutput',
                },
              },
              string: '￼',
            },
            WFSerializationType: 'WFTextTokenString',
          },
        ],
        code: 'import sys, ast, hashlib\n\ndata = sys.argv[1]\nn = int(ast.literal_eval(sys.argv[2]))\n\nfor i in range(n):\n  data = hashlib.sha1(data.encode()).hexdigest()\n\nprint(data)',
        input: '',
      },
    },
    {
      WFWorkflowActionIdentifier: 'ch.marcela.ada.Pyto.GetScriptOutputIntent',
      WFWorkflowActionParameters: {
        UUID: '2676F0E1-DE77-48AE-B71E-F6208BEADD0F',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.gettimebetweendates',
      WFWorkflowActionParameters: {
        UUID: '37C27230-8F02-4D84-A441-B10A14AB5F6A',
        WFInput: {
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
        WFTimeUntilFromDate: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Date',
                OutputUUID: '192673B0-AC02-4FB9-8BA0-32844BE3836C',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFTimeUntilUnit: 'Seconds',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.replace',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Hash Suffix',
        UUID: 'F5A841DE-858A-43A2-A55A-8197EBCA5811',
        WFInput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Output',
                OutputUUID: '2676F0E1-DE77-48AE-B71E-F6208BEADD0F',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFReplaceTextFind: '.*?(.{7})$',
        WFReplaceTextRegularExpression: true,
        WFReplaceTextReplace: '...$1',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.gettext',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Result',
        UUID: 'A825FF52-2759-4E67-BD28-583C27388967',
        WFTextActionText: {
          Value: {
            attachmentsByRange: {
              '{18, 1}': {
                OutputName: 'Num Repetitions',
                OutputUUID: '13CD3D97-5F7C-460E-9E3C-B8C08DE7EB67',
                Type: 'ActionOutput',
              },
              '{32, 1}': {
                OutputName: 'Time Between Dates',
                OutputUUID: '37C27230-8F02-4D84-A441-B10A14AB5F6A',
                Type: 'ActionOutput',
              },
              '{48, 1}': {
                OutputName: 'Hash Suffix',
                OutputUUID: 'F5A841DE-858A-43A2-A55A-8197EBCA5811',
                Type: 'ActionOutput',
              },
              '{62, 1}': {
                Aggrandizements: [
                  {
                    Type: 'WFDateFormatVariableAggrandizement',
                    WFDateFormatStyle: 'ISO 8601',
                    WFISO8601IncludeTime: true,
                  },
                ],
                OutputName: 'Date',
                OutputUUID: '192673B0-AC02-4FB9-8BA0-32844BE3836C',
                Type: 'ActionOutput',
              },
            },
            string: 'Hash repetitions: ￼\nTotal time: ￼s\nHash suffix: ￼\nStarted at: ￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'dk.simonbs.DataJar.SetValueIntent',
      WFWorkflowActionParameters: {
        UUID: '4C321391-C11D-4FD2-A0E2-062638082243',
        keyPath: {
          Value: {
            attachmentsByRange: {
              '{23, 1}': {
                OutputName: 'Device Model',
                OutputUUID: '8099AC4C-6BB9-4F62-A650-AA5B22EE4C55',
                Type: 'ActionOutput',
              },
            },
            string: 'Repeat Hash Signatures.￼.result',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        values: {
          Value: {
            OutputName: 'Result',
            OutputUUID: 'A825FF52-2759-4E67-BD28-583C27388967',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.gettext',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Prompt',
        UUID: '7216B996-5BBB-4476-A4DA-1096E8B3D668',
        WFTextActionText: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Result',
                OutputUUID: 'A825FF52-2759-4E67-BD28-583C27388967',
                Type: 'ActionOutput',
              },
            },
            string: '￼\n\nView leading digits?',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
        WFControlFlowMode: 0,
        WFMenuItems: [
          'Yes',
          'No',
        ],
        WFMenuPrompt: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Prompt',
                OutputUUID: '7216B996-5BBB-4476-A4DA-1096E8B3D668',
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
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
        WFControlFlowMode: 1,
        WFMenuItemTitle: 'Yes',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.replace',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Leading Digits',
        UUID: '46896B58-84DD-4DE4-8793-F7D8C78522CD',
        WFInput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Output',
                OutputUUID: '2676F0E1-DE77-48AE-B71E-F6208BEADD0F',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFReplaceTextFind: '.*?(\\d).*?(\\d).*?(\\d).*?(\\d).*',
        WFReplaceTextRegularExpression: true,
        WFReplaceTextReplace: '$1$2$3$4',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.showresult',
      WFWorkflowActionParameters: {
        Text: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Leading Digits',
                OutputUUID: '46896B58-84DD-4DE4-8793-F7D8C78522CD',
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
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
        WFControlFlowMode: 1,
        WFMenuItemTitle: 'No',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.output',
      WFWorkflowActionParameters: {
        WFOutput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Result',
                OutputUUID: 'A825FF52-2759-4E67-BD28-583C27388967',
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
      WFWorkflowActionIdentifier: 'is.workflow.actions.choosefrommenu',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
        UUID: '22DE96B7-A742-4E8E-9A23-52ECA914A24F',
        WFControlFlowMode: 2,
      },
    },
  ],
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 946986751,
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
  WFWorkflowOutputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowTypes: [],
}
