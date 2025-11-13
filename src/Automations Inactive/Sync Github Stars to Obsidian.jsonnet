local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Empty'),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Latest Page Etag', params={
      fallbackValues: sc.Attach(sc.Ref('Empty')),
      keyPath: 'github-stars-obsidian-sync.latestPageEtag',
    }),

    sc.Action('is.workflow.actions.gettext', name='Initial Page URL', params={
      WFTextActionText: 'https://api.github.com/users/vergenzt/starred?direction=asc',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Latest Page URL', params={
      fallbackValues: sc.Attach(sc.Ref('Initial Page URL')),
      keyPath: 'github-stars-obsidian-sync.latestPageUrl',
    }),

    sc.Action('is.workflow.actions.gettext', name='HEAD', params={
      WFTextActionText: 'HEAD',
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      ShowHeaders: true,
      WFHTTPBodyType: 'File',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Accept']),
              WFValue: sc.Str(['application/vnd.github.star+json']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['If-None-Match']),
              WFValue: sc.Str([sc.Ref('Latest Page Etag')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFHTTPMethod: sc.Attach(sc.Ref('HEAD')),
      WFRequestVariable: sc.Attach(sc.Ref('Empty')),
      WFURL: sc.Str([sc.Ref('Latest Page URL')]),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -1263359489,
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
