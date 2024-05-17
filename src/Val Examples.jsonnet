local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.number', {
      UUID: '24E1A9FB-BFC9-49E6-A403-654F64E342FF',
      WFNumberActionNumber: '42',
    }),

    sc.Action('is.workflow.actions.gettext', {
      UUID: '6F9CA6CB-2E6D-46BA-A52A-14F846971F17',
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{8, 1}': {
              Type: 'ExtensionInput',
            },
          },
          string: 'Foo bar ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', {
      UUID: '7B211891-BAA3-4610-A33E-CD17A628F428',
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: {
                Value: {
                  string: 'string',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: 'value',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 3,
              WFKey: {
                Value: {
                  string: 'number',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  string: '5',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 1,
              WFKey: {
                Value: {
                  string: 'dict',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: {
                          Value: {
                            string: 'bliz',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                        WFValue: {
                          Value: {
                            string: 'fah',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                    ],
                  },
                  WFSerializationType: 'WFDictionaryFieldValue',
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
            {
              WFItemType: 2,
              WFKey: {
                Value: {
                  string: '',
                },
                WFSerializationType: 'WFTextTokenString',
              },
              WFValue: {
                Value: [
                  'foo',
                  'bar',
                  {
                    WFItemType: 2,
                    WFValue: {
                      Value: [
                        'biz',
                        'baz',
                        {
                          WFItemType: 3,
                          WFValue: {
                            Value: {
                              string: '0',
                            },
                            WFSerializationType: 'WFTextTokenString',
                          },
                        },
                        {
                          WFItemType: 4,
                          WFValue: {
                            Value: false,
                            WFSerializationType: 'WFNumberSubstitutableState',
                          },
                        },
                        {
                          WFItemType: 1,
                          WFValue: {
                            Value: {
                              Value: {
                                WFDictionaryFieldValueItems: [
                                  {
                                    WFItemType: 2,
                                    WFKey: {
                                      Value: {
                                        string: 'fizz',
                                      },
                                      WFSerializationType: 'WFTextTokenString',
                                    },
                                    WFValue: {
                                      Value: [
                                        'buzz',
                                        'bliz',
                                      ],
                                      WFSerializationType: 'WFArrayParameterState',
                                    },
                                  },
                                ],
                              },
                              WFSerializationType: 'WFDictionaryFieldValue',
                            },
                            WFSerializationType: 'WFDictionaryFieldValue',
                          },
                        },
                      ],
                      WFSerializationType: 'WFArrayParameterState',
                    },
                  },
                ],
                WFSerializationType: 'WFArrayParameterState',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.list', {
      WFItems: [
        'Asdf',
        'Jkl',
      ],
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -23508481,
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
