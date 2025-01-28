local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Github URL Regex', params={
      WFTextActionText: '(?:https://)?github.com/(?:\\w+)/(\\w+)/(?:blob|tree)/(?:[0-9a-f]+/)([^#]*)(?:#L(\\d+).*)?',
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: sc.Str([sc.Ref('Github URL Regex')]),
      text: sc.Str([sc.Input]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '37FACB10-90AE-4291-8398-BEA591C7E341',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Matches')),
      },
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Attach(sc.Input),
      WFNotificationActionBody: sc.Str(['No Github URL detected: ', sc.Input]),
      WFNotificationActionSound: false,
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '37FACB10-90AE-4291-8398-BEA591C7E341',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.file', name='Code Folder', params={
      WFFile: {
        displayName: 'code',
        fileLocation: {
          WFFileLocationType: 'Home',
          relativeSubpath: 'code',
        },
        filename: 'code',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', name='VSCode URL', params={
      WFInput: sc.Str([sc.Input]),
      WFReplaceTextCaseSensitive: false,
      WFReplaceTextFind: sc.Str([sc.Ref('Github URL Regex')]),
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: sc.Str(['vscode://file/', sc.Ref('Code Folder', aggs=[
        {
          PropertyName: 'File Path',
          PropertyUserInfo: {},
          Type: 'WFPropertyVariableAggrandizement',
        },
      ]), '/$1/$2:$3']),
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: sc.Attach(sc.Ref('VSCode URL')),
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 463140863,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorGetClipboard',
    Parameters: {},
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'QuickActions',
    'ReceivesOnScreenContent',
  ],
}
