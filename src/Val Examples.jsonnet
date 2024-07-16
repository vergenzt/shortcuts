local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.number', {
      WFNumberActionNumber: '42',
    }),

    sc.Action('is.workflow.actions.gettext', {
      local state = super.state,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{8, 1}': sc.Ref(state, 'Shortcut Input'),
          },
          string: 'Foo bar ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', {
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('string'),
              WFValue: sc.Val('value'),
            },
            {
              WFItemType: 3,
              WFKey: sc.Val('number'),
              WFValue: sc.Val('5'),
            },
            {
              WFItemType: 1,
              WFKey: sc.Val('dict'),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('bliz'),
                        WFValue: sc.Val('fah'),
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
              WFKey: sc.Val(''),
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
                          WFValue: sc.Val('0'),
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
                                    WFKey: sc.Val('fizz'),
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
