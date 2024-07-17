local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('dk.simonbs.DataJar.GetValueIntent', name='config', params={
      keyPath: 'google-oauth',
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='existing unexpired token', params={
      input: function(state) sc.Ref(state, 'config', att=true),
      jqQuery: 'if .token.expires_at > (now | todate) and .token.access_token then .token else empty end',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A79BC9F-64D3-4E75-9B83-A2D758932D7B',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'existing unexpired token', att=true),
      },
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'existing unexpired token', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'token_type',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
            '{2, 1}': function(state) sc.Ref(state, 'existing unexpired token', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'access_token',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼ ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFResponse: 'Successfully authenticated to Google. ✅',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2A79BC9F-64D3-4E75-9B83-A2D758932D7B',
      WFControlFlowMode: 2,
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='refresh_uri', params={
      input: function(state) sc.Ref(state, 'config', att=true),
      jqQuery: 'if .token.expires_at <= (now | todate) and .token.refresh_token then .token_uri + "?" + (.params + (.token | {refresh_token}) + { grant_type: "refresh_token" } | to_entries | map(map(@uri) | join("=")) | join("&")) else empty end',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '22E62798-BDB0-43EE-BE22-F8F025412072',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'refresh_uri', att=true),
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', name='refresh_result', params={
      WFHTTPMethod: 'POST',
      WFURL: function(state) sc.Val('${refresh_uri}', state),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='timestamped_token', params={
      input: function(state) sc.Ref(state, 'refresh_result', att=true),
      jqQuery: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'config', aggs=[
              {
                CoercionItemClass: 'WFDictionaryContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
              {
                DictionaryKey: 'token',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ]),
          },
          string: '￼ + . + { refreshed_at: (now | todate), expires_at: (now + .expires_in | todate) }',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      queryType: 'jq',
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: 'google-oauth.token',
      overwriteStrategy: 'alwaysAllow',
      values: function(state) sc.Ref(state, 'timestamped_token', att=true),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: function(state) sc.Ref(state, 'timestamped_token', att=true),
      jqQuery: '.token_type + " " + .access_token',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: function(state) sc.Val('${Result}', state),
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
              WFKey: sc.Val('approval_prompt'),
              WFValue: sc.Val('force'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('access_type'),
              WFValue: sc.Val('offline'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('response_type'),
              WFValue: sc.Val('code'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='auth_uri', params={
      input: function(state) sc.Ref(state, 'config', att=true),
      jqQuery: {
        Value: {
          attachmentsByRange: {
            '{29, 1}': function(state) sc.Ref(state, 'auth_params'),
          },
          string: '.auth_uri + "?" + (.params + ￼| del(.client_secret) | to_entries | map(map(@uri) | join("=")) | join("&"))',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      queryType: 'jq',
      slurp: false,
    }),

    sc.Action('is.workflow.actions.openxcallbackurl', name='X-Callback Result', params={
      WFXCallbackCustomCallbackEnabled: true,
      WFXCallbackCustomSuccessKey: 'state',
      WFXCallbackCustomSuccessURLEnabled: false,
      WFXCallbackURL: function(state) sc.Val('${auth_uri}', state),
    }),

    sc.Action('is.workflow.actions.detect.dictionary', name='result', params={
      WFInput: function(state) sc.Ref(state, 'X-Callback Result', att=true),
    }),

    sc.Action('is.workflow.actions.dictionary', name='token_params', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('grant_type'),
              WFValue: sc.Val('authorization_code'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='token_uri', params={
      input: function(state) sc.Ref(state, 'config', att=true),
      jqQuery: {
        Value: {
          attachmentsByRange: {
            '{20, 1}': function(state) sc.Ref(state, 'token_params'),
            '{24, 1}': function(state) sc.Ref(state, 'result'),
          },
          string: '.token_uri + "?" + (￼ + ￼ + .params | to_entries | map(map(@uri | gsub("\\\\+"; "%20")) | join("=")) | join("&"))',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      queryType: 'jq',
      slurp: false,
    }),

    sc.Action('is.workflow.actions.url', name='URL', params={
      'Show-WFURLActionURL': true,
      WFURLActionURL: function(state) sc.Ref(state, 'token_uri', att=true),
    }),

    sc.Action('is.workflow.actions.downloadurl', name='token', params={
      Advanced: true,
      ShowHeaders: false,
      WFHTTPMethod: 'POST',
      WFURL: function(state) sc.Val('${URL}', state),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='timestamped_token', params={
      input: function(state) sc.Ref(state, 'token', att=true),
      jqQuery: '. + { refreshed_at: (now | todate), expires_at: (now + .expires_in | todate) }',
      queryType: 'jq',
    }),

    sc.Action('dk.simonbs.DataJar.SetValueIntent', {
      keyPath: 'google-oauth.token',
      overwriteStrategy: 'alwaysAllow',
      values: function(state) sc.Ref(state, 'timestamped_token', att=true),
    }),

    sc.Action('ke.bou.GizmoPack.QueryJSONIntent', name='Result', params={
      input: function(state) sc.Ref(state, 'timestamped_token', att=true),
      jqQuery: '.token_type + " " + .access_token',
      queryType: 'jq',
    }),

    sc.Action('is.workflow.actions.output', {
      WFNoOutputSurfaceBehavior: 'Respond',
      WFOutput: function(state) sc.Val('${Result}', state),
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
  ],
}
