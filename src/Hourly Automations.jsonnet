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

    sc.If_(sc.Cond(
      {
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
      'contains',
      {
        WFConditionalActionString: '🔂',
      }
    )).Then_([

      sc.Action('is.workflow.actions.runworkflow', {
        WFWorkflow: sc.Attach(sc.Ref('Vars.Repeat Item')),
        WFWorkflowName: sc.Attach(sc.Ref('Vars.Repeat Item')),
      }),

    ]).EndIf_(),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B4F3CD09-4BC6-4CBD-B8AC-2DC99998DBF2',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '4528.0.4.2',
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
    'WFWorkflowTypeShowInSearch',
    'Watch',
  ],
}
