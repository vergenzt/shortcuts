local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: 'jira-config',
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Value', aggs=[
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
      WFInput: {
        Value: sc.Input,
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref('Input As Dict', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      WFDictionaryKey: 'issue_key',
      WFInput: sc.Ref('Input As Dict', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      WFInput: sc.Str([sc.Input]),
      WFReplaceTextFind: '.*\\b([A-Z]+-[1-9][0-9]*)\\b.*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1',
    }),

    sc.Action('is.workflow.actions.conditional', name='Issue key', params={
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['method']),
              WFValue: sc.Str(['GET']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['path']),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': sc.Ref('Issue key'),
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
      WFInput: sc.Ref('Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Initial Issue Key', params={
      WFDictionaryKey: 'key',
      WFInput: sc.Ref('Get Initial Issue Response', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='fields.summary', params={
      WFDictionaryKey: 'fields.summary',
      WFInput: sc.Ref('Get Initial Issue Response', att=true),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Initial Issue Key'),
            '{2, 1}': sc.Ref('fields.summary'),
          },
          string: '￼ ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      WFInput: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('URL'),
            '{1, 1}': sc.Ref('URL Encoded Text'),
          },
          string: '￼￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: sc.Ref('URL', att=true),
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
