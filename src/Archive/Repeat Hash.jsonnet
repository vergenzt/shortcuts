local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.gettext', label='Input', params={
      UUID: '557C0901-48F1-4406-BB48-9BF1D341FDAC',
      WFTextActionText: 'Screen Time Passcode',
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', label='Num Repetitions', params={
      UUID: '13CD3D97-5F7C-460E-9E3C-B8C08DE7EB67',
      WFTextActionText: '500_000_000',
    }),

    [_()]: lib.Action('is.workflow.actions.getdevicedetails', {
      UUID: '8099AC4C-6BB9-4F62-A650-AA5B22EE4C55',
      WFDeviceDetail: 'Device Model',
    }),

    [_()]: lib.Action('is.workflow.actions.date', {
      UUID: '192673B0-AC02-4FB9-8BA0-32844BE3836C',
    }),

    [_()]: lib.Action('dk.simonbs.DataJar.SetValueIntent', {
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
    }),

    [_()]: lib.Action('ch.marcela.ada.Pyto.RunCodeIntent', {
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
    }),

    [_()]: lib.Action('ch.marcela.ada.Pyto.GetScriptOutputIntent', {
      UUID: '2676F0E1-DE77-48AE-B71E-F6208BEADD0F',
    }),

    [_()]: lib.Action('is.workflow.actions.gettimebetweendates', {
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
    }),

    [_()]: lib.Action('is.workflow.actions.text.replace', label='Hash Suffix', params={
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
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', label='Result', params={
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
    }),

    [_()]: lib.Action('dk.simonbs.DataJar.SetValueIntent', {
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
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', label='Prompt', params={
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
    }),

    [_()]: lib.Action('is.workflow.actions.choosefrommenu', {
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
    }),

    [_()]: lib.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'Yes',
    }),

    [_()]: lib.Action('is.workflow.actions.text.replace', label='Leading Digits', params={
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
    }),

    [_()]: lib.Action('is.workflow.actions.showresult', {
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
    }),

    [_()]: lib.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No',
    }),

    [_()]: lib.Action('is.workflow.actions.output', {
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
    }),

    [_()]: lib.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      UUID: '22DE96B7-A742-4E8E-9A23-52ECA914A24F',
      WFControlFlowMode: 2,
    }),
  }),
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
