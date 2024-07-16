local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.ask', name='Split Time', params={
      WFAskActionPrompt: 'At what date/time would you like to split the active Toggl Track entry?',
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.converttimezone', name='Split Time (UTC)', params={
      local state = super.state,
      Date: sc.Val('${Split Time}', state),
      DestinationTimeZone: {
        alCityIdentifier: 302,
        localizedCityName: 'UTC',
        timeZone: 'GMT',
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      local state = super.state,
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
              WFValue: sc.Val('me/time_entries'),
            },
            {
              WFItemType: 1,
              WFKey: sc.Val('params'),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('before'),
                        WFValue: sc.Val('${Split Time (UTC)}', state),
                      },
                    ],
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

    sc.Action('is.workflow.actions.runworkflow', name='Time Entries', params={
      local state = super.state,
      WFInput: sc.Ref(state, 'Dictionary', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'D7676A00-FF48-4BCC-AD06-21D893C2BFE9',
        workflowName: 'Toggl API',
      },
      WFWorkflowName: 'Toggl API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: 'D9C206AD-C252-455D-A994-9C52097C95F0',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Time Entries', att=true),
    }),

    sc.Action('is.workflow.actions.list', name='Endpoint Keys', params={
      WFItems: [
        'start',
        'stop',
      ],
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      local state = super.state,
      GroupingIdentifier: 'B6878FDB-F12E-4BE9-8FA0-198D4A57DA40',
      WFControlFlowMode: 0,
      WFInput: sc.Ref(state, 'Endpoint Keys', att=true),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Endpoint Text', params={
      local state = super.state,
      WFDictionaryKey: sc.Val('${Vars.Repeat Item 2}', state),
      WFInput: sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '96AB6539-120D-4246-A24B-80C6F2F3758E',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Endpoint Text', att=true),
      },
    }),

    sc.Action('is.workflow.actions.detect.date', name='Endpoint', params={
      local state = super.state,
      WFInput: sc.Ref(state, 'Endpoint Text', att=true),
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Endpoint Interval', params={
      local state = super.state,
      WFInput: sc.Val('${Split Time (UTC)}', state),
      WFTimeUntilFromDate: sc.Val('${Endpoint}', state),
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: 'AF919587-F239-4E2F-8061-D205AF6AC302',
      WFCondition: 5,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Endpoint Interval', att=true),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.calculateexpression', {
      local state = super.state,
      Input: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Endpoint Interval'),
            '{8, 1}': sc.Ref(state, 'Endpoint Interval'),
          },
          string: '￼ / abs(￼)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AF919587-F239-4E2F-8061-D205AF6AC302',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.number', {
      WFNumberActionNumber: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AF919587-F239-4E2F-8061-D205AF6AC302',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '96AB6539-120D-4246-A24B-80C6F2F3758E',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettext', {
      local state = super.state,
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref(state, 'Vars.Repeat Item 2'),
            '{2, 1}': sc.Ref(state, 'If Result'),
          },
          string: '￼:￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'B6878FDB-F12E-4BE9-8FA0-198D4A57DA40',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      local state = super.state,
      WFTextCustomSeparator: ', ',
      WFTextSeparator: 'Custom',
      text: sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('start:1, stop:'),
              WFValue: sc.Val('yes (start < split, stop empty)'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('start:1, stop:-1'),
              WFValue: sc.Val('yes (start < split, stop > split)'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      local state = super.state,
      WFDictionaryKey: sc.Val('${Combined Text}', state),
      WFInput: sc.Ref(state, 'Dictionary', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      local state = super.state,
      GroupingIdentifier: '4FAF4B8F-8164-4849-B48A-32D3A32C12FC',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Ref(state, 'Dictionary Value', att=true),
      },
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Split Time splits Repeat Item\n→ create new pre-split entry\n→ update Repeat Item entry to set start time to Split Time',
    }),

    sc.Action('is.workflow.actions.dictionary', name='New Entry Request', params={
      local state = super.state,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('start'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'start',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('stop'),
              WFValue: sc.Val('${Split Time (UTC)}', state),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('created_with'),
              WFValue: sc.Val('Shortcuts'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('description'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'description',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('project_id'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'project_id',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('task_id'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{0, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'task_id',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: '￼',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 4,
              WFKey: sc.Val('billable'),
              WFValue: {
                Value: {
                  Value: {
                    Aggrandizements: [
                      {
                        CoercionItemClass: 'WFDictionaryContentItem',
                        Type: 'WFCoercionVariableAggrandizement',
                      },
                      {
                        DictionaryKey: 'billable',
                        Type: 'WFDictionaryValueVariableAggrandizement',
                      },
                    ],
                    Type: 'Variable',
                    VariableName: 'Repeat Item',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
                WFSerializationType: 'WFNumberSubstitutableState',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Updated JSON', params={
      local state = super.state,
      WFDictionary: sc.Ref(state, 'New Entry Request', aggs=[
        {
          DictionaryKey: 'json',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ], att=true),
      WFDictionaryKey: 'tag_ids',
      WFDictionaryValue: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'tag_ids',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ],
              Type: 'Variable',
              VariableName: 'Repeat Item',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Updated New Entry Request', params={
      local state = super.state,
      WFDictionary: sc.Ref(state, 'New Entry Request', att=true),
      WFDictionaryKey: 'json',
      WFDictionaryValue: sc.Val('${Updated JSON}', state),
    }),

    sc.Action('is.workflow.actions.dictionary', {
      local state = super.state,
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('method'),
              WFValue: sc.Val('POST'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('path'),
              WFValue: {
                Value: {
                  attachmentsByRange: {
                    '{11, 1}': {
                      Aggrandizements: [
                        {
                          CoercionItemClass: 'WFDictionaryContentItem',
                          Type: 'WFCoercionVariableAggrandizement',
                        },
                        {
                          DictionaryKey: 'workspace_id',
                          Type: 'WFDictionaryValueVariableAggrandizement',
                        },
                      ],
                      Type: 'Variable',
                      VariableName: 'Repeat Item',
                    },
                  },
                  string: 'workspaces/￼/time_entries',
                },
                WFSerializationType: 'WFTextTokenString',
              },
            },
            {
              WFItemType: 1,
              WFKey: sc.Val('json'),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('start'),
                        WFValue: sc.Val('${Split Time (UTC)}', state),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('stop'),
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{0, 1}': {
                                Aggrandizements: [
                                  {
                                    CoercionItemClass: 'WFDictionaryContentItem',
                                    Type: 'WFCoercionVariableAggrandizement',
                                  },
                                  {
                                    DictionaryKey: 'stop',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
                              },
                            },
                            string: '￼',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('created_with'),
                        WFValue: sc.Val('Shortcuts'),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('description'),
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{0, 1}': {
                                Aggrandizements: [
                                  {
                                    CoercionItemClass: 'WFDictionaryContentItem',
                                    Type: 'WFCoercionVariableAggrandizement',
                                  },
                                  {
                                    DictionaryKey: 'description',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
                              },
                            },
                            string: '￼',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('project_id'),
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{0, 1}': {
                                Aggrandizements: [
                                  {
                                    CoercionItemClass: 'WFDictionaryContentItem',
                                    Type: 'WFCoercionVariableAggrandizement',
                                  },
                                  {
                                    DictionaryKey: 'project_id',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
                              },
                            },
                            string: '￼',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Val('task_id'),
                        WFValue: {
                          Value: {
                            attachmentsByRange: {
                              '{0, 1}': {
                                Aggrandizements: [
                                  {
                                    CoercionItemClass: 'WFDictionaryContentItem',
                                    Type: 'WFCoercionVariableAggrandizement',
                                  },
                                  {
                                    DictionaryKey: 'task_id',
                                    Type: 'WFDictionaryValueVariableAggrandizement',
                                  },
                                ],
                                Type: 'Variable',
                                VariableName: 'Repeat Item',
                              },
                            },
                            string: '￼',
                          },
                          WFSerializationType: 'WFTextTokenString',
                        },
                      },
                      {
                        WFItemType: 4,
                        WFKey: sc.Val('billable'),
                        WFValue: {
                          Value: {
                            Value: {
                              Aggrandizements: [
                                {
                                  CoercionItemClass: 'WFDictionaryContentItem',
                                  Type: 'WFCoercionVariableAggrandizement',
                                },
                                {
                                  DictionaryKey: 'billable',
                                  Type: 'WFDictionaryValueVariableAggrandizement',
                                },
                              ],
                              Type: 'Variable',
                              VariableName: 'Repeat Item',
                            },
                            WFSerializationType: 'WFTextTokenAttachment',
                          },
                          WFSerializationType: 'WFNumberSubstitutableState',
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
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      local state = super.state,
      WFInput: sc.Ref(state, 'Updated New Entry Request', att=true),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'D7676A00-FF48-4BCC-AD06-21D893C2BFE9',
        workflowName: 'Toggl API',
      },
      WFWorkflowName: 'Toggl API',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4FAF4B8F-8164-4849-B48A-32D3A32C12FC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D9C206AD-C252-455D-A994-9C52097C95F0',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -12365313,
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
