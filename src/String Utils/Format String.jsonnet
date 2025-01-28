local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'fmt',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }),
      WFVariableName: 'fmt',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'esc',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }),
      WFVariableName: 'esc',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            CoercionItemClass: 'WFDictionaryContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
          {
            DictionaryKey: 'vals',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ],
        Type: 'ExtensionInput',
      }),
      WFVariableName: 'vals',
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: '(?<!\\\\)\\$\\{(\\w+)\\}',
      text: sc.Str([sc.Ref('Vars.fmt')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '782BF2B0-5469-48AB-A7BA-2824FD3B7EAC',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Matches')),
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='Text', params={
      matches: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Text')]),
      WFInput: sc.Attach(sc.Ref('Vars.vals')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D9F34061-54B9-4CE8-AAF0-2FE250B17914',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.esc')),
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Dictionary Value')),
      WFWorkflow: sc.Attach(sc.Ref('Vars.esc')),
      WFWorkflowName: sc.Attach(sc.Ref('Vars.esc')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D9F34061-54B9-4CE8-AAF0-2FE250B17914',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Dictionary Value')),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'D9F34061-54B9-4CE8-AAF0-2FE250B17914',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([sc.Ref('Vars.fmt')]),
      WFReplaceTextFind: sc.Str([sc.Ref('Vars.Repeat Item')]),
      WFReplaceTextReplace: sc.Str([sc.Ref('If Result')]),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Updated Text')),
      WFVariableName: 'fmt',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '782BF2B0-5469-48AB-A7BA-2824FD3B7EAC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      WFInput: sc.Str([sc.Ref('Vars.fmt')]),
      WFReplaceTextFind: '\\$',
      WFReplaceTextReplace: '$',
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
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
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
