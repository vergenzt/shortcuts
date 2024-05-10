local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.CheckIfValueExistsIntent', {
      UUID: '5204022D-FB4D-4E7A-B522-03CE1B6914DE',
      keyPath: 'Version Control',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF33CBB3-BE80-4AA1-AED9-3A5752F93CA6',
      WFCondition: 4,
      WFConditionalActionString: 'No',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Name',
                PropertyUserInfo: 'WFItemName',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Value Exists',
            OutputUUID: '5204022D-FB4D-4E7A-B522-03CE1B6914DE',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: '3DA074DC-6D05-452D-803D-1A8130D6990D',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 1,
              WFKey: {
                Value: {
                  string: 'placeholder',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [],
                  },
                  WFSerializationType: 'WFDictionaryFieldValue',
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      UUID: 'BB445F37-584B-4250-8BEA-47F0903EFCFF',
      keyPath: 'Version Control',
      overwriteStrategy: 'alwaysAllow',
      values: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '3DA074DC-6D05-452D-803D-1A8130D6990D',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.delay', {}),

    sc.Action('dk.simonbs.DataJar.DeleteValueIntent', {
      UUID: 'A6457EBB-BD44-435A-B05B-952F5388940E',
      deleteStrategy: 'alwaysAllow',
      keyPath: 'Version Control.placeholder',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF33CBB3-BE80-4AA1-AED9-3A5752F93CA6',
      UUID: '1F6A6DD7-450B-4645-A36F-5D1EA7296393',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C4380019-D2D9-4726-9A29-0FE78E467056',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Type: 'ExtensionInput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      UUID: '0ED328FB-DA01-4A10-8C99-7D050D301568',
      WFInput: {
        Value: {
          Type: 'ExtensionInput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: 'Create',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C4380019-D2D9-4726-9A29-0FE78E467056',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'F7FF9B50-48A3-4F05-B33F-82C47C22BC7A',
      WFTextActionText: 'title: Create new Version\nsub: Add a new version of a shortcut\nicon: link.badge.plus,nil,purple\n\ntitle: View/Restore Versions\nsub: View or Restore a available version of a shortcut\nicon: link.icloud,nil,blue\n\ntitle: Remove a Previous Version\nSub: This cannot be undone!\nicon: trash.circle,nil,red\n\ntitle: Stop Shortcut\nsub: Stop shortcut from running\nicon: clear,nil,orange',
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.QuickMenu2Intent', {
      UUID: 'D004E1C4-B185-441C-9C93-8116E74099CF',
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text',
              OutputUUID: 'F7FF9B50-48A3-4F05-B33F-82C47C22BC7A',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      UUID: '537AFC3E-CEC3-46FA-BA1A-CF564A0AB8B8',
      WFInput: {
        Value: {
          OutputName: 'Menu Items',
          OutputUUID: 'D004E1C4-B185-441C-9C93-8116E74099CF',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C4380019-D2D9-4726-9A29-0FE78E467056',
      UUID: 'CC42B6F1-5FCA-4A49-A1F8-1EF92CD15F8A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '92EABD63-025D-48B9-88E5-1C577ED0ABCB',
      WFCondition: 99,
      WFConditionalActionString: 'Create',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            OutputName: 'If Result',
            OutputUUID: 'CC42B6F1-5FCA-4A49-A1F8-1EF92CD15F8A',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BD667D5A-E1F5-4FE7-A782-38C314E4F4AF',
      WFCondition: 999,
      WFConditionalActionString: 'shortcut',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Type: 'Clipboard',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionCancelButtonShown: false,
      WFAlertActionMessage: 'No shortcut link was found in the clipboard. Please go to the shortcut, hit the share icon and copy the link then run this shortcut again.',
    }),

    sc.Action('is.workflow.actions.exit', {}),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BD667D5A-E1F5-4FE7-A782-38C314E4F4AF',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: '4310D930-0175-42AD-A2D5-D74A936E70DE',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'Clipboard',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '/shortcuts/',
      WFReplaceTextReplace: '/shortcuts/api/records/',
    }),

    sc.Action('is.workflow.actions.gettypeaction', {
      UUID: 'FC7B8BD4-C8B4-4582-82B2-F6D30A949583',
      WFFileType: 'public.json',
      WFInput: {
        Value: {
          OutputName: 'Updated Text',
          OutputUUID: '4310D930-0175-42AD-A2D5-D74A936E70DE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.urlencode', {
      UUID: '8D1D0078-7C9A-459C-9FC2-F7808A01E058',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.name.value',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'File of Type',
              OutputUUID: 'FC7B8BD4-C8B4-4582-82B2-F6D30A949583',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: 'E5BBED9D-F7DC-44BC-94DB-C64154905DDE',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.icon.value.downloadURL',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'File of Type',
              OutputUUID: 'FC7B8BD4-C8B4-4582-82B2-F6D30A949583',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '${f}',
      WFReplaceTextReplace: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'URL Encoded Text',
              OutputUUID: '8D1D0078-7C9A-459C-9FC2-F7808A01E058',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      UUID: '2B21E774-629A-4D0F-8FA0-ABAB51E22CA0',
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Updated Text',
              OutputUUID: 'E5BBED9D-F7DC-44BC-94DB-C64154905DDE',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setitemname', {
      CustomOutputName: 'Icon Image',
      UUID: 'DAC82E85-C42D-4B0C-87DB-402080E025C4',
      WFInput: {
        Value: {
          OutputName: 'Contents of URL',
          OutputUUID: '2B21E774-629A-4D0F-8FA0-ABAB51E22CA0',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFName: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.name.value',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'File of Type',
              OutputUUID: 'FC7B8BD4-C8B4-4582-82B2-F6D30A949583',
              Type: 'ActionOutput',
            },
          },
          string: '￼.png',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.image.resize', {
      CustomOutputName: 'Resized Icon',
      UUID: 'A8F4C807-86FB-44C2-9252-51D407C894C0',
      WFImage: {
        Value: {
          OutputName: 'Icon Image',
          OutputUUID: 'DAC82E85-C42D-4B0C-87DB-402080E025C4',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFImageResizeHeight: '123',
      WFImageResizeWidth: '123',
    }),

    sc.Action('is.workflow.actions.base64encode', {
      UUID: 'F5779930-D85C-4250-A695-B43C0C2429D3',
      WFBase64LineBreakMode: 'None',
      WFEncodeMode: 'Encode',
      WFInput: {
        Value: {
          OutputName: 'Resized Icon',
          OutputUUID: 'A8F4C807-86FB-44C2-9252-51D407C894C0',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: 'A39CBE03-0473-43CA-AE24-C59D385ACADB',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.shortcut.value.downloadURL',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'File of Type',
              OutputUUID: 'FC7B8BD4-C8B4-4582-82B2-F6D30A949583',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '${f}',
      WFReplaceTextReplace: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'URL Encoded Text',
              OutputUUID: '8D1D0078-7C9A-459C-9FC2-F7808A01E058',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      CustomOutputName: 'rawShortcut',
      UUID: 'F2AFC086-9640-4DA1-9471-5D1FE498F995',
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Updated Text',
              OutputUUID: 'A39CBE03-0473-43CA-AE24-C59D385ACADB',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setitemname', {
      UUID: '6353C00A-ED32-4A27-8129-1F2855873BF6',
      WFInput: {
        Value: {
          OutputName: 'rawShortcut',
          OutputUUID: 'F2AFC086-9640-4DA1-9471-5D1FE498F995',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFName: 'A.plist',
    }),

    sc.Action('is.workflow.actions.count', {
      Input: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'WFWorkflowActions',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          OutputName: 'Renamed Item',
          OutputUUID: '6353C00A-ED32-4A27-8129-1F2855873BF6',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      UUID: 'C417DFE3-1A9F-487F-91B8-A8A3C6D224D8',
    }),

    sc.Action('is.workflow.actions.ask', {
      UUID: '3EE3C750-52BC-42DE-B9F1-FD8C8C707B7D',
      WFAskActionDefaultAnswer: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.name.value',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'File of Type',
              OutputUUID: 'FC7B8BD4-C8B4-4582-82B2-F6D30A949583',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: 'What Shortcut name should this be stored under?',
    }),

    sc.Action('dk.simonbs.DataJar.GetChildCountIntent', {
      UUID: 'CB39EF01-CA19-469C-9D74-356C709F2664',
      errorWhenValueNotFound: false,
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              OutputName: 'Provided Input',
              OutputUUID: '3EE3C750-52BC-42DE-B9F1-FD8C8C707B7D',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9C913971-1128-4AC0-B025-55581C32C11D',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Count',
            OutputUUID: 'CB39EF01-CA19-469C-9D74-356C709F2664',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '0',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '94A8CCC2-4F50-4ECE-B012-1F05EA6B6C59',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              OutputName: 'Provided Input',
              OutputUUID: '3EE3C750-52BC-42DE-B9F1-FD8C8C707B7D',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              OutputName: 'Count',
              OutputUUID: 'CB39EF01-CA19-469C-9D74-356C709F2664',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.￼.version',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9C913971-1128-4AC0-B025-55581C32C11D',
      UUID: '5F20C3B9-BC27-4806-8369-E2D09CAEEF7F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: '0671B9D7-7CB2-48FC-BAE7-BF9BE2320CE1',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'name',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Provided Input',
                      OutputUUID: '3EE3C750-52BC-42DE-B9F1-FD8C8C707B7D',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'version',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Value',
                      OutputUUID: '94A8CCC2-4F50-4ECE-B012-1F05EA6B6C59',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'url',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Type: 'Clipboard',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'date',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Type: 'CurrentDate',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'note',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Type: 'Ask',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'actions count',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Count',
                      OutputUUID: 'C417DFE3-1A9F-487F-91B8-A8A3C6D224D8',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'b64icon',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      OutputName: 'Base64 Encoded',
                      OutputUUID: 'F5779930-D85C-4250-A695-B43C0C2429D3',
                      Type: 'ActionOutput',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.math', {
      UUID: '848FFAF6-01AA-47F0-92AF-C729CD82706A',
      WFInput: {
        Value: {
          OutputName: 'Count',
          OutputUUID: 'CB39EF01-CA19-469C-9D74-356C709F2664',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFMathOperand: '1',
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      UUID: 'E7D903D2-BE45-4884-B91A-4C55A4645192',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  DictionaryKey: 'name',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Dictionary',
              OutputUUID: '0671B9D7-7CB2-48FC-BAE7-BF9BE2320CE1',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              OutputName: 'Calculation Result',
              OutputUUID: '848FFAF6-01AA-47F0-92AF-C729CD82706A',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysAllow',
      values: {
        Value: {
          OutputName: 'Dictionary',
          OutputUUID: '0671B9D7-7CB2-48FC-BAE7-BF9BE2320CE1',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      UUID: 'E701185F-3121-462E-BF40-BA743220FC3A',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  DictionaryKey: 'name',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Dictionary',
              OutputUUID: '0671B9D7-7CB2-48FC-BAE7-BF9BE2320CE1',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              OutputName: 'Calculation Result',
              OutputUUID: '848FFAF6-01AA-47F0-92AF-C729CD82706A',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.￼.icon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysAllow',
      values: {
        Value: {
          OutputName: 'Resized Icon',
          OutputUUID: 'A8F4C807-86FB-44C2-9252-51D407C894C0',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      UUID: 'BC7F47CA-27EF-409A-BAE7-A469B024525E',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  DictionaryKey: 'name',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Dictionary',
              OutputUUID: '0671B9D7-7CB2-48FC-BAE7-BF9BE2320CE1',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              OutputName: 'Calculation Result',
              OutputUUID: '848FFAF6-01AA-47F0-92AF-C729CD82706A',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.￼.exporticon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysAllow',
      values: {
        Value: {
          OutputName: 'Icon Image',
          OutputUUID: 'DAC82E85-C42D-4B0C-87DB-402080E025C4',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BD667D5A-E1F5-4FE7-A782-38C314E4F4AF',
      UUID: '4AD80F85-EEEC-4573-9855-990C6C795949',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '92EABD63-025D-48B9-88E5-1C577ED0ABCB',
      UUID: '536174A9-D369-4415-8011-FE3BBC665035',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '417A0E48-5F82-44DF-B448-ED047609E58D',
      WFCondition: 99,
      WFConditionalActionString: 'View',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Chosen Item',
            OutputUUID: '537AFC3E-CEC3-46FA-BA1A-CF564A0AB8B8',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetKeysIntent', {
      UUID: '93804AA3-E572-4014-A50B-CC9FDC31F2FF',
      keyPath: 'Version Control',
    }),

    sc.Action('com.sindresorhus.Actions.SortListIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'SortListIntent',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      'Show-list': true,
      UUID: '98271167-A4A6-478B-A2A7-70B3D55354B0',
      list: {
        Value: {
          OutputName: 'Keys',
          OutputUUID: '93804AA3-E572-4014-A50B-CC9FDC31F2FF',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F530BB16-B092-43FF-B5E0-26DFFAC48AA8',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Sorted List',
          OutputUUID: '98271167-A4A6-478B-A2A7-70B3D55354B0',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '1466E691-42D4-424F-8336-4E0DDB8BF69B',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: 'Version Control.￼.1.b64icon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: '26E670DC-1B70-413D-82B6-FC124D6E64E7',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{17, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFStringContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '1466E691-42D4-424F-8336-4E0DDB8BF69B',
              Type: 'ActionOutput',
            },
            '{7, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Name',
                  PropertyUserInfo: 'WFItemName',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: 'title: ￼\nbase64: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.QuickMenu2Intent', {
      UUID: '869883AF-AEF1-40C4-9682-0112D7EFE480',
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text',
              OutputUUID: '26E670DC-1B70-413D-82B6-FC124D6E64E7',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F530BB16-B092-43FF-B5E0-26DFFAC48AA8',
      UUID: '2686FF70-9F69-4C18-A995-275F9852A8CC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      UUID: 'EA361DB3-4B73-422E-BEAD-560973D58347',
      WFChooseFromListActionPrompt: 'Select shortcut to view its versions',
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '2686FF70-9F69-4C18-A995-275F9852A8CC',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '9E7ECAD9-A585-4D10-BFAE-66373F9E1D1E',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: 'EA361DB3-4B73-422E-BEAD-560973D58347',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Value',
          OutputUUID: '9E7ECAD9-A585-4D10-BFAE-66373F9E1D1E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Export',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '964E44BF-AD7A-4D63-B099-4704FE2F6B15',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Value',
          OutputUUID: '9E7ECAD9-A585-4D10-BFAE-66373F9E1D1E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '34055841-5AF3-4D03-A179-8C01FE0AD04A',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              OutputName: 'Chosen Item',
              OutputUUID: 'EA361DB3-4B73-422E-BEAD-560973D58347',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index',
            },
          },
          string: 'Version Control.￼.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'name',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          OutputName: 'Value',
          OutputUUID: '34055841-5AF3-4D03-A179-8C01FE0AD04A',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'name',
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'E06235D8-3A9D-4A84-B051-7FBFDF2060C9',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{11, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'date',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '34055841-5AF3-4D03-A179-8C01FE0AD04A',
              Type: 'ActionOutput',
            },
            '{27, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'actions count',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '34055841-5AF3-4D03-A179-8C01FE0AD04A',
              Type: 'ActionOutput',
            },
            '{31, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'note',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '34055841-5AF3-4D03-A179-8C01FE0AD04A',
              Type: 'ActionOutput',
            },
            '{41, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'b64icon',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '34055841-5AF3-4D03-A179-8C01FE0AD04A',
              Type: 'ActionOutput',
            },
            '{7, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'version',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '34055841-5AF3-4D03-A179-8C01FE0AD04A',
              Type: 'ActionOutput',
            },
          },
          string: 'title: ￼ : ￼\nsub: Actions: ￼ | ￼\nbase64: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.QuickMenu2Intent', {
      UUID: '3E3D1C3E-A063-4D39-A57B-BB5ADEF7A81D',
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text',
              OutputUUID: 'E06235D8-3A9D-4A84-B051-7FBFDF2060C9',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '964E44BF-AD7A-4D63-B099-4704FE2F6B15',
      UUID: '1A22C49E-2CDC-4F0C-8DA9-C54C0EC5C988',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '1A22C49E-2CDC-4F0C-8DA9-C54C0EC5C988',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: '66F8EEA4-D400-41EB-9788-D39C9D9B3EF6',
      WFTextActionText: 'Export All',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      UUID: '507AC0FC-58A9-4F9B-A27E-CC89DBDB99F1',
      WFInput: {
        Value: {
          OutputName: 'Text',
          OutputUUID: '66F8EEA4-D400-41EB-9788-D39C9D9B3EF6',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'F9439A55-5470-40CE-82FD-F94D04DC7165',
      WFTextActionText: 'Go Back',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      UUID: 'BA454485-22C3-48F5-806D-0207C7D640BE',
      WFInput: {
        Value: {
          OutputName: 'Text',
          OutputUUID: 'F9439A55-5470-40CE-82FD-F94D04DC7165',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      UUID: 'FC92331E-86EC-44DC-9F94-99428F68C12E',
      WFChooseFromListActionPrompt: {
        Value: {
          attachmentsByRange: {
            '{17, 1}': {
              OutputName: 'Chosen Item',
              OutputUUID: 'EA361DB3-4B73-422E-BEAD-560973D58347',
              Type: 'ActionOutput',
            },
          },
          string: 'Which version of ￼ would you like to restore?',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Menu',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6A3266FB-DD65-4ADC-B3DF-B13AE8E5A41C',
      WFCondition: 4,
      WFConditionalActionString: 'Go Back',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Name',
                PropertyUserInfo: 'WFItemName',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Chosen Item',
            OutputUUID: 'FC92331E-86EC-44DC-9F94-99428F68C12E',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: {
        Value: {
          OutputName: 'Chosen Item',
          OutputUUID: 'FC92331E-86EC-44DC-9F94-99428F68C12E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: '63BDD6A0-A90B-425F-9CD8-C2B25DC56CD6',
        workflowName: 'Version Control',
      },
      WFWorkflowName: 'Version Control',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6A3266FB-DD65-4ADC-B3DF-B13AE8E5A41C',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.split', {
      'Show-text': true,
      UUID: '9048A880-31AD-4EF4-94A2-121C1DC16119',
      WFTextCustomSeparator: ':',
      WFTextSeparator: 'Custom',
      text: {
        Value: {
          OutputName: 'Chosen Item',
          OutputUUID: 'FC92331E-86EC-44DC-9F94-99428F68C12E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      UUID: 'FBEC057D-509B-4786-A029-72B09B779D96',
      WFInput: {
        Value: {
          OutputName: 'Split Text',
          OutputUUID: '9048A880-31AD-4EF4-94A2-121C1DC16119',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: '68C50CED-9F62-4032-B617-ADB18CA5D319',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Item from List',
              OutputUUID: 'FBEC057D-509B-4786-A029-72B09B779D96',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '\\s$',
      WFReplaceTextRegularExpression: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B542FF5C-D6F2-47A8-9A8B-DE4F0D6D0C5E',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Value',
          OutputUUID: '9E7ECAD9-A585-4D10-BFAE-66373F9E1D1E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '190B4734-D23D-408C-982F-2ADDD8CAF2AF',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: 'EA361DB3-4B73-422E-BEAD-560973D58347',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index',
            },
          },
          string: 'Version Control.￼.￼.version',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6128F9AF-A448-4A95-9A19-1117FD929284',
      WFCondition: 4,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Value',
              OutputUUID: '190B4734-D23D-408C-982F-2ADDD8CAF2AF',
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
            OutputName: 'Updated Text',
            OutputUUID: '68C50CED-9F62-4032-B617-ADB18CA5D319',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: 'E155BE84-2BAE-4CC3-B5AE-80FB478023A0',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Type: 'Variable',
              VariableName: 'name',
            },
            '{18, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index',
            },
          },
          string: 'Version Control.￼.￼.url',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.showwebpage', {
      UUID: 'E5FCE941-F673-4FD9-97C8-40364761A746',
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Value',
              OutputUUID: 'E155BE84-2BAE-4CC3-B5AE-80FB478023A0',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6128F9AF-A448-4A95-9A19-1117FD929284',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6128F9AF-A448-4A95-9A19-1117FD929284',
      UUID: 'F4699682-229E-423A-99B4-EA1CB2837A1A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B542FF5C-D6F2-47A8-9A8B-DE4F0D6D0C5E',
      UUID: '71A0C9D5-5B00-4564-A1C8-9329D29A3633',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6A3266FB-DD65-4ADC-B3DF-B13AE8E5A41C',
      UUID: 'AA0896B1-2A7A-46B7-93EA-CFF629196CF6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '417A0E48-5F82-44DF-B448-ED047609E58D',
      UUID: '298B4A09-7924-4235-A3C3-5A09F7B0C142',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '70A99A6B-B6FF-4FCE-9FB5-3E51BD8C7F1A',
      WFCondition: 4,
      WFConditionalActionString: 'Export All',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Name',
                PropertyUserInfo: 'WFItemName',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Chosen Item',
            OutputUUID: 'FC92331E-86EC-44DC-9F94-99428F68C12E',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: 'If this is your first time Exporting, please cancel this shortcut and create a folder in the Notes app named Version Control otherwise, continue.',
      WFAlertActionTitle: 'Version Control Export Setup',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '80A2FDB7-7A37-4C1F-BD49-43DCD82B30E8',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Export',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Name',
      UUID: 'C925A36D-FCD0-4369-B7E2-C8C6EA14A4B1',
      WFDictionaryKey: 'name',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Version',
      UUID: '7D997D9D-6281-4A68-BE4A-47502B555520',
      WFDictionaryKey: 'version',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Date',
      UUID: 'B33C2273-8145-4A08-A16C-DB6665E14041',
      WFDictionaryKey: 'date',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'URL',
      UUID: '0B96CFB0-1942-4566-9B64-0074917F8A04',
      WFDictionaryKey: 'url',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Note',
      UUID: 'E544A1F4-5F6D-4024-8492-5B0ECD860606',
      WFDictionaryKey: 'note',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Actions',
      UUID: 'A0EDE6A2-BCAA-470A-963E-45CFFC38FE38',
      WFDictionaryKey: 'actions count',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'D66D6650-CABA-4B18-B9C3-909212B8F562',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Date',
              OutputUUID: 'B33C2273-8145-4A08-A16C-DB6665E14041',
              Type: 'ActionOutput',
            },
            '{11, 1}': {
              OutputName: 'URL',
              OutputUUID: '0B96CFB0-1942-4566-9B64-0074917F8A04',
              Type: 'ActionOutput',
            },
            '{16, 1}': {
              OutputName: 'Actions',
              OutputUUID: 'A0EDE6A2-BCAA-470A-963E-45CFFC38FE38',
              Type: 'ActionOutput',
            },
            '{26, 1}': {
              OutputName: 'Note',
              OutputUUID: 'E544A1F4-5F6D-4024-8492-5B0ECD860606',
              Type: 'ActionOutput',
            },
            '{3, 1}': {
              OutputName: 'Name',
              OutputUUID: 'C925A36D-FCD0-4369-B7E2-C8C6EA14A4B1',
              Type: 'ActionOutput',
            },
            '{8, 1}': {
              OutputName: 'Version',
              OutputUUID: '7D997D9D-6281-4A68-BE4A-47502B555520',
              Type: 'ActionOutput',
            },
          },
          string: '￼\n[￼ : v￼](￼) : ￼ Actions\n￼\n\n-',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.getrichtextfrommarkdown', {
      UUID: 'BCF5B4B9-7060-4A00-B375-66349949DB5F',
      WFInput: {
        Value: {
          OutputName: 'Text',
          OutputUUID: 'D66D6650-CABA-4B18-B9C3-909212B8F562',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '80A2FDB7-7A37-4C1F-BD49-43DCD82B30E8',
      UUID: '5BCBC21E-5CB4-4D12-9999-9A0F117E2CB4',
      WFControlFlowMode: 2,
    }),

    sc.Action('dk.simonbs.DataJar.CheckIfValueExistsIntent', {
      UUID: '2BEDEE0B-72BC-4F88-ABFE-053564C08FC2',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              OutputName: 'Name',
              OutputUUID: 'C925A36D-FCD0-4369-B7E2-C8C6EA14A4B1',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.1.exporticon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED0B8895-BCD2-4611-B12A-821C84B2D53C',
      WFCondition: 4,
      WFConditionalActionString: 'Yes',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Name',
                PropertyUserInfo: 'WFItemName',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Value Exists',
            OutputUUID: '2BEDEE0B-72BC-4F88-ABFE-053564C08FC2',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '5D113B1F-14B6-4839-B08B-02DEBB79E948',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              OutputName: 'Name',
              OutputUUID: 'C925A36D-FCD0-4369-B7E2-C8C6EA14A4B1',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.1.exporticon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED0B8895-BCD2-4611-B12A-821C84B2D53C',
      WFControlFlowMode: 1,
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: 'C523B7FB-C1F4-4167-8D5D-C06D887A2329',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              OutputName: 'Name',
              OutputUUID: 'C925A36D-FCD0-4369-B7E2-C8C6EA14A4B1',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.1.url',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: 'F114952F-6204-4443-89E6-4F92403D9E2D',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Value',
              OutputUUID: 'C523B7FB-C1F4-4167-8D5D-C06D887A2329',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '/shortcuts/',
      WFReplaceTextReplace: '/shortcuts/api/records/',
    }),

    sc.Action('is.workflow.actions.gettypeaction', {
      UUID: '9CA00A22-5C27-4E96-8A7E-8B6546B18286',
      WFFileType: 'public.json',
      WFInput: {
        Value: {
          OutputName: 'Updated Text',
          OutputUUID: 'F114952F-6204-4443-89E6-4F92403D9E2D',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.urlencode', {
      UUID: '7A3200EC-7B5F-400D-B605-3182E55C7035',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.name.value',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'File of Type',
              OutputUUID: '9CA00A22-5C27-4E96-8A7E-8B6546B18286',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: '297CCACB-57E6-434A-B64C-ABFEDD2D23D9',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.icon.value.downloadURL',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'File of Type',
              OutputUUID: '9CA00A22-5C27-4E96-8A7E-8B6546B18286',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '${f}',
      WFReplaceTextReplace: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'URL Encoded Text',
              OutputUUID: '7A3200EC-7B5F-400D-B605-3182E55C7035',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      UUID: '9F85A0CF-B086-4261-B2D2-F35C90737B39',
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Updated Text',
              OutputUUID: '297CCACB-57E6-434A-B64C-ABFEDD2D23D9',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setitemname', {
      CustomOutputName: 'Icon Image',
      UUID: '73B6E965-4B7A-4347-889E-5FB119480F3F',
      WFInput: {
        Value: {
          OutputName: 'Contents of URL',
          OutputUUID: '9F85A0CF-B086-4261-B2D2-F35C90737B39',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFName: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'fields.name.value',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'File of Type',
              OutputUUID: '9CA00A22-5C27-4E96-8A7E-8B6546B18286',
              Type: 'ActionOutput',
            },
          },
          string: '￼.png',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      UUID: '693783FB-CBF4-46F6-B868-2A73401A352D',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: 'EA361DB3-4B73-422E-BEAD-560973D58347',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.1.exporticon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysAllow',
      valueConversionMode: 'file',
      values: {
        Value: {
          OutputName: 'Icon Image',
          OutputUUID: '73B6E965-4B7A-4347-889E-5FB119480F3F',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.delay', {}),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '08B5D4C0-5361-483D-8230-54D990295776',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: 'EA361DB3-4B73-422E-BEAD-560973D58347',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼.1.exporticon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED0B8895-BCD2-4611-B12A-821C84B2D53C',
      UUID: 'B2D838A4-B438-49D0-A46E-14DDE3DBB265',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'AC280BA0-4102-4C8C-9FF8-BC0FA7DECBB1',
      WFTextActionText: 'Version Control',
    }),

    sc.Action('com.apple.mobilenotes.SharingExtension', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateNoteLinkAction',
        BundleIdentifier: 'com.apple.mobilenotes',
        Name: 'Notes',
        TeamIdentifier: '0000000000',
      },
      UUID: '028E505B-D66D-4B8C-A499-30B2DDA50699',
      WFCreateNoteInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Name',
              OutputUUID: 'C925A36D-FCD0-4369-B7E2-C8C6EA14A4B1',
              Type: 'ActionOutput',
            },
            '{2, 1}': {
              OutputName: 'If Result',
              OutputUUID: 'B2D838A4-B438-49D0-A46E-14DDE3DBB265',
              Type: 'ActionOutput',
            },
          },
          string: '￼ ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      folder: {
        Value: {
          OutputName: 'Text',
          OutputUUID: 'AC280BA0-4102-4C8C-9FF8-BC0FA7DECBB1',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.appendnote', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'AppendToNoteLinkAction',
        BundleIdentifier: 'com.apple.mobilenotes',
        Name: 'Notes',
        TeamIdentifier: '0000000000',
      },
      UUID: 'A78C7A26-DFEE-45AC-BB6D-E20020C6EA5D',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Repeat Results',
              OutputUUID: '5BCBC21E-5CB4-4D12-9999-9A0F117E2CB4',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFNote: {
        Value: {
          OutputName: 'Note',
          OutputUUID: '028E505B-D66D-4B8C-A499-30B2DDA50699',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '70A99A6B-B6FF-4FCE-9FB5-3E51BD8C7F1A',
      UUID: '13F05D00-F229-438B-8F3A-BD16D82F76FE',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED4BD5DF-3115-4D29-8460-D699A8604E1A',
      WFCondition: 99,
      WFConditionalActionString: 'Remove',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Chosen Item',
            OutputUUID: '537AFC3E-CEC3-46FA-BA1A-CF564A0AB8B8',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetKeysIntent', {
      UUID: '5E854A01-8380-4139-AC71-9F595F8680D9',
      keyPath: 'Version Control',
    }),

    sc.Action('com.sindresorhus.Actions.SortListIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'SortListIntent',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      'Show-list': true,
      UUID: 'D03E4BCE-71C2-4D1D-A5B8-E950A4402582',
      list: {
        Value: {
          OutputName: 'Keys',
          OutputUUID: '5E854A01-8380-4139-AC71-9F595F8680D9',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F51681C8-CDBA-40EB-89BF-3CD57E5F3951',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Sorted List',
          OutputUUID: 'D03E4BCE-71C2-4D1D-A5B8-E950A4402582',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: 'A400285C-EAD8-435A-AA25-1F9E043CBA25',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: 'Version Control.￼.1.b64icon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'A4C847F6-29D9-40C4-892F-8988B5A2E88E',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{17, 1}': {
              OutputName: 'Value',
              OutputUUID: 'A400285C-EAD8-435A-AA25-1F9E043CBA25',
              Type: 'ActionOutput',
            },
            '{7, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'Name',
                  PropertyUserInfo: 'WFItemName',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: 'title: ￼\nbase64: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.QuickMenu2Intent', {
      UUID: 'DCC848B2-4181-4A11-A3B8-2D3172C655CB',
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text',
              OutputUUID: 'A4C847F6-29D9-40C4-892F-8988B5A2E88E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F51681C8-CDBA-40EB-89BF-3CD57E5F3951',
      UUID: '4481AB4E-BF06-4DC6-837D-66C7FC866739',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: '4481AB4E-BF06-4DC6-837D-66C7FC866739',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'FAE648AE-A8A5-4909-8315-E81204A906B1',
      WFTextActionText: 'Go Back',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      UUID: 'A8C31F3F-4A7D-458C-9C80-6A2E1CAF6C45',
      WFInput: {
        Value: {
          OutputName: 'Text',
          OutputUUID: 'FAE648AE-A8A5-4909-8315-E81204A906B1',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      UUID: '43E34568-0D30-4CAF-9EE0-85036C039342',
      WFChooseFromListActionPrompt: 'Select shortcut to view its versions',
      WFInput: {
        Value: {
          Type: 'Variable',
          VariableName: 'Menu',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B224B2D7-B7E4-4B66-9945-899A91135E65',
      WFCondition: 4,
      WFConditionalActionString: 'Go Back',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Name',
                PropertyUserInfo: 'WFItemName',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Chosen Item',
            OutputUUID: '43E34568-0D30-4CAF-9EE0-85036C039342',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B224B2D7-B7E4-4B66-9945-899A91135E65',
      WFControlFlowMode: 1,
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '04D3A32B-829E-4B1C-AB5D-248985693BC0',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: '43E34568-0D30-4CAF-9EE0-85036C039342',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '7FE68386-F34C-4E25-888C-5862816FFCCB',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Value',
          OutputUUID: '04D3A32B-829E-4B1C-AB5D-248985693BC0',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              OutputName: 'Chosen Item',
              OutputUUID: '43E34568-0D30-4CAF-9EE0-85036C039342',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index',
            },
          },
          string: 'Version Control.￼.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              DictionaryKey: 'name',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ],
          OutputName: 'Value',
          OutputUUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'name',
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: 'E36910E9-E841-4DAB-8E9C-1F44E4D78FC5',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{11, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'date',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
              Type: 'ActionOutput',
            },
            '{27, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'actions count',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
              Type: 'ActionOutput',
            },
            '{31, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'note',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
              Type: 'ActionOutput',
            },
            '{41, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'b64icon',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
              Type: 'ActionOutput',
            },
            '{52, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'name',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
              Type: 'ActionOutput',
            },
            '{63, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'version',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
              Type: 'ActionOutput',
            },
            '{7, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'version',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              OutputName: 'Value',
              OutputUUID: '492B0B66-3F9D-4398-9B0A-8E6FC74B5EBA',
              Type: 'ActionOutput',
            },
          },
          string: 'title: ￼ : ￼\nsub: Actions: ￼ | ￼\nbase64: ￼\nfield 1: ￼\nfield 2: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.QuickMenu2Intent', {
      UUID: 'E6A9D7C9-FA85-4E70-B5B2-AD637DC696E4',
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text',
              OutputUUID: 'E36910E9-E841-4DAB-8E9C-1F44E4D78FC5',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '7FE68386-F34C-4E25-888C-5862816FFCCB',
      UUID: 'EC28F38F-B672-49D4-B6BC-D423AAE41A0E',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      UUID: 'A9206DE9-0A45-4606-8BFD-842169A3D143',
      WFChooseFromListActionPrompt: 'Select the version(s) you would like to remove',
      WFChooseFromListActionSelectMultiple: true,
      WFInput: {
        Value: {
          OutputName: 'Repeat Results',
          OutputUUID: 'EC28F38F-B672-49D4-B6BC-D423AAE41A0E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '2CB74CD2-6D0E-4685-8163-F8F7E1116CBD',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Chosen Item',
          OutputUUID: 'A9206DE9-0A45-4606-8BFD-842169A3D143',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.split', {
      'Show-text': true,
      UUID: '72E4C06C-871A-4FA4-A3AA-AE27739E06AE',
      WFTextCustomSeparator: ':',
      WFTextSeparator: 'Custom',
      text: {
        Value: {
          Type: 'Variable',
          VariableName: 'Repeat Item',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      UUID: '908C9060-197E-4E8C-BD07-2ED93B2A8F59',
      WFInput: {
        Value: {
          OutputName: 'Split Text',
          OutputUUID: '72E4C06C-871A-4FA4-A3AA-AE27739E06AE',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', {
      UUID: 'F486FB9A-18B4-4F37-9781-372B86800923',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Item from List',
              OutputUUID: '908C9060-197E-4E8C-BD07-2ED93B2A8F59',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFReplaceTextFind: '\\s$',
      WFReplaceTextRegularExpression: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '0E77A3C6-B0C3-441A-BF2E-5A5884F53FC1',
      WFControlFlowMode: 0,
      WFInput: {
        Value: {
          OutputName: 'Value',
          OutputUUID: '04D3A32B-829E-4B1C-AB5D-248985693BC0',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8662EBE-5B24-4C8C-822E-53DA00E3605F',
      WFCondition: 5,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Type: 'Variable',
            VariableName: 'Deleted',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '1',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      UUID: '5FB36B0B-3EAA-46E5-9CB8-2B9B23A89760',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: '43E34568-0D30-4CAF-9EE0-85036C039342',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index 2',
            },
          },
          string: 'Version Control.￼.￼.version',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FC4A4FEE-B2EB-4E46-A1D5-E388AAC67024',
      WFCondition: 4,
      WFConditionalActionString: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Value',
              OutputUUID: '5FB36B0B-3EAA-46E5-9CB8-2B9B23A89760',
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
            OutputName: 'Updated Text',
            OutputUUID: 'F486FB9A-18B4-4F37-9781-372B86800923',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: {
        Value: {
          attachmentsByRange: {
            '{40, 1}': {
              OutputName: 'Value',
              OutputUUID: '5FB36B0B-3EAA-46E5-9CB8-2B9B23A89760',
              Type: 'ActionOutput',
            },
          },
          string: 'Are you sure you want to delete version ￼? If so, press OK.',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('dk.simonbs.DataJar.DeleteValueIntent', {
      UUID: '5744E89D-B821-4DC8-8F49-D5C9E3A21828',
      deleteStrategy: 'alwaysAllow',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: '43E34568-0D30-4CAF-9EE0-85036C039342',
              Type: 'ActionOutput',
            },
            '{18, 1}': {
              Type: 'Variable',
              VariableName: 'Repeat Index 2',
            },
          },
          string: 'Version Control.￼.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.number', {
      UUID: '54E822F2-299F-40C2-A1B9-4DB5CA35E272',
      WFNumberActionNumber: '1',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: {
        Value: {
          OutputName: 'Number',
          OutputUUID: '54E822F2-299F-40C2-A1B9-4DB5CA35E272',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFVariableName: 'Deleted',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FC4A4FEE-B2EB-4E46-A1D5-E388AAC67024',
      UUID: '5058DFBC-B13D-40F2-AD24-567702D473FE',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8662EBE-5B24-4C8C-822E-53DA00E3605F',
      UUID: '8B07063B-0286-4613-AD83-6B6D2D0827E3',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '0E77A3C6-B0C3-441A-BF2E-5A5884F53FC1',
      UUID: 'D574FAF3-4186-4693-B108-54FBB95721E1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '2CB74CD2-6D0E-4685-8163-F8F7E1116CBD',
      UUID: '9BB4B715-93C8-4FCC-BB0B-26867E1A92D4',
      WFControlFlowMode: 2,
    }),

    sc.Action('dk.simonbs.DataJar.GetChildCountIntent', {
      UUID: '1C0C163D-447D-413D-BA91-AF9C9D7C91EF',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: '43E34568-0D30-4CAF-9EE0-85036C039342',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '433E8EF4-5A58-4BBC-8DFC-BA73102FA3A6',
      WFCondition: 0,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Count',
            OutputUUID: '1C0C163D-447D-413D-BA91-AF9C9D7C91EF',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
      WFNumberValue: '1',
    }),

    sc.Action('dk.simonbs.DataJar.DeleteValueIntent', {
      UUID: 'CFE58E5B-0C24-4B97-8612-CAFD5B25CEAB',
      deleteStrategy: 'alwaysAllow',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': {
              Aggrandizements: [
                {
                  PropertyName: 'title',
                  Type: 'WFPropertyVariableAggrandizement',
                },
              ],
              OutputName: 'Chosen Item',
              OutputUUID: '43E34568-0D30-4CAF-9EE0-85036C039342',
              Type: 'ActionOutput',
            },
          },
          string: 'Version Control.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '433E8EF4-5A58-4BBC-8DFC-BA73102FA3A6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B224B2D7-B7E4-4B66-9945-899A91135E65',
      UUID: 'F68F816F-BC00-44A7-A4AF-3B2AD78EEFAE',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED4BD5DF-3115-4D29-8460-D699A8604E1A',
      UUID: '20405278-7C35-4304-AD37-68CF5FACA7F1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '53C04CCA-3A14-4CC7-A7D5-3C28AC23E4B3',
      WFCondition: 99,
      WFConditionalActionString: 'Stop',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            OutputName: 'Chosen Item',
            OutputUUID: '537AFC3E-CEC3-46FA-BA1A-CF564A0AB8B8',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.exit', {}),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '53C04CCA-3A14-4CC7-A7D5-3C28AC23E4B3',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      UUID: 'F3F939B0-25E2-4F0A-B253-E947A027B618',
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: '34FF5E78-C8C3-4B44-B688-59FC05E3F8A8',
        workflowName: 'ShortVersion',
      },
      WFWorkflowName: 'ShortVersion',
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59821,
    WFWorkflowIconStartColor: 463140863,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
    'Watch',
  ],
}
