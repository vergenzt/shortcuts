local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.dictionary', name='Dictionary'),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Device Labels', params={
      WFInput: sc.Attach(sc.Ref('Network Details')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '54A10E86-3149-4BDC-9C7C-F822194182D1',
        workflowName: 'Get Device Labels',
      },
      WFWorkflowName: 'Get Device Labels',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B415E81D-19C0-4B0D-BCDB-001B43402E3B',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Device Labels', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          PropertyName: 'Keys',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item')]),
      WFInput: sc.Attach(sc.Ref('Device Labels')),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Vars.Menu')),
      WFDictionaryKey: sc.Str([sc.Ref('Dictionary Value')]),
      WFDictionaryValue: sc.Str([sc.Ref('Vars.Repeat Item')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B415E81D-19C0-4B0D-BCDB-001B43402E3B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Device ID', params={
      WFChooseFromListActionPrompt: 'Which device would you like to switch to?',
      WFInput: sc.Attach(sc.Ref('Vars.Menu')),
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Copy to Clipboard',
      WFOutput: sc.Str([sc.Ref('Device ID')]),
      WFResponse: sc.Str([sc.Ref('Device ID')]),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: true,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 946986751,
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
  WFWorkflowOutputContentItemClasses: [
    'WFDictionaryContentItem',
  ],
  WFWorkflowTypes: [],
}
