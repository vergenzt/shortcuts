local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.urlencode', name='Encoded URL', params={
      WFInput: function(state) sc.Val('${Shortcut Input}', state),
    }),

    sc.Action('is.workflow.actions.gettext', name='Archive Save URL', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{29, 1}': function(state) sc.Ref(state, 'Encoded URL'),
          },
          string: 'https://web.archive.org/save/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      ShowHeaders: false,
      WFFormValues: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  attachmentsByRange: {},
                  string: 'url',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: function(state) sc.Val('${Vars.URL}', state),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFHTTPBodyType: 'Form',
      WFHTTPMethod: 'POST',
      WFURL: function(state) sc.Val('${Archive Save URL}', state),
    }),

    sc.Action('is.workflow.actions.gettext', name='Archive Root URL', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{28, 1}': function(state) sc.Ref(state, 'Encoded URL'),
          },
          string: 'https://web.archive.org/web/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.url.getheaders', name='Headers of URL', params={
      WFInput: function(state) sc.Val('${Archive Root URL}', state),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Link Header', params={
      WFDictionaryKey: 'Link',
      WFInput: function(state) sc.Ref(state, 'Headers of URL', att=true),
    }),

    sc.Action('is.workflow.actions.previewdocument', {
      WFInput: function(state) sc.Ref(state, 'Link Header', att=true),
    }),

    sc.Action('is.workflow.actions.text.match', name='Link Header Matches', params={
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: '<([^>]+)>; rel="memento"',
      text: function(state) sc.Val('${Link Header}', state),
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='Archive URL', params={
      WFGetGroupType: 'Group At Index',
      matches: function(state) sc.Ref(state, 'Link Header Matches', att=true),
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: function(state) sc.Ref(state, 'Archive URL', att=true),
      WFLocalOnly: false,
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: function(state) sc.Ref(state, 'Archive URL', att=true),
      WFNotificationActionBody: 'Archive URL copied to clipboard',
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
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
  WFWorkflowTypes: [],
}
