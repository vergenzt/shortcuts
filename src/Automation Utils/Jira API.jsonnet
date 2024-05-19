local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Input Dict', params={
      WFInput: sc.Ref(outputs, 'Shortcut Input', att=true),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Jira Config', params={
      keyPath: 'jira-config',
    }),

    sc.Action('ke.bou.GizmoPack.RandomDataIntent', name='Error Nonce', params={
      outputEncoding: 'hex',
    }),

    sc.Action('ch.marcela.ada.Pyto.RunCodeIntent', {
      local outputs = super.outputs,
      code: {
        Value: {
          attachmentsByRange: {
            '{65, 1}': sc.Ref(outputs, 'Input Dict'),
            '{68, 1}': sc.Ref(outputs, 'Jira Config'),
            '{72, 1}': sc.Ref(outputs, 'Error Nonce'),
          },
          string: 'import json, requests\n\nargs, cfg, err_nonce = json.loads(r"""\n  [￼, ￼, "￼"]\n""")\n\nresp = requests.request(\n  url=cfg["base_url"] + args.pop("path"),\n  **args,\n  auth=requests.auth.HTTPBasicAuth(\n    cfg["username"],\n    cfg["api_token"]\n  ),\n)\n\nif not resp.ok:\n  print(err_nonce)\n  print("On", resp.request.method, resp.request.path_url)\n  print("Error", resp.status_code, resp.reason)\n\nprint(resp.text)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      input: '',
      showConsole: false,
    }),

    sc.Action('ch.marcela.ada.Pyto.GetScriptOutputIntent', name='Output'),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      local outputs = super.outputs,
      text: sc.Ref(outputs, 'Output', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Split Text', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
      WFCondition: 4,
      WFConditionalActionString: sc.Val('${Error Nonce}', outputs),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Item from List', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Error Context', params={
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Split Text', att=true),
      WFItemIndex: '2',
      WFItemRangeStart: '2',
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Error Message Lines', params={
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Split Text', att=true),
      WFItemRangeStart: '3',
      WFItemSpecifier: 'Items in Range',
    }),

    sc.Action('is.workflow.actions.text.combine', name='Error Message', params={
      local outputs = super.outputs,
      text: sc.Ref(outputs, 'Error Message Lines', att=true),
    }),

    sc.Action('is.workflow.actions.alert', {
      local outputs = super.outputs,
      WFAlertActionMessage: sc.Val('${Error Message}', outputs),
      WFAlertActionTitle: sc.Val('${Error Context}', outputs),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.output', {
      local outputs = super.outputs,
      WFOutput: sc.Val('${Output}', outputs),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -615917313,
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
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFStringContentItem',
    },
  },
  WFWorkflowOutputContentItemClasses: [
    'WFGenericFileContentItem',
  ],
  WFWorkflowTypes: [
    'Watch',
  ],
}
