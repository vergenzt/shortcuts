local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='config', params={
      keyPath: 'google-oauth',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='existing unexpired token', params={
      input: sc.Attach(sc.Ref('config')),
      jqQuery: 'if .token.expires_at > (now | todate) and .token.access_token then .token else empty end',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A79BC9F-64D3-4E75-9B83-A2D758932D7B',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('existing unexpired token')),
      },
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: sc.Str([sc.Ref('existing unexpired token', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'token_type',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])]),
      WFResponse: 'Successfully authenticated to Google. ✅',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A79BC9F-64D3-4E75-9B83-A2D758932D7B',
      WFControlFlowMode: 2,
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='refresh_uri', params={
      input: sc.Attach(sc.Ref('config')),
      jqQuery: 'if .token.expires_at <= (now | todate) and .token.refresh_token then .token_uri + "?" + (.params + (.token | {refresh_token}) + { grant_type: "refresh_token" } | to_entries | map(map(@uri) | join("=")) | join("&")) else empty end',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '22E62798-BDB0-43EE-BE22-F8F025412072',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('refresh_uri')),
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', name='refresh_result', params={
      WFHTTPMethod: 'POST',
      WFURL: sc.Str([sc.Ref('refresh_uri')]),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='timestamped_token', params={
      input: sc.Attach(sc.Ref('refresh_result')),
      jqQuery: sc.Str([sc.Ref('config', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          DictionaryKey: 'token',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ]), ' + . + { refreshed_at: (now | todate), expires_at: (now + .expires_in | todate) }']),
      queryType: 'jq',
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: 'google-oauth.token',
      overwriteStrategy: 'alwaysAllow',
      values: sc.Attach(sc.Ref('timestamped_token')),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: sc.Attach(sc.Ref('timestamped_token')),
      jqQuery: '.token_type + " " + .access_token',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: sc.Str([sc.Ref('Result')]),
      WFResponse: 'Successfully authenticated to Google. ✅',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '22E62798-BDB0-43EE-BE22-F8F025412072',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.dictionary', name='auth_params', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['approval_prompt']),
              WFValue: sc.Str(['force']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['access_type']),
              WFValue: sc.Str(['offline']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['response_type']),
              WFValue: sc.Str(['code']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='auth_uri', params={
      input: sc.Attach(sc.Ref('config')),
      jqQuery: sc.Str(['.auth_uri + "?" + (.params + ', sc.Ref('auth_params'), '| del(.client_secret) | to_entries | map(map(@uri) | join("=")) | join("&"))']),
      queryType: 'jq',
      slurp: false,
    }),

    sc.Action('is.workflow.actions.openxcallbackurl', name='X-Callback Result', params={
      WFXCallbackCustomCallbackEnabled: true,
      WFXCallbackCustomSuccessKey: 'state',
      WFXCallbackCustomSuccessURLEnabled: false,
      WFXCallbackURL: sc.Str([sc.Ref('auth_uri')]),
    }),

    sc.Action('is.workflow.actions.detect.dictionary', name='result', params={
      WFInput: sc.Attach(sc.Ref('X-Callback Result')),
    }),

    sc.Action('is.workflow.actions.dictionary', name='token_params', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['grant_type']),
              WFValue: sc.Str(['authorization_code']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='token_uri', params={
      input: sc.Attach(sc.Ref('config')),
      jqQuery: sc.Str(['.token_uri + "?" + (', sc.Ref('token_params')]),
      queryType: 'jq',
      slurp: false,
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      'Show-WFURLActionURL': true,
      WFURLActionURL: sc.Attach(sc.Ref('token_uri')),
    }),

    sc.Action('is.workflow.actions.downloadurl', name='token', params={
      Advanced: true,
      ShowHeaders: false,
      WFHTTPMethod: 'POST',
      WFURL: sc.Str([sc.Ref('URL')]),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='timestamped_token', params={
      input: sc.Attach(sc.Ref('token')),
      jqQuery: '. + { refreshed_at: (now | todate), expires_at: (now + .expires_in | todate) }',
      queryType: 'jq',
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: 'google-oauth.token',
      overwriteStrategy: 'alwaysAllow',
      values: sc.Attach(sc.Ref('timestamped_token')),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: sc.Attach(sc.Ref('timestamped_token')),
      jqQuery: '.token_type + " " + .access_token',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: sc.Str([sc.Ref('Result')]),
      WFResponse: 'Successfully authenticated to Google. ✅',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '22E62798-BDB0-43EE-BE22-F8F025412072',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: true,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 59749,
    WFWorkflowIconStartColor: 463140863,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [
    'WFGenericFileContentItem',
    'WFStringContentItem',
  ],
  WFWorkflowTypes: [
    'NCWidget',
    'Watch',
  ],
}
