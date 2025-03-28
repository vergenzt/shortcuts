{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: [
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.date',
      WFWorkflowActionParameters: {
        UUID: 'F451F999-C3D1-47DB-90A2-969B0F612971',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.ask',
      WFWorkflowActionParameters: {
        CustomOutputName: 'N',
        UUID: '22736820-07CB-44B4-AB55-C5C8EDA83C4C',
        WFAskActionPrompt: 'How many days?',
        WFInputType: 'Number',
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.adjustdate',
      WFWorkflowActionParameters: {
        UUID: 'D44749C8-B13A-48FA-B58B-93967D6BC605',
        WFDate: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                OutputName: 'Date',
                OutputUUID: 'F451F999-C3D1-47DB-90A2-969B0F612971',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFDuration: {
          Value: {
            Magnitude: {
              OutputName: 'N',
              OutputUUID: '22736820-07CB-44B4-AB55-C5C8EDA83C4C',
              Type: 'ActionOutput',
            },
            Unit: 'days',
          },
          WFSerializationType: 'WFQuantityFieldValue',
        },
      },
    },
    {
      WFWorkflowActionIdentifier: 'is.workflow.actions.addnewreminder',
      WFWorkflowActionParameters: {
        UUID: '1DC33832-5163-4CF7-85F8-4939EAFDBE96',
        WFAlertCustomTime: {
          Value: {
            attachmentsByRange: {
              '{0, 1}': {
                Aggrandizements: [
                  {
                    Type: 'WFDateFormatVariableAggrandizement',
                    WFDateFormatStyle: 'Medium',
                    WFISO8601IncludeTime: false,
                    WFTimeFormatStyle: 'None',
                  },
                ],
                OutputName: 'Adjusted Date',
                OutputUUID: 'D44749C8-B13A-48FA-B58B-93967D6BC605',
                Type: 'ActionOutput',
              },
            },
            string: '￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
        WFAlertEnabled: 'Alert',
        WFCalendarDescriptor: {
          Identifier: '<x-apple-reminderkit://REMCDList/0D507F24-D632-477A-BEF2-AFC7E49CB18D>',
          IsAllCalendar: false,
          Title: 'Perishable Food',
        },
        WFCalendarItemCalendar: 'Perishable Food',
        WFCalendarItemTitle: {
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
    },
  ],
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 2071128575,
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
