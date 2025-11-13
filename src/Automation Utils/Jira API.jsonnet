local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Input Dict', params={
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Jira Config', params={
      keyPath: 'jira-config',
    }),

    sc.Action('ke.bou.GizmoPack.RandomDataIntent', name='Error Nonce', params={
      outputEncoding: 'hex',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['import json, requests\n\nargs, cfg, err_nonce = json.loads(r"""\n  [', sc.Ref('Input Dict', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ]), ', ', sc.Ref('Jira Config', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('ch.marcela.ada.Pyto.RunCodeIntent', {
      code: sc.Str([sc.Ref('Text')]),
      input: '',
      showConsole: false,
    }),

    sc.Action('ch.marcela.ada.Pyto.GetScriptOutputIntent', name='Output'),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      text: sc.Attach(sc.Ref('Output')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
      WFCondition: 4,
      WFConditionalActionString: sc.Str([sc.Ref('Error Nonce')]),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Item from List')),
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Error Context', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
      WFItemIndex: '2',
      WFItemRangeStart: '2',
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Error Message Lines', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
      WFItemRangeStart: '3',
      WFItemSpecifier: 'Items in Range',
    }),

    sc.Action('is.workflow.actions.text.combine', name='Error Message', params={
      text: sc.Attach(sc.Ref('Error Message Lines')),
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: sc.Str([sc.Ref('Error Message')]),
      WFAlertActionTitle: sc.Str([sc.Ref('Error Context')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.output', {
      WFOutput: sc.Str([sc.Ref('Output')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
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
