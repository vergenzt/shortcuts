local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('is.workflow.actions.ask', name='N', params={
      local state = super.state,
      WFAskActionPrompt: 'How many days?',
      WFInputType: 'Number',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Adjusted Date', params={
      local state = super.state,
      WFDate: sc.Val('${Date}', state),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref(state, 'N'),
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.addnewreminder', {
      local state = super.state,
      WFAlertCustomTime: sc.Val('${Adjusted Date}', state),
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
