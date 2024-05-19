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
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{23, 1}': sc.Ref(outputs, 'Device Model'),
          },
          string: 'Repeat Hash Signatures.￼.started_at',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      values: sc.Ref(outputs, 'Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'ISO 8601',
          WFISO8601IncludeTime: true,
        },
      ], att=true),
    }),

    sc.Action('ch.marcela.ada.Pyto.RunCodeIntent', {
      local outputs = super.outputs,
      arguments: [
        sc.Val('${Input}', outputs),
        sc.Val('${Num Repetitions}', outputs),
      ],
      code: 'import sys, ast, hashlib\n\ndata = sys.argv[1]\nn = int(ast.literal_eval(sys.argv[2]))\n\nfor i in range(n):\n  data = hashlib.sha1(data.encode()).hexdigest()\n\nprint(data)',
      input: '',
    }),

    sc.Action('ch.marcela.ada.Pyto.GetScriptOutputIntent', name='Output'),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      local outputs = super.outputs,
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

    sc.Action('is.workflow.actions.text.replace', name='Hash Suffix', params={
      local outputs = super.outputs,
      WFInput: sc.Val('${Output}', outputs),
      WFReplaceTextFind: '.*?(.{7})$',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '...$1',
    }),

    sc.Action('is.workflow.actions.gettext', name='Result', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{18, 1}': sc.Ref(outputs, 'Num Repetitions'),
            '{32, 1}': sc.Ref(outputs, 'Time Between Dates'),
            '{48, 1}': sc.Ref(outputs, 'Hash Suffix'),
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
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{23, 1}': sc.Ref(outputs, 'Device Model'),
          },
          string: 'Repeat Hash Signatures.￼.result',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      values: sc.Ref(outputs, 'Result', att=true),
    }),

    sc.Action('is.workflow.actions.gettext', name='Prompt', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Result'),
          },
          string: '￼\n\nView leading digits?',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      local outputs = super.outputs,
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 0,
      WFMenuItems: [
        'Yes',
        'No',
      ],
      WFMenuPrompt: sc.Val('${Prompt}', outputs),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'Yes',
    }),

    sc.Action('is.workflow.actions.text.replace', name='Leading Digits', params={
      local outputs = super.outputs,
      WFInput: sc.Val('${Output}', outputs),
      WFReplaceTextFind: '.*?(\\d).*?(\\d).*?(\\d).*?(\\d).*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1$2$3$4',
    }),

    sc.Action('is.workflow.actions.showresult', {
      local outputs = super.outputs,
      Text: sc.Val('${Leading Digits}', outputs),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No',
    }),

    sc.Action('is.workflow.actions.output', {
      local outputs = super.outputs,
      WFOutput: sc.Val('${Result}', outputs),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
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
