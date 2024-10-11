local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.number', name='1', params={
      WFNumberActionNumber: '1',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('1')),
      WFVariableName: 'Index',
    }),

    sc.Action('is.workflow.actions.number', name='N times', params={
      WFNumberActionNumber: '99',
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '74EEC384-D8EE-4E48-BA88-00469989FABF',
      WFControlFlowMode: 0,
      WFRepeatCount: sc.Attach(sc.Ref('N times')),
    }),

    sc.Action('is.workflow.actions.filter.reminders', name='Reminders', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Operator: 4,
              Property: 'List',
              Removable: true,
              Values: {
                Enumeration: {
                  Value: 'Morning Routine',
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
            {
              Operator: 4,
              Property: 'Is Completed',
              Removable: true,
              Values: {
                Bool: {
                  Value: false,
                  WFSerializationType: 'WFBooleanSubstitutableState',
                },
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Reminders')),
      WFVariableName: 'Reminders',
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: sc.Attach(sc.Ref('Vars.Reminders')),
      WFItemIndex: sc.Attach(sc.Ref('Vars.Index')),
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Item from List')),
      WFVariableName: 'Reminder',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '69E51372-986B-4F46-9188-3AE7460CD657',
      WFControlFlowMode: 0,
      WFMenuItems: [
        '✅ Done',
        '➡️ Defer',
      ],
      WFMenuPrompt: sc.Str(['📥 ', sc.Ref('Vars.Reminder')]),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '69E51372-986B-4F46-9188-3AE7460CD657',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '✅ Done',
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      WFContentItemPropertyName: 'Is Completed',
      WFInput: sc.Attach(sc.Ref('Vars.Reminder')),
      WFReminderContentItemIsCompleted: 1,
    }),

    sc.Action('is.workflow.actions.number', name='Number', params={
      WFNumberActionNumber: '1',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Number')),
      WFVariableName: 'Index',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '69E51372-986B-4F46-9188-3AE7460CD657',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '➡️ Defer',
    }),

    sc.Action('is.workflow.actions.calculateexpression', name='Calculation Result', params={
      Input: sc.Str([sc.Ref('Vars.Index'), '+1']),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Calculation Result')),
      WFVariableName: 'Index',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '69E51372-986B-4F46-9188-3AE7460CD657',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '74EEC384-D8EE-4E48-BA88-00469989FABF',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -43634177,
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
