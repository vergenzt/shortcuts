local sc = import 'shortcuts.libsonnet';

{
  WFQuickActionSurfaces: [],
  WFWorkflowActions: sc.ActionsSeq([

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'Delete duplicate images\nTim Wilson, June 2024',
    }),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: 'UpdateCheck: Whether shortcut should check for updated versions after each run.\n\nProgressSeconds: How often progress notifications are shown, in seconds.\n\nHashSize: Defines N, and each image is turned into a NxN grayscale image. The higher the value, the more closely the algorithms “looks” at the images for differences. You need to raise/lower the DupThresholds if you raise/lower HashSize.\n\nDupThreshold: The maximum Hamming distance between two images’ dhashes in order for them to be considered duplicate or similar. e.g. Two images with a Hamming distance of less than the “Duplicate images” threshold will be considered a duplicate. Good threshold values depend on the HashSize.\n\nBatchSize: It’s faster to process images in batches, and this controls the batch size. You can crash the shortcut if you raise the value too high.\n\nMaxNumImages: Sets a limit on the number of images you’re able to process with the shortcut. The shortcut may crash or become very slow (process fewer images per second) if many images are loaded at once. ',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Options', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 4,
              WFKey: sc.Str(['UpdateCheck']),
              WFValue: sc.Num(true),
            },
            {
              WFItemType: 3,
              WFKey: sc.Str(['ProgressSeconds']),
              WFValue: sc.Str(['15']),
            },
            {
              WFItemType: 3,
              WFKey: sc.Str(['HashSize']),
              WFValue: sc.Str(['17']),
            },
            {
              WFItemType: 1,
              WFKey: sc.Str(['DupThreshold']),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 3,
                        WFKey: sc.Str(['Duplicate images']),
                        WFValue: sc.Str(['20']),
                      },
                      {
                        WFItemType: 3,
                        WFKey: sc.Str(['Very similar images']),
                        WFValue: sc.Str(['70']),
                      },
                      {
                        WFItemType: 3,
                        WFKey: sc.Str(['Similar images']),
                        WFValue: sc.Str(['140']),
                      },
                    ],
                  },
                  WFSerializationType: 'WFDictionaryFieldValue',
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
            {
              WFItemType: 1,
              WFKey: sc.Str(['BatchSize']),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 3,
                        WFKey: sc.Str(['Mac']),
                        WFValue: sc.Str(['100']),
                      },
                      {
                        WFItemType: 3,
                        WFKey: sc.Str(['iOS']),
                        WFValue: sc.Str(['30']),
                      },
                    ],
                  },
                  WFSerializationType: 'WFDictionaryFieldValue',
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
            {
              WFItemType: 1,
              WFKey: sc.Str(['MaxNumImages']),
              WFValue: {
                Value: {
                  Value: {
                    WFDictionaryFieldValueItems: [
                      {
                        WFItemType: 3,
                        WFKey: sc.Str(['Mac']),
                        WFValue: sc.Str(['10000']),
                      },
                      {
                        WFItemType: 3,
                        WFKey: sc.Str(['iOS']),
                        WFValue: sc.Str(['500']),
                      },
                    ],
                  },
                  WFSerializationType: 'WFDictionaryFieldValue',
                },
                WFSerializationType: 'WFDictionaryFieldValue',
              },
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach({
          Aggrandizements: [
            {
              PropertyName: 'Device Type',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'DeviceDetails',
        }),
      },
      'is',
      {
        UUID: '265AD133-B82F-4159-AC30-6EE51DB5E047',
        WFEnumeration: 'Mac',
      }
    )).Then_([

      sc.Action('is.workflow.actions.number', name='Number', params={
        WFNumberActionNumber: sc.Attach(sc.Ref('Options', aggs=[
          {
            DictionaryKey: 'BatchSize.Mac',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Number')),
        WFVariableName: 'BatchSize',
      }),

      sc.Action('is.workflow.actions.number', name='Number', params={
        WFNumberActionNumber: sc.Attach(sc.Ref('Options', aggs=[
          {
            DictionaryKey: 'MaxNumImages.Mac',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Number')),
        WFVariableName: 'Max images',
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.number', name='Number', params={
        WFNumberActionNumber: sc.Attach(sc.Ref('Options', aggs=[
          {
            DictionaryKey: 'BatchSize.iOS',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Number')),
        WFVariableName: 'BatchSize',
      }),

      sc.Action('is.workflow.actions.number', name='Number', params={
        WFNumberActionNumber: sc.Attach(sc.Ref('Options', aggs=[
          {
            DictionaryKey: 'MaxNumImages.iOS',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Number')),
        WFVariableName: 'Max images',
      }),

    ]).EndIf_(),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
      'has any value',
      {
        UUID: 'D4FA68D6-A610-4761-8AF6-00D99F4A6E78',
      }
    )).Then_([

      sc.Action('is.workflow.actions.filter.photos', {
        WFContentItemFilter: {
          Value: {
            WFActionParameterFilterPrefix: 1,
            WFActionParameterFilterTemplates: [
              {
                Operator: 4,
                Property: 'Media Type',
                Removable: true,
                Values: {
                  Enumeration: {
                    Value: 'Image',
                    WFSerializationType: 'WFStringSubstitutableState',
                  },
                  Unit: 4,
                },
              },
            ],
            WFContentPredicateBoundedDate: false,
          },
          WFSerializationType: 'WFContentPredicateTableTemplate',
        },
        WFContentItemInputParameter: sc.Attach(sc.Input),
        WFContentItemLimitEnabled: false,
        WFContentItemLimitNumber: sc.Attach(sc.Ref('Vars.Max images')),
      }),

    ]).Else_([

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach({
            Aggrandizements: [
              {
                PropertyName: 'Device Type',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'DeviceDetails',
          }),
        },
        'is',
        {
          UUID: 'D932EB04-F084-4AF3-A455-5FD51CD1EB1F',
          WFEnumeration: 'Mac',
        }
      )).Then_([

        sc.Action('is.workflow.actions.choosefrommenu', {
          GroupingIdentifier: 'B841B9A7-7344-46E0-913E-5EA29BA093E5',
          WFControlFlowMode: 0,
          WFMenuItems: [
            'Photos',
            'One or more folders in Finder',
          ],
          WFMenuPrompt: 'Load images from',
        }),

        sc.Action('is.workflow.actions.choosefrommenu', {
          GroupingIdentifier: 'B841B9A7-7344-46E0-913E-5EA29BA093E5',
          WFControlFlowMode: 1,
          WFMenuItemTitle: 'Photos',
        }),

        sc.Action('is.workflow.actions.filter.photos', {
          WFContentItemFilter: {
            Value: {
              WFActionParameterFilterPrefix: 0,
              WFActionParameterFilterTemplates: [
                {
                  Operator: 4,
                  Property: 'Album',
                  Removable: true,
                  Values: {
                    Enumeration: {
                      Value: sc.Attach({
                        Prompt: 'Select album(s) and/or other criteria to search for photos',
                        Type: 'Ask',
                      }),
                      WFSerializationType: 'WFStringSubstitutableState',
                    },
                    Unit: 4,
                  },
                },
              ],
              WFContentPredicateBoundedDate: false,
            },
            WFSerializationType: 'WFContentPredicateTableTemplate',
          },
          WFContentItemInputParameter: 'Library',
          WFContentItemLimitEnabled: false,
          WFContentItemLimitNumber: sc.Attach(sc.Ref('Vars.Max images')),
        }),

        sc.Action('is.workflow.actions.choosefrommenu', {
          GroupingIdentifier: 'B841B9A7-7344-46E0-913E-5EA29BA093E5',
          WFControlFlowMode: 1,
          WFMenuItemTitle: 'One or more folders in Finder',
        }),

        sc.Action('is.workflow.actions.file.select', name='Finder folder', params={
          SelectMultiple: true,
          WFPickingMode: 'Folders',
        }),

        sc.Action('is.workflow.actions.setvariable', {
          WFInput: sc.Attach(sc.Ref('Finder folder')),
          WFVariableName: 'Use finder',
        }),

        sc.Action('is.workflow.actions.repeat.each', {
          GroupingIdentifier: 'DEC4EAD9-4905-480F-804D-CF8330EAADEE',
          WFControlFlowMode: 0,
          WFInput: sc.Attach(sc.Ref('Vars.Use finder')),
        }),

        sc.Action('is.workflow.actions.file.getfoldercontents', {
          WFFolder: sc.Attach(sc.Ref('Vars.Repeat Item')),
        }),

        sc.Action('is.workflow.actions.repeat.each', {
          GroupingIdentifier: 'DEC4EAD9-4905-480F-804D-CF8330EAADEE',
          WFControlFlowMode: 2,
        }),

        sc.Action('is.workflow.actions.choosefrommenu', {
          GroupingIdentifier: 'B841B9A7-7344-46E0-913E-5EA29BA093E5',
          WFControlFlowMode: 2,
        }),

      ]).Else_([

        sc.Action('is.workflow.actions.filter.photos', {
          WFContentItemFilter: {
            Value: {
              WFActionParameterFilterPrefix: 0,
              WFActionParameterFilterTemplates: [
                {
                  Operator: 4,
                  Property: 'Album',
                  Removable: true,
                  Values: {
                    Enumeration: {
                      Value: sc.Attach({
                        Prompt: 'Select album(s) and/or other criteria to search for photos',
                        Type: 'Ask',
                      }),
                      WFSerializationType: 'WFStringSubstitutableState',
                    },
                    Unit: 4,
                  },
                },
              ],
              WFContentPredicateBoundedDate: false,
            },
            WFSerializationType: 'WFContentPredicateTableTemplate',
          },
          WFContentItemInputParameter: 'Library',
          WFContentItemLimitEnabled: false,
          WFContentItemLimitNumber: sc.Attach(sc.Ref('Vars.Max images')),
        }),

      ]).EndIf_(name='If Result'),

      sc.Action('is.workflow.actions.filter.photos', {
        WFContentItemFilter: {
          Value: {
            WFActionParameterFilterPrefix: 1,
            WFActionParameterFilterTemplates: [
              {
                Operator: 4,
                Property: 'Media Type',
                Removable: true,
                Values: {
                  Enumeration: {
                    Value: 'Image',
                    WFSerializationType: 'WFStringSubstitutableState',
                  },
                  Unit: 4,
                },
              },
            ],
            WFContentPredicateBoundedDate: false,
          },
          WFSerializationType: 'WFContentPredicateTableTemplate',
        },
        WFContentItemInputParameter: sc.Attach(sc.Ref('If Result')),
        WFContentItemLimitEnabled: false,
        WFContentItemLimitNumber: sc.Attach(sc.Ref('Vars.Max images')),
      }),

    ]).EndIf_(name='If Result'),

    sc.Action('is.workflow.actions.count', name='Original count', params={
      Input: sc.Attach(sc.Ref('If Result')),
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Original count')),
      },
      '>',
      {
        UUID: 'BD368A4F-70DF-4E5C-936F-2F0574582859',
        WFNumberValue: sc.Attach(sc.Ref('Vars.Max images')),
      }
    )).Then_([

      sc.Action('is.workflow.actions.filter.photos', {
        WFContentItemFilter: {
          Value: {
            WFActionParameterFilterPrefix: 1,
            WFActionParameterFilterTemplates: [],
            WFContentPredicateBoundedDate: false,
          },
          WFSerializationType: 'WFContentPredicateTableTemplate',
        },
        WFContentItemInputParameter: sc.Attach(sc.Ref('If Result')),
        WFContentItemLimitEnabled: true,
        WFContentItemLimitNumber: sc.Attach(sc.Ref('Vars.Max images')),
        WFContentItemSortProperty: 'Random',
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.getvariable', {
        WFVariable: sc.Attach(sc.Ref('If Result')),
      }),

    ]).EndIf_(name='If Result'),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('If Result')),
      WFVariableName: 'Image list',
    }),

    sc.Action('is.workflow.actions.count', name='Count', params={
      Input: sc.Attach(sc.Ref('Vars.Image list')),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Count')),
      WFVariableName: 'Image count',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Image count')),
      },
      '<',
      {
        UUID: '6C926B90-A218-4FF0-954E-75891E719537',
        WFNumberValue: sc.Attach(sc.Ref('Original count')),
      }
    )).Then_([

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach({
            Aggrandizements: [
              {
                PropertyName: 'Device Type',
                Type: 'WFPropertyVariableAggrandizement',
              },
            ],
            Type: 'DeviceDetails',
          }),
        },
        'is not',
        {
          WFEnumeration: 'Mac',
        }
      )).Then_([

        sc.Action('is.workflow.actions.gettext', name='Text', params={
          WFTextActionText: sc.Str([sc.Ref('Original count')]),
        }),

        sc.Action('is.workflow.actions.alert', {
          WFAlertActionMessage: sc.Str([sc.Ref('Text')]),
        }),

      ]).EndIf_(),

    ]).EndIf_(),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: 'DupThreshold',
      WFInput: sc.Attach(sc.Ref('Options')),
    }),

    sc.Action('is.workflow.actions.choosefromlist', name='Chosen dup type', params={
      WFChooseFromListActionPrompt: 'What kind of images do you want to cleanup?',
      WFInput: sc.Attach(sc.Ref('Dictionary Value', aggs=[
        {
          CoercionItemClass: 'WFDictionaryContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
        {
          PropertyName: 'Keys',
          Type: 'WFPropertyVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
      WFDictionaryKey: sc.Str([sc.Ref('Chosen dup type')]),
      WFInput: sc.Attach(sc.Ref('Options', aggs=[
        {
          DictionaryKey: 'DupThreshold',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Date')),
      WFVariableName: 'TimeLast',
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: sc.Attach(sc.Ref('Vars.Image list')),
      WFItemSpecifier: 'Random Item',
    }),

    sc.Action('is.workflow.actions.text.changecase', name='dup type', params={
      WFCaseType: 'lowercase',
      text: sc.Attach(sc.Ref('Chosen dup type')),
    }),

    sc.Action('is.workflow.actions.notification', {
      WFInput: sc.Attach(sc.Ref('Item from List')),
      WFNotificationActionBody: sc.Str(['Checking ', sc.Ref('dup type')]),
      WFNotificationActionSound: false,
    }),

    sc.Action('is.workflow.actions.calculateexpression', name='Number of batches', params={
      Input: sc.Str(['ceil(', sc.Ref('Vars.Image count')]),
    }),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '5D9EE8B3-FCC0-4D77-BDC7-E8A064BE780C',
      WFControlFlowMode: 0,
      WFRepeatCount: sc.Attach(sc.Ref('Number of batches')),
    }),

    sc.Action('is.workflow.actions.calculateexpression', name='lower', params={
      Input: sc.Str(['(', sc.Ref('Vars.Repeat Index')]),
    }),

    sc.Action('is.workflow.actions.calculateexpression', name='upper', params={
      Input: sc.Str([sc.Ref('Vars.Repeat Index')]),
    }),

    sc.Action('is.workflow.actions.list', name='List', params={
      WFItems: [
        {
          WFItemType: 0,
          WFValue: sc.Str([sc.Ref('upper')]),
        },
        {
          WFItemType: 0,
          WFValue: sc.Str([sc.Ref('Vars.Image count')]),
        },
      ],
    }),

    sc.Action('is.workflow.actions.statistics', name='Minimum', params={
      Input: sc.Attach(sc.Ref('List')),
      WFStatisticsOperation: 'Minimum',
    }),

    sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
      WFInput: sc.Attach(sc.Ref('Vars.Image list')),
      WFItemRangeEnd: sc.Attach(sc.Ref('Minimum')),
      WFItemRangeStart: sc.Attach(sc.Ref('lower')),
      WFItemSpecifier: 'Items in Range',
    }),

    sc.Action('is.workflow.actions.image.convert', name='Converted Image', params={
      WFImageCompressionQuality: 0.0,
      WFImageFormat: 'JPEG',
      WFImagePreserveMetadata: false,
      WFInput: sc.Attach(sc.Ref('Item from List')),
    }),

    sc.Action('is.workflow.actions.image.resize', name='Resized Image', params={
      WFImage: sc.Attach(sc.Ref('Converted Image')),
      WFImageResizeHeight: sc.Attach(sc.Ref('Options', aggs=[
        {
          DictionaryKey: 'HashSize',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
      WFImageResizeWidth: sc.Attach(sc.Ref('Options', aggs=[
        {
          DictionaryKey: 'HashSize',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
    }),

    sc.Action('is.workflow.actions.base64encode', name='Base64 Encoded', params={
      WFBase64LineBreakMode: 'Every 76 Characters',
      WFInput: sc.Attach(sc.Ref('Resized Image')),
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: '`,`',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Base64 Encoded')),
    }),

    sc.Action('is.workflow.actions.gettext', name='dhash js', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{2740, 1}': sc.Ref('Combined Text'),
          },
          string: "function computeDHash(base64Images) {\n  const dHashValues = [];\n  let processedCount = 0;\n\n  base64Images.forEach((base64String, index) => {\n    const image = new Image();\n    image.src = `data:image/png;base64,${base64String.replaceAll(\"\\r\\n\", \"\")}`;\n\n    image.onload = () => {\n      const width = image.width;\n      const height = image.height;\n\n      const canvas = document.createElement(\"canvas\");\n      const context = canvas.getContext(\"2d\");\n      canvas.width = width;\n      canvas.height = height;\n      context.drawImage(image, 0, 0, width, height);\n\n      const imageData = context.getImageData(0, 0, width, height);\n      const pixels = imageData.data;\n\n      // Convert to grayscale and store in a new array\n      const grayscale = new Uint8Array(width * height);\n      for (let i = 0; i < pixels.length; i += 4) {\n        const r = pixels[i];\n        const g = pixels[i + 1];\n        const b = pixels[i + 2];\n        // Use luminance formula to convert to grayscale\n        grayscale[i / 4] = Math.round(0.299 * r + 0.587 * g + 0.114 * b);\n      }\n\n      // Allow the original pixels array to be garbage collected\n      imageData.data = null;\n\n      // Calculate row hash\n      let rowHash = \"\";\n      for (let i = 0; i < height; i++) {\n        for (let j = 0; j < width - 1; j++) {\n          const current = grayscale[i * width + j];\n          const next = grayscale[i * width + j + 1];\n          rowHash += current >= next ? \"1\" : \"0\";\n        }\n      }\n\n      // Calculate column hash\n      let colHash = \"\";\n      for (let j = 0; j < width; j++) {\n        for (let i = 0; i < height - 1; i++) {\n          const current = grayscale[i * width + j];\n          const next = grayscale[(i + 1) * width + j];\n          colHash += current >= next ? \"1\" : \"0\";\n        }\n      }\n\n      // Concatenate row and column hashes\n      const binaryDHash = rowHash + colHash;\n      \n      // Convert to base64\n      const base64DHash = binaryToBase64(binaryDHash);\n      \n      dHashValues[index] = base64DHash;\n      processedCount++;\n\n      if (processedCount === base64Images.length) {\n        // Prepare an output string, with one base64 dHash value per line\n        const output = dHashValues.join(\"\\n\");\n        document.body.textContent = encodeURIComponent(output);\n      }\n    };\n  });\n}\n\nfunction binaryToBase64(binaryString) {\n  const byteArray = new Uint8Array(binaryString.match(/.{1,8}/g).map(byte => parseInt(byte, 2)));\n  return btoa(String.fromCharCode.apply(null, byteArray));\n}\n\nfunction base64ToBinary(base64String) {\n  const binaryString = atob(base64String);\n  return Array.from(binaryString).map(char => \n    char.charCodeAt(0).toString(2).padStart(8, '0')\n  ).join('');\n}\n\n// Example usage\nconst base64Images = [`￼`];\n\ncomputeDHash(base64Images);",
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.url', name='URL as Rich Text', params={
      WFURLActionURL: sc.Str(['data:text/html;charset=utf-8,<body/><script>', sc.Ref('dhash js'), '</script>']),
    }),

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      WFEncodeMode: 'Decode',
      WFInput: sc.Str([sc.Ref('URL as Rich Text', aggs=[
        {
          CoercionItemClass: 'WFRichTextContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.text.split', name='Split Text', params={
      text: sc.Attach(sc.Ref('URL Encoded Text')),
    }),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FEF965CF-C2CB-444A-A647-EA95BB55CD1C',
      WFControlFlowMode: 0,
      WFInput: sc.Attach(sc.Ref('Split Text')),
    }),

    sc.Action('is.workflow.actions.appendvariable', {
      WFInput: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
      WFVariableName: 'Hash list',
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'FEF965CF-C2CB-444A-A647-EA95BB55CD1C',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      WFInput: sc.Str([sc.Ref('Date')]),
      WFTimeUntilFromDate: sc.Str([sc.Ref('Vars.TimeLast')]),
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Time Between Dates')),
      },
      '>',
      {
        UUID: 'E4913BA4-16E7-4E46-98C1-DAE49006099E',
        WFNumberValue: sc.Attach(sc.Ref('Options', aggs=[
          {
            DictionaryKey: 'ProgressSeconds',
            Type: 'WFDictionaryValueVariableAggrandizement',
          },
        ])),
      }
    )).Then_([

      sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
        WFInput: sc.Str([{
          Type: 'CurrentDate',
        }]),
        WFTimeUntilFromDate: sc.Str([sc.Ref('Date')]),
        WFTimeUntilUnit: 'Seconds',
      }),

      sc.Action('is.workflow.actions.count', name='CurNumImages', params={
        Input: sc.Attach(sc.Ref('Vars.Hash list')),
      }),

      sc.Action('is.workflow.actions.calculateexpression', name='Calculation Result', params={
        Input: sc.Str([sc.Ref('CurNumImages')]),
      }),

      sc.Action('is.workflow.actions.round', name='Items per second', params={
        WFInput: sc.Attach(sc.Ref('Calculation Result')),
        WFRoundTo: 'Tenths',
      }),

      sc.Action('is.workflow.actions.gettext', name='Text', params={
        WFTextActionText: sc.Str(['round(', sc.Ref('Vars.Image count'), '/', sc.Ref('CurNumImages'), '*(', sc.Ref('Time Between Dates')]),
      }),

      sc.Action('is.workflow.actions.calculateexpression', name='Seconds remaining', params={
        Input: sc.Str([sc.Ref('Text')]),
      }),

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Vars.Repeat Index')),
        },
        '>',
        {
          UUID: '1EC6E4AC-CA98-4011-9F5B-3B913172C608',
          WFNumberValue: '2',
        }
      )).Then_([

        sc.If_(sc.Cond(
          {
            Type: 'Variable',
            Variable: sc.Attach(sc.Ref('Seconds remaining')),
          },
          '>',
          {
            UUID: '11A59BDE-545F-499E-B361-33F6515AF5C4',
            WFNumberValue: '0',
          }
        )).Then_([

          sc.If_(sc.Cond(
            {
              Type: 'Variable',
              Variable: sc.Attach(sc.Ref('Seconds remaining')),
            },
            '>',
            {
              WFNumberValue: '80',
            }
          )).Then_([

            sc.Action('is.workflow.actions.calculateexpression', name='Minutes remaining', params={
              Input: sc.Str(['ceil(', sc.Ref('Seconds remaining'), '/60)']),
            }),

            sc.Action('is.workflow.actions.gettext', {
              WFTextActionText: sc.Str([sc.Ref('Minutes remaining'), 'm left']),
            }),

          ]).Else_([

            sc.Action('is.workflow.actions.gettext', {
              WFTextActionText: sc.Str([sc.Ref('Seconds remaining'), 's left']),
            }),

          ]).EndIf_(),

        ]).Else_([

          sc.Action('is.workflow.actions.gettext'),

        ]).EndIf_(),

      ]).Else_([

        sc.Action('is.workflow.actions.gettext'),

      ]).EndIf_(name='Time left'),

      sc.Action('is.workflow.actions.calculateexpression', name='Calculation Result', params={
        Input: sc.Str(['round(', sc.Ref('Vars.Repeat Index')]),
      }),

      sc.Action('is.workflow.actions.gettext', name='Text', params={
        WFTextActionText: sc.Str([sc.Ref('Time left'), ' @ ', sc.Ref('Items per second')]),
      }),

      sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
        WFInput: sc.Attach(sc.Ref('Item from List')),
        WFItemSpecifier: 'Random Item',
      }),

      sc.Action('is.workflow.actions.notification', {
        WFInput: sc.Attach(sc.Ref('Item from List')),
        WFNotificationActionBody: sc.Str([sc.Ref('Text')]),
        WFNotificationActionSound: false,
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Date')),
        WFVariableName: 'TimeLast',
      }),

    ]).EndIf_(),

    sc.Action('is.workflow.actions.repeat.count', {
      GroupingIdentifier: '5D9EE8B3-FCC0-4D77-BDC7-E8A064BE780C',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', {
      Input: sc.Attach(sc.Ref('Vars.Hash list')),
    }),

    sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
      WFTextCustomSeparator: '`,`',
      WFTextSeparator: 'Custom',
      text: sc.Attach(sc.Ref('Vars.Hash list')),
    }),

    sc.Action('is.workflow.actions.gettext', name='dup check js', params={
      WFTextActionText: {
        Value: {
          attachmentsByRange: {
            '{109, 1}': sc.Ref('Dictionary Value'),
            '{3817, 1}': sc.Ref('Combined Text'),
          },
          string: "// Set the duplicate threshold (maximum Hamming distance to be considered a duplicate)\nconst DUP_THRESHOLD = ￼;\n\n// BK-Tree node class\nclass BKTreeNode {\n    constructor(hash, index) {\n        this.hash = hash;\n        this.index = index;\n        this.exactDuplicates = [index];\n        this.children = new Map();\n    }\n}\n\n// BK-Tree class\nclass BKTree {\n    constructor() {\n        this.root = null;\n    }\n\n    insert(hash, index) {\n        if (!this.root) {\n            this.root = new BKTreeNode(hash, index);\n            return;\n        }\n\n        let node = this.root;\n        while (true) {\n            const distance = hammingDistance(node.hash, hash);\n            if (distance === 0) {\n                node.exactDuplicates.push(index);\n                return;\n            }\n            if (!node.children.has(distance)) {\n                node.children.set(distance, new BKTreeNode(hash, index));\n                return;\n            }\n            node = node.children.get(distance);\n        }\n    }\n\n    findDuplicates(hash, threshold) {\n        const duplicates = [];\n        this._search(this.root, hash, threshold, duplicates);\n        return duplicates;\n    }\n\n    _search(node, hash, threshold, results) {\n        if (!node) return;\n\n        const distance = hammingDistance(node.hash, hash);\n        if (distance <= threshold) {\n            results.push(...node.exactDuplicates.map(index => ({ index, distance })));\n        }\n\n        const minDistance = Math.max(0, distance - threshold);\n        const maxDistance = distance + threshold;\n\n        for (let i = minDistance; i <= maxDistance; i++) {\n            if (node.children.has(i)) {\n                this._search(node.children.get(i), hash, threshold, results);\n            }\n        }\n    }\n}\n\nfunction hammingDistance(hash1, hash2) {\n    const bin1 = base64ToBinary(hash1);\n    const bin2 = base64ToBinary(hash2);\n    let distance = 0;\n    for (let i = 0; i < bin1.length; i++) {\n        if (bin1[i] !== bin2[i]) distance++;\n    }\n    return distance;\n}\n\nfunction base64ToBinary(base64String) {\n    const binaryString = atob(base64String);\n    return Array.from(binaryString).map(char => \n        char.charCodeAt(0).toString(2).padStart(8, '0')\n    ).join('');\n}\n\nfunction findDuplicateImages(base64Hashes) {\n    const tree = new BKTree();\n    const allDuplicates = new Map();\n\n    for (let i = 0; i < base64Hashes.length; i++) {\n        const hash = base64Hashes[i];\n        const foundDuplicates = tree.findDuplicates(hash, DUP_THRESHOLD);\n        \n        if (foundDuplicates.length > 0) {\n            const group = new Set([i, ...foundDuplicates.map(d => d.index)]);\n            \n            // Merge with existing groups if there's an overlap\n            for (const [key, value] of allDuplicates.entries()) {\n                if ([...group].some(index => value.has(index))) {\n                    group.forEach(index => value.add(index));\n                    group.clear();\n                    break;\n                }\n            }\n            \n            // If the group wasn't merged, add it as a new group\n            if (group.size > 0) {\n                allDuplicates.set(i, group);\n            }\n        }\n\n        tree.insert(hash, i);\n    }\n\n    // Convert the map to the desired output format with 1-based indices\n    const duplicates = {};\n    for (const [key, value] of allDuplicates.entries()) {\n        const group = Array.from(value);\n        if (group.length > 1) {  // Only include groups with more than one image\n            const minIndex = Math.min(...group);\n            duplicates[minIndex + 1] = group\n                .filter(index => index !== minIndex)\n                .map(index => index + 1)\n                .sort((a, b) => a - b);\n        }\n    }\n\n    return duplicates;\n}\n\n// Example usage\nconst base64Hashes = [`￼`];\n\nconst duplicateResults = findDuplicateImages(base64Hashes);\n//console.log(JSON.stringify(duplicateResults, null, 2));\ndocument.body.textContent = encodeURIComponent(JSON.stringify(duplicateResults, null, 2));\n\n// Output: Image indices pointing to duplicates\n// {\"1\": [2,3], \"4\": [5]}",
        },
        WFSerializationType: 'WFTextTokenString',
      },
    }),

    sc.Action('is.workflow.actions.url', name='URL as Rich Text', params={
      WFURLActionURL: sc.Str(['data:text/html;charset=utf-8,<body/><script>', sc.Ref('dup check js'), '</script>']),
    }),

    sc.Action('is.workflow.actions.urlencode', name='URL Encoded Text', params={
      WFEncodeMode: 'Decode',
      WFInput: sc.Str([sc.Ref('URL as Rich Text', aggs=[
        {
          CoercionItemClass: 'WFRichTextContentItem',
          Type: 'WFCoercionVariableAggrandizement',
        },
      ])]),
    }),

    sc.Action('is.workflow.actions.detect.dictionary', name='Dictionary', params={
      WFInput: sc.Attach(sc.Ref('URL Encoded Text')),
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Dictionary')),
      WFVariableName: 'Duplicate dictionary',
    }),

    sc.Action('is.workflow.actions.count', name='Duplicate set count', params={
      Input: sc.Attach({
        Aggrandizements: [
          {
            PropertyName: 'Keys',
            Type: 'WFPropertyVariableAggrandizement',
          },
        ],
        Type: 'Variable',
        VariableName: 'Duplicate dictionary',
      }),
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Duplicate set count')),
      },
      'is',
      {
        UUID: '755DABCC-7FF2-4D4D-B727-E4C1F238358A',
        WFNumberValue: '0',
      }
    )).Then_([

      sc.Action('is.workflow.actions.alert', {
        WFAlertActionCancelButtonShown: false,
        WFAlertActionMessage: 'All clean! No duplicates found. ',
      }),

    ]).Else_([

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Duplicate set count')),
        WFVariableName: 'Total count',
      }),

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: '5B169A6D-A228-409B-8B43-E534E2416F2B',
        WFControlFlowMode: 0,
        WFInput: sc.Attach({
          Aggrandizements: [
            {
              PropertyName: 'Values',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Duplicate dictionary',
        }),
      }),

      sc.Action('is.workflow.actions.count', name='Count', params={
        Input: sc.Attach(sc.Ref('Vars.Repeat Item')),
      }),

      sc.Action('is.workflow.actions.math', name='Calculation Result', params={
        WFInput: sc.Attach(sc.Ref('Count')),
        WFMathOperand: sc.Attach(sc.Ref('Vars.Total count')),
      }),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Calculation Result')),
        WFVariableName: 'Total count',
      }),

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: '5B169A6D-A228-409B-8B43-E534E2416F2B',
        WFControlFlowMode: 2,
      }),

      sc.Action('is.workflow.actions.dictionary', name='Dictionary', params={
        WFItems: {
          Value: {
            WFDictionaryFieldValueItems: [
              {
                WFItemType: 0,
                WFKey: sc.Str(['Clean ', sc.Ref('dup type')]),
                WFValue: sc.Str(['Choose which ', sc.Ref('dup type'), ' to keep or delete']),
              },
              {
                WFItemType: 0,
                WFKey: sc.Str(['Copy into separate albums/folders']),
                WFValue: sc.Str(['Group ', sc.Ref('dup type'), ' into separate albums/folders for viewing/deleting']),
              },
              {
                WFItemType: 0,
                WFKey: sc.Str(['Copy into same album/folder']),
                WFValue: sc.Str(['Put all ', sc.Ref('dup type'), ' into same album/folder for viewing/deleting']),
              },
            ],
          },
          WFSerializationType: 'WFDictionaryFieldValue',
        },
      }),

      sc.Action('is.workflow.actions.gettext', name='Text', params={
        WFTextActionText: sc.Str([sc.Ref('Chosen dup type'), ' found for ', sc.Ref('Duplicate set count'), ' image(s); ', sc.Ref('Vars.Total count'), ' ', sc.Ref('dup type')]),
      }),

      sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
        WFChooseFromListActionPrompt: sc.Str([sc.Ref('Text')]),
        WFInput: sc.Attach(sc.Ref('Dictionary')),
      }),

      sc.Action('is.workflow.actions.date', name='Date'),

      sc.Action('is.workflow.actions.setvariable', {
        WFInput: sc.Attach(sc.Ref('Date')),
        WFVariableName: 'TimeLast',
      }),

      sc.Action('is.workflow.actions.nothing', name='Nothing'),

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'E427C3BD-F21F-48A8-B778-0FA3B0396EFB',
        WFControlFlowMode: 0,
        WFInput: sc.Attach({
          Aggrandizements: [
            {
              PropertyName: 'Keys',
              Type: 'WFPropertyVariableAggrandizement',
            },
          ],
          Type: 'Variable',
          VariableName: 'Duplicate dictionary',
        }),
      }),

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
            {
              CoercionItemClass: 'WFStringContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ])),
        },
        'does not contain',
        {
          WFConditionalActionString: 'same',
        }
      )).Then_([

        sc.Action('is.workflow.actions.setvariable', {
          WFInput: sc.Attach(sc.Ref('Nothing')),
          WFVariableName: 'Display images',
        }),

      ]).EndIf_(),

      sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
        WFInput: sc.Attach(sc.Ref('Vars.Image list')),
        WFItemIndex: sc.Attach(sc.Ref('Vars.Repeat Item')),
        WFItemSpecifier: 'Item At Index',
      }),

      sc.Action('is.workflow.actions.appendvariable', {
        WFInput: sc.Attach(sc.Ref('Item from List')),
        WFVariableName: 'Display images',
      }),

      sc.Action('is.workflow.actions.getvalueforkey', name='Dictionary Value', params={
        WFDictionaryKey: sc.Str([sc.Ref('Vars.Repeat Item')]),
        WFInput: sc.Attach(sc.Ref('Vars.Duplicate dictionary')),
      }),

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'DA0F21C4-E324-4BF3-85BB-C935E2A289F9',
        WFControlFlowMode: 0,
        WFInput: sc.Attach(sc.Ref('Dictionary Value')),
      }),

      sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
        WFInput: sc.Attach(sc.Ref('Vars.Image list')),
        WFItemIndex: sc.Attach(sc.Ref('Vars.Repeat Item 2')),
        WFItemSpecifier: 'Item At Index',
      }),

      sc.Action('is.workflow.actions.appendvariable', {
        WFInput: sc.Attach(sc.Ref('Item from List')),
        WFVariableName: 'Display images',
      }),

      sc.Action('is.workflow.actions.nothing'),

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'DA0F21C4-E324-4BF3-85BB-C935E2A289F9',
        WFControlFlowMode: 2,
      }),

      sc.Action('is.workflow.actions.count', name='Set size', params={
        Input: sc.Attach(sc.Ref('Vars.Display images')),
      }),

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
            {
              CoercionItemClass: 'WFStringContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ])),
        },
        'contains',
        {
          UUID: 'D43FBAEA-CF1B-43FF-8746-0DEB71079D0B',
          WFConditionalActionString: 'album',
        }
      )).Then_([

        sc.If_(sc.Cond(
          {
            Type: 'Variable',
            Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ])),
          },
          'contains',
          {
            UUID: '9B04E7D9-47BE-41CF-9C8B-233C29DCF4C3',
            WFConditionalActionString: 'separate',
          }
        )).Then_([

          sc.If_(sc.Cond(
            {
              Type: 'Variable',
              Variable: sc.Attach(sc.Ref('Vars.Use finder')),
            },
            'has any value',
            {
              UUID: '778E1939-0A55-4DF4-A76F-7D4A88B33500',
            }
          )).Then_([

            sc.Action('is.workflow.actions.gettext', name='Folder name', params={
              WFTextActionText: sc.Str(['(', sc.Ref('Vars.Repeat Index'), ' of ', sc.Ref('dup type'), ') ', sc.Ref('Duplicate set count')]),
            }),

            sc.If_(sc.Cond(
              {
                Type: 'Variable',
                Variable: sc.Attach(sc.Ref('Vars.Out folder')),
              },
              'does not have any value'
            )).Then_([

              sc.Action('is.workflow.actions.alert', {
                WFAlertActionCancelButtonShown: false,
                WFAlertActionMessage: sc.Str(['Where should ', sc.Ref('dup type'), ' be stored?']),
              }),

              sc.Action('is.workflow.actions.file.select', name='File', params={
                WFPickingMode: 'Folders',
              }),

              sc.Action('is.workflow.actions.setvariable', {
                WFInput: sc.Attach(sc.Ref('File')),
                WFVariableName: 'Out folder',
              }),

            ]).EndIf_(),

            sc.Action('is.workflow.actions.file.createfolder', name='Created Folder', params={
              WFFilePath: sc.Str([sc.Ref('Folder name')]),
              WFFolder: sc.Attach(sc.Ref('Vars.Out folder')),
            }),

            sc.Action('is.workflow.actions.documentpicker.save', {
              WFAskWhereToSave: false,
              WFFolder: sc.Attach(sc.Ref('Created Folder')),
              WFInput: sc.Attach(sc.Ref('Vars.Display images')),
              WFSaveFileOverwrite: true,
            }),

          ]).Else_([

            sc.Action('is.workflow.actions.gettext', name='Album name', params={
              WFTextActionText: sc.Str([sc.Ref('Date', aggs=[
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormat: 'MMM-dd HH-mm',
                  WFDateFormatStyle: 'Custom',
                  WFISO8601IncludeTime: false,
                },
              ]), ' (', sc.Ref('Set size'), ' of ', sc.Ref('dup type'), '): ', sc.Ref('Vars.Repeat Index')]),
            }),

            sc.Action('is.workflow.actions.photos.createalbum', {
              AlbumName: sc.Str([sc.Ref('Album name')]),
              WFInput: sc.Attach(sc.Ref('Vars.Display images')),
            }),

          ]).EndIf_(),

        ]).EndIf_(),

        sc.Action('is.workflow.actions.date', name='Date'),

        sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
          WFInput: sc.Str([sc.Ref('Date')]),
          WFTimeUntilFromDate: sc.Str([sc.Ref('Vars.TimeLast')]),
          WFTimeUntilUnit: 'Seconds',
        }),

        sc.If_(sc.Cond(
          {
            Type: 'Variable',
            Variable: sc.Attach(sc.Ref('Time Between Dates')),
          },
          '>',
          {
            UUID: 'D9CB6B66-2CA9-4218-9DFA-229B2375685F',
            WFNumberValue: sc.Attach(sc.Ref('Options', aggs=[
              {
                DictionaryKey: 'ProgressSeconds',
                Type: 'WFDictionaryValueVariableAggrandizement',
              },
            ])),
          }
        )).Then_([

          sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
            WFInput: sc.Str([{
              Type: 'CurrentDate',
            }]),
            WFTimeUntilFromDate: sc.Str([sc.Ref('Date')]),
            WFTimeUntilUnit: 'Seconds',
          }),

          sc.Action('is.workflow.actions.gettext', name='Text', params={
            WFTextActionText: sc.Str(['round(', sc.Ref('Duplicate set count'), '/', sc.Ref('Vars.Repeat Index'), '*(', sc.Ref('Time Between Dates')]),
          }),

          sc.Action('is.workflow.actions.calculateexpression', name='Seconds elapsed', params={
            Input: sc.Str([sc.Ref('Text')]),
          }),

          sc.If_(sc.Cond(
            {
              Type: 'Variable',
              Variable: sc.Attach(sc.Ref('Vars.Repeat Index')),
            },
            '>',
            {
              UUID: 'B43420F8-307F-4A6C-87BC-0AB02D00304D',
              WFNumberValue: '2',
            }
          )).Then_([

            sc.If_(sc.Cond(
              {
                Type: 'Variable',
                Variable: sc.Attach(sc.Ref('Seconds elapsed')),
              },
              '>',
              {
                UUID: '61C23F7D-AAFE-4249-80D3-E8E1E9C0DC87',
                WFNumberValue: '0',
              }
            )).Then_([

              sc.If_(sc.Cond(
                {
                  Type: 'Variable',
                  Variable: sc.Attach(sc.Ref('Seconds elapsed')),
                },
                '>',
                {
                  WFNumberValue: '80',
                }
              )).Then_([

                sc.Action('is.workflow.actions.calculateexpression', name='Minutes elapsed', params={
                  Input: sc.Str(['ceil(', sc.Ref('Seconds elapsed'), '/60)']),
                }),

                sc.If_(sc.Cond(
                  {
                    Type: 'Variable',
                    Variable: sc.Attach(sc.Ref('Minutes elapsed')),
                  },
                  'is',
                  {
                    WFNumberValue: '1',
                  }
                )).Then_([

                  sc.Action('is.workflow.actions.gettext', {
                    WFTextActionText: sc.Str([sc.Ref('Minutes elapsed'), ' minute left, ']),
                  }),

                ]).Else_([

                  sc.Action('is.workflow.actions.gettext', {
                    WFTextActionText: sc.Str([sc.Ref('Minutes elapsed'), ' minutes left, ']),
                  }),

                ]).EndIf_(),

              ]).Else_([

                sc.If_(sc.Cond(
                  {
                    Type: 'Variable',
                    Variable: sc.Attach(sc.Ref('Seconds elapsed')),
                  },
                  'is',
                  {
                    WFNumberValue: '1',
                  }
                )).Then_([

                  sc.Action('is.workflow.actions.gettext', {
                    WFTextActionText: sc.Str([sc.Ref('Seconds elapsed'), ' second left, ']),
                  }),

                ]).Else_([

                  sc.Action('is.workflow.actions.gettext', {
                    WFTextActionText: sc.Str([sc.Ref('Seconds elapsed'), ' seconds left, ']),
                  }),

                ]).EndIf_(),

              ]).EndIf_(),

            ]).Else_([

              sc.Action('is.workflow.actions.gettext'),

            ]).EndIf_(),

          ]).Else_([

            sc.Action('is.workflow.actions.gettext'),

          ]).EndIf_(name='Time left'),

          sc.Action('is.workflow.actions.calculateexpression', name='Calculation Result', params={
            Input: sc.Str(['round(', sc.Ref('Vars.Repeat Index')]),
          }),

          sc.Action('is.workflow.actions.gettext', name='Text', params={
            WFTextActionText: sc.Str(['Organizing ', sc.Ref('dup type'), ' (', sc.Ref('Time left')]),
          }),

          sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
            WFInput: sc.Attach(sc.Ref('Vars.Display images')),
            WFItemSpecifier: 'Random Item',
          }),

          sc.Action('is.workflow.actions.notification', {
            WFInput: sc.Attach(sc.Ref('Item from List')),
            WFNotificationActionBody: sc.Str([sc.Ref('Text')]),
            WFNotificationActionSound: false,
          }),

          sc.Action('is.workflow.actions.setvariable', {
            WFInput: sc.Attach(sc.Ref('Date')),
            WFVariableName: 'TimeLast',
          }),

        ]).EndIf_(),

      ]).Else_([

        sc.Action('is.workflow.actions.math', name='Calculation Result', params={
          WFInput: sc.Attach(sc.Ref('Set size')),
          WFMathOperand: '1',
          WFMathOperation: '-',
        }),

        sc.Action('is.workflow.actions.gettext', name='Text', params={
          WFTextActionText: sc.Str(['(', sc.Ref('Vars.Repeat Index'), ' of ', sc.Ref('Calculation Result'), ') Found ', sc.Ref('dup type')]),
        }),

        sc.Action('is.workflow.actions.choosefromlist', name='Chosen Item', params={
          WFChooseFromListActionPrompt: sc.Str([sc.Ref('Text')]),
          WFChooseFromListActionSelectAll: false,
          WFChooseFromListActionSelectMultiple: true,
          WFInput: sc.Attach(sc.Ref('Vars.Display images')),
        }),

        sc.If_(sc.Cond(
          {
            Type: 'Variable',
            Variable: sc.Attach(sc.Ref('Vars.Use finder')),
          },
          'has any value'
        )).Then_([

          sc.Action('is.workflow.actions.file.delete', {
            WFInput: sc.Attach(sc.Ref('Chosen Item')),
          }),

        ]).Else_([

          sc.Action('is.workflow.actions.deletephotos', {
            photos: sc.Attach(sc.Ref('Chosen Item')),
          }),

        ]).EndIf_(),

      ]).EndIf_(),

      sc.Action('is.workflow.actions.nothing'),

      sc.Action('is.workflow.actions.repeat.each', {
        GroupingIdentifier: 'E427C3BD-F21F-48A8-B778-0FA3B0396EFB',
        WFControlFlowMode: 2,
      }),

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
            {
              CoercionItemClass: 'WFStringContentItem',
              Type: 'WFCoercionVariableAggrandizement',
            },
          ])),
        },
        'contains',
        {
          UUID: '14F0650C-AD71-411D-9658-989814B3A78A',
          WFConditionalActionString: 'album',
        }
      )).Then_([

        sc.If_(sc.Cond(
          {
            Type: 'Variable',
            Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ])),
          },
          'does not contain',
          {
            UUID: '15811CE6-1C46-4BFB-B3DE-C52E6C5BDF0C',
            WFConditionalActionString: 'separate',
          }
        )).Then_([

          sc.If_(sc.Cond(
            {
              Type: 'Variable',
              Variable: sc.Attach(sc.Ref('Vars.Use finder')),
            },
            'has any value',
            {
              UUID: '44ADCEED-CA50-41A8-B966-C80C9CE33773',
            }
          )).Then_([

            sc.Action('is.workflow.actions.gettext', {
              WFTextActionText: sc.Str(['(', sc.Ref('Vars.Total count'), ' ', sc.Ref('Vars.Image count'), ' of ', sc.Ref('dup type')]),
            }),

            sc.If_(sc.Cond(
              {
                Type: 'Variable',
                Variable: sc.Attach(sc.Ref('Vars.Out folder')),
              },
              'does not have any value'
            )).Then_([

              sc.Action('is.workflow.actions.alert', {
                WFAlertActionCancelButtonShown: false,
                WFAlertActionMessage: sc.Str(['Where should ', sc.Ref('dup type'), ' be stored?']),
              }),

              sc.Action('is.workflow.actions.file.select', name='File', params={
                WFPickingMode: 'Folders',
              }),

              sc.Action('is.workflow.actions.setvariable', {
                WFInput: sc.Attach(sc.Ref('File')),
                WFVariableName: 'Out folder',
              }),

            ]).EndIf_(),

            sc.Action('is.workflow.actions.documentpicker.save', {
              WFAskWhereToSave: false,
              WFFolder: sc.Attach(sc.Ref('Vars.Out folder')),
              WFInput: sc.Attach(sc.Ref('Vars.Display images')),
              WFSaveFileOverwrite: true,
            }),

          ]).Else_([

            sc.Action('is.workflow.actions.gettext', name='Album name', params={
              WFTextActionText: sc.Str([sc.Ref('Date', aggs=[
                {
                  Type: 'WFDateFormatVariableAggrandizement',
                  WFDateFormat: 'MMM-dd HH-mm',
                  WFDateFormatStyle: 'Custom',
                  WFISO8601IncludeTime: false,
                },
              ]), ' (', sc.Ref('Duplicate set count'), ' ', sc.Ref('Vars.Image count'), ' of ', sc.Ref('Vars.Total count')]),
            }),

            sc.Action('is.workflow.actions.photos.createalbum', {
              AlbumName: sc.Str([sc.Ref('Album name')]),
              WFInput: sc.Attach(sc.Ref('Vars.Display images')),
            }),

          ]).EndIf_(),

        ]).EndIf_(),

        sc.If_(sc.Cond(
          {
            Type: 'Variable',
            Variable: sc.Attach(sc.Ref('Vars.Use finder')),
          },
          'has any value'
        )).Then_([

          sc.Action('is.workflow.actions.gettext', {
            WFTextActionText: sc.Str(['Finished. ', sc.Ref('Chosen dup type')]),
          }),

        ]).Else_([

          sc.Action('is.workflow.actions.gettext', {
            WFTextActionText: sc.Str(['Finished. ', sc.Ref('Chosen dup type'), ' grouped into new album(s) in Photos. You can delete the images in the album(s) and it will be removed from your library. Then you can remove the album(s).']),
          }),

        ]).EndIf_(name='If Result'),

        sc.Action('is.workflow.actions.alert', {
          WFAlertActionCancelButtonShown: false,
          WFAlertActionMessage: sc.Str([sc.Ref('If Result')]),
        }),

      ]).Else_([

        sc.Action('is.workflow.actions.alert', {
          WFAlertActionMessage: 'All finished! Have a nice day!',
        }),

      ]).EndIf_(),

    ]).EndIf_(),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: '【Auto-Update Routine】',
    }),

    sc.Action('is.workflow.actions.dictionary', name='Info', params={
      WFItems: {
        Value: {
          WFDictionaryFieldValueItems: [
            {
              WFItemType: 0,
              WFKey: sc.Str(['Version']),
              WFValue: sc.Str(['1.2.2']),
            },
            {
              WFItemType: 3,
              WFKey: sc.Str(['RoutineHub ID']),
              WFValue: sc.Str(['19025']),
            },
            {
              WFItemType: 0,
              WFKey: sc.Str(['Author']),
              WFValue: sc.Str(['twilsonco']),
            },
            {
              WFItemType: 4,
              WFKey: sc.Str(['Version Check']),
              WFValue: sc.Num(sc.Attach(sc.Ref('Options', aggs=[
                {
                  DictionaryKey: 'UpdateCheck',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ]))),
            },
            {
              WFItemType: 3,
              WFKey: sc.Str(['Change log word count']),
              WFValue: sc.Str(['20']),
            },
          ],
        },
        WFSerializationType: 'WFDictionaryFieldValue',
      },
    }),

    sc.Action('is.workflow.actions.getvalueforkey', name='True', params={
      WFDictionaryKey: 'Version Check',
      WFInput: sc.Attach(sc.Ref('Info')),
    }),

    sc.If_(sc.Cond(
      {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('True', aggs=[
          {
            CoercionItemClass: 'WFBooleanContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
      'is',
      {
        UUID: '3D0BA485-6AA0-408E-8FE6-6AA248A5C2A5',
        WFConditionalActionString: 'Yes',
      }
    )).Then_([

      sc.Action('is.workflow.actions.getipaddress', name='Current IP Address', params={
        WFIPAddressSourceOption: 'External',
        WFIPAddressTypeOption: 'IPv4',
      }),

      sc.If_(sc.Cond(
        {
          Type: 'Variable',
          Variable: sc.Attach(sc.Ref('Current IP Address')),
        },
        'has any value',
        {
          UUID: 'BF067D51-BEE7-4F24-BE0F-555E83555F99',
        }
      )).Then_([

        sc.Action('is.workflow.actions.downloadurl', name='Result ', params={
          WFURL: sc.Str(['https://routinehub.co/api/v1/shortcuts/', sc.Ref('Info', aggs=[
            {
              DictionaryKey: 'RoutineHub ID',
              Type: 'WFDictionaryValueVariableAggrandizement',
            },
          ]), '/versions/latest']),
        }),

        sc.If_(sc.Cond(
          {
            Type: 'Variable',
            Variable: sc.Attach(sc.Ref('Result ', aggs=[
              {
                CoercionItemClass: 'WFStringContentItem',
                Type: 'WFCoercionVariableAggrandizement',
              },
            ])),
          },
          'contains',
          {
            UUID: '843563B2-20EF-4E80-9287-8C05F959CC1F',
            WFConditionalActionString: 'success',
          }
        )).Then_([

          sc.Action('is.workflow.actions.gettext', name='Text', params={
            WFTextActionText: {
              Value: {
                attachmentsByRange: {
                  '{100, 1}': sc.Ref('Info', aggs=[
                    {
                      DictionaryKey: 'Version',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ]),
                  '{72, 1}': sc.Ref('Result ', aggs=[
                    {
                      CoercionItemClass: 'WFDictionaryContentItem',
                      Type: 'WFCoercionVariableAggrandizement',
                    },
                    {
                      DictionaryKey: 'Version',
                      Type: 'WFDictionaryValueVariableAggrandizement',
                    },
                  ]),
                },
                string: "// Define the latest and current version numbers\nconst latestVersion = '￼';\nconst currentVersion = '￼';\n\n// Compare the two version numbers\nconst isLatestGreater = compareVersions(latestVersion, currentVersion);\n\n// Print the result\ndocument.write(`${+isLatestGreater}`);\n\n// Function to compare two semantic version numbers\nfunction compareVersions(v1, v2) {\n  // Split the version numbers into an array of numbers\n  const v1Arr = v1.split('.');\n  const v2Arr = v2.split('.');\n\n  // Compare the major, minor, and patch versions\n  for (let i = 0; i < 3; i++) {\n    const v1Part = parseInt(v1Arr[i]);\n    const v2Part = parseInt(v2Arr[i]);\n\n    if (v1Part > v2Part) {\n      return true;\n    } else if (v1Part < v2Part) {\n      return false;\n    }\n  }\n\n  // The two versions are equal\n  return false;\n}",
              },
              WFSerializationType: 'WFTextTokenString',
            },
          }),

          sc.Action('is.workflow.actions.url', name='URL', params={
            WFURLActionURL: sc.Str(['data:text/html;charset=utf-8,<script>', sc.Ref('Text'), '</script>']),
          }),

          sc.Action('is.workflow.actions.gettypeaction', name='Get File of Type', params={
            WFFileType: 'com.apple.webarchive',
            WFInput: sc.Attach(sc.Ref('URL')),
          }),

          sc.If_(sc.Cond(
            {
              Type: 'Variable',
              Variable: sc.Attach(sc.Ref('Get File of Type', aggs=[
                {
                  CoercionItemClass: 'WFBooleanContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
              ])),
            },
            'is',
            {
              UUID: 'F9FBA074-AD8C-4417-A8B1-6FB00A27C95F',
              WFNumberValue: sc.Attach(sc.Ref('Vars.Current Version')),
            }
          )).Then_([

            sc.Action('is.workflow.actions.count', name='Count', params={
              Input: sc.Attach(sc.Ref('Result ', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'Notes',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ])),
              WFCountType: 'Words',
            }),

            sc.If_(sc.Cond(
              {
                Type: 'Variable',
                Variable: sc.Attach(sc.Ref('Count')),
              },
              '>',
              {
                WFNumberValue: sc.Attach(sc.Ref('Info', aggs=[
                  {
                    DictionaryKey: 'Change log word count',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ])),
              }
            )).Then_([

              sc.Action('is.workflow.actions.text.split', name='Split Text', params={
                WFTextSeparator: 'Spaces',
                text: sc.Attach(sc.Ref('Result ', aggs=[
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'Notes',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ])),
              }),

              sc.Action('is.workflow.actions.getitemfromlist', name='Item from List', params={
                WFInput: sc.Attach(sc.Ref('Split Text')),
                WFItemRangeEnd: sc.Attach(sc.Ref('Info', aggs=[
                  {
                    DictionaryKey: 'Change log word count',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ])),
                WFItemSpecifier: 'Items in Range',
              }),

              sc.Action('is.workflow.actions.text.combine', name='Combined Text', params={
                WFTextSeparator: 'Spaces',
                text: sc.Attach(sc.Ref('Item from List')),
              }),

              sc.Action('is.workflow.actions.gettext', {
                WFTextActionText: sc.Str([sc.Ref('Combined Text'), '...']),
              }),

            ]).Else_([

              sc.Action('is.workflow.actions.getvariable', {
                WFVariable: sc.Attach(sc.Ref('Result ', aggs=[
                  {
                    CoercionItemClass: 'WFDictionaryContentItem',
                    Type: 'WFCoercionVariableAggrandizement',
                  },
                  {
                    DictionaryKey: 'Notes',
                    Type: 'WFDictionaryValueVariableAggrandizement',
                  },
                ])),
              }),

            ]).EndIf_(name='Notes processed'),

            sc.Action('is.workflow.actions.gettext', name='Upgrade prompt', params={
              WFTextActionText: sc.Str(['New Version: ', sc.Ref('Result ', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'Version',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ]), '\nRelease: ', sc.Ref('Result ', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'Release',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ])]),
            }),

            sc.Action('is.workflow.actions.choosefrommenu', {
              GroupingIdentifier: 'A868DB78-D204-43A4-B386-66BA46DFAAA4',
              WFControlFlowMode: 0,
              WFMenuItems: [
                '🌐 Go to RoutineHub',
                '📥 Download Update',
                '↵  Not Now',
              ],
              WFMenuPrompt: sc.Str([sc.Ref('Upgrade prompt')]),
            }),

            sc.Action('is.workflow.actions.choosefrommenu', {
              GroupingIdentifier: 'A868DB78-D204-43A4-B386-66BA46DFAAA4',
              WFControlFlowMode: 1,
              WFMenuItemTitle: '🌐 Go to RoutineHub',
            }),

            sc.Action('is.workflow.actions.openurl', {
              WFInput: sc.Str(['https://routinehub.co/shortcut/', sc.Ref('Info', aggs=[
                {
                  DictionaryKey: 'RoutineHub ID',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ]), '/']),
            }),

            sc.Action('is.workflow.actions.exit'),

            sc.Action('is.workflow.actions.choosefrommenu', {
              GroupingIdentifier: 'A868DB78-D204-43A4-B386-66BA46DFAAA4',
              WFControlFlowMode: 1,
              WFMenuItemTitle: '📥 Download Update',
            }),

            sc.Action('is.workflow.actions.url.expand', name='Expanded URL', params={
              URL: sc.Str([sc.Ref('Result ', aggs=[
                {
                  CoercionItemClass: 'WFDictionaryContentItem',
                  Type: 'WFCoercionVariableAggrandizement',
                },
                {
                  DictionaryKey: 'URL',
                  Type: 'WFDictionaryValueVariableAggrandizement',
                },
              ])]),
            }),

            sc.Action('is.workflow.actions.text.replace', name='Updated Text', params={
              WFInput: sc.Str([sc.Ref('Expanded URL')]),
              WFReplaceTextCaseSensitive: false,
              WFReplaceTextFind: 'https://www.icloud.com/',
              WFReplaceTextReplace: 'shortcuts://',
            }),

            sc.Action('is.workflow.actions.openurl', {
              WFInput: sc.Attach(sc.Ref('Updated Text')),
            }),

            sc.Action('is.workflow.actions.exit'),

            sc.Action('is.workflow.actions.choosefrommenu', {
              GroupingIdentifier: 'A868DB78-D204-43A4-B386-66BA46DFAAA4',
              WFControlFlowMode: 1,
              WFMenuItemTitle: '↵  Not Now',
            }),

            sc.Action('is.workflow.actions.choosefrommenu', {
              GroupingIdentifier: 'A868DB78-D204-43A4-B386-66BA46DFAAA4',
              WFControlFlowMode: 2,
            }),

          ]).EndIf_(),

        ]).EndIf_(),

      ]).EndIf_(),

      sc.Action('is.workflow.actions.nothing'),

    ]).EndIf_(),

    sc.Action('is.workflow.actions.comment', {
      WFCommentActionText: '【Auto-Update Routine Ends Here】',
    }),

  ]),
  WFWorkflowClientVersion: '3607.0.2',
  WFWorkflowHasOutputFallback: false,
  WFWorkflowHasShortcutInputVariables: true,
  WFWorkflowIcon: {
    WFWorkflowIconGlyphNumber: 61523,
    WFWorkflowIconStartColor: -2873601,
  },
  WFWorkflowImportQuestions: [],
  WFWorkflowInputContentItemClasses: [
    'WFImageContentItem',
  ],
  WFWorkflowMinimumClientVersion: 1106,
  WFWorkflowMinimumClientVersionString: '1106',
  WFWorkflowOutputContentItemClasses: [],
  WFWorkflowTypes: [
    'ActionExtension',
    'MenuBar',
  ],
}
