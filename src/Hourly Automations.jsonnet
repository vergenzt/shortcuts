local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.getmyworkflows', name='My Shortcuts'),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B4F3CD09-4BC6-4CBD-B8AC-2DC99998DBF2',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('My Shortcuts')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39F1EC3C-990A-48C7-8F12-1E92E7A0B51B',
      WFCondition: 99,
      WFConditionalActionString: '🔂',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              PropertyName: 'Name',
              PropertyUserInfo: 'WFItemName',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item',
        }),
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFWorkflow: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFWorkflowName: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '39F1EC3C-990A-48C7-8F12-1E92E7A0B51B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B4F3CD09-4BC6-4CBD-B8AC-2DC99998DBF2',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59699,
    WFWorkflowIconStartColor: -12365313,
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
