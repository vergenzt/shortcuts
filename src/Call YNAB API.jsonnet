local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Dictionary', params={
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '42008FCF-811C-4119-9A38-B4C7DFE77739',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Dictionary', aggs=[
          {
            DictionaryKey: 'service',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '42008FCF-811C-4119-9A38-B4C7DFE77739',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '42008FCF-811C-4119-9A38-B4C7DFE77739',
      WFControlFlowMode: 2,
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: '1password-uris.YNAB_TOKEN',
    }),

    sc.Action('is.workflow.actions.runworkflow', name='GH_TOKEN', params={
      WFInput: sc.Attach(sc.Ref('Value')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '9855AD9C-0B5E-4DA4-B0B2-EA7AF05FE05C',
        workflowName: 'Retrieve 1Password Field from URI',
      },
      WFWorkflowName: 'Retrieve 1Password Field from URI',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['Authorization:token ', sc.Ref('GH_TOKEN')]),
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Authorization', params={
      WFInput: sc.Attach(sc.Ref('Text')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B6E1C410-AC2A-47B0-8B43-995FF70B487C',
        workflowName: 'Shell Quote Text',
      },
      WFWorkflowName: 'Shell Quote Text',
    }),

    sc.Action('is.workflow.actions.runworkflow', name='path', params={
      WFInput: sc.Attach(sc.Ref('Dictionary', aggs=[
        {
          DictionaryKey: 'path',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B6E1C410-AC2A-47B0-8B43-995FF70B487C',
        workflowName: 'Shell Quote Text',
      },
      WFWorkflowName: 'Shell Quote Text',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Dictionary', aggs=[
        {
          DictionaryKey: 'params',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B6E1C410-AC2A-47B0-8B43-995FF70B487C',
        workflowName: 'Shell Quote Text',
      },
      WFWorkflowName: 'Shell Quote Text',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['curl -H ', sc.Ref('path')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Command',
    }),

    sc.Action('AsheKube.app.a-Shell-mini.ExecuteCommandIntent', {
      ShowWhenRun: false,
      command: sc.Attach(sc.Ref('Text')),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -1448498689,
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
