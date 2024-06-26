local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      local state = super.state,
      WFDeviceDetail: 'Device Model',
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '6C16A978-32F1-45D5-A028-BFFC2A301E17',
      WFCondition: 4,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Device Model', att=true),
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      local state = super.state,
      WFTextActionText: "jq -c 'if type == \"array\" then .[] else . end' \\\n| parallel '\\\n  curl \\\n  --no-progress-meter \\\n  --fail-with-body \\\n  --url {[ [.base_url, .path] | join(\"/\") ]} \\\n  {[ .method // empty | \"--request\", . ]} \\\n  {[ .params // empty | to_entries | map(\"--url-query\", \"\\(.key)=\\(.value)\")[] ]} \\\n  {[ .data // empty | to_entries | map(\"--data-urlencode\", \"(\\.key)=\\(.value)\")[] ]} \\\n  {[ .form // empty | to_entries | map(\"--form-string\", \"(\\.key)=\\(.value)\")[] ]} \\\n  {[ .json // empty | \"--json\", . ]}",
    }),

    sc.Action('is.workflow.actions.runshellscript', name='Shell Script Result', params={
      local state = super.state,
      Input: sc.Ref(state, 'Shortcut Input', att=true),
      InputMode: 'to stdin',
      Script: sc.Val('${Text}', state),
    }),

    sc.Action('is.workflow.actions.previewdocument', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Shell Script Result', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '6C16A978-32F1-45D5-A028-BFFC2A301E17',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: 'B4F4A155-D1B9-4A89-AA17-1A9CBA5CFE54',
      WFCondition: 4,
      WFConditionalActionString: 'iPhone',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Device Model', att=true),
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Text'),

    sc.Action('dk.simonbs.Scriptable.RunScriptInlineIntent', {
      local state = super.state,
      'Show-texts': false,
      'Show-urls': false,
      ShowWhenRun: false,
      parameter: [],
      script: sc.Val('${Text}', state),
      texts: sc.Val('${Input Dict}', state),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: 'B4F4A155-D1B9-4A89-AA17-1A9CBA5CFE54',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
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
