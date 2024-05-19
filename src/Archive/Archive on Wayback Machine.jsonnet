local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.urlencode', name='Encoded URL', params={
      WFInput: sc.Val('${Shortcut Input}', outputs),
    }),

    sc.Action('is.workflow.actions.gettext', name='Archive Save URL', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{29, 1}': sc.Ref(outputs, 'Encoded URL'),
          },
          string: 'https://web.archive.org/save/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      local outputs = super.outputs,
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
              WFValue: sc.Val('${Vars.URL}', outputs),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFHTTPBodyType: 'Form',
      WFHTTPMethod: 'POST',
      WFURL: sc.Val('${Archive Save URL}', outputs),
    }),

    sc.Action('is.workflow.actions.gettext', name='Archive Root URL', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{28, 1}': sc.Ref(outputs, 'Encoded URL'),
          },
          string: 'https://web.archive.org/web/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.url.getheaders', name='Headers of URL', params={
      local outputs = super.outputs,
      WFInput: sc.Val('${Archive Root URL}', outputs),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Link Header', params={
      local outputs = super.outputs,
      WFDictionaryKey: 'Link',
      WFInput: sc.Ref(outputs, 'Headers of URL', att=true),
    }),

    sc.Action('is.workflow.actions.previewdocument', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Link Header', att=true),
    }),

    sc.Action('is.workflow.actions.text.match', name='Link Header Matches', params={
      local outputs = super.outputs,
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: '<([^>]+)>; rel="memento"',
      text: sc.Val('${Link Header}', outputs),
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='Archive URL', params={
      local outputs = super.outputs,
      WFGetGroupType: 'Group At Index',
      matches: sc.Ref(outputs, 'Link Header Matches', att=true),
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Archive URL', att=true),
      WFLocalOnly: false,
    }),

    sc.Action('is.workflow.actions.notification', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Archive URL', att=true),
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
