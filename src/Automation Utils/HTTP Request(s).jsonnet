local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
      'is',
      {
        WFConditionalActionString: 'Mac',
      }
    )).Then_([

      sc.Action('is.workflow.actions.gettext', name='Text', params={
        WFTextActionText: |||
          jq -c 'if type == \"array\" then .[] else . end' \\
            | parallel '\\
              curl \\
              --no-progress-meter \\
              --fail-with-body \\
              --url {[ [.base_url, .path] | join(\"/\") ]} \\
              {[ .method // empty | \"--request\", . ]} \\
              {[ .params // empty | to_entries | map(\"--url-query\", \"\\(.key)=\\(.value)\")[] ]} \\
              {[ .data // empty | to_entries | map(\"--data-urlencode\", \"(\\.key)=\\(.value)\")[] ]} \\
              {[ .form // empty | to_entries | map(\"--form-string\", \"(\\.key)=\\(.value)\")[] ]} \\
              {[ .json // empty | \"--json\", . ]}
        |||,
      }),

      sc.Action('is.workflow.actions.runshellscript', name='Shell Script Result', params={
        Input: sc.Attach(sc.Input),
        InputMode: 'to stdin',
        Script: sc.Str([sc.Ref('Text')]),
      }),

      sc.Action('is.workflow.actions.previewdocument', {
        WFInput: sc.Attach(sc.Ref('Shell Script Result')),
      }),

    ]).EndIf_(),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
      'is',
      {
        WFConditionalActionString: 'iPhone',
      }
    )).Then_([

      sc.Action('is.workflow.actions.gettext', name='Text'),

      sc.Action('dk.simonbs.Scriptable.RunScriptInlineIntent', {
        'Show-texts': false,
        'Show-urls': false,
        ShowWhenRun: false,
        parameter: [],
        script: sc.Str([sc.Ref('Text')]),
        texts: sc.Str([sc.Ref('Input Dict')]),
      }),

    ]).EndIf_(),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 431817727,
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
  WFWorkflowTypes: [],
}
