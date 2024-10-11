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
      keyPath: sc.Str(['Repeat Hash Signatures.', sc.Ref('Device Model'), '.started_at']),
      values: sc.Attach(sc.Ref('Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'ISO 8601',
          WFISO8601IncludeTime: true,
        },
      ])),
    }),

    sc.Action('ch.marcela.ada.Pyto.RunCodeIntent', {
      arguments: [
        sc.Str([sc.Ref('Input')]),
        sc.Str([sc.Ref('Num Repetitions')]),
      ],
      code: |||
        import sys, ast, hashlib

        data = sys.argv[1]
        n = int(ast.literal_eval(sys.argv[2]))

        for i in range(n):
          data = hashlib.sha1(data.encode()).hexdigest()

        print(data)
      |||,
      input: '',
    }),

    sc.Action('ch.marcela.ada.Pyto.GetScriptOutputIntent', name='Output'),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      WFInput: sc.Str([{
        Type: 'CurrentDate',
      }]),
      WFTimeUntilFromDate: sc.Str([sc.Ref('Date')]),
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.Action('is.workflow.actions.text.replace', name='Hash Suffix', params={
      WFInput: sc.Str([sc.Ref('Output')]),
      WFReplaceTextFind: '.*?(.{7})$',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '...$1',
    }),

    sc.Action('is.workflow.actions.gettext', name='Result', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{18, 1}': sc.Ref('Num Repetitions'),
            '{32, 1}': sc.Ref('Time Between Dates'),
            '{48, 1}': sc.Ref('Hash Suffix'),
            '{62, 1}': sc.Ref('Date', aggs=[
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'ISO 8601',
                WFISO8601IncludeTime: true,
              },
            ]),
          },
          string: |||
            Hash repetitions: ￼
            Total time: ￼s
            Hash suffix: ￼
            Started at: ￼
          |||,
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: sc.Str(['Repeat Hash Signatures.', sc.Ref('Device Model'), '.result']),
      values: sc.Attach(sc.Ref('Result')),
    }),

    sc.Action('is.workflow.actions.gettext', name='Prompt', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Result'),
          },
          string: |||
            ￼

            View leading digits?
          |||,
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
      WFMenuPrompt: sc.Str([sc.Ref('Prompt')]),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'Yes',
    }),

    sc.Action('is.workflow.actions.text.replace', name='Leading Digits', params={
      WFInput: sc.Str([sc.Ref('Output')]),
      WFReplaceTextFind: '.*?(\\d).*?(\\d).*?(\\d).*?(\\d).*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1$2$3$4',
    }),

    sc.Action('is.workflow.actions.showresult', {
      Text: sc.Str([sc.Ref('Leading Digits')]),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '4BD0FCCB-729B-4037-8F49-4582958A0C52',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No',
    }),

    sc.Action('is.workflow.actions.output', {
      WFOutput: sc.Str([sc.Ref('Result')]),
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
