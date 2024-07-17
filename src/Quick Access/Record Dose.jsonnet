local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.runworkflow', name='Google OAuth', params={
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '410F7B2D-3951-4BAE-A70D-514A8986662E',
        workflowName: 'Google OAuth',
      },
      WFWorkflowName: 'Google OAuth',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: 'dose-recorder',
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: {
        Value: {
          attachmentsByRange: {
            '{46, 1}': function(state) sc.Ref(state, 'Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'spreadsheetId',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'https://sheets.googleapis.com/v4/spreadsheets/￼/values',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.urlencode', name='menuRange', params={
      WFInput: function(state) sc.Val('${Value}', state),
    }),

    sc.Action('is.workflow.actions.downloadurl', name='Contents of URL', params={
      ShowHeaders: false,
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('Authorization'),
              WFValue: function(state) sc.Val('${Google OAuth}', state),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'URL'),
            '{2, 1}': function(state) sc.Ref(state, 'menuRange'),
          },
          string: '￼/￼?valueRenderOption=FORMATTED_VALUE',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '12455693-4B6E-4486-BAD9-730E939E6984',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Contents of URL', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'values',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ], att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', {
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '12455693-4B6E-4486-BAD9-730E939E6984',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFInput: function(state) sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.text.match', name='Matches', params={
      WFMatchTextPattern: 'Other',
      text: function(state) sc.Val('${Chosen Item}', state),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF4D8839-949A-412C-9955-483681D84092',
      WFCondition: 100,
      WFConditionalActionString: 'Other',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Matches', att=true),
      },
    }),

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionPrompt: 'Other',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Provided Input', att=true),
      WFVariableName: 'Med',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF4D8839-949A-412C-9955-483681D84092',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Chosen Item', att=true),
      WFVariableName: 'Med',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF4D8839-949A-412C-9955-483681D84092',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionDefaultAnswerDateAndTime: '',
      WFInputType: 'Date and Time',
    }),

    sc.Action('is.workflow.actions.format.date', name='Formatted Date', params={
      WFDate: function(state) sc.Val('${Provided Input}', state),
      WFDateFormat: 'yyyy-MM-dd HH:mm',
      WFDateFormatStyle: 'Custom',
      WFISO8601IncludeTime: true,
      WFTimeFormatStyle: 'Long',
    }),

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionDefaultAnswer: function(state) sc.Val('${Vars.Med}', state),
      WFAskActionPrompt: {
        Value: {
          attachmentsByRange: {
            '{13, 1}': function(state) sc.Ref(state, 'Formatted Date'),
          },
          string: 'Record dose? ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Provided Input', att=true),
      WFVariableName: 'Med',
    }),

    sc.Action('is.workflow.actions.urlencode', name='dataRange', params={
      WFInput: function(state) sc.Val('${Value}', state),
    }),

    sc.Action('is.workflow.actions.downloadurl', name='Contents of URL', params={
      ShowHeaders: true,
      WFFormValues: {
        Value: {
          WFDictionaryFieldValueItems: [],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFHTTPBodyType: 'JSON',
      WFHTTPHeaders: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('Authorization'),
              WFValue: function(state) sc.Val('${Google OAuth}', state),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
      WFHTTPMethod: 'POST',
      WFJSONValues: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 2,
              WFKey: sc.Val('values'),
              WFValue: {
                Value: [
                  {
                    WFItemType: 2,
                    WFValue: {
                      Value: [
                        {
                          WFItemType: 0,
                          WFValue: function(state) sc.Val('${Formatted Date}', state),
                        },
                        {
                          WFItemType: 0,
                          WFValue: function(state) sc.Val('${Vars.Med}', state),
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
      WFURL: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'URL'),
            '{2, 1}': function(state) sc.Ref(state, 'dataRange'),
          },
          string: '￼/￼:append?valueInputOption=USER_ENTERED',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionTitle: function(state) sc.Val('${Contents of URL}', state),
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: 'D5DEBDFA-5540-4CBE-A707-122DDBF6E907',
        workflowName: 'Dose History',
      },
      WFWorkflowName: 'Dose History',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '0937D1D5-A680-418A-AD7E-0EE31DBAA43B',
      WFControlFlowMode: 0,
      WFMenuItems: [
        'I’d like an alarm. I’ll copy the time to clipboard and return to Shortcuts.',
        'No alarm please.',
      ],
      WFMenuPrompt: 'Would you like to set an alarm?',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '0937D1D5-A680-418A-AD7E-0EE31DBAA43B',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'I’d like an alarm. I’ll copy the time to clipboard and return to Shortcuts.',
    }),

    sc.Action('is.workflow.actions.waittoreturn'),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionTitle: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDateContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormat: 'yyyy-dd-MM H:mm',
                  WFDateFormatStyle: 'Custom',
                  WFISO8601IncludeTime: false,
                },
              ],
              Type: 'Clipboard',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.format.date', name='Formatted Date', params={
      WFDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Aggrandizements: [
                {
                  CoercionItemClass: 'WFDateContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormat: 'yyyy-dd-MM H:mm',
                  WFDateFormatStyle: 'Custom',
                  WFISO8601IncludeTime: false,
                },
              ],
              Type: 'Clipboard',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDateFormat: 'h:mm:ss a',
      WFDateFormatStyle: 'Custom',
      WFISO8601IncludeTime: false,
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionTitle: function(state) sc.Val('${Formatted Date}', state),
    }),

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionDefaultAnswerDateAndTime: function(state) sc.Val('${Formatted Date}', state),
      WFAskActionDefaultAnswerTime: function(state) sc.Val('${Formatted Date}', state),
      WFAskActionPrompt: 'Alarm time',
      WFInputType: 'Time',
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateAlarmIntent',
        BundleIdentifier: 'com.apple.clock',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      dateComponents: function(state) sc.Val('${Provided Input}', state),
      label: function(state) sc.Val('${Vars.Med}', state),
      repeatSchedule: {
        displayString: 'Never',
        value: 0,
      },
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '0937D1D5-A680-418A-AD7E-0EE31DBAA43B',
      WFControlFlowMode: 1,
      WFMenuItemTitle: 'No alarm please.',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', name='Menu Result', params={
      GroupingIdentifier: '0937D1D5-A680-418A-AD7E-0EE31DBAA43B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.detect.date', {
      WFInput: function(state) sc.Ref(state, 'Menu Result', att=true),
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59461,
    WFWorkflowIconStartColor: 1440408063,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFAppStoreAppContentItem',
    'WFArticleContentItem',
    'WFContactContentItem',
    'WFDateContentItem',
    'WFEmailAddressContentItem',
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
