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
      WFDate: sc.Str([sc.Ref('Date')]),
      WFDuration: {
        Value: {
          Magnitude: sc.Ref('N'),
          Unit: 'days',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.addnewreminder', {
      WFAlertCustomTime: sc.Str([sc.Ref('Adjusted Date', aggs=[
        {
          Type: 'WFDateFormatVariableAggrandizement',
          WFDateFormatStyle: 'Medium',
          WFISO8601IncludeTime: false,
          WFTimeFormatStyle: 'None',
        },
      ])]),
      WFAlertEnabled: 'Alert',
      WFCalendarDescriptor: {
        Identifier: '<x-apple-reminderkit://REMCDList/0D507F24-D632-477A-BEF2-AFC7E49CB18D>',
        IsAllCalendar: false,
        Title: 'Perishable Food',
      },
      WFCalendarItemCalendar: 'Perishable Food',
      WFCalendarItemTitle: sc.Str([{
        Type: 'Ask',
      }]),
    }),

  ]),
  WFWorkflowClientVersion: '2607.1',
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
  WFWorkflowTypes: [
    'Watch',
  ],
}
