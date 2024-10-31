local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: 'Jira Create Task Config',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Instance IDs By Device ID', params={
      WFDictionaryKey: 'instances-by-device-id',
      WFInput: sc.Attach(sc.Ref('Value')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Instances', params={
      WFDictionaryKey: 'instances',
      WFInput: sc.Attach(sc.Ref('Value')),
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Device ID', params={
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '43EF6A71-8D2A-4204-BF21-39EFA01C7A62',
        workflowName: 'Get Device ID',
      },
      WFWorkflowName: 'Get Device ID',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Instance IDs', params={
      WFDictionaryKey: sc.Str([sc.Ref('Device ID')]),
      WFInput: sc.Attach(sc.Ref('Instance IDs By Device ID')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '5D2433DA-C2D9-4574-94A9-9CD66937FAB4',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Instance IDs')),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: 'No instance configured for device! Would you like to configure one?',
    }),

    sc.Action('dk.simonbs.DataJar.ViewValueIntent', {
      keyPath: 'Jira Create Task Config',
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '5D2433DA-C2D9-4574-94A9-9CD66937FAB4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: sc.Attach(sc.Ref('Instance IDs')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '74A4EA81-DD0F-4589-A817-B956A43B1B92',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Count')),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Empty Dictionary'),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Empty Dictionary')),
      WFVariableName: 'Instance Labels',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '62FF8516-8CF1-4D5B-89D9-B71798B93826',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Instance IDs', aggs=[
        {
          CoercionItemClass: 'WFStringContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFVariableName: 'Instance ID',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Instance', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item')]),
      WFInput: sc.Attach(sc.Ref('Instances')),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: sc.Attach(sc.Ref('Vars.Instance Labels')),
      WFDictionaryKey: sc.Str([sc.Ref('Instance', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'label',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFDictionaryValue: sc.Str([sc.Ref('Vars.Repeat Item')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Instance Labels',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '62FF8516-8CF1-4D5B-89D9-B71798B93826',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: 'Which Jira instance?',
      WFInput: sc.Attach(sc.Ref('Vars.Instance Labels')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: sc.Str([sc.Ref('Chosen Item')]),
      WFInput: sc.Attach(sc.Ref('Instances', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '74A4EA81-DD0F-4589-A817-B956A43B1B92',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: sc.Str([sc.Ref('Instance IDs')]),
      WFInput: sc.Attach(sc.Ref('Instances')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '74A4EA81-DD0F-4589-A817-B956A43B1B92',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '5D2433DA-C2D9-4574-94A9-9CD66937FAB4',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.output', {
      WFOutput: sc.Str([sc.Ref('If Result')]),
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -1263359489,
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
