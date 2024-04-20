local lib = import 'shortcuts.libsonnet';
local _ = lib.anon;

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: lib.Actions({
    local outputs = self,

    [_()]: lib.Action('is.workflow.actions.getdevicedetails', {
      UUID: '3841D6D9-62A4-4686-9B3B-736A9FF4C347',
      WFDeviceDetail: 'Device Model',
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6C16A978-32F1-45D5-A028-BFFC2A301E17',
      WFCondition: 4,
      WFConditionalActionString: 'Mac',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Device Model',
            OutputUUID: '3841D6D9-62A4-4686-9B3B-736A9FF4C347',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', {
      UUID: 'F09D65FC-95AB-4B6F-BE23-1E0A1044ED9E',
      WFTextActionText: "jq -c 'if type == \"array\" then .[] else . end' \\\n| parallel '\\\n  curl \\\n  --no-progress-meter \\\n  --fail-with-body \\\n  --url {[ [.base_url, .path] | join(\"/\") ]} \\\n  {[ .method // empty | \"--request\", . ]} \\\n  {[ .params // empty | to_entries | map(\"--url-query\", \"\\(.key)=\\(.value)\")[] ]} \\\n  {[ .data // empty | to_entries | map(\"--data-urlencode\", \"(\\.key)=\\(.value)\")[] ]} \\\n  {[ .form // empty | to_entries | map(\"--form-string\", \"(\\.key)=\\(.value)\")[] ]} \\\n  {[ .json // empty | \"--json\", . ]}",
    }),

    [_()]: lib.Action('is.workflow.actions.runshellscript', {
      Input: {
        Value: {
          Type: 'ExtensionInput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      InputMode: 'to stdin',
      Script: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text',
              OutputUUID: 'F09D65FC-95AB-4B6F-BE23-1E0A1044ED9E',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      UUID: '31196EFE-1490-4D96-B658-F07F732CC855',
    }),

    [_()]: lib.Action('is.workflow.actions.previewdocument', {
      WFInput: {
        Value: {
          OutputName: 'Shell Script Result',
          OutputUUID: '31196EFE-1490-4D96-B658-F07F732CC855',
          Type: 'ActionOutput',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6C16A978-32F1-45D5-A028-BFFC2A301E17',
      UUID: '22A61DA6-17F3-4D65-A3FC-93DCAA64C974',
      WFControlFlowMode: 2,
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B4F4A155-D1B9-4A89-AA17-1A9CBA5CFE54',
      WFCondition: 4,
      WFConditionalActionString: 'iPhone',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            OutputName: 'Device Model',
            OutputUUID: '3841D6D9-62A4-4686-9B3B-736A9FF4C347',
            Type: 'ActionOutput',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    [_()]: lib.Action('is.workflow.actions.gettext', {
      UUID: 'F6C5BBCC-019A-4FB8-A9C8-9C7B59FD4E38',
    }),

    [_()]: lib.Action('dk.simonbs.Scriptable.RunScriptInlineIntent', {
      'Show-texts': false,
      'Show-urls': false,
      ShowWhenRun: false,
      UUID: 'A8CEA644-3421-4760-AE3B-82E3668E8870',
      parameter: [],
      script: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Text',
              OutputUUID: 'F6C5BBCC-019A-4FB8-A9C8-9C7B59FD4E38',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      texts: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              OutputName: 'Input Dict',
              OutputUUID: 'EB495A2F-7586-419E-B8A8-00CA55CBDEE8',
              Type: 'ActionOutput',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    [_()]: lib.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B4F4A155-D1B9-4A89-AA17-1A9CBA5CFE54',
      WFControlFlowMode: 2,
    }),
  }),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 431817727,
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
