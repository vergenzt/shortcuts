local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Jira Config', params={
      keyPath: 'jira-config',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: sc.Attach(sc.Ref('Jira Config')),
      jqQuery: '"\\(.username):\\(.api_token)" | @base64',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.setvalueforkey', {
      WFDictionary: sc.Attach(sc.Ref('Jira Config', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])),
      WFDictionaryKey: 'authorization',
      WFDictionaryValue: sc.Str(['Basic ', sc.Ref('Result')]),
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59749,
    WFWorkflowIconStartColor: 2071128575,
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
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'Watch',
  ],
}
