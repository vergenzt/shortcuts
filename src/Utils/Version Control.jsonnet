local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.CheckIfValueExistsIntent', name='Value Exists', params={
      keyPath: 'Version Control',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF33CBB3-BE80-4AA1-AED9-3A5752F93CA6',
      WFCondition: 4,
      WFConditionalActionString: 'No',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Value Exists', aggs=[
          {
            PropertyName: 'Name',
            PropertyUserInfo: 'WFItemName',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 1,
              WFKey: sc.Str(['placeholder']),
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
      keyPath: 'Version Control',
      overwriteStrategy: 'alwaysAllow',
      values: sc.Attach(sc.Ref('Dictionary')),
    }),

    sc.Action('is.workflow.actions.delay'),

    sc.Action('dk.simonbs.DataJar.DeleteValueIntent', {
      deleteStrategy: 'alwaysAllow',
      keyPath: 'Version Control.placeholder',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FF33CBB3-BE80-4AA1-AED9-3A5752F93CA6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C4380019-D2D9-4726-9A29-0FE78E467056',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
    }),

    sc.Action('is.workflow.actions.setclipboard', {
      WFInput: sc.Attach(sc.Input),
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: 'Create',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C4380019-D2D9-4726-9A29-0FE78E467056',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: 'title: Create new Version\nsub: Add a new version of a shortcut\nicon: link.badge.plus,nil,purple\n\ntitle: View/Restore Versions\nsub: View or Restore a available version of a shortcut\nicon: link.icloud,nil,blue\n\ntitle: Remove a Previous Version\nSub: This cannot be undone!\nicon: trash.circle,nil,red\n\ntitle: Stop Shortcut\nsub: Stop shortcut from running\nicon: clear,nil,orange',
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.QuickMenu2Intent', name='Menu Items', params={
      text: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFInput: sc.Attach(sc.Ref('Menu Items')),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'C4380019-D2D9-4726-9A29-0FE78E467056',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '92EABD63-025D-48B9-88E5-1C577ED0ABCB',
      WFCondition: 99,
      WFConditionalActionString: 'Create',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('If Result', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BD667D5A-E1F5-4FE7-A782-38C314E4F4AF',
      WFCondition: 999,
      WFConditionalActionString: 'shortcut',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Type: 'Clipboard',
        }),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionCancelButtonShown: false,
      WFAlertActionMessage: 'No shortcut link was found in the clipboard. Please go to the shortcut, hit the share icon and copy the link then run this shortcut again.',
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BD667D5A-E1F5-4FE7-A782-38C314E4F4AF',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([{
        Type: 'Clipboard',
      }]),
      WFReplaceTextFind: '/shortcuts/',
      WFReplaceTextReplace: '/shortcuts/api/records/',
    }),

    sc.Action('is.workflow.actions.gettypeaction', name='File of Type', params={
      WFFileType: 'public.json',
      WFInput: sc.Attach(sc.Ref('Updated Text')),
    }),

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      WFInput: sc.Str([sc.Ref('File of Type', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'fields.name.value',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([sc.Ref('File of Type', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'fields.icon.value.downloadURL',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFReplaceTextFind: '${f}',
      WFReplaceTextReplace: sc.Str([sc.Ref('URL Encoded Text')]),
    }),

    sc.Action('is.workflow.actions.downloadurl', name='Contents of URL', params={
      WFURL: sc.Str([sc.Ref('Updated Text')]),
    }),

    sc.Action('is.workflow.actions.setitemname', name='Icon Image', params={
      WFInput: sc.Attach(sc.Ref('Contents of URL')),
      WFName: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('File of Type', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'fields.name.value',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼.png',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.image.resize', name='Resized Icon', params={
      WFImage: sc.Attach(sc.Ref('Icon Image')),
      WFImageResizeHeight: '123',
      WFImageResizeWidth: '123',
    }),

    sc.Action('is.workflow.actions.base64encode', name='Base64 Encoded', params={
      WFBase64LineBreakMode: 'None',
      WFEncodeMode: 'Encode',
      WFInput: sc.Attach(sc.Ref('Resized Icon')),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([sc.Ref('File of Type', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'fields.shortcut.value.downloadURL',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFReplaceTextFind: '${f}',
      WFReplaceTextReplace: sc.Str([sc.Ref('URL Encoded Text')]),
    }),

    sc.Action('is.workflow.actions.downloadurl', name='rawShortcut', params={
      WFURL: sc.Str([sc.Ref('Updated Text')]),
    }),

    sc.Action('is.workflow.actions.setitemname', name='Renamed Item', params={
      WFInput: sc.Attach(sc.Ref('rawShortcut')),
      WFName: 'A.plist',
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: sc.Attach(sc.Ref('Renamed Item', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'WFWorkflowActions',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionDefaultAnswer: sc.Str([sc.Ref('File of Type', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'fields.name.value',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFAskActionPrompt: 'What Shortcut name should this be stored under?',
    }),

    sc.Action('dk.simonbs.DataJar.GetChildCountIntent', name='Count', params={
      errorWhenValueNotFound: false,
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Provided Input'),
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
        Variable: sc.Attach(sc.Ref('Count')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Provided Input'),
            '{18, 1}': sc.Ref('Count'),
          },
          string: 'Version Control.￼.￼.version',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9C913971-1128-4AC0-B025-55581C32C11D',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['name']),
              WFValue: sc.Str([sc.Ref('Provided Input')]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['version']),
              WFValue: sc.Str([sc.Ref('Value')]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['url']),
              WFValue: sc.Str([{
                Type: 'Clipboard',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['date']),
              WFValue: sc.Str([{
                Type: 'CurrentDate',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['note']),
              WFValue: sc.Str([{
                Type: 'Ask',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['actions count']),
              WFValue: sc.Str([sc.Ref('Count')]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['b64icon']),
              WFValue: sc.Str([sc.Ref('Base64 Encoded')]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.math', name='Calculation Result', params={
      WFInput: sc.Attach(sc.Ref('Count')),
      WFMathOperand: '1',
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Dictionary', aggs=[
              {
                DictionaryKey: 'name',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{18, 1}': sc.Ref('Calculation Result'),
          },
          string: 'Version Control.￼.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysAllow',
      values: sc.Attach(sc.Ref('Dictionary')),
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Dictionary', aggs=[
              {
                DictionaryKey: 'name',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{18, 1}': sc.Ref('Calculation Result'),
          },
          string: 'Version Control.￼.￼.icon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysAllow',
      values: sc.Attach(sc.Ref('Resized Icon')),
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Dictionary', aggs=[
              {
                DictionaryKey: 'name',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{18, 1}': sc.Ref('Calculation Result'),
          },
          string: 'Version Control.￼.￼.exporticon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysAllow',
      values: sc.Attach(sc.Ref('Icon Image')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BD667D5A-E1F5-4FE7-A782-38C314E4F4AF',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '92EABD63-025D-48B9-88E5-1C577ED0ABCB',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '417A0E48-5F82-44DF-B448-ED047609E58D',
      WFCondition: 99,
      WFConditionalActionString: 'View',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            PropertyName: 'title',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetKeysIntent', name='Keys', params={
      keyPath: 'Version Control',
    }),

    sc.Action('com.sindresorhus.Actions.SortListIntent', name='Sorted List', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'SortListIntent',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      'Show-list': true,
      list: sc.Attach(sc.Ref('Keys')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F530BB16-B092-43FF-B5E0-26DFFAC48AA8',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Sorted List')),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Vars.Repeat Item'),
          },
          string: 'Version Control.￼.1.b64icon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{17, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ]),
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
      text: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'F530BB16-B092-43FF-B5E0-26DFFAC48AA8',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: 'Select shortcut to view its versions',
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
          },
          string: 'Version Control.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Value')),
      WFVariableName: 'Export',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '964E44BF-AD7A-4D63-B099-4704FE2F6B15',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Value')),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item'),
            '{18, 1}': sc.Ref('Vars.Repeat Index'),
          },
          string: 'Version Control.￼.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Value', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'name',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
      WFVariableName: 'name',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{11, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'date',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{27, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'actions count',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{31, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'note',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{41, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'b64icon',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{7, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'version',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'title: ￼ : ￼\nsub: Actions: ￼ | ￼\nbase64: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.QuickMenu2Intent', {
      text: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '964E44BF-AD7A-4D63-B099-4704FE2F6B15',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: 'Export All',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: 'Go Back',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: {
        Value: {
          attachmentsByRange: {
            '{17, 1}': sc.Ref('Chosen Item'),
          },
          string: 'Which version of ￼ would you like to restore?',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: sc.Attach(sc.Ref('Vars.Menu')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6A3266FB-DD65-4ADC-B3DF-B13AE8E5A41C',
      WFCondition: 4,
      WFConditionalActionString: 'Go Back',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            PropertyName: 'Name',
            PropertyUserInfo: 'WFItemName',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: sc.Attach(sc.Ref('Chosen Item')),
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

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      'Show-text': true,
      WFTextCustomSeparator: ':',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Chosen Item')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([sc.Ref('Item from List')]),
      WFReplaceTextFind: '\\s$',
      WFReplaceTextRegularExpression: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B542FF5C-D6F2-47A8-9A8B-DE4F0D6D0C5E',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Value')),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{18, 1}': sc.Ref('Vars.Repeat Index'),
          },
          string: 'Version Control.￼.￼.version',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6128F9AF-A448-4A95-9A19-1117FD929284',
      WFCondition: 4,
      WFConditionalActionString: sc.Str([sc.Ref('Value')]),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Updated Text')),
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Vars.name'),
            '{18, 1}': sc.Ref('Vars.Repeat Index'),
          },
          string: 'Version Control.￼.￼.url',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.showwebpage', {
      WFURL: sc.Str([sc.Ref('Value')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6128F9AF-A448-4A95-9A19-1117FD929284',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6128F9AF-A448-4A95-9A19-1117FD929284',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B542FF5C-D6F2-47A8-9A8B-DE4F0D6D0C5E',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6A3266FB-DD65-4ADC-B3DF-B13AE8E5A41C',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '417A0E48-5F82-44DF-B448-ED047609E58D',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '70A99A6B-B6FF-4FCE-9FB5-3E51BD8C7F1A',
      WFCondition: 4,
      WFConditionalActionString: 'Export All',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            PropertyName: 'Name',
            PropertyUserInfo: 'WFItemName',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: 'If this is your first time Exporting, please cancel this shortcut and create a folder in the Notes app named Version Control otherwise, continue.',
      WFAlertActionTitle: 'Version Control Export Setup',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '80A2FDB7-7A37-4C1F-BD49-43DCD82B30E8',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Vars.Export')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Name', params={
      WFDictionaryKey: 'name',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Version', params={
      WFDictionaryKey: 'version',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Date', params={
      WFDictionaryKey: 'date',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='URL', params={
      WFDictionaryKey: 'url',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Note', params={
      WFDictionaryKey: 'note',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Actions', params={
      WFDictionaryKey: 'actions count',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Date'),
            '{11, 1}': sc.Ref('URL'),
            '{16, 1}': sc.Ref('Actions'),
            '{26, 1}': sc.Ref('Note'),
            '{3, 1}': sc.Ref('Name'),
            '{8, 1}': sc.Ref('Version'),
          },
          string: '￼\n[￼ : v￼](￼) : ￼ Actions\n￼\n\n-',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.getrichtextfrommarkdown', {
      WFInput: sc.Attach(sc.Ref('Text')),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '80A2FDB7-7A37-4C1F-BD49-43DCD82B30E8',
      WFControlFlowMode: 2,
    }),

    sc.Action('dk.simonbs.DataJar.CheckIfValueExistsIntent', name='Value Exists', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Name'),
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
        Variable: sc.Attach(sc.Ref('Value Exists', aggs=[
          {
            PropertyName: 'Name',
            PropertyUserInfo: 'WFItemName',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
      WFNumberValue: '',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Name'),
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

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Name'),
          },
          string: 'Version Control.￼.1.url',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([sc.Ref('Value')]),
      WFReplaceTextFind: '/shortcuts/',
      WFReplaceTextReplace: '/shortcuts/api/records/',
    }),

    sc.Action('is.workflow.actions.gettypeaction', name='File of Type', params={
      WFFileType: 'public.json',
      WFInput: sc.Attach(sc.Ref('Updated Text')),
    }),

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      WFInput: sc.Str([sc.Ref('File of Type', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'fields.name.value',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([sc.Ref('File of Type', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'fields.icon.value.downloadURL',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFReplaceTextFind: '${f}',
      WFReplaceTextReplace: sc.Str([sc.Ref('URL Encoded Text')]),
    }),

    sc.Action('is.workflow.actions.downloadurl', name='Contents of URL', params={
      WFURL: sc.Str([sc.Ref('Updated Text')]),
    }),

    sc.Action('is.workflow.actions.setitemname', name='Icon Image', params={
      WFInput: sc.Attach(sc.Ref('Contents of URL')),
      WFName: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('File of Type', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'fields.name.value',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼.png',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
          },
          string: 'Version Control.￼.1.exporticon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      overwriteStrategy: 'alwaysAllow',
      valueConversionMode: 'file',
      values: sc.Attach(sc.Ref('Icon Image')),
    }),

    sc.Action('is.workflow.actions.delay'),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', {
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
          },
          string: 'Version Control.￼.1.exporticon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'ED0B8895-BCD2-4611-B12A-821C84B2D53C',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: 'Version Control',
    }),

    sc.Action('com.apple.mobilenotes.SharingExtension', name='Note', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'CreateNoteLinkAction',
        BundleIdentifier: 'com.apple.mobilenotes',
        Name: 'Notes',
        TeamIdentifier: '0000000000',
      },
      WFCreateNoteInput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': sc.Ref('Name'),
            '{2, 1}': sc.Ref('If Result'),
          },
          string: '￼ ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      folder: sc.Attach(sc.Ref('Text')),
    }),

    sc.Action('is.workflow.actions.appendnote', {
      AppIntentDescriptor: {
        AppIntentIdentifier: 'AppendToNoteLinkAction',
        BundleIdentifier: 'com.apple.mobilenotes',
        Name: 'Notes',
        TeamIdentifier: '0000000000',
      },
      WFInput: sc.Str([sc.Ref('Repeat Results')]),
      WFNote: sc.Attach(sc.Ref('Note')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '70A99A6B-B6FF-4FCE-9FB5-3E51BD8C7F1A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED4BD5DF-3115-4D29-8460-D699A8604E1A',
      WFCondition: 99,
      WFConditionalActionString: 'Remove',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            PropertyName: 'title',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('dk.simonbs.DataJar.GetKeysIntent', name='Keys', params={
      keyPath: 'Version Control',
    }),

    sc.Action('com.sindresorhus.Actions.SortListIntent', name='Sorted List', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'SortListIntent',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      'Show-list': true,
      list: sc.Attach(sc.Ref('Keys')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'F51681C8-CDBA-40EB-89BF-3CD57E5F3951',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Sorted List')),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Vars.Repeat Item'),
          },
          string: 'Version Control.￼.1.b64icon',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{17, 1}': sc.Ref('Value'),
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
      text: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'F51681C8-CDBA-40EB-89BF-3CD57E5F3951',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: 'Go Back',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Menu',
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: 'Select shortcut to view its versions',
      WFInput: sc.Attach(sc.Ref('Vars.Menu')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B224B2D7-B7E4-4B66-9945-899A91135E65',
      WFCondition: 4,
      WFConditionalActionString: 'Go Back',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            PropertyName: 'Name',
            PropertyUserInfo: 'WFItemName',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B224B2D7-B7E4-4B66-9945-899A91135E65',
      WFControlFlowMode: 1,
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
          },
          string: 'Version Control.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '7FE68386-F34C-4E25-888C-5862816FFCCB',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Value')),
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item'),
            '{18, 1}': sc.Ref('Vars.Repeat Index'),
          },
          string: 'Version Control.￼.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Value', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'name',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
      WFVariableName: 'name',
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{11, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'date',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{27, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'actions count',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{31, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'note',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{41, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'b64icon',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{52, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'name',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{63, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'version',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{7, 1}': sc.Ref('Value', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'version',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: 'title: ￼ : ￼\nsub: Actions: ￼ | ￼\nbase64: ￼\nfield 1: ￼\nfield 2: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('com.alexhay.ToolboxProForShortcuts.QuickMenu2Intent', {
      text: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '7FE68386-F34C-4E25-888C-5862816FFCCB',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: 'Select the version(s) you would like to remove',
      WFChooseFromListActionSelectMultiple: true,
      WFInput: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '2CB74CD2-6D0E-4685-8163-F8F7E1116CBD',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Chosen Item')),
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      'Show-text': true,
      WFTextCustomSeparator: ':',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
    }),

    sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
      WFInput: sc.Str([sc.Ref('Item from List')]),
      WFReplaceTextFind: '\\s$',
      WFReplaceTextRegularExpression: true,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '0E77A3C6-B0C3-441A-BF2E-5A5884F53FC1',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Value')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8662EBE-5B24-4C8C-822E-53DA00E3605F',
      WFCondition: 5,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Deleted')),
      },
      WFNumberValue: '1',
    }),

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='Value', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{18, 1}': sc.Ref('Vars.Repeat Index 2'),
          },
          string: 'Version Control.￼.￼.version',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FC4A4FEE-B2EB-4E46-A1D5-E388AAC67024',
      WFCondition: 4,
      WFConditionalActionString: sc.Str([sc.Ref('Value')]),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Updated Text')),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: {
        Value: {
          attachmentsByRange: {
            '{40, 1}': sc.Ref('Value'),
          },
          string: 'Are you sure you want to delete version ￼? If so, press OK.',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('dk.simonbs.DataJar.DeleteValueIntent', {
      deleteStrategy: 'alwaysAllow',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{18, 1}': sc.Ref('Vars.Repeat Index 2'),
          },
          string: 'Version Control.￼.￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.number', name='Number', params={
      WFNumberActionNumber: '1',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Number')),
      WFVariableName: 'Deleted',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'FC4A4FEE-B2EB-4E46-A1D5-E388AAC67024',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B8662EBE-5B24-4C8C-822E-53DA00E3605F',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '0E77A3C6-B0C3-441A-BF2E-5A5884F53FC1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '2CB74CD2-6D0E-4685-8163-F8F7E1116CBD',
      WFControlFlowMode: 2,
    }),

    sc.Action('dk.simonbs.DataJar.GetChildCountIntent', name='Count', params={
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
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
        Variable: sc.Attach(sc.Ref('Count')),
      },
      WFNumberValue: '1',
    }),

    sc.Action('dk.simonbs.DataJar.DeleteValueIntent', {
      deleteStrategy: 'alwaysAllow',
      keyPath: {
        Value: {
          attachmentsByRange: {
            '{16, 1}': sc.Ref('Chosen Item', aggs=[
              {
                PropertyName: 'title',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
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
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED4BD5DF-3115-4D29-8460-D699A8604E1A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '53C04CCA-3A14-4CC7-A7D5-3C28AC23E4B3',
      WFCondition: 99,
      WFConditionalActionString: 'Stop',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            PropertyName: 'title',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '53C04CCA-3A14-4CC7-A7D5-3C28AC23E4B3',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.runworkflow', {
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
