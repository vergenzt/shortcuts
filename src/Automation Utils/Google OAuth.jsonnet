{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'dk.simonbs.DataJar.GetValueIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'config',
        UUID: '84D26323-BCD6-4B0A-B5AF-B5DD07DC4D47',
        keyPath: 'google-oauth',
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.QueryJSONIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'existing unexpired token',
        UUID: 'DEC1146C-9821-4B3C-87A0-EC348E12AA9F',
        input: {
          Value: {
            OutputName: 'config',
            OutputUUID: '84D26323-BCD6-4B0A-B5AF-B5DD07DC4D47',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: 'if .token.expires_at > (now | todate) and .token.access_token then .token else empty end',
        queryType: 'jq',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '2A79BC9F-64D3-4E75-9B83-A2D758932D7B',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'existing unexpired token',
              OutputUUID: 'DEC1146C-9821-4B3C-87A0-EC348E12AA9F',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.output',
      WFWorkflowActionParameters: {
        UUID: 'A039CBB8-A415-4C45-8F41-F48FD5109FFA',
        WFNoOutputSurfaceBehavior: 'Respond',
        WFOutput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'token_type',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                OutputName: 'existing unexpired token',
                OutputUUID: 'DEC1146C-9821-4B3C-87A0-EC348E12AA9F',
                Type: 'ActionOutput',
              },
              '{2, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'access_token',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                OutputName: 'existing unexpired token',
                OutputUUID: 'DEC1146C-9821-4B3C-87A0-EC348E12AA9F',
                Type: 'ActionOutput',
              },
            },
            string: '￼ ￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFResponse: 'Successfully authenticated to Google. ✅',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '2A79BC9F-64D3-4E75-9B83-A2D758932D7B',
        UUID: '47C51576-B96D-4A97-AD0C-0352C33DCF49',
        WFControlFlowMode: 2,
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.QueryJSONIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'refresh_uri',
        UUID: 'CC3A7B19-F8E9-492A-8449-C67FBC94BAFD',
        input: {
          Value: {
            OutputName: 'config',
            OutputUUID: '84D26323-BCD6-4B0A-B5AF-B5DD07DC4D47',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: 'if .token.expires_at <= (now | todate) and .token.refresh_token then .token_uri + "?" + (.params + (.token | {refresh_token}) + { grant_type: "refresh_token" } | to_entries | map(map(@uri) | join("=")) | join("&")) else empty end',
        queryType: 'jq',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '22E62798-BDB0-43EE-BE22-F8F025412072',
        WFCondition: 100,
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'refresh_uri',
              OutputUUID: 'CC3A7B19-F8E9-492A-8449-C67FBC94BAFD',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.downloadurl',
      WFWorkflowActionParameters: {
        CustomOutputName: 'refresh_result',
        UUID: 'A365AFC6-4FD4-4082-A035-A5CD21C94068',
        WFHTTPMethod: 'POST',
        WFURL: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'refresh_uri',
                OutputUUID: 'CC3A7B19-F8E9-492A-8449-C67FBC94BAFD',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.QueryJSONIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'timestamped_token',
        UUID: '668D8032-4727-427E-8D4B-EAA5C4BA8941',
        input: {
          Value: {
            OutputName: 'refresh_result',
            OutputUUID: 'A365AFC6-4FD4-4082-A035-A5CD21C94068',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Aggrandizements: [
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'token',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ],
                OutputName: 'config',
                OutputUUID: '84D26323-BCD6-4B0A-B5AF-B5DD07DC4D47',
                Type: 'ActionOutput',
              },
            },
            string: '￼ + . + { refreshed_at: (now | todate), expires_at: (now + .expires_in | todate) }',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        queryType: 'jq',
      },
    },
    {
      WFWorkflowActionIdentifier: 'dk.simonbs.DataJar.SetValueIntent',
      WFWorkflowActionParameters: {
        UUID: '64B1C3FA-FFD4-4D37-8079-99E9EF0434DC',
        keyPath: 'google-oauth.token',
        overwriteStrategy: 'alwaysAllow',
        values: {
          Value: {
            OutputName: 'timestamped_token',
            OutputUUID: '668D8032-4727-427E-8D4B-EAA5C4BA8941',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.QueryJSONIntent',
      WFWorkflowActionParameters: {
        UUID: '76635C95-C145-47EC-9FBB-3DD2B9985D90',
        input: {
          Value: {
            OutputName: 'timestamped_token',
            OutputUUID: '668D8032-4727-427E-8D4B-EAA5C4BA8941',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: '.token_type + " " + .access_token',
        queryType: 'jq',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.output',
      WFWorkflowActionParameters: {
        UUID: 'D2234AD6-0857-4053-B57F-6246D4D96D77',
        WFNoOutputSurfaceBehavior: 'Respond',
        WFOutput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Result',
                OutputUUID: '76635C95-C145-47EC-9FBB-3DD2B9985D90',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFResponse: 'Successfully authenticated to Google. ✅',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '22E62798-BDB0-43EE-BE22-F8F025412072',
        WFControlFlowMode: 1,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.dictionary',
      WFWorkflowActionParameters: {
        CustomOutputName: 'auth_params',
        UUID: '4C5D6E57-01AD-433F-B742-1A5F09AFAC5B',
        WFItems: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 0,
                WFKey: {
                  Value: {
                    string: 'approval_prompt',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
                WFValue: {
                  Value: {
                    string: 'force',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
              },
              {
                WFItemType: 0,
                WFKey: {
                  Value: {
                    string: 'access_type',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
                WFValue: {
                  Value: {
                    string: 'offline',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
              },
              {
                WFItemType: 0,
                WFKey: {
                  Value: {
                    string: 'response_type',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
                WFValue: {
                  Value: {
                    string: 'code',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
              },
            ],
          },
          WFSerializationType: 'WFDictionaryFieldValue',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.QueryJSONIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'auth_uri',
        UUID: '8D8036AD-0DC7-4E4E-B882-62CE84B55BE8',
        input: {
          Value: {
            OutputName: 'config',
            OutputUUID: '84D26323-BCD6-4B0A-B5AF-B5DD07DC4D47',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: {
          Value: {
            attachmentsByRange: {
              '{29, 1}': {
                OutputName: 'auth_params',
                OutputUUID: '4C5D6E57-01AD-433F-B742-1A5F09AFAC5B',
                Type: 'ActionOutput',
              },
            },
            string: '.auth_uri + "?" + (.params + ￼| del(.client_secret) | to_entries | map(map(@uri) | join("=")) | join("&"))',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        queryType: 'jq',
        slurp: false,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.openxcallbackurl',
      WFWorkflowActionParameters: {
        UUID: '70E940E7-6A39-4C9E-9641-9FB4061A2B1F',
        WFXCallbackCustomCallbackEnabled: true,
        WFXCallbackCustomSuccessKey: 'state',
        WFXCallbackCustomSuccessURLEnabled: false,
        WFXCallbackURL: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'auth_uri',
                OutputUUID: '8D8036AD-0DC7-4E4E-B882-62CE84B55BE8',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.detect.dictionary',
      WFWorkflowActionParameters: {
        CustomOutputName: 'result',
        UUID: 'E0894B2F-D51A-4A7A-AD1D-B27C80322D33',
        WFInput: {
          Value: {
            OutputName: 'X-Callback Result',
            OutputUUID: '70E940E7-6A39-4C9E-9641-9FB4061A2B1F',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.dictionary',
      WFWorkflowActionParameters: {
        CustomOutputName: 'token_params',
        UUID: '0069A083-78C1-41CB-B483-61B88DACE991',
        WFItems: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 0,
                WFKey: {
                  Value: {
                    string: 'grant_type',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
                WFValue: {
                  Value: {
                    string: 'authorization_code',
                  },
                  WFSerializationType: 'WFTextTokenString',
                },
              },
            ],
          },
          WFSerializationType: 'WFDictionaryFieldValue',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.QueryJSONIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'token_uri',
        UUID: '9B9A24AE-B2CE-4BF6-A6D5-68174D4F2A4C',
        input: {
          Value: {
            OutputName: 'config',
            OutputUUID: '84D26323-BCD6-4B0A-B5AF-B5DD07DC4D47',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: {
          Value: {
            attachmentsByRange: {
              '{20, 1}': {
                OutputName: 'token_params',
                OutputUUID: '0069A083-78C1-41CB-B483-61B88DACE991',
                Type: 'ActionOutput',
              },
              '{24, 1}': {
                OutputName: 'result',
                OutputUUID: 'E0894B2F-D51A-4A7A-AD1D-B27C80322D33',
                Type: 'ActionOutput',
              },
            },
            string: '.token_uri + "?" + (￼ + ￼ + .params | to_entries | map(map(@uri | gsub("\\\\+"; "%20")) | join("=")) | join("&"))',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        queryType: 'jq',
        slurp: false,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.url',
      WFWorkflowActionParameters: {
        'Show-WFURLActionURL': true,
        UUID: 'F4EF10F0-DF9E-44BD-AD8B-82026C0DA33A',
        WFURLActionURL: {
          Value: {
            OutputName: 'token_uri',
            OutputUUID: '9B9A24AE-B2CE-4BF6-A6D5-68174D4F2A4C',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.downloadurl',
      WFWorkflowActionParameters: {
        Advanced: true,
        CustomOutputName: 'token',
        ShowHeaders: false,
        UUID: '28548D2F-D810-43D4-87E7-B9C925A91E03',
        WFHTTPMethod: 'POST',
        WFURL: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'URL',
                OutputUUID: 'F4EF10F0-DF9E-44BD-AD8B-82026C0DA33A',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.QueryJSONIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'timestamped_token',
        UUID: '7DCCE61E-A062-49C6-9905-E9D5A86014E7',
        input: {
          Value: {
            OutputName: 'token',
            OutputUUID: '28548D2F-D810-43D4-87E7-B9C925A91E03',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: '. + { refreshed_at: (now | todate), expires_at: (now + .expires_in | todate) }',
        queryType: 'jq',
      },
    },
    {
      WFWorkflowActionIdentifier: 'dk.simonbs.DataJar.SetValueIntent',
      WFWorkflowActionParameters: {
        UUID: '329B8DDA-EA20-4512-B06E-12DFCCDC0A4D',
        keyPath: 'google-oauth.token',
        overwriteStrategy: 'alwaysAllow',
        values: {
          Value: {
            OutputName: 'timestamped_token',
            OutputUUID: '7DCCE61E-A062-49C6-9905-E9D5A86014E7',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.QueryJSONIntent',
      WFWorkflowActionParameters: {
        UUID: '639E654E-2FA2-42AA-B0B4-880B56B8984E',
        input: {
          Value: {
            OutputName: 'timestamped_token',
            OutputUUID: '7DCCE61E-A062-49C6-9905-E9D5A86014E7',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: '.token_type + " " + .access_token',
        queryType: 'jq',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.output',
      WFWorkflowActionParameters: {
        UUID: 'D739C597-97BB-4948-9306-2A6A81F05B3C',
        WFNoOutputSurfaceBehavior: 'Respond',
        WFOutput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Result',
                OutputUUID: '639E654E-2FA2-42AA-B0B4-880B56B8984E',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFResponse: 'Successfully authenticated to Google. ✅',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: '22E62798-BDB0-43EE-BE22-F8F025412072',
        UUID: '162C4B87-DCFE-4D7B-90F9-01B9B17B1191',
        WFControlFlowMode: 2,
      },
    },
  ],
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: true,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59749,
    WFWorkflowIconStartColor: 463140863,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [
    'WFGenericFileContentItem',
    'WFStringContentItem',
  ],
  WFWorkflowTypes: [
    'NCWidget',
  ],
}