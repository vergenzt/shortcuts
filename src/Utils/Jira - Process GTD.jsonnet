local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: 'jira-config',
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      local outputs = super.outputs,
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'typeform_url',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼#jira_key=',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.detect.dictionary', name='Input As Dict', params={
      WFInput: sc.Ref(outputs, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local outputs = super.outputs,
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(outputs, 'Input As Dict', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      local outputs = super.outputs,
      WFDictionaryKey: 'issue_key',
      WFInput: sc.Ref(outputs, 'Input As Dict', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      WFInput: sc.Val('${Shortcut Input}', outputs),
      WFReplaceTextFind: '.*\\b([A-Z]+-[1-9][0-9]*)\\b.*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1',
    }),

    sc.Action('is.workflow.actions.conditional', name='Issue key', params={
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      local outputs = super.outputs,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('method'),
              WFValue: sc.Val('GET'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('path'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': sc.Ref(outputs, 'Issue key'),
                  },
                  string: 'issue/￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Get Initial Issue Response', params={
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Initial Issue Key', params={
      local outputs = super.outputs,
      WFDictionaryKey: 'key',
      WFInput: sc.Ref(outputs, 'Get Initial Issue Response', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='fields.summary', params={
      local outputs = super.outputs,
      WFDictionaryKey: 'fields.summary',
      WFInput: sc.Ref(outputs, 'Get Initial Issue Response', att=true),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      local outputs = super.outputs,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'Initial Issue Key'),
            '{2, 1}': sc.Ref(outputs, 'fields.summary'),
          },
          string: '￼ ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      local outputs = super.outputs,
      WFInput: sc.Val('${Text}', outputs),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      local outputs = super.outputs,
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(outputs, 'URL'),
            '{1, 1}': sc.Ref(outputs, 'URL Encoded Text'),
          },
          string: '￼￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      local outputs = super.outputs,
      WFInput: sc.Ref(outputs, 'URL', att=true),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -615917313,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
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
  WFWorkflowTypes: [
    'ActionExtension',
    'MenuBar',
    'ReceivesOnScreenContent',
  ],
}
