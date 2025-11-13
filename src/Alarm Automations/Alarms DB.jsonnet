local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('com.apple.mobiletimer-framework.MobileTimerIntents.MTGetAlarmsIntent', name='Alarms', params={
      AppIntentDescriptor: {
        ActionRequiresAppInstallation: true,
        AppIntentIdentifier: 'AlarmEntity',
        BundleIdentifier: 'com.apple.mobiletimer',
        Name: 'Clock',
        TeamIdentifier: '0000000000',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: '064B0244-A51E-43D7-A6D6-1203D45DC503',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Alarms')),
    }),

    sc.Action('is.workflow.actions.dictionary', {
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Label']),
              WFValue: sc.Str([{
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
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['URL']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'url',
                    PropertyUserInfo: {
                      WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'url',
                    },
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Hours']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'hours',
                    PropertyUserInfo: {
                      WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'hours',
                    },
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Minutes']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'minutes',
                    PropertyUserInfo: {
                      WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'minutes',
                    },
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Is Enabled']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'enabled',
                    PropertyUserInfo: {
                      WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'enabled',
                    },
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Repeats']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'repeats',
                    PropertyUserInfo: {
                      WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'repeats',
                    },
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Repeat Days']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'repeatDays',
                    PropertyUserInfo: {
                      WFLinkEntityContentPropertyUserInfoEnumMetadata: {
                        __data__: {
                          '$archiver': 'NSKeyedArchiver',
                          '$objects': [
                            '$null',
                            {
                              '$class': {
                                __data__: 94,
                                __type__: 'uid',
                              },
                              assistantDefinedSchemas: {
                                __data__: 91,
                                __type__: 'uid',
                              },
                              availabilityAnnotations: {
                                __data__: 84,
                                __type__: 'uid',
                              },
                              cases: {
                                __data__: 12,
                                __type__: 'uid',
                              },
                              customIntentEnumTypeName: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 3,
                                __type__: 'uid',
                              },
                              effectiveBundleIdentifiers: {
                                __data__: 77,
                                __type__: 'uid',
                              },
                              fullyQualifiedTypeName: {
                                __data__: 90,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 2,
                                __type__: 'uid',
                              },
                              mangledTypeName: {
                                __data__: 72,
                                __type__: 'uid',
                              },
                              mangledTypeNameByBundleIdentifier: {
                                __data__: 73,
                                __type__: 'uid',
                              },
                              system: {
                                __data__: 89,
                                __type__: 'uid',
                              },
                              visibilityMetadata: {
                                __data__: 92,
                                __type__: 'uid',
                              },
                            },
                            'RepeatDay',
                            {
                              '$class': {
                                __data__: 11,
                                __type__: 'uid',
                              },
                              name: {
                                __data__: 4,
                                __type__: 'uid',
                              },
                              numericFormat: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 6,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 5,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 9,
                                __type__: 'uid',
                              },
                            },
                            'Repeat Day',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 7,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            {
                              '$classes': [
                                'NSURL',
                                'NSObject',
                              ],
                              '$classname': 'NSURL',
                            },
                            'AppIntents',
                            {
                              '$classes': [
                                'LNStaticDeferredLocalizedString',
                                'NSObject',
                              ],
                              '$classname': 'LNStaticDeferredLocalizedString',
                            },
                            {
                              '$classes': [
                                'LNTypeDisplayRepresentation',
                                'NSObject',
                              ],
                              '$classname': 'LNTypeDisplayRepresentation',
                            },
                            {
                              '$class': {
                                __data__: 71,
                                __type__: 'uid',
                              },
                              'NS.objects': [
                                {
                                  __data__: 13,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 23,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 31,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 39,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 47,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 55,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 63,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 15,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 14,
                                __type__: 'uid',
                              },
                            },
                            'sunday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 16,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 18,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 17,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 20,
                                __type__: 'uid',
                              },
                            },
                            'Sunday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 19,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$classes': [
                                'LNDisplayRepresentation',
                                'NSObject',
                              ],
                              '$classname': 'LNDisplayRepresentation',
                            },
                            {
                              '$classes': [
                                'LNEnumCaseMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNEnumCaseMetadata',
                            },
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 25,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 24,
                                __type__: 'uid',
                              },
                            },
                            'monday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 26,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 28,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 27,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 30,
                                __type__: 'uid',
                              },
                            },
                            'Monday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 29,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 33,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 32,
                                __type__: 'uid',
                              },
                            },
                            'tuesday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 34,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 36,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 35,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 38,
                                __type__: 'uid',
                              },
                            },
                            'Tuesday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 37,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 41,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 40,
                                __type__: 'uid',
                              },
                            },
                            'wednesday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 42,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 44,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 43,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 46,
                                __type__: 'uid',
                              },
                            },
                            'Wednesday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 45,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 49,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 48,
                                __type__: 'uid',
                              },
                            },
                            'thursday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 50,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 52,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 51,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 54,
                                __type__: 'uid',
                              },
                            },
                            'Thursday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 53,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 57,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 56,
                                __type__: 'uid',
                              },
                            },
                            'friday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 58,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 60,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 59,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 62,
                                __type__: 'uid',
                              },
                            },
                            'Friday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 61,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 65,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 64,
                                __type__: 'uid',
                              },
                            },
                            'saturday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 66,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 68,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 67,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 70,
                                __type__: 'uid',
                              },
                            },
                            'Saturday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 69,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$classes': [
                                'NSArray',
                                'NSObject',
                              ],
                              '$classname': 'NSArray',
                            },
                            '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                            {
                              '$class': {
                                __data__: 76,
                                __type__: 'uid',
                              },
                              'NS.keys': [
                                {
                                  __data__: 74,
                                  __type__: 'uid',
                                },
                              ],
                              'NS.objects': [
                                {
                                  __data__: 75,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            'com.apple.mobiletimer',
                            '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                            {
                              '$classes': [
                                'NSDictionary',
                                'NSObject',
                              ],
                              '$classname': 'NSDictionary',
                            },
                            {
                              '$class': {
                                __data__: 83,
                                __type__: 'uid',
                              },
                              'NS.object.0': {
                                __data__: 78,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 82,
                                __type__: 'uid',
                              },
                              bundleIdentifier: {
                                __data__: 79,
                                __type__: 'uid',
                              },
                              type: 0,
                              url: {
                                __data__: 80,
                                __type__: 'uid',
                              },
                            },
                            'com.apple.mobiletimer',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 81,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            {
                              '$classes': [
                                'LNEffectiveBundleIdentifier',
                                'NSObject',
                              ],
                              '$classname': 'LNEffectiveBundleIdentifier',
                            },
                            {
                              '$classes': [
                                'NSOrderedSet',
                                'NSObject',
                              ],
                              '$classname': 'NSOrderedSet',
                            },
                            {
                              '$class': {
                                __data__: 76,
                                __type__: 'uid',
                              },
                              'NS.keys': [
                                {
                                  __data__: 85,
                                  __type__: 'uid',
                                },
                              ],
                              'NS.objects': [
                                {
                                  __data__: 86,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            'LNPlatformNameWildcard',
                            {
                              '$class': {
                                __data__: 88,
                                __type__: 'uid',
                              },
                              deprecatedVersion: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              introducedVersion: {
                                __data__: 87,
                                __type__: 'uid',
                              },
                              obsoletedVersion: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                            },
                            '*',
                            {
                              '$classes': [
                                'LNAvailabilityAnnotation',
                                'NSObject',
                              ],
                              '$classname': 'LNAvailabilityAnnotation',
                            },
                            false,
                            'MobileTimerSupport.AlarmEntity.RepeatDay',
                            {
                              '$class': {
                                __data__: 71,
                                __type__: 'uid',
                              },
                              'NS.objects': [],
                            },
                            {
                              '$class': {
                                __data__: 93,
                                __type__: 'uid',
                              },
                              assistantOnly: false,
                              isDiscoverable: true,
                            },
                            {
                              '$classes': [
                                'LNVisibilityMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNVisibilityMetadata',
                            },
                            {
                              '$classes': [
                                'LNEnumMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNEnumMetadata',
                            },
                          ],
                          '$top': {
                            root: {
                              __data__: 1,
                              __type__: 'uid',
                            },
                          },
                          '$version': 100000,
                        },
                        __type__: 'data-bplist',
                      },
                      WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'repeatDays',
                    },
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Allows Snooze']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'snooze',
                    PropertyUserInfo: {
                      WFLinkEntityContentPropertyUserInfoEnumMetadata: {
                        __data__: {
                          '$archiver': 'NSKeyedArchiver',
                          '$objects': [
                            '$null',
                            {
                              '$class': {
                                __data__: 94,
                                __type__: 'uid',
                              },
                              assistantDefinedSchemas: {
                                __data__: 91,
                                __type__: 'uid',
                              },
                              availabilityAnnotations: {
                                __data__: 84,
                                __type__: 'uid',
                              },
                              cases: {
                                __data__: 12,
                                __type__: 'uid',
                              },
                              customIntentEnumTypeName: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 3,
                                __type__: 'uid',
                              },
                              effectiveBundleIdentifiers: {
                                __data__: 77,
                                __type__: 'uid',
                              },
                              fullyQualifiedTypeName: {
                                __data__: 90,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 2,
                                __type__: 'uid',
                              },
                              mangledTypeName: {
                                __data__: 72,
                                __type__: 'uid',
                              },
                              mangledTypeNameByBundleIdentifier: {
                                __data__: 73,
                                __type__: 'uid',
                              },
                              system: {
                                __data__: 89,
                                __type__: 'uid',
                              },
                              visibilityMetadata: {
                                __data__: 92,
                                __type__: 'uid',
                              },
                            },
                            'RepeatDay',
                            {
                              '$class': {
                                __data__: 11,
                                __type__: 'uid',
                              },
                              name: {
                                __data__: 4,
                                __type__: 'uid',
                              },
                              numericFormat: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 6,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 5,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 9,
                                __type__: 'uid',
                              },
                            },
                            'Repeat Day',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 7,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            {
                              '$classes': [
                                'NSURL',
                                'NSObject',
                              ],
                              '$classname': 'NSURL',
                            },
                            'AppIntents',
                            {
                              '$classes': [
                                'LNStaticDeferredLocalizedString',
                                'NSObject',
                              ],
                              '$classname': 'LNStaticDeferredLocalizedString',
                            },
                            {
                              '$classes': [
                                'LNTypeDisplayRepresentation',
                                'NSObject',
                              ],
                              '$classname': 'LNTypeDisplayRepresentation',
                            },
                            {
                              '$class': {
                                __data__: 71,
                                __type__: 'uid',
                              },
                              'NS.objects': [
                                {
                                  __data__: 13,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 23,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 31,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 39,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 47,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 55,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 63,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 15,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 14,
                                __type__: 'uid',
                              },
                            },
                            'sunday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 16,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 18,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 17,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 20,
                                __type__: 'uid',
                              },
                            },
                            'Sunday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 19,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$classes': [
                                'LNDisplayRepresentation',
                                'NSObject',
                              ],
                              '$classname': 'LNDisplayRepresentation',
                            },
                            {
                              '$classes': [
                                'LNEnumCaseMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNEnumCaseMetadata',
                            },
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 25,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 24,
                                __type__: 'uid',
                              },
                            },
                            'monday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 26,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 28,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 27,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 30,
                                __type__: 'uid',
                              },
                            },
                            'Monday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 29,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 33,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 32,
                                __type__: 'uid',
                              },
                            },
                            'tuesday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 34,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 36,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 35,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 38,
                                __type__: 'uid',
                              },
                            },
                            'Tuesday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 37,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 41,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 40,
                                __type__: 'uid',
                              },
                            },
                            'wednesday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 42,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 44,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 43,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 46,
                                __type__: 'uid',
                              },
                            },
                            'Wednesday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 45,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 49,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 48,
                                __type__: 'uid',
                              },
                            },
                            'thursday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 50,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 52,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 51,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 54,
                                __type__: 'uid',
                              },
                            },
                            'Thursday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 53,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 57,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 56,
                                __type__: 'uid',
                              },
                            },
                            'friday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 58,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 60,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 59,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 62,
                                __type__: 'uid',
                              },
                            },
                            'Friday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 61,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 65,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 64,
                                __type__: 'uid',
                              },
                            },
                            'saturday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 66,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 68,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 67,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 70,
                                __type__: 'uid',
                              },
                            },
                            'Saturday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 69,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$classes': [
                                'NSArray',
                                'NSObject',
                              ],
                              '$classname': 'NSArray',
                            },
                            '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                            {
                              '$class': {
                                __data__: 76,
                                __type__: 'uid',
                              },
                              'NS.keys': [
                                {
                                  __data__: 74,
                                  __type__: 'uid',
                                },
                              ],
                              'NS.objects': [
                                {
                                  __data__: 75,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            'com.apple.mobiletimer',
                            '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                            {
                              '$classes': [
                                'NSDictionary',
                                'NSObject',
                              ],
                              '$classname': 'NSDictionary',
                            },
                            {
                              '$class': {
                                __data__: 83,
                                __type__: 'uid',
                              },
                              'NS.object.0': {
                                __data__: 78,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 82,
                                __type__: 'uid',
                              },
                              bundleIdentifier: {
                                __data__: 79,
                                __type__: 'uid',
                              },
                              type: 0,
                              url: {
                                __data__: 80,
                                __type__: 'uid',
                              },
                            },
                            'com.apple.mobiletimer',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 81,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            {
                              '$classes': [
                                'LNEffectiveBundleIdentifier',
                                'NSObject',
                              ],
                              '$classname': 'LNEffectiveBundleIdentifier',
                            },
                            {
                              '$classes': [
                                'NSOrderedSet',
                                'NSObject',
                              ],
                              '$classname': 'NSOrderedSet',
                            },
                            {
                              '$class': {
                                __data__: 76,
                                __type__: 'uid',
                              },
                              'NS.keys': [
                                {
                                  __data__: 85,
                                  __type__: 'uid',
                                },
                              ],
                              'NS.objects': [
                                {
                                  __data__: 86,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            'LNPlatformNameWildcard',
                            {
                              '$class': {
                                __data__: 88,
                                __type__: 'uid',
                              },
                              deprecatedVersion: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              introducedVersion: {
                                __data__: 87,
                                __type__: 'uid',
                              },
                              obsoletedVersion: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                            },
                            '*',
                            {
                              '$classes': [
                                'LNAvailabilityAnnotation',
                                'NSObject',
                              ],
                              '$classname': 'LNAvailabilityAnnotation',
                            },
                            false,
                            'MobileTimerSupport.AlarmEntity.RepeatDay',
                            {
                              '$class': {
                                __data__: 71,
                                __type__: 'uid',
                              },
                              'NS.objects': [],
                            },
                            {
                              '$class': {
                                __data__: 93,
                                __type__: 'uid',
                              },
                              assistantOnly: false,
                              isDiscoverable: true,
                            },
                            {
                              '$classes': [
                                'LNVisibilityMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNVisibilityMetadata',
                            },
                            {
                              '$classes': [
                                'LNEnumMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNEnumMetadata',
                            },
                          ],
                          '$top': {
                            root: {
                              __data__: 1,
                              __type__: 'uid',
                            },
                          },
                          '$version': 100000,
                        },
                        __type__: 'data-bplist',
                      },
                      WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'snooze',
                    },
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Time']),
              WFValue: sc.Str([{
                Aggrandizements: [
                  {
                    PropertyName: 'dateComponents',
                    PropertyUserInfo: {
                      WFLinkEntityContentPropertyUserInfoEnumMetadata: {
                        __data__: {
                          '$archiver': 'NSKeyedArchiver',
                          '$objects': [
                            '$null',
                            {
                              '$class': {
                                __data__: 94,
                                __type__: 'uid',
                              },
                              assistantDefinedSchemas: {
                                __data__: 91,
                                __type__: 'uid',
                              },
                              availabilityAnnotations: {
                                __data__: 84,
                                __type__: 'uid',
                              },
                              cases: {
                                __data__: 12,
                                __type__: 'uid',
                              },
                              customIntentEnumTypeName: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 3,
                                __type__: 'uid',
                              },
                              effectiveBundleIdentifiers: {
                                __data__: 77,
                                __type__: 'uid',
                              },
                              fullyQualifiedTypeName: {
                                __data__: 90,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 2,
                                __type__: 'uid',
                              },
                              mangledTypeName: {
                                __data__: 72,
                                __type__: 'uid',
                              },
                              mangledTypeNameByBundleIdentifier: {
                                __data__: 73,
                                __type__: 'uid',
                              },
                              system: {
                                __data__: 89,
                                __type__: 'uid',
                              },
                              visibilityMetadata: {
                                __data__: 92,
                                __type__: 'uid',
                              },
                            },
                            'RepeatDay',
                            {
                              '$class': {
                                __data__: 11,
                                __type__: 'uid',
                              },
                              name: {
                                __data__: 4,
                                __type__: 'uid',
                              },
                              numericFormat: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 6,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 5,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 9,
                                __type__: 'uid',
                              },
                            },
                            'Repeat Day',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 7,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            {
                              '$classes': [
                                'NSURL',
                                'NSObject',
                              ],
                              '$classname': 'NSURL',
                            },
                            'AppIntents',
                            {
                              '$classes': [
                                'LNStaticDeferredLocalizedString',
                                'NSObject',
                              ],
                              '$classname': 'LNStaticDeferredLocalizedString',
                            },
                            {
                              '$classes': [
                                'LNTypeDisplayRepresentation',
                                'NSObject',
                              ],
                              '$classname': 'LNTypeDisplayRepresentation',
                            },
                            {
                              '$class': {
                                __data__: 71,
                                __type__: 'uid',
                              },
                              'NS.objects': [
                                {
                                  __data__: 13,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 23,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 31,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 39,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 47,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 55,
                                  __type__: 'uid',
                                },
                                {
                                  __data__: 63,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 15,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 14,
                                __type__: 'uid',
                              },
                            },
                            'sunday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 16,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 18,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 17,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 20,
                                __type__: 'uid',
                              },
                            },
                            'Sunday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 19,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$classes': [
                                'LNDisplayRepresentation',
                                'NSObject',
                              ],
                              '$classname': 'LNDisplayRepresentation',
                            },
                            {
                              '$classes': [
                                'LNEnumCaseMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNEnumCaseMetadata',
                            },
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 25,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 24,
                                __type__: 'uid',
                              },
                            },
                            'monday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 26,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 28,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 27,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 30,
                                __type__: 'uid',
                              },
                            },
                            'Monday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 29,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 33,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 32,
                                __type__: 'uid',
                              },
                            },
                            'tuesday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 34,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 36,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 35,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 38,
                                __type__: 'uid',
                              },
                            },
                            'Tuesday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 37,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 41,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 40,
                                __type__: 'uid',
                              },
                            },
                            'wednesday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 42,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 44,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 43,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 46,
                                __type__: 'uid',
                              },
                            },
                            'Wednesday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 45,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 49,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 48,
                                __type__: 'uid',
                              },
                            },
                            'thursday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 50,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 52,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 51,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 54,
                                __type__: 'uid',
                              },
                            },
                            'Thursday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 53,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 57,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 56,
                                __type__: 'uid',
                              },
                            },
                            'friday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 58,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 60,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 59,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 62,
                                __type__: 'uid',
                              },
                            },
                            'Friday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 61,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$class': {
                                __data__: 22,
                                __type__: 'uid',
                              },
                              displayRepresentation: {
                                __data__: 65,
                                __type__: 'uid',
                              },
                              identifier: {
                                __data__: 64,
                                __type__: 'uid',
                              },
                            },
                            'saturday',
                            {
                              '$class': {
                                __data__: 21,
                                __type__: 'uid',
                              },
                              descriptionText: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              image: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              snippetPluginModel: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              subtitle: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              synonyms: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              title: {
                                __data__: 66,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 10,
                                __type__: 'uid',
                              },
                              bundleURL: {
                                __data__: 68,
                                __type__: 'uid',
                              },
                              defaultValue: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              key: {
                                __data__: 67,
                                __type__: 'uid',
                              },
                              table: {
                                __data__: 70,
                                __type__: 'uid',
                              },
                            },
                            'Saturday',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 69,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            'AppIntents',
                            {
                              '$classes': [
                                'NSArray',
                                'NSObject',
                              ],
                              '$classname': 'NSArray',
                            },
                            '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                            {
                              '$class': {
                                __data__: 76,
                                __type__: 'uid',
                              },
                              'NS.keys': [
                                {
                                  __data__: 74,
                                  __type__: 'uid',
                                },
                              ],
                              'NS.objects': [
                                {
                                  __data__: 75,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            'com.apple.mobiletimer',
                            '18MobileTimerSupport11AlarmEntityV9RepeatDayO',
                            {
                              '$classes': [
                                'NSDictionary',
                                'NSObject',
                              ],
                              '$classname': 'NSDictionary',
                            },
                            {
                              '$class': {
                                __data__: 83,
                                __type__: 'uid',
                              },
                              'NS.object.0': {
                                __data__: 78,
                                __type__: 'uid',
                              },
                            },
                            {
                              '$class': {
                                __data__: 82,
                                __type__: 'uid',
                              },
                              bundleIdentifier: {
                                __data__: 79,
                                __type__: 'uid',
                              },
                              type: 0,
                              url: {
                                __data__: 80,
                                __type__: 'uid',
                              },
                            },
                            'com.apple.mobiletimer',
                            {
                              '$class': {
                                __data__: 8,
                                __type__: 'uid',
                              },
                              'NS.base': {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              'NS.relative': {
                                __data__: 81,
                                __type__: 'uid',
                              },
                            },
                            'file:///System/Library/PrivateFrameworks/MobileTimerSupport.framework/',
                            {
                              '$classes': [
                                'LNEffectiveBundleIdentifier',
                                'NSObject',
                              ],
                              '$classname': 'LNEffectiveBundleIdentifier',
                            },
                            {
                              '$classes': [
                                'NSOrderedSet',
                                'NSObject',
                              ],
                              '$classname': 'NSOrderedSet',
                            },
                            {
                              '$class': {
                                __data__: 76,
                                __type__: 'uid',
                              },
                              'NS.keys': [
                                {
                                  __data__: 85,
                                  __type__: 'uid',
                                },
                              ],
                              'NS.objects': [
                                {
                                  __data__: 86,
                                  __type__: 'uid',
                                },
                              ],
                            },
                            'LNPlatformNameWildcard',
                            {
                              '$class': {
                                __data__: 88,
                                __type__: 'uid',
                              },
                              deprecatedVersion: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                              introducedVersion: {
                                __data__: 87,
                                __type__: 'uid',
                              },
                              obsoletedVersion: {
                                __data__: 0,
                                __type__: 'uid',
                              },
                            },
                            '*',
                            {
                              '$classes': [
                                'LNAvailabilityAnnotation',
                                'NSObject',
                              ],
                              '$classname': 'LNAvailabilityAnnotation',
                            },
                            false,
                            'MobileTimerSupport.AlarmEntity.RepeatDay',
                            {
                              '$class': {
                                __data__: 71,
                                __type__: 'uid',
                              },
                              'NS.objects': [],
                            },
                            {
                              '$class': {
                                __data__: 93,
                                __type__: 'uid',
                              },
                              assistantOnly: false,
                              isDiscoverable: true,
                            },
                            {
                              '$classes': [
                                'LNVisibilityMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNVisibilityMetadata',
                            },
                            {
                              '$classes': [
                                'LNEnumMetadata',
                                'NSObject',
                              ],
                              '$classname': 'LNEnumMetadata',
                            },
                          ],
                          '$top': {
                            root: {
                              __data__: 1,
                              __type__: 'uid',
                            },
                          },
                          '$version': 100000,
                        },
                        __type__: 'data-bplist',
                      },
                      WFLinkEntityContentPropertyUserInfoPropertyIdentifier: 'dateComponents',
                    },
                    Type: 'WFPropertyVariableAggrandizement',
                  },
                  {
                    Type: 'WFDateFormatVariableAggrandizement',
                    WFDateFormatStyle: 'None',
                    WFISO8601IncludeTime: false,
                    WFTimeFormatStyle: 'Short',
                  },
                ],
                Type: 'Variable',
                VariableName: 'Repeat Item',
              }]),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.repeat.each', name='Repeat Results', params={
      GroupingIdentifier: '064B0244-A51E-43D7-A6D6-1203D45DC503',
      WFControlFlowMode: 2,
    }),

    sc.Action('com.sindresorhus.Actions.GenerateCSVIntent', name='CSV File', params={
      AppIntentDescriptor: {
        AppIntentIdentifier: 'GenerateCSVIntent',
        BundleIdentifier: 'com.sindresorhus.Actions',
        Name: 'Actions',
        TeamIdentifier: 'YG56YK5RN5',
      },
      dictionaries: sc.Attach(sc.Ref('Repeat Results')),
    }),

    sc.Action('is.workflow.actions.previewdocument', {
      WFInput: sc.Attach(sc.Ref('CSV File', aggs=[
        {
          PropertyName: 'File Path',
          PropertyUserInfo: {},
          Type: 'WFPropertyVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.previewdocument', {
      WFInput: sc.Attach(sc.Ref('CSV File')),
    }),

    sc.Action('net.filippomaguolo.SQLiteMobile.CreateSqliteFromCSVIntent', {
      csvFile: sc.Attach(sc.Ref('CSV File')),
      csvInputSeparator: 'comma',
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: false,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61440,
    WFWorkflowIconStartColor: 463140863,
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
