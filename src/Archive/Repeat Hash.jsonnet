local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Input', params={
      WFTextActionText: 'Screen Time Passcode',
    }),

    sc.Action('is.workflow.actions.gettext', name='Num Repetitions', params={
      WFTextActionText: '500_000_000',
    }),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      local outputs = super.outputs,
      UUID: '7FF4C2E6-FF50-47C3-B483-C1173C3D2986',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{23, 1}': sc.Ref(outputs, 'Device Model'),
          },
          string: 'Repeat Hash Signatures.￼.started_at',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      values: {
        Value: sc.Ref(outputs, 'Date', aggs=[
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ]),
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('ch.marcela.ada.Pyto.RunCodeIntent', {
      local outputs = super.outputs,
      UUID: 'F9DFD763-FD68-42E7-AFF7-EC9AB00F46CB',
      arguments: [
        sc.Val('${Input}', outputs),
        sc.Val('${Num Repetitions}', outputs),
      ],
      code: 'import sys, ast, hashlib\n\ndata = sys.argv[1]\nn = int(ast.literal_eval(sys.argv[2]))\n\nfor i in range(n):\n  data = hashlib.sha1(data.encode()).hexdigest()\n\nprint(data)',
      input: '',
    }),

    sc.Action('ch.marcela.ada.Pyto.GetScriptOutputIntent', {
      UUID: '2676F0E1-DE77-48AE-B71E-F6208BEADD0F',
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', {
      local outputs = super.outputs,
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
      WFTimeUntilFromDate: sc.Val('${Date}', outputs),
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.Action('is.workflow.actions.text.replace', {
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
    }),

    sc.Action('is.workflow.actions.gettext', {
      local outputs = super.outputs,
      CustomOutputName: 'Result',
      UUID: 'A825FF52-2759-4E67-BD28-583C27388967',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{18, 1}': sc.Ref(outputs, 'Num Repetitions'),
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
            '{62, 1}': sc.Ref(outputs, 'Date', aggs=[
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'ISO 8601',
                WFISO8601IncludeTime: true,
              },
            ]),
          },
          string: 'Hash repetitions: ￼\nTotal time: ￼s\nHash suffix: ￼\nStarted at: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      local outputs = super.outputs,
      UUID: '4C321391-C11D-4FD2-A0E2-062638082243',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{23, 1}': sc.Ref(outputs, 'Device Model'),
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

    sc.Action('is.workflow.actions.gettext', {
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
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
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

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'Yes',
    }),

    sc.Action('is.workflow.actions.text.replace', {
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
    }),

    sc.Action('is.workflow.actions.showresult', {
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

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No',
    }),

    sc.Action('is.workflow.actions.output', {
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

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      UUID: '22DE96B7-A742-4E8E-9A23-52ECA914A24F',
      WFControlFlowMode: 2,
    }),

  ]),
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
