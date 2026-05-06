local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
      'does not have any value'
    )).Then_([

      sc.Action('is.workflow.actions.list', name='List', params={
        WFItems: [
          'connect',
          'disconnect',
        ],
      }),

      sc.Action('is.workflow.actions.choosefromlist', {
        WFInput: sc.Attach(sc.Ref('List')),
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.getvariable', {
        WFVariable: sc.Attach(sc.Input),
      }),

    ]).EndIf_(name='Input'),

    sc.Action('is.workflow.actions.getdevicedetails', name='Device Model', params={
      WFDeviceDetail: 'Device Model',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Device Model')),
      },
      'is',
      {
        WFConditionalActionString: 'Mac',
      }
    )).Then_([

      sc.Action('is.workflow.actions.gettext', name='Text', params={
        WFTextActionText: |||
          mouse=10-94-bb-a9-41-7a
            keybd=70-f0-87-36-14-6e
        |||,
      }),

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Input', aggs=[
            {
              CoercionItemClass: 'WFStringContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ])),
        },
        'is',
        {
          WFConditionalActionString: 'disconnect',
        }
      )).Then_([

        sc.Action('is.workflow.actions.runshellscript', {
          Input: sc.Attach(sc.Ref('Text')),
          Script: |||
            parallel --plain -t --tagstring='{1}' --colsep='=' \\
                blueutil --unpair '{2}' '# {1}'
          |||
          ,
          Shell: '/bin/bash',
        }),

      ]).Else_([

        sc.Action('is.workflow.actions.runshellscript', {
          Input: sc.Attach(sc.Ref('Text')),
          RunAsRoot: false,
          Script: |||
            parallel --plain -t --tagstring='{1}' --colsep='=' \\
                blueutil --pair '{2}' 0000 '# {1}'
          |||
          ,
          Shell: '/bin/bash',
        }),

      ]).EndIf_(),

    ]).Else_([

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Input', aggs=[
            {
              CoercionItemClass: 'WFStringContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ])),
        },
        'is',
        {
          WFConditionalActionString: 'disconnect',
        }
      )).Then_([

        sc.Action('is.workflow.actions.alert', {
          WFAlertActionMessage: "You will be taken Bluetooth Preferences. Please \"Forget\" Tim's Apple mouse & Tim's Keyboard, then return to Shortcuts.",
        }),

      ]).Else_([

        sc.Action('is.workflow.actions.alert', {
          WFAlertActionMessage: "You will be taken Bluetooth Preferences. Please \"Pair\" Tim's Apple mouse & Tim's Keyboard.",
        }),

      ]).EndIf_(name='If Result'),

      sc.Action('is.workflow.actions.runworkflow', {
        WFInput: sc.Attach(sc.Ref('If Result')),
        WFWorkflow: {
          isSelf: false,
          workflowIdentifier: 'F5C12AD8-86EC-4BC7-8E52-8564AB5EFDD4',
          workflowName: 'Open Bluetooth Preferences',
        },
        WFWorkflowName: 'Open Bluetooth Preferences',
      }),

      sc.Action('is.workflow.actions.waittoreturn'),

    ]).EndIf_(),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: -43634177,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFStringContentItem',
  ],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
