local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.urlencode', {
      CustomOutputName: 'Encoded URL',
      UUID: 'C9099835-7512-4CD7-9490-754E20C55F29',
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
    }),

    sc.Action('is.workflow.actions.gettext', {
      CustomOutputName: 'Archive Save URL',
      UUID: '80190A65-C906-4CC9-8019-0A65C906ECC9',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{29, 1}': {
              OutputName: 'Encoded URL',
              OutputUUID: 'C9099835-7512-4CD7-9490-754E20C55F29',
              Type: 'ActionOutput',
            },
          },
          string: 'https://web.archive.org/save/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', {
      ShowHeaders: false,
      UUID: '65D93BA0-20BC-4E7E-8513-8A123D03B5C0',
      WFFormValues: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  attachmentsByRange: {},
                  string: 'url',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Type: 'Variable',
                      VariableName: 'URL',
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
      WFHTTPBodyType: 'Form',
      WFHTTPMethod: 'POST',
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Archive Save URL',
              OutputUUID: '80190A65-C906-4CC9-8019-0A65C906ECC9',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      CustomOutputName: 'Archive Root URL',
      UUID: '6EFE14C8-3F96-41ED-BF54-9B9A85E1AC0E',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{28, 1}': {
              OutputName: 'Encoded URL',
              OutputUUID: 'C9099835-7512-4CD7-9490-754E20C55F29',
              Type: 'ActionOutput',
            },
          },
          string: 'https://web.archive.org/web/￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.url.getheaders', {
      UUID: '73018831-A7B6-4CC6-A308-A78FC757E71E',
      WFInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Archive Root URL',
              OutputUUID: '6EFE14C8-3F96-41ED-BF54-9B9A85E1AC0E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', {
      CustomOutputName: 'Link Header',
      UUID: 'BF44ED2B-F396-4DBE-9FE7-A04EA4A0ECE1',
      WFDictionaryKey: 'Link',
      WFInput: {
        Value: {
          OutputName: 'Headers of URL',
          OutputUUID: '73018831-A7B6-4CC6-A308-A78FC757E71E',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.previewdocument', {
      WFInput: {
        Value: {
          OutputName: 'Link Header',
          OutputUUID: 'BF44ED2B-F396-4DBE-9FE7-A04EA4A0ECE1',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.text.match', {
      CustomOutputName: 'Link Header Matches',
      UUID: '256220E2-0CB2-4B82-905E-53C98EB58D08',
      WFMatchTextCaseSensitive: false,
      WFMatchTextPattern: '<([^>]+)>; rel="memento"',
      text: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Link Header',
              OutputUUID: 'BF44ED2B-F396-4DBE-9FE7-A04EA4A0ECE1',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', {
      CustomOutputName: 'Archive URL',
      UUID: 'BA97664E-4A47-4582-8981-D75B4E68C4A5',
      WFGetGroupType: 'Group At Index',
      matches: {
        Value: {
          OutputName: 'Link Header Matches',
          OutputUUID: '256220E2-0CB2-4B82-905E-53C98EB58D08',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: {
        Value: {
          OutputName: 'Archive URL',
          OutputUUID: 'BA97664E-4A47-4582-8981-D75B4E68C4A5',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFLocalOnly: false,
    }),

    sc.Action('is.workflow.actions.notification', {
      UUID: '5E9BC1D6-D980-4843-BD4E-19C9DD0197EC',
      WFInput: {
        Value: {
          OutputName: 'Archive URL',
          OutputUUID: 'BA97664E-4A47-4582-8981-D75B4E68C4A5',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFNotificationActionBody: 'Archive URL copied to clipboard',
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59457,
    WFWorkflowIconStartColor: -12365313,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFArticleContentItem',
    'WFSafariWebPageContentItem',
    'WFURLContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
