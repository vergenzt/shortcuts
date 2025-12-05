local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.detect.dictionary', name='Dictionary', params={
      WFInput: sc.Attach(sc.Input),
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Dictionary')),
      },
      'has any value'
    )).Then_([

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Dictionary', aggs=[
          {
            DictionaryKey: 'args',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
        WFVariableName: 'Args',
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Dictionary', aggs=[
          {
            DictionaryKey: 'script',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
        WFVariableName: 'Script',
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
        WFItems: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 2,
                WFKey: sc.Str(['empty_args']),
                WFValue: {
                  Value: [],
                  WFSerializationType: 'WFArrayParameterState',
                },
              },
            ],
          },
          WFSerializationType: 'WFDictionaryFieldValue',
        },
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Dictionary', aggs=[
          {
            DictionaryKey: 'empty_args',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
        WFVariableName: 'Args',
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Input),
        WFVariableName: 'Script',
      }),

    ]).EndIf_(name='If Result'),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('If Result')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'F9603A60-27B0-4FA8-AAE3-D958D9F7121E',
        workflowName: 'Get Obsidian Vault Path',
      },
      WFWorkflowName: 'Get Obsidian Vault Path',
    }),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
      'is',
      {
        WFConditionalActionString: 'Mac',
      }
    )).Then_([

      sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Set Args', params={
        input: sc.Attach(sc.Ref('Vars.Args')),
        jqQuery: '"set -- " + (map(@sh) | join(" "))',
        queryType: 'jq',
      }),

      sc.Action('is.workflow.actions.gettext', name='Text', params={
        WFTextActionText: sc.Str(['set -euo pipefail\n\n', sc.Ref('Set Args')]),
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Text')),
        WFVariableName: 'Script',
      }),

      sc.Action('is.workflow.actions.gettext', name='Text', params={
        WFTextActionText: sc.Str(['cd "/Users/tim_vergenz/Library/Mobile Documents/iCloud~md~obsidian/Documents/brain"\n', sc.Ref('Vars.Script')]),
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Text')),
        WFVariableName: 'Script',
      }),

      sc.Action('is.workflow.actions.runshellscript', {
        InputMode: 'as arguments',
        Script: sc.Str([sc.Ref('Vars.Script')]),
        Shell: '/bin/bash',
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.gettext', name='Text', params={
        WFTextActionText: sc.Str(['cd ~brain\n\n', sc.Ref('Vars.Script'), '\n\nopen shortcuts://']),
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Text')),
        WFVariableName: 'Script',
      }),

      sc.Action('AsheKube.app.a-Shell-mini.ExecuteCommandIntent', {
        ShowWhenRun: false,
        command: sc.Str([sc.Ref('Vars.Script')]),
        openWindow: 'default',
      }),

    ]).EndIf_(),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 255,
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
