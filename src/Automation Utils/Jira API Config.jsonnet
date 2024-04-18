{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    ['Jira Config']: lib.Action('dk.simonbs.DataJar.GetValueIntent', {
              CustomOutputName: 'Jira Config',
              UUID: '2C93C881-B46A-43DA-B28F-9C9FFED23E79',
              keyPath: 'jira-config',
            })
      ,
      [lib.anon()]: lib.Action('ke.bou.GizmoPack.QueryJSONIntent', {
        UUID: '1D3A849D-EFB8-433B-AAAE-E4874ABA35BA',
        input: {
          Value: {
            OutputName: 'Jira Config',
            OutputUUID: '2C93C881-B46A-43DA-B28F-9C9FFED23E79',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        jqQuery: '"\\(.username):\\(.api_token)" | @base64',
        queryType: 'jq',
      })
      ,
      [lib.anon()]: lib.Action('is.workflow.actions.setvalueforkey', {
        UUID: 'DB9762D8-746F-4B5A-BF6E-B933A7E1C055',
        WFDictionary: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            OutputName: 'Jira Config',
            OutputUUID: '2C93C881-B46A-43DA-B28F-9C9FFED23E79',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
        WFDictionaryKey: 'authorization',
        WFDictionaryValue: {
          Value: {
            attachmentsByRange: {
              '{6, 1}': {
                OutputName: 'Result',
                OutputUUID: '1D3A849D-EFB8-433B-AAAE-E4874ABA35BA',
                Type: 'ActionOutput',
              },
            },
            string: 'Basic ￼',
          },
          WFSerializationType: 'WFTextTokenString',
        },
      })
      ,
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59749,
    WFWorkflowIconStartColor: 2071128575,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
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
