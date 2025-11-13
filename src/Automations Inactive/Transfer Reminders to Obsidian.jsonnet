local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.filter.reminders', name='Reminders', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Operator: 4,
              Property: 'Is Completed',
              Removable: true,
              Values: {
                Bool: false,
              },
            },
            {
              Operator: 4,
              Property: 'List',
              Removable: true,
              Values: {
                Enumeration: {
                  Value: 'Reminders',
                  WFSerializationType: 'WFStringSubstitutableState',
                },
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemLimitEnabled: false,
      WFContentItemLimitNumber: 5.0,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '00AC6591-B3B8-417A-AB05-4415056FDF78',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Reminders')),
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        {
          WFItemType: 0,
          WFValue: sc.Str(['# ', sc.Ref('Vars.Repeat Item')]),
        },
        {
          WFItemType: 0,
          WFValue: sc.Str([{
            Aggrandizements: [
              {
                PropertyName: 'URL',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item',
          }]),
        },
        {
          WFItemType: 0,
          WFValue: sc.Str([{
            Aggrandizements: [
              {
                PropertyName: 'Notes',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item',
          }]),
        },
      ],
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '257DCF15-3390-47B6-9891-EF2C34FBA39B',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('List')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C5BC56C1-0702-4768-B26B-4E99EB226BBA',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C5BC56C1-0702-4768-B26B-4E99EB226BBA',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '257DCF15-3390-47B6-9891-EF2C34FBA39B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettext', name='Two Newlines', params={
      WFTextActionText: '\n\n',
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: sc.Str([sc.Ref('Two Newlines')]),
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Combined Text')),
      WFVariableName: 'Content',
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        {
          WFItemType: 0,
          WFValue: sc.Str(['updated_at: ', {
            Aggrandizements: [
              {
                PropertyName: 'Last Modified Date',
                PropertyUserInfo: 'WFFileModificationDate',
                Type: 'WFPropertyVariableAggrandizement',
              },
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'ISO 8601',
                WFISO8601IncludeTime: true,
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item',
          }]),
        },
        {
          WFItemType: 0,
          WFValue: sc.Str(['created_at: ', {
            Aggrandizements: [
              {
                PropertyName: 'Creation Date',
                PropertyUserInfo: 'WFFileCreationDate',
                Type: 'WFPropertyVariableAggrandizement',
              },
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'ISO 8601',
                WFISO8601IncludeTime: true,
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item',
          }]),
        },
        {
          WFItemType: 0,
          WFValue: sc.Str(['imported_at: ', {
            Aggrandizements: [
              {
                Type: 'WFDateFormatVariableAggrandizement',
                WFDateFormatStyle: 'ISO 8601',
                WFISO8601IncludeTime: true,
              },
            ],
            Type: 'CurrentDate',
          }]),
        },
        'import_source: Apple Reminders',
      ],
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('List')),
      WFVariableName: 'Frontmatter',
    }),

    sc.Action('is.workflow.actions.runworkflow', name='Reminder URL', params={
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFWorkflow: {
        isSelf: false,
        workflowIdentifier: '905FF3E9-756A-496E-8327-5E8AB3CF58EE',
        workflowName: 'Get Reminder URL',
      },
      WFWorkflowName: 'Get Reminder URL',
    }),

    sc.Action('is.workflow.actions.gettext', name='Reminder URL Meta', params={
      WFTextActionText: sc.Str(['reminder_url: ', sc.Ref('Reminder URL')]),
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Reminder URL Meta')),
      WFVariableName: 'Frontmatter',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'Due Date',
            Type: 'WFPropertyVariableAggrandizement',
          },
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }),
      WFVariableName: 'Due Date ISO',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '11BC3E6C-4D1C-4D68-9814-456811832BE7',
      WFCondition: 100,
      WFConditionalActionString: 'T00:00:00',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Due Date ISO')),
      },
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      WFTextCustomSeparator: 'T',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Vars.Due Date ISO')),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Due Date', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
    }),

    sc.Action('is.workflow.actions.gettext', name='Due Date Meta', params={
      WFTextActionText: sc.Str(['due_date: ', sc.Ref('Due Date')]),
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Due Date Meta')),
      WFVariableName: 'Frontmatter',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C56C1A12-52FE-471F-9646-4ACA618280C7',
      WFCondition: 999,
      WFConditionalActionString: 'T00:00:00',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Due Date ISO')),
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Due Time', params={
      WFInput: sc.Attach(sc.Ref('Split Text')),
      WFItemIndex: '2',
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.gettext', name='Due Time Meta', params={
      WFTextActionText: sc.Str(['due_time: ', sc.Ref('Due Time')]),
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Due Time Meta')),
      WFVariableName: 'Frontmatter',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C56C1A12-52FE-471F-9646-4ACA618280C7',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '11BC3E6C-4D1C-4D68-9814-456811832BE7',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '68E2F2EA-A823-4AA1-9E63-E82799B52408',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              PropertyName: 'Reminder Location',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Repeat Item',
        }),
      },
    }),

    sc.Action('is.workflow.actions.properties.reminders', name='Reminder Location', params={
      WFContentItemPropertyName: 'Reminder Location',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str(['reminder_location_geo: geo:', sc.Ref('Reminder Location', aggs=[
        {
          PropertyName: 'Latitude',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Text')),
      WFVariableName: 'Frontmatter',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '68E2F2EA-A823-4AA1-9E63-E82799B52408',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Frontmatter Combined', params={
      text: sc.Attach(sc.Ref('Vars.Frontmatter')),
    }),

    sc.Action('is.workflow.actions.gettext', name='New Note File Body', params={
      WFTextActionText: sc.Str(['---\n', sc.Ref('Vars.Content')]),
    }),

    sc.Action('is.workflow.actions.gettext', name='New Note Filename', params={
      WFTextActionText: sc.Str(['@', {
        Aggrandizements: [
          {
            PropertyName: 'Creation Date',
            PropertyUserInfo: 'WFFileCreationDate',
            Type: 'WFPropertyVariableAggrandizement',
          },
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormat: 'yyyyMMddHHmmssSSS',
            WFDateFormatStyle: 'Custom',
            WFISO8601IncludeTime: false,
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }, '.md']),
    }),

    sc.Action('is.workflow.actions.documentpicker.save', name='Saved File', params={
      WFAskWhereToSave: false,
      WFFileDestinationPath: sc.Str([sc.Ref('New Note Filename')]),
      WFFolder: {
        displayName: 'Inbox',
        fileLocation: {
          WFFileLocationType: 'LocalStorage',
          appContainerBundleIdentifier: 'md.obsidian',
          crossDeviceItemID: 'deviceSpecific:CB3CF8B9-7192-4227-9973-42070585C008:fp:/VRZ969UewqEk1hn_bxR0mIxWUDXsI0TA5Y_+yJ15_Vs=/com.apple.FileProvider.LocalStorage//fid=16742731',
          fileProviderDomainID: 'com.apple.FileProvider.LocalStorage',
          relativeSubpath: 'brain/Inbox',
        },
        filename: 'Inbox',
      },
      WFInput: sc.Attach(sc.Ref('New Note File Body')),
    }),

    sc.Action('is.workflow.actions.file.rename', {
      WFFile: sc.Attach(sc.Ref('Saved File')),
      WFNewFilename: sc.Str([sc.Ref('New Note Filename')]),
    }),

    sc.Action('is.workflow.actions.url', name='Obsidian URL', params={
      WFURLActionURL: sc.Str(['obsidian://open?vault=brain&file=', sc.Ref('New Note Filename')]),
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        {
          WFItemType: 0,
          WFValue: sc.Str([{
            Aggrandizements: [
              {
                PropertyName: 'Notes',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item',
          }]),
        },
        {
          WFItemType: 0,
          WFValue: sc.Str([sc.Ref('Obsidian URL')]),
        },
      ],
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'A8687361-9785-48CE-83F9-0C7E2B08D4E0',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('List')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6B3C089D-98D0-499C-A3DD-D1F928C7C56B',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6B3C089D-98D0-499C-A3DD-D1F928C7C56B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'A8687361-9785-48CE-83F9-0C7E2B08D4E0',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Reminder Notes with Obsidian URL', params={
      WFTextCustomSeparator: sc.Str([sc.Ref('Two Newlines')]),
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('is.workflow.actions.setters.reminders', name='Edited Reminder', params={
      Mode: 'Set',
      WFContentItemPropertyName: 'Notes',
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item')),
      WFReminderContentItemNotes: sc.Str([sc.Ref('Reminder Notes with Obsidian URL')]),
    }),

    sc.Action('is.workflow.actions.setters.reminders', {
      Mode: 'Set',
      WFContentItemPropertyName: 'Is Completed',
      WFInput: sc.Attach(sc.Ref('Edited Reminder')),
      WFReminderContentItemIsCompleted: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('Obsidian URL')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '00AC6591-B3B8-417A-AB05-4415056FDF78',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 463140863,
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
  WFWorkflowMinimumClientVersion: 1106,
  WFWorkflowMinimumClientVersionString: '1106',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'Watch',
  ],
}
