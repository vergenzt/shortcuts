local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.ask', name='Split Time', params={
      WFAskActionPrompt: 'At what date/time would you like to split the active Toggl Track entry?',
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.converttimezone', name='Split Time (UTC)', params={
      Date: sc.Str([sc.Ref('Split Time')]),
      DestinationTimeZone: {
        alCityIdentifier: 302,
        localizedCityName: 'UTC',
        timeZone: 'GMT',
      },
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
              WFValue: sc.Str(['me/time_entries']),
            },
            {
              WFItemType: 1,
              WFKey: sc.Str(['params']),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['before']),
                        WFValue: sc.Str([sc.Ref('Split Time (UTC)', aggs=[
                          {
                            Type: 'WFDateFormatVariableAggrandizement',
                            WFDateFormatStyle: 'ISO 8601',
                            WFISO8601IncludeTime: true,
                          },
                        ])]),
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
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'D7676A00-FF48-4BCC-AD06-21D893C2BFE9',
        workflowName: 'Toggl API',
      },
      WFWorkflowName: 'Toggl API',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D9C206AD-C252-455D-A994-9C52097C95F0',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Time Entries')),
    }),

    sc.Action('is.workflow.actions.list', name='Endpoint Keys', params={
      WFItems: [
        'start',
        'stop',
      ],
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B6878FDB-F12E-4BE9-8FA0-198D4A57DA40',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Endpoint Keys')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Endpoint Text', params={
      WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item 2')]),
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '96AB6539-120D-4246-A24B-80C6F2F3758E',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Endpoint Text')),
      },
    }),

    sc.Action('is.workflow.actions.detect.date', name='Endpoint', params={
      WFInput: sc.Attach(sc.Ref('Endpoint Text')),
    }),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Endpoint Interval', params={
      WFInput: sc.Str([sc.Ref('Split Time (UTC)')]),
      WFTimeUntilFromDate: sc.Str([sc.Ref('Endpoint')]),
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AF919587-F239-4E2F-8061-D205AF6AC302',
      WFCondition: 5,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Endpoint Interval')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.calculateexpression', {
      Input: sc.Str([sc.Ref('Endpoint Interval')]),
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
      WFTextActionText: sc.Str([sc.Ref('Vars.Repeat Item 2')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'B6878FDB-F12E-4BE9-8FA0-198D4A57DA40',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: ', ',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['start:1, stop:']),
              WFValue: sc.Str(['yes (start < split, stop empty)']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['start:1, stop:-1']),
              WFValue: sc.Str(['yes (start < split, stop > split)']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Combined Text')]),
      WFInput: sc.Attach(sc.Ref('Dictionary')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4FAF4B8F-8164-4849-B48A-32D3A32C12FC',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Dictionary Value')),
      },
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Split Time splits Repeat Item\n→ create new pre-split entry\n→ update Repeat Item entry to set start time to Split Time',
    }),

    sc.Action('is.workflow.actions.dictionary', name='New Entry Request', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['start']),
              WFValue: sc.Str([{
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
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['stop']),
              WFValue: sc.Str([sc.Ref('Split Time (UTC)')]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['created_with']),
              WFValue: sc.Str(['Shortcuts']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['description']),
              WFValue: sc.Str([{
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
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['project_id']),
              WFValue: sc.Str([{
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
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['task_id']),
              WFValue: sc.Str([{
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
              }]),
            },
            {
              WFItemType: 4,
              WFKey: sc.Str(['billable']),
              WFValue: sc.Num(sc.Attach({
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
              })),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Updated JSON', params={
      WFDictionary: sc.Attach(sc.Ref('New Entry Request', aggs=[
        {
          DictionaryKey: 'json',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
      WFDictionaryKey: 'tag_ids',
      WFDictionaryValue: sc.Str([{
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
      }]),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Updated New Entry Request', params={
      WFDictionary: sc.Attach(sc.Ref('New Entry Request')),
      WFDictionaryKey: 'json',
      WFDictionaryValue: sc.Str([sc.Ref('Updated JSON')]),
    }),

    sc.Action('is.workflow.actions.dictionary', {
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['method']),
              WFValue: sc.Str(['POST']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['path']),
              WFValue: sc.Str(['workspaces/', {
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
              }, '/time_entries']),
            },
            {
              WFItemType: 1,
              WFKey: sc.Str(['json']),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['start']),
                        WFValue: sc.Str([sc.Ref('Split Time (UTC)')]),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['stop']),
                        WFValue: sc.Str([{
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
                        }]),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['created_with']),
                        WFValue: sc.Str(['Shortcuts']),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['description']),
                        WFValue: sc.Str([{
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
                        }]),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['project_id']),
                        WFValue: sc.Str([{
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
                        }]),
                      },
                      {
                        WFItemType: 0,
                        WFKey: sc.Str(['task_id']),
                        WFValue: sc.Str([{
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
                        }]),
                      },
                      {
                        WFItemType: 4,
                        WFKey: sc.Str(['billable']),
                        WFValue: sc.Num(sc.Attach({
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
                        })),
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
      WFInput: sc.Attach(sc.Ref('Updated New Entry Request')),
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
  WFWorkflowClientVersion: '3607.0.2',
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
