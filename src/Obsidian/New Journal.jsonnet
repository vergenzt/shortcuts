local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.gettext', name='Content', params={
      WFTextActionText: sc.Str(['---\nupdated_at: ', {
        Aggrandizements: [
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ],
        Type: 'CurrentDate',
      }, '\ncreated_at: ', {
        Aggrandizements: [
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormatStyle: 'ISO 8601',
            WFISO8601IncludeTime: true,
          },
        ],
        Type: 'CurrentDate',
      }, '\n---\n# Journal entry from ', {
        Type: 'CurrentDate',
      }]),
    }),

    sc.Action('is.workflow.actions.gettext', name='New File Name', params={
      WFTextActionText: sc.Str(['@', {
        Aggrandizements: [
          {
            Type: 'WFDateFormatVariableAggrandizement',
            WFDateFormat: 'yyyyMMddHHmmssSSS',
            WFDateFormatStyle: 'Custom',
            WFISO8601IncludeTime: false,
          },
        ],
        Type: 'CurrentDate',
      }, '.md']),
    }),

    sc.Action('is.workflow.actions.documentpicker.save', name='Saved File', params={
      WFAskWhereToSave: false,
      WFFileDestinationPath: sc.Str(['Reference/Journal/', sc.Ref('New File Name')]),
      WFFolder: {
        displayName: 'brain',
        fileLocation: {
          WFFileLocationType: 'Home',
          relativeSubpath: 'brain',
        },
        filename: 'brain',
      },
      WFInput: sc.Attach(sc.Ref('Content')),
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: '^always seems to always set the file extension to .txt\n\nThis works around that:',
    }),

    sc.Action('is.workflow.actions.file.rename', {
      WFFile: sc.Attach(sc.Ref('Saved File')),
      WFNewFilename: sc.Str([sc.Ref('New File Name')]),
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      WFURLActionURL: sc.Str(['obsidian://open?vault=brain&file=', sc.Ref('New File Name')]),
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: sc.Attach(sc.Ref('URL')),
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61466,
    WFWorkflowIconStartColor: 2071128575,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFAppContentItem',
    'WFAppStoreAppContentItem',
    'WFContactContentItem',
    'WFDateContentItem',
    'WFEmailAddressContentItem',
    'WFiTunesProductContentItem',
    'WFPhoneNumberContentItem',
    'WFStringContentItem',
    'WFURLContentItem',
    'WFArticleContentItem',
    'WFSafariWebPageContentItem',
    'WFLocationContentItem',
    'WFDCMapsLinkContentItem',
    'WFImageContentItem',
    'WFAVAssetContentItem',
    'WFGenericFileContentItem',
    'WFFolderContentItem',
    'WFPDFContentItem',
    'WFRichTextContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1113,
  WFWorkflowMinimumClientVersionString: '1113',
  WFWorkflowNoInputBehavior: {
    Name: 'WFWorkflowNoInputBehaviorAskForInput',
    Parameters: {
      ItemClass: 'WFStringContentItem',
    },
  },
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
    'Watch',
  ],
}
