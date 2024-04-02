{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.detect.dictionary',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Input Dict',
        UUID: '89C08046-311F-4B52-90E3-C2A3DBFCF024',
        WFInput: {
          Value: {
            Type: 'ExtensionInput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'dk.simonbs.DataJar.GetValueIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Jira Config',
        UUID: '89A86341-ECE8-4BBA-B75E-EC3E951D9F57',
        keyPath: 'jira-config',
      },
    },
    {
      WFWorkflowActionIdentifier: 'ke.bou.GizmoPack.RandomDataIntent',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Error Nonce',
        UUID: '996788C8-83B7-43C2-AB00-1BA590A2A85F',
        outputEncoding: 'hex',
      },
    },
    {
      WFWorkflowActionIdentifier: 'ch.marcela.ada.Pyto.RunCodeIntent',
      WFWorkflowActionParameters: {
        UUID: '94BD3C02-F0B8-4EA3-B793-51A53A09FE97',
        code: {
          Value: {
            attachmentsByRange: {
              '{65, 1}': {
                OutputName: 'Input Dict',
                OutputUUID: '89C08046-311F-4B52-90E3-C2A3DBFCF024',
                Type: 'ActionOutput',
              },
              '{68, 1}': {
                OutputName: 'Jira Config',
                OutputUUID: '89A86341-ECE8-4BBA-B75E-EC3E951D9F57',
                Type: 'ActionOutput',
              },
              '{72, 1}': {
                OutputName: 'Error Nonce',
                OutputUUID: '996788C8-83B7-43C2-AB00-1BA590A2A85F',
                Type: 'ActionOutput',
              },
            },
            string: 'import json, requests\n\nargs, cfg, err_nonce = json.loads(r"""\n  [￼, ￼, "￼"]\n""")\n\nresp = requests.request(\n  url=cfg["base_url"] + args.pop("path"),\n  **args,\n  auth=requests.auth.HTTPBasicAuth(\n    cfg["username"],\n    cfg["api_token"]\n  ),\n)\n\nif not resp.ok:\n  print(err_nonce)\n  print("On", resp.request.method, resp.request.path_url)\n  print("Error", resp.status_code, resp.reason)\n\nprint(resp.text)',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        input: '',
        showConsole: false,
      },
    },
    {
      WFWorkflowActionIdentifier: 'ch.marcela.ada.Pyto.GetScriptOutputIntent',
      WFWorkflowActionParameters: {
        UUID: 'D7A259F7-36FF-42B3-A9B4-BCE9394624D7',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.split',
      WFWorkflowActionParameters: {
        UUID: 'AD47B4AC-D848-4D16-AC07-A5C512D66BBA',
        text: {
          Value: {
            OutputName: 'Output',
            OutputUUID: 'D7A259F7-36FF-42B3-A9B4-BCE9394624D7',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getitemfromlist',
      WFWorkflowActionParameters: {
        UUID: '125443CC-6BC7-4578-BA1F-836F14C029F5',
        WFInput: {
          Value: {
            OutputName: 'Split Text',
            OutputUUID: 'AD47B4AC-D848-4D16-AC07-A5C512D66BBA',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
        WFCondition: 4,
        WFConditionalActionString: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Error Nonce',
                OutputUUID: '996788C8-83B7-43C2-AB00-1BA590A2A85F',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFControlFlowMode: 0,
        WFInput: {
          Type: 'Variable',
          Variable: {
            Value: {
              OutputName: 'Item from List',
              OutputUUID: '125443CC-6BC7-4578-BA1F-836F14C029F5',
              Type: 'ActionOutput',
            },
            WFSerializationType: 'WFTextTokenAttachment',
          },
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getitemfromlist',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Error Context',
        UUID: '1F185F43-5922-472E-B25E-BA4EA4DDB6E4',
        WFInput: {
          Value: {
            OutputName: 'Split Text',
            OutputUUID: 'AD47B4AC-D848-4D16-AC07-A5C512D66BBA',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFItemIndex: '2',
        WFItemRangeStart: '2',
        WFItemSpecifier: 'Item At Index',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.getitemfromlist',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Error Message Lines',
        UUID: '421DC2D2-68AB-4602-ADDD-D272F4441728',
        WFInput: {
          Value: {
            OutputName: 'Split Text',
            OutputUUID: 'AD47B4AC-D848-4D16-AC07-A5C512D66BBA',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFItemRangeStart: '3',
        WFItemSpecifier: 'Items in Range',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.text.combine',
      WFWorkflowActionParameters: {
        CustomOutputName: 'Error Message',
        UUID: 'E89D9FB3-E77E-46E3-93E5-2E21D3DC7474',
        text: {
          Value: {
            OutputName: 'Error Message Lines',
            OutputUUID: '421DC2D2-68AB-4602-ADDD-D272F4441728',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.alert',
      WFWorkflowActionParameters: {
        WFAlertActionMessage: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Error Message',
                OutputUUID: 'E89D9FB3-E77E-46E3-93E5-2E21D3DC7474',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFAlertActionTitle: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Error Context',
                OutputUUID: '1F185F43-5922-472E-B25E-BA4EA4DDB6E4',
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
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
        WFControlFlowMode: 1,
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.output',
      WFWorkflowActionParameters: {
        WFOutput: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Output',
                OutputUUID: 'D7A259F7-36FF-42B3-A9B4-BCE9394624D7',
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
      WFWorkflowActionIdentifier: 'is.workflow.actions.conditional',
      WFWorkflowActionParameters: {
        GroupingIdentifier: 'B8B9F0F6-0B7F-4C5D-9FF3-1256A1C48B93',
        UUID: 'E97FD31C-D2E0-49C0-B4A9-796A16C27345',
        WFControlFlowMode: 2,
      },
    },
  ],
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -615917313,
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
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFStringContentItem',
    },
  },
  WFWorkflowOutputContentItemClasses: [
    'WFGenericFileContentItem',
  ],
  WFWorkflowTypes: [],
}
