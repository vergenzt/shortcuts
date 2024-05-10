local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '6E04ECBB-60CD-433C-A4FA-4C15F5A339D5',
      keyPath: 'jira-config',
    }),

    sc.Action('is.workflow.actions.url', {
      UUID: '0C64BE4C-DE0F-47C5-A525-EABE3D8B1952',
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'typeform_url',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '6E04ECBB-60CD-433C-A4FA-4C15F5A339D5',
              Type: 'ActionOutput',
            },
          },
          string: '￼#jira_key=',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.detect.dictionary', {
      CustomOutputName: 'Input As Dict',
      UUID: '2AD3A488-0CEF-4445-AB44-9959DAC1472F',
      WFInput: {
        Value: {
          Type: 'ExtensionInput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Input As Dict',
            OutputUUID: '2AD3A488-0CEF-4445-AB44-9959DAC1472F',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      UUID: '8BAFECD7-A17E-4FCC-8DBF-89A4B292C18F',
      WFDictionaryKey: 'issue_key',
      WFInput: {
        Value: {
          OutputName: 'Input As Dict',
          OutputUUID: '2AD3A488-0CEF-4445-AB44-9959DAC1472F',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: 'F5C1A2B2-6F88-4B40-8CD8-9948E2B2F762',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'ExtensionInput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '.*\\b([A-Z]+-[1-9][0-9]*)\\b.*',
      WFReplaceTextRegularExpression: true,
      WFReplaceTextReplace: '$1',
    }),

    sc.Action('is.workflow.actions.conditional', {
      CustomOutputName: 'Issue key',
      GroupingIdentifier: 'AA47C097-218D-48E1-8EC2-CE887F3EA1C4',
      UUID: '0136A062-CA5F-4107-8BC7-4AE815BEEE68',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: 'F25C44DC-481A-4936-847E-03A8DE5CC0FF',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'method',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'GET',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'path',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{6, 1}': {
                      OutputName: 'Issue key',
                      OutputUUID: '0136A062-CA5F-4107-8BC7-4AE815BEEE68',
                      Type: 'ActionOutput',
                    },
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

    sc.Action('is.workflow.actions.runworkflow', {
      CustomOutputName: 'Get Initial Issue Response',
      UUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
      WFInput: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: 'F25C44DC-481A-4936-847E-03A8DE5CC0FF',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'B245F907-CA3B-4273-B2B7-BE1A4BAE3F79',
        workflowName: 'Jira API',
      },
      WFWorkflowName: 'Jira API',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Initial Issue Key',
      UUID: 'F64A9F32-626F-4776-87A8-674454196E8E',
      WFDictionaryKey: 'key',
      WFInput: {
        Value: {
          OutputName: 'Get Initial Issue Response',
          OutputUUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'fields.summary',
      UUID: '77F5841A-5F54-4CB0-B6C2-BF2E890D4153',
      WFDictionaryKey: 'fields.summary',
      WFInput: {
        Value: {
          OutputName: 'Get Initial Issue Response',
          OutputUUID: '1FF07592-0AD1-4DE6-8EF7-55E37F5B44AE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: '647CAABD-FAFD-4873-B0B6-C5E6ADFB9F32',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Initial Issue Key',
              OutputUUID: 'F64A9F32-626F-4776-87A8-674454196E8E',
              Type: 'ActionOutput',
            },
            '{2, 1}': {
              OutputName: 'fields.summary',
              OutputUUID: '77F5841A-5F54-4CB0-B6C2-BF2E890D4153',
              Type: 'ActionOutput',
            },
          },
          string: '￼ ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.urlencode', {
      UUID: 'F5166AC2-D4FA-46B0-91A0-FC639F2965FB',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text',
              OutputUUID: '647CAABD-FAFD-4873-B0B6-C5E6ADFB9F32',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.url', {
      UUID: '4078B415-12C4-45FC-8093-56EA1ABBB972',
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'URL',
              OutputUUID: '0C64BE4C-DE0F-47C5-A525-EABE3D8B1952',
              Type: 'ActionOutput',
            },
            '{1, 1}': {
              OutputName: 'URL Encoded Text',
              OutputUUID: 'F5166AC2-D4FA-46B0-91A0-FC639F2965FB',
              Type: 'ActionOutput',
            },
          },
          string: '￼￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      UUID: '2F37F63B-8CF2-462B-8DEC-AD80F6FA7DC3',
      WFInput: {
        Value: {
          OutputName: 'URL',
          OutputUUID: '4078B415-12C4-45FC-8093-56EA1ABBB972',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
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
