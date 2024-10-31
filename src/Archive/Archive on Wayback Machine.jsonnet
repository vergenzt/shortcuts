local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.urlencode', name='Encoded URL', params={
      WFInput: sc.Str([sc.Input]),
    }),

    sc.Action('is.workflow.actions.gettext', name='Archive Save URL', params={
      WFTextActionText: sc.Str(['https://web.archive.org/save/', sc.Ref('Encoded URL')]),
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      ShowHeaders: false,
      WFFormValues: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['url']),
              WFValue: sc.Str([sc.Ref('Vars.URL')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFHTTPBodyType: 'Form',
      WFHTTPMethod: 'POST',
      WFURL: sc.Str([sc.Ref('Archive Save URL')]),
    }),

    sc.Action('is.workflow.actions.gettext', name='Archive Root URL', params={
      WFTextActionText: sc.Str(['https://web.archive.org/web/', sc.Ref('Encoded URL')]),
    }),

    sc.Action('is.workflow.actions.url.getheaders', name='Headers of URL', params={
      WFInput: sc.Str([sc.Ref('Archive Root URL')]),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Link Header', params={
      WFDictionaryKey: 'Link',
      WFInput: sc.Attach(sc.Ref('Headers of URL')),
    }),

    sc.Action('is.workflow.actions.previewdocument', {
      WFInput: sc.Attach(sc.Ref('Link Header')),
    }),

    sc.Action('is.workflow.actions.text.match', name='Link Header Matches', params={
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: '<([^>]+)>; rel="memento"',
      text: sc.Str([sc.Ref('Link Header')]),
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='Archive URL', params={
      WFGetGroupType: 'Group At Index',
      matches: sc.Attach(sc.Ref('Link Header Matches')),
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: sc.Attach(sc.Ref('Archive URL')),
      WFLocalOnly: false,
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Attach(sc.Ref('Archive URL')),
      WFNotificationActionBody: 'Archive URL copied to clipboard',
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59457,
    WFWorkflowIconStartColor: -12365313,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFArticleContentItem',
    'WFSafariWebPageContentItem',
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'Watch',
  ],
}
