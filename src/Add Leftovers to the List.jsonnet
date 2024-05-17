local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('is.workflow.actions.ask', name='N', params={
      WFAskActionPrompt: 'How many days?',
      WFInputType: 'Number',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Adjusted Date', params={
      local outputs = super.outputs,
      WFDate: sc.Val('${Date}', outputs),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref(outputs, 'N'),
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.addnewreminder', {
      local outputs = super.outputs,
      UUID: '1DC33832-5163-4CF7-85F8-4939EAFDBE96',
      WFAlertCustomTime: sc.Val('${Adjusted Date}', outputs),
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
    }),

  ]),
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
