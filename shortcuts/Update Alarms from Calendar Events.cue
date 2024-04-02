// from https://www.icloud.com/shortcuts/50962fea05244c43914f42f822aa6379
{
	WFWorkflowMinimumClientVersionString: "900"
	WFWorkflowMinimumClientVersion:       900
	WFWorkflowIcon: {
		WFWorkflowIconStartColor:  431817727
		WFWorkflowIconGlyphNumber: 61440
	}
	WFWorkflowClientVersion: "1206.3.2"
	WFWorkflowOutputContentItemClasses: []
	WFWorkflowHasOutputFallback: false
	WFWorkflowActions: [
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.gettext"
			WFWorkflowActionParameters: {
				UUID:             "4898379A-8CF9-4B46-BE00-3DB1A233D9E0"
				WFTextActionText: ""
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "4898379A-8CF9-4B46-BE00-3DB1A233D9E0"
						Type:       "ActionOutput"
						OutputName: "Text"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Delete unmatched?"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.dictionary"
			WFWorkflowActionParameters: {
				WFItems: {
					Value: WFDictionaryFieldValueItems: [
						{
							WFKey: {
								Value: string: "Calendar"
								WFSerializationType: "WFTextTokenString"
							}
							WFItemType: 0
							WFValue: {
								Value: string: "Calendar"
								WFSerializationType: "WFTextTokenString"
							}
						},
					]
					WFSerializationType: "WFDictionaryFieldValue"
				}
				CustomOutputName: "Calendars"
				UUID:             "E17254C9-251D-4D01-BA9D-CCA53796AF37"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.text.combine"
			WFWorkflowActionParameters: {
				WFTextCustomSeparator: "|"
				UUID:                  "CAAB610A-9E1B-42F1-8BEC-ED595EC07840"
				WFTextSeparator:       "Custom"
				text: {
					Value: {
						Type:       "ActionOutput"
						OutputName: "Calendars"
						OutputUUID: "E17254C9-251D-4D01-BA9D-CCA53796AF37"
						Aggrandizements: [
							{
								Type:         "WFPropertyVariableAggrandizement"
								PropertyName: "Values"
							},
						]
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
			}
		},
		{
			WFWorkflowActionIdentifier: "com.apple.mobiletimer-framework.MobileTimerIntents.MTGetAlarmsIntent"
			WFWorkflowActionParameters: {
				WFContentItemFilter: {
					Value: {
						WFActionParameterFilterPrefix: 1
						WFContentPredicateBoundedDate: false
						WFActionParameterFilterTemplates: []
					}
					WFSerializationType: "WFContentPredicateTableTemplate"
				}
				ShowWhenRun: false
				UUID:        "96BFA7D2-40FE-48DE-A762-72BB69134F34"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "96BFA7D2-40FE-48DE-A762-72BB69134F34"
						Type:       "ActionOutput"
						OutputName: "Alarm"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				GroupingIdentifier: "25CDD183-1362-42B9-8712-863F0F571C6B"
				WFControlFlowMode:  0
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.text.match"
			WFWorkflowActionParameters: {
				WFMatchTextPattern: {
					Value: {
						string: "(￼) 🗓️: (.*) at ([0-9: APM]+)"
						attachmentsByRange: "{1, 1}": {
							OutputUUID: "CAAB610A-9E1B-42F1-8BEC-ED595EC07840"
							Type:       "ActionOutput"
							OutputName: "Combined Text"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				text: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							VariableName: "Repeat Item"
							Type:         "Variable"
							Aggrandizements: [
								{
									PropertyUserInfo: "label"
									Type:             "WFPropertyVariableAggrandizement"
									PropertyName:     "label"
								},
							]
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				UUID: "5424F246-989D-4B1D-862D-48CE6D8A7B04"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFInput: {
					Type: "Variable"
					Variable: {
						Value: {
							OutputUUID: "5424F246-989D-4B1D-862D-48CE6D8A7B04"
							Type:       "ActionOutput"
							OutputName: "Matches"
						}
						WFSerializationType: "WFTextTokenAttachment"
					}
				}
				WFControlFlowMode:  0
				GroupingIdentifier: "06187FD3-4E72-47D2-8626-3DFC096A3334"
				WFCondition:        100
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.getvariable"
			WFWorkflowActionParameters: WFVariable: {
				Value: {
					VariableName: "Repeat Item"
					Type:         "Variable"
				}
				WFSerializationType: "WFTextTokenAttachment"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				UUID:               "13CCA2BD-9C22-4474-9954-7A68B3B4B444"
				GroupingIdentifier: "06187FD3-4E72-47D2-8626-3DFC096A3334"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				UUID:               "F505E2A0-23F4-48A2-9B69-E0685C498FBA"
				GroupingIdentifier: "25CDD183-1362-42B9-8712-863F0F571C6B"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "F505E2A0-23F4-48A2-9B69-E0685C498FBA"
						Type:       "ActionOutput"
						OutputName: "Repeat Results"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Calendar Alarms"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.dictionary"
			WFWorkflowActionParameters: UUID: "53A72E38-2837-4D4B-BC66-CF33E559EB7D"
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "53A72E38-2837-4D4B-BC66-CF33E559EB7D"
						Type:       "ActionOutput"
						OutputName: "Dictionary"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Matched Calendar Alarm Indices"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.date"
			WFWorkflowActionParameters: {
				CustomOutputName: "Current Datetime"
				UUID:             "F1E39DC9-CAE8-458C-8B72-450D09704C59"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.adjustdate"
			WFWorkflowActionParameters: {
				WFDuration: {
					Value: {
						Unit:      "hr"
						Magnitude: "24"
					}
					WFSerializationType: "WFQuantityFieldValue"
				}
				CustomOutputName: "24 Hours Out"
				UUID:             "9D0897C6-4877-4C09-B387-90503CC88144"
				WFDate: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							OutputUUID: "F1E39DC9-CAE8-458C-8B72-450D09704C59"
							Type:       "ActionOutput"
							OutputName: "Current Datetime"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.filter.calendarevents"
			WFWorkflowActionParameters: {
				WFContentItemInputParameter: "Library"
				WFContentItemLimitEnabled:   false
				UUID:                        "58E91960-056A-43F4-A3CA-61059329F2A5"
				WFContentItemFilter: {
					Value: {
						WFActionParameterFilterPrefix: 1
						WFContentPredicateBoundedDate: false
						WFActionParameterFilterTemplates: [
							{
								Property: "Start Date"
								Operator: 1003
								Values: {
									AnotherDate: {
										Value: {
											OutputUUID: "9D0897C6-4877-4C09-B387-90503CC88144"
											Type:       "ActionOutput"
											OutputName: "24 Hours Out"
										}
										WFSerializationType: "WFTextTokenAttachment"
									}
									Unit: 16
									Date: {
										Value: {
											OutputUUID: "F1E39DC9-CAE8-458C-8B72-450D09704C59"
											Type:       "ActionOutput"
											OutputName: "Current Datetime"
										}
										WFSerializationType: "WFTextTokenAttachment"
									}
									Number: 7
								}
								Removable: false
								Bounded:   true
							},
							{
								Operator: 4
								Values: Bool: false
								Removable: true
								Property:  "Is All Day"
							},
							{
								Operator: 5
								Values: Enumeration: {
									Value:               "Declined"
									WFSerializationType: "WFStringSubstitutableState"
								}
								Removable: true
								Property:  "My Status"
							},
						]
					}
					WFSerializationType: "WFContentPredicateTableTemplate"
				}
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "58E91960-056A-43F4-A3CA-61059329F2A5"
						Type:       "ActionOutput"
						OutputName: "Calendar Events"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				GroupingIdentifier: "3A666097-90F9-4E2A-BBDC-A7A2F903EB04"
				WFControlFlowMode:  0
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: WFVariableName: "Alarm"
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.properties.calendarevents"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Repeat Item"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				UUID:                      "9BEA2617-BB08-4044-A5F6-B4EC6E3A94F9"
				WFContentItemPropertyName: "Calendar"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.getvalueforkey"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "E17254C9-251D-4D01-BA9D-CCA53796AF37"
						Type:       "ActionOutput"
						OutputName: "Calendars"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				CustomOutputName: "Calendar Label"
				UUID:             "A7586AA4-688F-4160-9D7F-704FACF79C8B"
				WFDictionaryKey: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							OutputUUID: "9BEA2617-BB08-4044-A5F6-B4EC6E3A94F9"
							Type:       "ActionOutput"
							OutputName: "Calendar"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFInput: {
					Type: "Variable"
					Variable: {
						Value: {
							OutputUUID: "A7586AA4-688F-4160-9D7F-704FACF79C8B"
							Type:       "ActionOutput"
							OutputName: "Calendar Label"
						}
						WFSerializationType: "WFTextTokenAttachment"
					}
				}
				WFControlFlowMode:  0
				GroupingIdentifier: "427BCD5D-36BB-4074-BB69-2550C082A88F"
				WFCondition:        100
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.properties.calendarevents"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Repeat Item"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFContentItemPropertyName: "Title"
				UUID:                      "B89D6127-FEC4-4DC5-AC30-3F1A4AED7A23"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.properties.calendarevents"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Repeat Item"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				UUID:                      "B0E48D17-CB8B-42DC-BC70-56D5B3779E4C"
				WFContentItemPropertyName: "Start Date"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.adjustdate"
			WFWorkflowActionParameters: {
				WFDuration: {
					Value: {
						Unit:      "min"
						Magnitude: "20"
					}
					WFSerializationType: "WFQuantityFieldValue"
				}
				UUID:              "DBB8C07D-7933-4F5D-B072-778D1E32AA10"
				CustomOutputName:  "Desired Alarm Time"
				WFAdjustOperation: "Subtract"
				WFDate: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							OutputUUID: "B0E48D17-CB8B-42DC-BC70-56D5B3779E4C"
							Type:       "ActionOutput"
							OutputName: "Start Date"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.gettext"
			WFWorkflowActionParameters: {
				WFTextActionText: {
					Value: {
						string: "￼ 🗓️: ￼ at ￼"
						attachmentsByRange: {
							"{12, 1}": {
								Type:       "ActionOutput"
								OutputName: "Start Date"
								OutputUUID: "B0E48D17-CB8B-42DC-BC70-56D5B3779E4C"
								Aggrandizements: [
									{
										WFDateFormatStyle:    "None"
										WFTimeFormatStyle:    "Short"
										WFISO8601IncludeTime: false
										Type:                 "WFDateFormatVariableAggrandizement"
									},
								]
							}
							"{7, 1}": {
								OutputUUID: "B89D6127-FEC4-4DC5-AC30-3F1A4AED7A23"
								Type:       "ActionOutput"
								OutputName: "Title"
							}
							"{0, 1}": {
								OutputUUID: "A7586AA4-688F-4160-9D7F-704FACF79C8B"
								Type:       "ActionOutput"
								OutputName: "Calendar Label"
							}
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				CustomOutputName: "Desired Alarm Name"
				UUID:             "827F3DBE-29D3-467B-8F7A-12F602A9389E"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Calendar Alarms"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				GroupingIdentifier: "96494FE3-384B-4E3D-A6BB-E7397D7E6D39"
				WFControlFlowMode:  0
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Repeat Item 2"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Candidate Alarm"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFInput: {
					Type: "Variable"
					Variable: {
						Value: {
							VariableName: "Repeat Item 2"
							Type:         "Variable"
							Aggrandizements: [
								{
									PropertyUserInfo: "label"
									Type:             "WFPropertyVariableAggrandizement"
									PropertyName:     "label"
								},
							]
						}
						WFSerializationType: "WFTextTokenAttachment"
					}
				}
				WFControlFlowMode: 0
				WFConditionalActionString: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							OutputUUID: "827F3DBE-29D3-467B-8F7A-12F602A9389E"
							Type:       "ActionOutput"
							OutputName: "Desired Alarm Name"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				GroupingIdentifier: "158A4D5F-D62E-4F00-9F76-3C5B2B144588"
				WFCondition:        4
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Candidate Alarm"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Alarm"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Repeat Index 2"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Alarm Index"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.gettimebetweendates"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							Type:       "ActionOutput"
							OutputName: "Start Date"
							OutputUUID: "B0E48D17-CB8B-42DC-BC70-56D5B3779E4C"
							Aggrandizements: [
								{
									WFDateFormatStyle:    "None"
									WFTimeFormatStyle:    "Short"
									WFISO8601IncludeTime: false
									Type:                 "WFDateFormatVariableAggrandizement"
								},
							]
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				WFTimeUntilFromDate: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							VariableName: "Repeat Item 2"
							Type:         "Variable"
							Aggrandizements: [
								{
									Type:         "WFPropertyVariableAggrandizement"
									PropertyName: "dateComponents"
								},
								{
									WFDateFormatStyle:    "None"
									WFTimeFormatStyle:    "Short"
									WFISO8601IncludeTime: false
									Type:                 "WFDateFormatVariableAggrandizement"
								},
							]
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				UUID: "C31DADE8-2948-443F-B725-1E1269312A17"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFCondition:     1003
				WFAnotherNumber: "240"
				WFConditionalActionString: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							Type:       "ActionOutput"
							OutputName: "Desired Alarm Time"
							OutputUUID: "DBB8C07D-7933-4F5D-B072-778D1E32AA10"
							Aggrandizements: [
								{
									WFDateFormatStyle:    "None"
									WFTimeFormatStyle:    "Short"
									WFISO8601IncludeTime: false
									Type:                 "WFDateFormatVariableAggrandizement"
								},
							]
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				GroupingIdentifier: "39E438DD-244C-452F-A903-9705E3730F13"
				WFInput: {
					Type: "Variable"
					Variable: {
						Value: {
							OutputUUID: "C31DADE8-2948-443F-B725-1E1269312A17"
							Type:       "ActionOutput"
							OutputName: "Time Between Dates"
						}
						WFSerializationType: "WFTextTokenAttachment"
					}
				}
				WFNumberValue:     "0"
				WFControlFlowMode: 0
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "39E438DD-244C-452F-A903-9705E3730F13"
				WFControlFlowMode:  1
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.alert"
			WFWorkflowActionParameters: WFAlertActionMessage: {
				Value: {
					string: "Alarm name matched but alarm time minus event time was outside range of [-4hr, -0min]! ￼"
					attachmentsByRange: "{87, 1}": {
						VariableName: "Alarm"
						Type:         "Variable"
						Aggrandizements: [
							{
								PropertyUserInfo: "WFItemName"
								Type:             "WFPropertyVariableAggrandizement"
								PropertyName:     "Name"
							},
						]
					}
				}
				WFSerializationType: "WFTextTokenString"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFControlFlowMode:  2
				GroupingIdentifier: "39E438DD-244C-452F-A903-9705E3730F13"
				UUID:               "28F19A4B-4221-45C6-84ED-CCF7F336427E"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.count"
			WFWorkflowActionParameters: Input: {
				Value: {
					OutputUUID: "28F19A4B-4221-45C6-84ED-CCF7F336427E"
					Type:       "ActionOutput"
					OutputName: "If Result"
				}
				WFSerializationType: "WFTextTokenAttachment"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "158A4D5F-D62E-4F00-9F76-3C5B2B144588"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "96494FE3-384B-4E3D-A6BB-E7397D7E6D39"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFInput: {
					Type: "Variable"
					Variable: {
						Value: {
							VariableName: "Alarm"
							Type:         "Variable"
						}
						WFSerializationType: "WFTextTokenAttachment"
					}
				}
				WFControlFlowMode:  0
				GroupingIdentifier: "2A08F09E-877D-4A80-BE67-91123BE8A71A"
				WFCondition:        101
			}
		},
		{
			WFWorkflowActionIdentifier: "com.apple.mobiletimer-framework.MobileTimerIntents.MTCreateAlarmIntent"
			WFWorkflowActionParameters: {
				UUID: "829E249D-B5D8-4917-AA5D-5780DF24F38E"
				dateComponents: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							OutputUUID: "DBB8C07D-7933-4F5D-B072-778D1E32AA10"
							Type:       "ActionOutput"
							OutputName: "Desired Alarm Time"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				repeatSchedule: {
					value:         0
					displayString: "Never"
				}
				label: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							OutputUUID: "827F3DBE-29D3-467B-8F7A-12F602A9389E"
							Type:       "ActionOutput"
							OutputName: "Desired Alarm Name"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				AppIntentDescriptor: {
					TeamIdentifier:      "0000000000"
					BundleIdentifier:    "com.apple.mobiletimer"
					Name:                "Clock"
					AppIntentIdentifier: "CreateAlarmIntent"
				}
				ShowWhenRun: false
				name: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							OutputUUID: "827F3DBE-29D3-467B-8F7A-12F602A9389E"
							Type:       "ActionOutput"
							OutputName: "Desired Alarm Name"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.notification"
			WFWorkflowActionParameters: {
				WFNotificationActionBody: {
					Value: {
						string: "Created alarm ￼"
						attachmentsByRange: "{14, 1}": {
							OutputUUID: "827F3DBE-29D3-467B-8F7A-12F602A9389E"
							Type:       "ActionOutput"
							OutputName: "Desired Alarm Name"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				UUID: "90E06046-8E1F-4934-BF2E-E87DC095DD60"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "2A08F09E-877D-4A80-BE67-91123BE8A71A"
				WFControlFlowMode:  1
			}
		},
		{
			WFWorkflowActionIdentifier: "com.apple.mobiletimer-framework.MobileTimerIntents.MTToggleAlarmIntent"
			WFWorkflowActionParameters: {
				alarm: {
					Value: {
						VariableName: "Alarm"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				AppIntentDescriptor: {
					TeamIdentifier:      "0000000000"
					BundleIdentifier:    "com.apple.mobiletimer"
					Name:                "Clock"
					AppIntentIdentifier: "ToggleAlarmIntent"
				}
				UUID:        "BEFD278C-C86C-453F-AD37-DC5053AF051F"
				ShowWhenRun: false
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvalueforkey"
			WFWorkflowActionParameters: {
				WFDictionaryValue: "yes"
				UUID:              "8AC4C390-058D-4FA0-8DD8-3025C6C81A83"
				WFDictionary: {
					Value: {
						VariableName: "Matched Calendar Alarm Indices"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFDictionaryKey: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							VariableName: "Alarm Index"
							Type:         "Variable"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "8AC4C390-058D-4FA0-8DD8-3025C6C81A83"
						Type:       "ActionOutput"
						OutputName: "Dictionary"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Matched Calendar Alarm Indices"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFControlFlowMode:  2
				GroupingIdentifier: "2A08F09E-877D-4A80-BE67-91123BE8A71A"
				UUID:               "AF3D58A7-32B2-40FB-8355-EDF7065E7EB6"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				UUID:               "982B4BF0-DFD8-43CF-A0FD-4948007C42D4"
				GroupingIdentifier: "427BCD5D-36BB-4074-BB69-2550C082A88F"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				WFControlFlowMode:  2
				GroupingIdentifier: "3A666097-90F9-4E2A-BBDC-A7A2F903EB04"
				UUID:               "3504C0A3-9377-4F28-92D0-3E4E40D97D34"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFInput: {
					Type: "Variable"
					Variable: {
						Value: {
							VariableName: "Delete unmatched?"
							Type:         "Variable"
						}
						WFSerializationType: "WFTextTokenAttachment"
					}
				}
				WFControlFlowMode:  0
				GroupingIdentifier: "5DF290DC-CAED-4223-8B03-363B64E3DB88"
				WFCondition:        100
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.count"
			WFWorkflowActionParameters: {
				Input: {
					Value: {
						VariableName: "Calendar Alarms"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				UUID: "86725A5F-9405-4490-B3C0-B1A8AB382C76"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.count"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "70AA4591-58E4-4CB5-8C7E-09A82EB1495D"
				WFRepeatCount: {
					Value: {
						OutputUUID: "86725A5F-9405-4490-B3C0-B1A8AB382C76"
						Type:       "ActionOutput"
						OutputName: "Count"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFControlFlowMode: 0
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.getvalueforkey"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Matched Calendar Alarm Indices"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				UUID: "B7C21E6D-7CE8-45ED-8670-A30CDF403BC7"
				WFDictionaryKey: {
					Value: {
						string: "￼"
						attachmentsByRange: "{0, 1}": {
							VariableName: "Repeat Index"
							Type:         "Variable"
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFInput: {
					Type: "Variable"
					Variable: {
						Value: {
							OutputUUID: "B7C21E6D-7CE8-45ED-8670-A30CDF403BC7"
							Type:       "ActionOutput"
							OutputName: "Dictionary Value"
						}
						WFSerializationType: "WFTextTokenAttachment"
					}
				}
				WFControlFlowMode:  0
				GroupingIdentifier: "671D206A-4570-40B9-BB1A-11FC898D8925"
				WFCondition:        100
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.nothing"
			WFWorkflowActionParameters: {}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "671D206A-4570-40B9-BB1A-11FC898D8925"
				WFControlFlowMode:  1
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.getvariable"
			WFWorkflowActionParameters: WFVariable: {
				Value: {
					VariableName: "Repeat Index"
					Type:         "Variable"
				}
				WFSerializationType: "WFTextTokenAttachment"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "671D206A-4570-40B9-BB1A-11FC898D8925"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.count"
			WFWorkflowActionParameters: {
				UUID:               "4B00EF21-76FF-43BF-889F-2122E12A8C3E"
				GroupingIdentifier: "70AA4591-58E4-4CB5-8C7E-09A82EB1495D"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "4B00EF21-76FF-43BF-889F-2122E12A8C3E"
						Type:       "ActionOutput"
						OutputName: "Repeat Results"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Unmatched Calendar Alarm Indices"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Unmatched Calendar Alarm Indices"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				GroupingIdentifier: "C3199CF3-E8AF-4AFF-A78D-D8CA218DF128"
				WFControlFlowMode:  0
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.getitemfromlist"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						VariableName: "Calendar Alarms"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFItemIndex: {
					Value: {
						VariableName: "Repeat Item"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				UUID:            "BD8661D4-66B9-4DB3-9F96-1821F8F2D868"
				WFItemSpecifier: "Item At Index"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.setvariable"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "BD8661D4-66B9-4DB3-9F96-1821F8F2D868"
						Type:       "ActionOutput"
						OutputName: "Item from List"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFVariableName: "Alarm to Delete"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				WFInput: {
					Type: "Variable"
					Variable: {
						Value: {
							VariableName: "Alarm to Delete"
							Type:         "Variable"
							Aggrandizements: [
								{
									PropertyUserInfo: "enabled"
									Type:             "WFPropertyVariableAggrandizement"
									PropertyName:     "enabled"
								},
							]
						}
						WFSerializationType: "WFTextTokenAttachment"
					}
				}
				WFControlFlowMode:  0
				GroupingIdentifier: "56DB22FA-EAD3-4625-A55E-D318797D0672"
				WFCondition:        4
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.notification"
			WFWorkflowActionParameters: {
				WFInput: {
					Value: {
						OutputUUID: "BD8661D4-66B9-4DB3-9F96-1821F8F2D868"
						Type:       "ActionOutput"
						OutputName: "Item from List"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				WFNotificationActionBody: {
					Value: {
						string: "Deleting alarm ￼"
						attachmentsByRange: "{15, 1}": {
							VariableName: "Alarm to Delete"
							Type:         "Variable"
							Aggrandizements: [
								{
									PropertyUserInfo: "label"
									Type:             "WFPropertyVariableAggrandizement"
									PropertyName:     "label"
								},
							]
						}
					}
					WFSerializationType: "WFTextTokenString"
				}
				UUID: "24AB86E4-59C0-4A43-A166-169FCFD79058"
			}
		},
		{
			WFWorkflowActionIdentifier: "com.apple.clock.DeleteAlarmIntent"
			WFWorkflowActionParameters: {
				AppIntentDescriptor: {
					TeamIdentifier:      "0000000000"
					BundleIdentifier:    "com.apple.mobiletimer"
					Name:                "Clock"
					AppIntentIdentifier: "DeleteAlarmIntent"
				}
				entities: {
					Value: {
						VariableName: "Alarm to Delete"
						Type:         "Variable"
					}
					WFSerializationType: "WFTextTokenAttachment"
				}
				UUID: "FC44BE9E-12C8-4249-9D53-F250712E4122"
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.conditional"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "56DB22FA-EAD3-4625-A55E-D318797D0672"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				GroupingIdentifier: "C3199CF3-E8AF-4AFF-A78D-D8CA218DF128"
				WFControlFlowMode:  2
			}
		},
		{
			WFWorkflowActionIdentifier: "is.workflow.actions.repeat.each"
			WFWorkflowActionParameters: {
				UUID:               "5A089C94-0944-459D-958C-1B72D48C0304"
				GroupingIdentifier: "5DF290DC-CAED-4223-8B03-363B64E3DB88"
				WFControlFlowMode:  2
			}
		},
	]
	WFWorkflowInputContentItemClasses: []
	WFWorkflowTypes: []
	WFWorkflowImportQuestions: [
		{
			ParameterKey: "WFItems"
			Category:     "Parameter"
			ActionIndex:  2
			Text:         "Which calendars would you like alarms to be created for? Keys should be Calendar names, and values should be aliases for those calendars (to go in alarm names)."
			DefaultValue: {
				Value: WFDictionaryFieldValueItems: [
					{
						WFKey: {
							Value: string: "Calendar"
							WFSerializationType: "WFTextTokenString"
						}
						WFItemType: 0
						WFValue: {
							Value: string: "Calendar"
							WFSerializationType: "WFTextTokenString"
						}
					},
				]
				WFSerializationType: "WFDictionaryFieldValue"
			}
		},
		{
			ParameterKey: "WFTextActionText"
			Category:     "Parameter"
			ActionIndex:  0
			Text:         "Delete enabled alarms that don’t match a calendar event? Leave blank for “no”, fill in a string for “yes”."
			DefaultValue: ""
		},
	]
	WFQuickActionSurfaces: []
	WFWorkflowHasShortcutInputVariables: false
}
