local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.geturlcomponent', name='Fragment', params={
      WFURL: sc.Str([sc.Input]),
      WFURLComponent: 'Fragment',
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: sc.Str(['Tap OK to open 1Password; after it opens, copy ', sc.Ref('Fragment'), ' to clipboard, then return to Shortcuts to continue.']),
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.waittoreturn'),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: 'DDC615DB-F7C2-4E33-966F-AB1A19C9725C',
      WFControlFlowMode: 0,
      WFMenuItems: [
        'Yes',
        'No',
      ],
      WFMenuPrompt: sc.Str(['Did you successfully copy ', sc.Ref('Fragment'), '?']),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: 'DDC615DB-F7C2-4E33-966F-AB1A19C9725C',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'Yes',
    }),

    sc.Action('is.workflow.actions.getclipboard'),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: 'DDC615DB-F7C2-4E33-966F-AB1A19C9725C',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Input),
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: '9855AD9C-0B5E-4DA4-B0B2-EA7AF05FE05C',
        workflowName: 'Retrieve 1Password Field from URI',
      },
      WFWorkflowName: 'Retrieve 1Password Field from URI',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: 'DDC615DB-F7C2-4E33-966F-AB1A19C9725C',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 1440408063,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFStringContentItem',
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
