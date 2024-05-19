local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Input', params={
      local state = super.state,
      WFTextActionText: 'Screen Time Passcode',
    }),

    sc.Action('is.workflow.actions.gettext', name='Num Repetitions', params={
      local state = super.state,
      WFTextActionText: '500_000_000',
    }),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      local state = super.state,
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      local state = super.state,
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{23, 1}': sc.Ref(state, 'Device Model'),
          },
          string: 'Repeat Hash Signatures.￼.started_at',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      values: sc.Ref(state, 'Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'ISO 8601',
          WFISO8601IncludeTime: true,
        },
      ], att=true),
    }),

    sc.Action('ch.marcela.ada.Pyto.RunCodeIntent', {
      local state = super.state,
      arguments: [
        sc.Val('${Input}', state),
        sc.Val('${Num Repetitions}', state),
      ],
      code: 'import sys, ast, hashlib\n\ndata = sys.argv[1]\nn = int(ast.literal_eval(sys.argv[2]))\n\nfor i in range(n):\n  data = hashlib.sha1(data.encode()).hexdigest()\n\nprint(data)',
      input: '',
    }),

    sc.Action('ch.marcela.ada.Pyto.GetScriptOutputIntent', name='Output'),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      local state = super.state,
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
      WFTimeUntilFromDate: sc.Val('${Date}', state),
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.Action('is.workflow.actions.text.replace', name='Hash Suffix', params={
      local state = super.state,
      WFInput: sc.Val('${Output}', state),
      WFReplaceTextFind: '.*?(.{7})$',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '...$1',
    }),

    sc.Action('is.workflow.actions.gettext', name='Result', params={
      local state = super.state,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{18, 1}': sc.Ref(state, 'Num Repetitions'),
            '{32, 1}': sc.Ref(state, 'Time Between Dates'),
            '{48, 1}': sc.Ref(state, 'Hash Suffix'),
            '{62, 1}': sc.Ref(state, 'Date', aggs=[
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
      local state = super.state,
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{23, 1}': sc.Ref(state, 'Device Model'),
          },
          string: 'Repeat Hash Signatures.￼.result',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      values: sc.Ref(state, 'Result', att=true),
    }),

    sc.Action('is.workflow.actions.gettext', name='Prompt', params={
      local state = super.state,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Result'),
          },
          string: '￼\n\nView leading digits?',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      local state = super.state,
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 0,
      WFMenuItems: [
        'Yes',
        'No',
      ],
      WFMenuPrompt: sc.Val('${Prompt}', state),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      local state = super.state,
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'Yes',
    }),

    sc.Action('is.workflow.actions.text.replace', name='Leading Digits', params={
      local state = super.state,
      WFInput: sc.Val('${Output}', state),
      WFReplaceTextFind: '.*?(\\d).*?(\\d).*?(\\d).*?(\\d).*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1$2$3$4',
    }),

    sc.Action('is.workflow.actions.showresult', {
      local state = super.state,
      Text: sc.Val('${Leading Digits}', state),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      local state = super.state,
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No',
    }),

    sc.Action('is.workflow.actions.output', {
      local state = super.state,
      WFOutput: sc.Val('${Result}', state),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      local state = super.state,
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
