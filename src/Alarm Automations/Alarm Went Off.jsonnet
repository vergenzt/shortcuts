local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.date', name='Date', params={
      WFDateActionDate: 'today at 5:40pm',
      WFDateActionMode: 'Current Date',
    }),

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTGetAlarmsIntent', name='Alarms', params={
      AppIntentDescriptor: {
        ActionRequiresAppInstallation: true,
        AppIntentIdentifier: 'AlarmEntity',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Operator: 4,
              Property: 'hours',
              Removable: true,
              Values: {
                Number: sc.Attach(sc.Ref('Date', aggs=[
                  {
                    Type: 'WFDateFormatVariableAggrandizement',
                    WFDateFormat: 'H',
                    WFDateFormatStyle: 'Custom',
                    WFISO8601IncludeTime: false,
                  },
                ])),
                Unit: 4,
              },
            },
            {
              Operator: 4,
              Property: 'minutes',
              Removable: true,
              Values: {
                Number: sc.Attach(sc.Ref('Date', aggs=[
                  {
                    Type: 'WFDateFormatVariableAggrandizement',
                    WFDateFormat: 'm',
                    WFDateFormatStyle: 'Custom',
                    WFISO8601IncludeTime: false,
                  },
                ])),
                Unit: 4,
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '1F8FD74D-2A4F-4A44-BBA4-4CB4D5FF6277',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Alarms')),
    }),

    sc.Action('is.workflow.actions.notification', {
      WFNotificationActionBody: sc.Str([{
        Aggrandizements: [
          {
            PropertyName: 'label',
            PropertyUserInfo: {
              WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'label',
            },
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Repeat Item',
      }]),
      WFNotificationActionSound: false,
      WFNotificationActionTitle: '',
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '1F8FD74D-2A4F-4A44-BBA4-4CB4D5FF6277',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '55EEE80D-D908-4AB3-BA29-F3762BE3870F',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Repeat Results', aggs=[
          {
            PropertyName: 'label',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '55EEE80D-D908-4AB3-BA29-F3762BE3870F',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '55EEE80D-D908-4AB3-BA29-F3762BE3870F',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61701,
    WFWorkflowIconStartColor: 255,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [],
}
