local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Optional multi-stop route\nTim Wilson, June 2024\n\nCreates a multi-stop navigation route in Apple Maps using locations specified by user from contacts, events, or locations. Optionally optimizes route for time or distance. ',
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      WFTextCustomSeparator: '&daddr=',
      WFTextSeparator: 'Custom',
      text: function(state) sc.Ref(state, 'Shortcut Input', att=true),
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: function(state) sc.Ref(state, 'Split Text', att=true),
    }),

    sc.Action('is.workflow.actions.calculateexpression', name='Location number', params={
      Input: {
        Value: {
          attachmentsByRange: {
            '{4, 1}': function(state) sc.Ref(state, 'Count'),
          },
          string: 'max(￼-1,0)',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '98A65311-964A-4139-80FE-A4D440488044',
      WFControlFlowMode: 0,
      WFMenuItems: [
        '👤 Search for contact',
        '📅 Search for event',
        "🗓️ Locations of day's events",
        '🗒️ Enter list of addresses',
        '📍 Choose location',
        '🧭 Current location',
      ],
      WFMenuPrompt: {
        Value: {
          attachmentsByRange: {
            '{12, 1}': function(state) sc.Ref(state, 'Location number'),
          },
          string: 'Select stop ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '98A65311-964A-4139-80FE-A4D440488044',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '👤 Search for contact',
    }),

    sc.Action('is.workflow.actions.filter.contacts', name='Contacts', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Operator: 4,
              Property: 'First Name',
              Removable: true,
              Values: {
                String: {
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
                Unit: 4,
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemLimitEnabled: false,
      WFContentItemLimitNumber: 5,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '923DF985-E1E0-4137-96A0-C7D054D600D1',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Contacts', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '51F17CDB-CDF9-446A-895D-A84AC9AE8BCE',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Street Addresses',
                PropertyUserInfo: 5,
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFVariableName: 'Loc contacts',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '51F17CDB-CDF9-446A-895D-A84AC9AE8BCE',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '923DF985-E1E0-4137-96A0-C7D054D600D1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '25EBB221-2825-4C5D-A57A-8BDC42A5DA97',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Vars.Loc contacts', att=true),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionCancelButtonShown: false,
      WFAlertActionMessage: 'No locations found',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: 'D76D84D1-6107-4F94-936D-EDC1C0A239AA',
        workflowName: 'Create multi stop route 1',
      },
      WFWorkflowName: 'Create multi stop route 1',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '25EBB221-2825-4C5D-A57A-8BDC42A5DA97',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: function(state) sc.Ref(state, 'Vars.Loc contacts', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '97ECC57B-1A22-461A-98D3-5395CE42A053',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Count', att=true),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      WFInput: function(state) sc.Ref(state, 'Vars.Loc contacts', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '97ECC57B-1A22-461A-98D3-5395CE42A053',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: function(state) sc.Ref(state, 'Vars.Loc contacts', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '97ECC57B-1A22-461A-98D3-5395CE42A053',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.properties.contacts', name='Street Addresses', params={
      WFContentItemPropertyName: 'Street Addresses',
      WFInput: function(state) sc.Ref(state, 'If Result', att=true),
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: function(state) sc.Ref(state, 'Street Addresses', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED98C656-D5E7-4082-B2F5-751F95DD1CFC',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Count', att=true),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      WFInput: function(state) sc.Ref(state, 'Street Addresses', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED98C656-D5E7-4082-B2F5-751F95DD1CFC',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: function(state) sc.Ref(state, 'Street Addresses', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ED98C656-D5E7-4082-B2F5-751F95DD1CFC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '98A65311-964A-4139-80FE-A4D440488044',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '📅 Search for event',
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='Calendar Events', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Bounded: true,
              Operator: 1000,
              Property: 'Start Date',
              Removable: false,
              Values: {
                Number: {
                  Value: {
                    Type: 'Ask',
                  },
                  WFSerializationType: 'WFTextTokenAttachment',
                },
                Unit: 16,
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '34746EE0-F852-4ABC-BB30-91BF83A4D4B7',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Calendar Events', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '8CFA9A3C-867E-4C33-8851-9BA1F198E5A4',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Location',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFVariableName: 'Loc events',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '8CFA9A3C-867E-4C33-8851-9BA1F198E5A4',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '34746EE0-F852-4ABC-BB30-91BF83A4D4B7',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '50075982-A6C8-421E-B299-8489F0EDB719',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Vars.Loc events', att=true),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: 'No events with locations found',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: 'D76D84D1-6107-4F94-936D-EDC1C0A239AA',
        workflowName: 'Create multi stop route 1',
      },
      WFWorkflowName: 'Create multi stop route 1',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '50075982-A6C8-421E-B299-8489F0EDB719',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: function(state) sc.Ref(state, 'Vars.Loc events', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2BC3D71D-AF01-4A83-AD33-DCDA8912F8F6',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Count', att=true),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.choosefromlist', {
      WFInput: function(state) sc.Ref(state, 'Vars.Loc events', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2BC3D71D-AF01-4A83-AD33-DCDA8912F8F6',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: function(state) sc.Ref(state, 'Vars.Loc events', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '2BC3D71D-AF01-4A83-AD33-DCDA8912F8F6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', {
      WFContentItemPropertyName: 'Location',
      WFInput: function(state) sc.Ref(state, 'If Result', att=true),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '98A65311-964A-4139-80FE-A4D440488044',
      WFControlFlowMode: 1,
      WFMenuItemTitle: "🗓️ Locations of day's events",
    }),

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionDefaultAnswerDate: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': {
              Type: 'CurrentDate',
            },
          },
          string: '￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFAskActionPrompt: 'Select day to navigate events',
      WFInputType: 'Date',
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Adjusted Date', params={
      WFAdjustOperation: 'Get Start of Day',
      WFDate: function(state) sc.Val('${Provided Input}', state),
    }),

    sc.Action('is.workflow.actions.adjustdate', name='Adjusted Date', params={
      WFAdjustOperation: 'Add',
      WFDate: function(state) sc.Val('${Adjusted Date}', state),
      WFDuration: {
        Value: {
          Magnitude: '24',
          Unit: 'hr',
        },
        WFSerializationType: 'WFQuantityFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.filter.calendarevents', name='Calendar Events', params={
      WFContentItemFilter: {
        Value: {
          WFActionParameterFilterPrefix: 1,
          WFActionParameterFilterTemplates: [
            {
              Bounded: true,
              Operator: 1003,
              Property: 'Start Date',
              Removable: false,
              Values: {
                AnotherDate: function(state) sc.Ref(state, 'Adjusted Date', att=true),
                Date: function(state) sc.Ref(state, 'Adjusted Date', att=true),
                Number: 7,
                Unit: 16,
              },
            },
          ],
          WFContentPredicateBoundedDate: false,
        },
        WFSerializationType: 'WFContentPredicateTableTemplate',
      },
      WFContentItemSortOrder: 'Oldest First',
      WFContentItemSortProperty: 'Start Date',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B16C96BF-E67D-4501-A3BC-5CE0B36C3639',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Calendar Events', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '8C0C50EE-CBF0-48ED-90AD-639E70A72C23',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Location',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Repeat Item',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFVariableName: 'Events',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '8C0C50EE-CBF0-48ED-90AD-639E70A72C23',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'B16C96BF-E67D-4501-A3BC-5CE0B36C3639',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'E07D8411-3D2C-4D3C-95BC-0D3352C391C6',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Vars.Events', att=true),
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionCancelButtonShown: false,
      WFAlertActionMessage: 'No locations found for selected date',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: 'B4ED64FC-91B2-4291-A539-D11C3C6B9864',
        workflowName: 'Navigate day’s events',
      },
      WFWorkflowName: 'Navigate day’s events',
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'E07D8411-3D2C-4D3C-95BC-0D3352C391C6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: 'Select events to include in route',
      WFChooseFromListActionSelectAll: true,
      WFChooseFromListActionSelectMultiple: true,
      WFInput: function(state) sc.Ref(state, 'Vars.Events', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3A53C81A-53DC-4C3E-A3C2-24B3EFE0B762',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Chosen Item', att=true),
    }),

    sc.Action('is.workflow.actions.properties.calendarevents', {
      WFContentItemPropertyName: 'Location',
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '3A53C81A-53DC-4C3E-A3C2-24B3EFE0B762',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '98A65311-964A-4139-80FE-A4D440488044',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '🗒️ Enter list of addresses',
    }),

    sc.Action('is.workflow.actions.ask', name='Provided Input', params={
      WFAskActionPrompt: 'Enter one or more addresses, one per line',
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      text: function(state) sc.Ref(state, 'Provided Input', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D78FC4C2-2A82-4508-8F7E-7975EDA72091',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Split Text', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7583D3FF-B4B7-4538-A03D-2AEB2D8DC41A',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      },
    }),

    sc.Action('is.workflow.actions.text.match', name='lone zip code', params={
      WFMatchTextPattern: '^[0-9]+$',
      text: function(state) sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7D5653C7-3BEA-4FDF-A27E-5539CA52D4E3',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'lone zip code', att=true),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2B094537-7AE2-4CDB-B261-4786BC4C4F39',
      WFCondition: 5,
      WFControlFlowMode: 0,
      WFEnumeration: 'Mac',
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                PropertyName: 'Device Type',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'DeviceDetails',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionCancelButtonShown: false,
      WFAlertActionMessage: 'Lone postal codes only work on Mac due to an iOS bug. Sorry!',
    }),

    sc.Action('is.workflow.actions.exit'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2B094537-7AE2-4CDB-B261-4786BC4C4F39',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.address', {
      WFPostalCode: function(state) sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7D5653C7-3BEA-4FDF-A27E-5539CA52D4E3',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.text.match', name='lat,lon', params={
      WFMatchTextPattern: '(\\-?[0-9]+\\.[0-9]+),(\\-?[0-9]+\\.[0-9]+)',
      text: function(state) sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3B08D904-BFEB-4FC3-980C-F0B959ABAFBF',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'lat,lon', att=true),
      },
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='lat', params={
      matches: function(state) sc.Ref(state, 'lat,lon', att=true),
    }),

    sc.Action('is.workflow.actions.text.match.getgroup', name='lon', params={
      WFGroupIndex: '2',
      matches: function(state) sc.Ref(state, 'lat,lon', att=true),
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'lat'),
            '{2, 1}': function(state) sc.Ref(state, 'lon'),
          },
          string: '￼,￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.getmapslink', name='Maps URL', params={
      WFInput: function(state) sc.Ref(state, 'Text', att=true),
    }),

    sc.Action('is.workflow.actions.location', {
      WFLocation: function(state) sc.Ref(state, 'Maps URL', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3B08D904-BFEB-4FC3-980C-F0B959ABAFBF',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.detect.address', {
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '3B08D904-BFEB-4FC3-980C-F0B959ABAFBF',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '7D5653C7-3BEA-4FDF-A27E-5539CA52D4E3',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'If Result', att=true),
      WFVariableName: 'ImportLocations',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7583D3FF-B4B7-4538-A03D-2AEB2D8DC41A',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'D78FC4C2-2A82-4508-8F7E-7975EDA72091',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: function(state) sc.Ref(state, 'Vars.ImportLocations', att=true),
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '98A65311-964A-4139-80FE-A4D440488044',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '📍 Choose location',
    }),

    sc.Action('is.workflow.actions.location', {
      WFLocation: {
        Value: {
          Type: 'Ask',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '98A65311-964A-4139-80FE-A4D440488044',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '🧭 Current location',
    }),

    sc.Action('is.workflow.actions.getcurrentlocation'),

    sc.Action('is.workflow.actions.choosefrommenu', name='Menu Result', params={
      GroupingIdentifier: '98A65311-964A-4139-80FE-A4D440488044',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: function(state) sc.Ref(state, 'Menu Result', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7C1B1E7E-AF93-4967-8D90-2944984AD192',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Count', att=true),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '051A5639-E48D-4F68-AEAF-4C54C33717E9',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Menu Result', att=true),
    }),

    sc.Action('is.workflow.actions.urlencode', {
      WFInput: function(state) sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '051A5639-E48D-4F68-AEAF-4C54C33717E9',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', {
      WFTextCustomSeparator: '&daddr=',
      WFTextSeparator: 'Custom',
      text: function(state) sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7C1B1E7E-AF93-4967-8D90-2944984AD192',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.urlencode', {
      WFInput: function(state) sc.Val('${Menu Result}', state),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '7C1B1E7E-AF93-4967-8D90-2944984AD192',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.gettext', name='Loc string', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Shortcut Input'),
            '{8, 1}': function(state) sc.Ref(state, 'If Result'),
          },
          string: '￼&daddr=￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      WFTextCustomSeparator: '&daddr=',
      WFTextSeparator: 'Custom',
      text: function(state) sc.Ref(state, 'Loc string', att=true),
    }),

    sc.Action('is.workflow.actions.count', name='Location count', params={
      Input: function(state) sc.Ref(state, 'Split Text', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4FBFA1D8-458E-4F9D-AEE8-38286EC9E75F',
      WFCondition: 0,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Location count', att=true),
      },
      WFNumberValue: '4',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: function(state) sc.Ref(state, 'Loc string', att=true),
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: '6F3A9A14-14B3-454E-81AB-D80DFC21D0C0',
        workflowName: 'Create multi stop route',
      },
      WFWorkflowName: 'Create multi stop route',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4FBFA1D8-458E-4F9D-AEE8-38286EC9E75F',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.math', name='cur count', params={
      WFInput: function(state) sc.Ref(state, 'Location count', att=true),
      WFMathOperand: '1',
      WFMathOperation: '-',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '22DD996B-20F1-4CC4-9365-C7AB59F08ADA',
      WFControlFlowMode: 0,
      WFMenuItems: [
        '➕ Add another location',
        '🏁 Create multi-stop route',
      ],
      WFMenuPrompt: {
        Value: {
          attachmentsByRange: {
            '{13, 1}': function(state) sc.Ref(state, 'cur count'),
          },
          string: 'Total stops: ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '22DD996B-20F1-4CC4-9365-C7AB59F08ADA',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '➕ Add another location',
    }),

    sc.Action('is.workflow.actions.runworkflow', {
      WFInput: function(state) sc.Ref(state, 'Loc string', att=true),
      WFWorkflow: {
        isSelf: true,
        workflowIdentifier: '6F3A9A14-14B3-454E-81AB-D80DFC21D0C0',
        workflowName: 'Create multi stop route',
      },
      WFWorkflowName: 'Create multi stop route',
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '22DD996B-20F1-4CC4-9365-C7AB59F08ADA',
      WFControlFlowMode: 1,
      WFMenuItemTitle: '🏁 Create multi-stop route',
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E9448D8B-66F3-4F17-8C96-32F99CA66DA6',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Split Text', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2FD86768-F75E-4E93-A165-66AE63C126CD',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      },
    }),

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      WFEncodeMode: 'Decode',
      WFInput: function(state) sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.detect.address', name='Addresses', params={
      WFInput: function(state) sc.Ref(state, 'URL Encoded Text', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ACD8954D-68D0-4E37-BF23-9BC81AA9CD04',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Addresses', att=true),
      },
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: function(state) sc.Ref(state, 'Addresses', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'ACD8954D-68D0-4E37-BF23-9BC81AA9CD04',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.address', {
      WFPostalCode: function(state) sc.Val('${URL Encoded Text}', state),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: 'ACD8954D-68D0-4E37-BF23-9BC81AA9CD04',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'If Result', att=true),
      WFVariableName: 'LocList',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2FD86768-F75E-4E93-A165-66AE63C126CD',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E9448D8B-66F3-4F17-8C96-32F99CA66DA6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Ask user how to compute optimal route',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Val('⏱️ Time'),
              WFValue: sc.Val('Fastest route'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('🛣️ Distance'),
              WFValue: sc.Val('Most efficient route'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('📏 Straight line distance'),
              WFValue: sc.Val('Fastest to compute'),
            },
            {
              WFItemType: 0,
              WFKey: sc.Val('🚫 Input order'),
              WFValue: sc.Val('No route optimization'),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
      WFChooseFromListActionPrompt: 'How to optimize route? ',
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Chosen Item', att=true),
      WFVariableName: 'TSP type',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '79C69DBC-A7CF-4C23-925B-0CA914D0A1D5',
      WFCondition: 999,
      WFConditionalActionString: 'No route optimization',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'TSP type',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Check for tour',
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='First', params={
      WFInput: function(state) sc.Ref(state, 'Vars.LocList', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Last', params={
      WFInput: function(state) sc.Ref(state, 'Vars.LocList', att=true),
      WFItemSpecifier: 'Last Item',
    }),

    sc.Action('is.workflow.actions.getdistance', name='Distance', params={
      Accuracy: 'Best',
      WFDistanceUnit: 'Kilometers',
      WFGetDirectionsCustomLocation: function(state) sc.Ref(state, 'First', att=true),
      WFGetDistanceDestination: function(state) sc.Ref(state, 'Last', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '1DEA492B-DF3D-48FF-A4D5-2722BD642384',
      WFCondition: 0,
      WFConditionalActionString: function(state) sc.Val('${First}', state),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Distance', att=true),
      },
      WFNumberValue: '0.3',
    }),

    sc.Action('is.workflow.actions.number', {
      WFNumberActionNumber: '1',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '1DEA492B-DF3D-48FF-A4D5-2722BD642384',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.number', {
      WFNumberActionNumber: '0',
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '1DEA492B-DF3D-48FF-A4D5-2722BD642384',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'If Result', att=true),
      WFVariableName: 'Is tour',
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Prepare cost dictionary. We’ll precompute the costs (drive times) between each pair of locations, and store those in the dictionary as a 2d array.',
    }),

    sc.Action('is.workflow.actions.date', name='t1'),

    sc.Action('is.workflow.actions.count', name='N', params={
      Input: function(state) sc.Ref(state, 'Vars.LocList', att=true),
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 3,
              WFKey: sc.Val('N'),
              WFValue: function(state) sc.Val('${N}', state),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Cost dictionary',
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '787C56C1-C9EB-4514-B811-E1D034A17906',
      WFControlFlowMode: 0,
      WFRepeatCount: function(state) sc.Ref(state, 'N', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='L1', params={
      WFInput: function(state) sc.Ref(state, 'Vars.LocList', att=true),
      WFItemIndex: function(state) sc.Ref(state, 'Vars.Repeat Index', att=true),
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: 'D110F405-9BF1-4D33-9020-802620EF60BF',
      WFControlFlowMode: 0,
      WFRepeatCount: function(state) sc.Ref(state, 'Vars.Repeat Index', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '913CEE15-2BBB-4A55-9DD1-B9ABBC853A78',
      WFCondition: 5,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Vars.Repeat Index', att=true),
      },
      WFNumberValue: function(state) sc.Ref(state, 'Vars.Repeat Index 2', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='L2', params={
      WFInput: function(state) sc.Ref(state, 'Vars.LocList', att=true),
      WFItemIndex: function(state) sc.Ref(state, 'Vars.Repeat Index 2', att=true),
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'We’ll assume a “symmetric” TSP, i.e. it takes the same amount of time to go from A to B as is does to go from B to A. Could still capture the effects of the true asymmetric system by using the average drive time for both directions, but that takes longer so we’ll just pick one.',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0A4291D7-5EAF-4244-B4AA-E4C8E05F8B0C',
      WFCondition: 99,
      WFConditionalActionString: 'Fastest route',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'TSP type',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.gettraveltime', {
      WFDestination: function(state) sc.Ref(state, 'L2', att=true),
      WFGetDirectionsActionMode: 'Driving',
      WFGetDirectionsCustomLocation: function(state) sc.Ref(state, 'L1', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0A4291D7-5EAF-4244-B4AA-E4C8E05F8B0C',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A3766452-8067-4937-A5ED-656B5270C4A0',
      WFCondition: 999,
      WFConditionalActionString: 'compute',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'TSP type',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getdistance', {
      Accuracy: 'HundredMeters',
      WFDistanceUnit: 'Kilometers',
      WFGetDirectionsActionMode: 'Driving',
      WFGetDirectionsCustomLocation: function(state) sc.Ref(state, 'L1', att=true),
      WFGetDistanceDestination: function(state) sc.Ref(state, 'L2', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A3766452-8067-4937-A5ED-656B5270C4A0',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getdistance', {
      Accuracy: 'HundredMeters',
      WFDistanceUnit: 'Kilometers',
      WFGetDirectionsActionMode: 'Direct',
      WFGetDirectionsCustomLocation: function(state) sc.Ref(state, 'L1', att=true),
      WFGetDistanceDestination: function(state) sc.Ref(state, 'L2', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A3766452-8067-4937-A5ED-656B5270C4A0',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', name='L1L2', params={
      GroupingIdentifier: '0A4291D7-5EAF-4244-B4AA-E4C8E05F8B0C',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: function(state) sc.Ref(state, 'Vars.Cost dictionary', att=true),
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Vars.Repeat Index'),
            '{2, 1}': function(state) sc.Ref(state, 'Vars.Repeat Index 2'),
          },
          string: '￼,￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDictionaryValue: function(state) sc.Val('${L1L2}', state),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Vars.Repeat Index 2'),
            '{2, 1}': function(state) sc.Ref(state, 'Vars.Repeat Index'),
          },
          string: '￼,￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFDictionaryValue: function(state) sc.Val('${L1L2}', state),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Cost dictionary',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '913CEE15-2BBB-4A55-9DD1-B9ABBC853A78',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: 'D110F405-9BF1-4D33-9020-802620EF60BF',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '787C56C1-C9EB-4514-B811-E1D034A17906',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.date', name='t2'),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Drive time wall time', params={
      WFInput: function(state) sc.Val('${t2}', state),
      WFTimeUntilFromDate: function(state) sc.Val('${t1}', state),
      WFTimeUntilUnit: 'Total Time',
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Now implement the “nearest neighbor” symmetric TSP solution.\nCurrent (first) location is starting point and there are N locations. \nWe’ll end up with a dictionary of routes where the key is the route drive time (in seconds) and the value is a comma-separated list of location indices.',
    }),

    sc.Action('is.workflow.actions.number', name='Big number', params={
      WFNumberActionNumber: '999999999999',
    }),

    sc.Action('is.workflow.actions.nothing', name='Nothing'),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Nothing', att=true),
      WFVariableName: 'Solutions',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4AD22761-EF65-4273-9B7C-7816199428C1',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFBooleanContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Is tour',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.math', {
      WFInput: function(state) sc.Ref(state, 'N', att=true),
      WFMathOperand: '2',
      WFMathOperation: '-',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4AD22761-EF65-4273-9B7C-7816199428C1',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.math', {
      WFInput: function(state) sc.Ref(state, 'N', att=true),
      WFMathOperand: '1',
      WFMathOperation: '-',
    }),

    sc.Action('is.workflow.actions.conditional', name='N - 1', params={
      GroupingIdentifier: '4AD22761-EF65-4273-9B7C-7816199428C1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '8EB302EA-C141-4165-AB98-CE45A879D7BF',
      WFControlFlowMode: 0,
      WFRepeatCount: function(state) sc.Ref(state, 'N - 1', att=true),
    }),

    sc.Action('is.workflow.actions.math', name='i', params={
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Index', att=true),
      WFMathOperand: '1',
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        '1',
        {
          WFItemType: 0,
          WFValue: function(state) sc.Val('${i}', state),
        },
      ],
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'List', att=true),
      WFVariableName: 'CurSolution',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Cost 1,i', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{2, 1}': function(state) sc.Ref(state, 'i'),
          },
          string: '1,￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: function(state) sc.Ref(state, 'Vars.Cost dictionary', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '11793AD6-34C0-4D03-ACEC-CE73681895B1',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Cost 1,i', aggs=[
          {
            CoercionItemClass: 'WFNumberContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ], att=true),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Cost 1,i', att=true),
      WFVariableName: 'CurSolutionCosts',
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Find the closest (least drive time) neighbor location in the list. Do this until the route is complete.',
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '3BAF33D3-8077-4A69-9395-3ADBF0705BC9',
      WFControlFlowMode: 0,
      WFRepeatCount: function(state) sc.Ref(state, 'N - 1', att=true),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Big number', att=true),
      WFVariableName: 'MinCost',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Nothing', att=true),
      WFVariableName: 'MinCostInd',
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='previous location', params={
      WFInput: function(state) sc.Ref(state, 'Vars.CurSolution', att=true),
      WFItemSpecifier: 'Last Item',
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: 'BF7CE22A-56B6-4E67-ADCB-F2702A982FFF',
      WFControlFlowMode: 0,
      WFRepeatCount: function(state) sc.Ref(state, 'N - 1', att=true),
    }),

    sc.Action('is.workflow.actions.math', name='j', params={
      WFInput: function(state) sc.Ref(state, 'Vars.Repeat Index 3', att=true),
      WFMathOperand: '1',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C1D0F2A9-157F-420A-8E30-B22F25CECFB8',
      WFCondition: 999,
      WFConditionalActionString: function(state) sc.Val('${j}', state),
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'CurSolution',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='cost ij', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'previous location'),
            '{2, 1}': function(state) sc.Ref(state, 'j'),
          },
          string: '￼,￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: function(state) sc.Ref(state, 'Vars.Cost dictionary', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '5EA4B056-81E2-4511-9866-C40F438C2F2B',
      WFCondition: 0,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'cost ij', aggs=[
          {
            CoercionItemClass: 'WFNumberContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ], att=true),
      },
      WFNumberValue: function(state) sc.Ref(state, 'Vars.MinCost', att=true),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'cost ij', att=true),
      WFVariableName: 'MinCost',
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'j', att=true),
      WFVariableName: 'MinCostInd',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '5EA4B056-81E2-4511-9866-C40F438C2F2B',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C1D0F2A9-157F-420A-8E30-B22F25CECFB8',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: 'BF7CE22A-56B6-4E67-ADCB-F2702A982FFF',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6B3ADB28-34A9-4B58-8F6E-1B0A1F6DD996',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: function(state) sc.Ref(state, 'Vars.MinCostInd', att=true),
      },
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'Vars.MinCostInd', att=true),
      WFVariableName: 'CurSolution',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'Vars.MinCost', att=true),
      WFVariableName: 'CurSolutionCosts',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '6B3ADB28-34A9-4B58-8F6E-1B0A1F6DD996',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '3BAF33D3-8077-4A69-9395-3ADBF0705BC9',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'We have the whole solution for this starting location. Save to solution dictionary\n',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '51EEEAD7-32F5-4E08-A19C-9332568866E1',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: {
          Value: {
            Aggrandizements: [
              {
                CoercionItemClass: 'WFBooleanContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ],
            Type: 'Variable',
            VariableName: 'Is tour',
          },
          WFSerializationType: 'WFTextTokenAttachment',
        },
      },
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: function(state) sc.Ref(state, 'Vars.CurSolution', att=true),
      WFItemSpecifier: 'Last Item',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Item from List'),
            '{2, 1}': function(state) sc.Ref(state, 'N'),
          },
          string: '￼,￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
      WFInput: function(state) sc.Ref(state, 'Vars.Cost dictionary', att=true),
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'Dictionary Value', att=true),
      WFVariableName: 'CurSolutionCosts',
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: function(state) sc.Ref(state, 'N', att=true),
      WFVariableName: 'CurSolution',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '51EEEAD7-32F5-4E08-A19C-9332568866E1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.statistics', name='Sum', params={
      Input: function(state) sc.Ref(state, 'Vars.CurSolutionCosts', att=true),
      WFStatisticsOperation: 'Sum',
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: ',',
      WFTextSeparator: 'Custom',
      text: function(state) sc.Ref(state, 'Vars.CurSolution', att=true),
    }),

    sc.Action('is.workflow.actions.setvalueforkey', name='Dictionary', params={
      WFDictionary: function(state) sc.Ref(state, 'Vars.Solutions', att=true),
      WFDictionaryKey: function(state) sc.Val('${Sum}', state),
      WFDictionaryValue: function(state) sc.Val('${Combined Text}', state),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: function(state) sc.Ref(state, 'Dictionary', att=true),
      WFVariableName: 'Solutions',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '11793AD6-34C0-4D03-ACEC-CE73681895B1',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '8EB302EA-C141-4165-AB98-CE45A879D7BF',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Now find the minimum of the solution costs',
    }),

    sc.Action('is.workflow.actions.statistics', name='Minimum', params={
      Input: {
        Value: {
          Aggrandizements: [
            {
              CoercionItemClass: 'WFDictionaryContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
            {
              PropertyName: 'Keys',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Solutions',
        },
        WFSerializationType: 'WFTextTokenAttachment',
      },
      WFStatisticsOperation: 'Minimum',
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='MinCostSolution', params={
      WFDictionaryKey: function(state) sc.Val('${Minimum}', state),
      WFInput: function(state) sc.Ref(state, 'Vars.Solutions', att=true),
    }),

    sc.Action('is.workflow.actions.date', name='t3'),

    sc.Action('is.workflow.actions.gettimebetweendates', name='TSP wall time', params={
      WFInput: function(state) sc.Val('${t3}', state),
      WFTimeUntilFromDate: function(state) sc.Val('${t2}', state),
      WFTimeUntilUnit: 'Total Time',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 3,
              WFKey: sc.Val('Precompute drive times'),
              WFValue: function(state) sc.Val('${Drive time wall time}', state),
            },
            {
              WFItemType: 3,
              WFKey: sc.Val('Compute optimal solution'),
              WFValue: function(state) sc.Val('${TSP wall time}', state),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      WFTextCustomSeparator: ',',
      WFTextSeparator: 'Custom',
      text: function(state) sc.Ref(state, 'MinCostSolution', att=true),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '38DF2123-5E7B-4B38-80B1-92FC4ABB4FD6',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Split Text', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: function(state) sc.Ref(state, 'Vars.LocList', att=true),
      WFItemIndex: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.urlencode', {
      WFInput: function(state) sc.Val('${Item from List}', state),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '38DF2123-5E7B-4B38-80B1-92FC4ABB4FD6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'DE59A7C3-6579-49EF-9B09-C5A2256FCC91',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Split Text', att=true),
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: function(state) sc.Ref(state, 'Vars.LocList', att=true),
      WFItemIndex: function(state) sc.Ref(state, 'Vars.Repeat Item', att=true),
      WFItemSpecifier: 'Item At Index',
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{0, 1}': function(state) sc.Ref(state, 'Vars.Repeat Index'),
            '{12, 1}': function(state) sc.Ref(state, 'Item from List', aggs=[
              {
                PropertyName: 'Country',
                PropertyUserInfo: 'country',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{3, 1}': function(state) sc.Ref(state, 'Item from List', aggs=[
              {
                PropertyName: 'Street',
                PropertyUserInfo: 'street',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{6, 1}': function(state) sc.Ref(state, 'Item from List', aggs=[
              {
                PropertyName: 'City',
                PropertyUserInfo: 'city',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
            '{9, 1}': function(state) sc.Ref(state, 'Item from List', aggs=[
              {
                PropertyName: 'State',
                PropertyUserInfo: 'state',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ]),
          },
          string: '￼) ￼, ￼, ￼, ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: 'DE59A7C3-6579-49EF-9B09-C5A2256FCC91',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', {
      text: function(state) sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{18, 1}': function(state) sc.Ref(state, 'Dictionary'),
          },
          string: 'Timing (seconds): ￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: '&daddr=',
      WFTextSeparator: 'Custom',
      text: function(state) sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.gettext', name='maps url', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{27, 1}': function(state) sc.Ref(state, 'Combined Text'),
          },
          string: 'maps://?dirflg=d&t=h&saddr=￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: function(state) sc.Ref(state, 'maps url', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '79C69DBC-A7CF-4C23-925B-0CA914D0A1D5',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '37E189D3-078A-4705-8225-DF9DF2186144',
      WFControlFlowMode: 0,
      WFInput: function(state) sc.Ref(state, 'Vars.LocList', att=true),
    }),

    sc.Action('is.workflow.actions.urlencode', {
      WFInput: function(state) sc.Val('${Vars.Repeat Item}', state),
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '37E189D3-078A-4705-8225-DF9DF2186144',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: '&daddr=',
      WFTextSeparator: 'Custom',
      text: function(state) sc.Ref(state, 'Repeat Results', att=true),
    }),

    sc.Action('is.workflow.actions.gettext', name='maps url', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{27, 1}': function(state) sc.Ref(state, 'Combined Text'),
          },
          string: 'maps://?dirflg=d&t=h&saddr=￼',
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.openurl', {
      WFInput: function(state) sc.Ref(state, 'maps url', att=true),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '79C69DBC-A7CF-4C23-925B-0CA914D0A1D5',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.choosefrommenu', {
      GroupingIdentifier: '22DD996B-20F1-4CC4-9365-C7AB59F08ADA',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4FBFA1D8-458E-4F9D-AEE8-38286EC9E75F',
      WFControlFlowMode: 2,
    }),

  ]),
  WFWorkflowClientVersion: '2302.0.4',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61444,
    WFWorkflowIconStartColor: -1448498689,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [],
  WFWorkflowMinimumClientVersion: 900,
  WFWorkflowMinimumClientVersionString: '900',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'Watch',
  ],
}
