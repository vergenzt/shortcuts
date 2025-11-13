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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BA3C2F70-11AD-4ED9-8402-E4A769E54001',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFEnumeration: 'Mac',
      WFInput: {
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
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BA3C2F70-11AD-4ED9-8402-E4A769E54001',
      WFControlFlowMode: 1,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BA3C2F70-11AD-4ED9-8402-E4A769E54001',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '376A2409-192B-45E7-B467-85FA26BE87CA',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Input),
      },
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '376A2409-192B-45E7-B467-85FA26BE87CA',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9EBFE732-4FF7-4AF9-B269-A63494FC9003',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFEnumeration: 'Mac',
      WFInput: {
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
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '9EBFE732-4FF7-4AF9-B269-A63494FC9003',
      WFControlFlowMode: 1,
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

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '9EBFE732-4FF7-4AF9-B269-A63494FC9003',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '376A2409-192B-45E7-B467-85FA26BE87CA',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.count', name='Original count', params={
      Input: sc.Attach(sc.Ref('If Result')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7DB4E8FC-2CFA-4F34-BBF6-F37851135579',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Original count')),
      },
      WFNumberValue: sc.Attach(sc.Ref('Vars.Max images')),
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '7DB4E8FC-2CFA-4F34-BBF6-F37851135579',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.getvariable', {
      WFVariable: sc.Attach(sc.Ref('If Result')),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '7DB4E8FC-2CFA-4F34-BBF6-F37851135579',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '883FDE9F-BF82-4F08-9953-692F7A6E5FF5',
      WFCondition: 0,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Image count')),
      },
      WFNumberValue: sc.Attach(sc.Ref('Original count')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '83902807-DBFF-4DED-99B8-82EF2EF4BF07',
      WFCondition: 5,
      WFControlFlowMode: 0,
      WFEnumeration: 'Mac',
      WFInput: {
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
    }),

    sc.Action('is.workflow.actions.gettext', name='Text', params={
      WFTextActionText: sc.Str([sc.Ref('Original count')]),
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: sc.Str([sc.Ref('Text')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '83902807-DBFF-4DED-99B8-82EF2EF4BF07',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '883FDE9F-BF82-4F08-9953-692F7A6E5FF5',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AB233B0D-3F0F-415E-AC36-289AD22C5D72',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Time Between Dates')),
      },
      WFNumberValue: sc.Attach(sc.Ref('Options', aggs=[
        {
          DictionaryKey: 'ProgressSeconds',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2BB9153E-3BAD-4E19-A64E-2013A2D713F4',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Repeat Index')),
      },
      WFNumberValue: '2',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D1315B0F-2414-4736-A972-4B2B31E648C7',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Seconds remaining')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '81754D8C-F123-4EA1-924D-7EFEC7FB2EEC',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Seconds remaining')),
      },
      WFNumberValue: '80',
    }),

    sc.Action('is.workflow.actions.calculateexpression', name='Minutes remaining', params={
      Input: sc.Str(['ceil(', sc.Ref('Seconds remaining'), '/60)']),
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str([sc.Ref('Minutes remaining'), 'm left']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '81754D8C-F123-4EA1-924D-7EFEC7FB2EEC',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str([sc.Ref('Seconds remaining'), 's left']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '81754D8C-F123-4EA1-924D-7EFEC7FB2EEC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D1315B0F-2414-4736-A972-4B2B31E648C7',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D1315B0F-2414-4736-A972-4B2B31E648C7',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '2BB9153E-3BAD-4E19-A64E-2013A2D713F4',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext'),

    sc.Action('is.workflow.actions.conditional', name='Time left', params={
      GroupingIdentifier: '2BB9153E-3BAD-4E19-A64E-2013A2D713F4',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AB233B0D-3F0F-415E-AC36-289AD22C5D72',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '940A3022-66DA-45BC-96BA-2A3F1569DC1C',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Duplicate set count')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionCancelButtonShown: false,
      WFAlertActionMessage: 'All clean! No duplicates found. ',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '940A3022-66DA-45BC-96BA-2A3F1569DC1C',
      WFControlFlowMode: 1,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '78CC5DF8-7A5D-4E17-B6B6-D7C55A562638',
      WFCondition: 999,
      WFConditionalActionString: 'same',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.setvariable', {
      WFInput: sc.Attach(sc.Ref('Nothing')),
      WFVariableName: 'Display images',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '78CC5DF8-7A5D-4E17-B6B6-D7C55A562638',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '50B45AB4-EB22-400F-88C6-759F06B5BF75',
      WFCondition: 99,
      WFConditionalActionString: 'album',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B50879F2-4528-438F-B3EC-CD4F33E1BE0E',
      WFCondition: 99,
      WFConditionalActionString: 'separate',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C74AD5E0-828B-473A-8DE7-10FD16ABD26C',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Use finder')),
      },
    }),

    sc.Action('is.workflow.actions.gettext', name='Folder name', params={
      WFTextActionText: sc.Str(['(', sc.Ref('Vars.Repeat Index'), ' of ', sc.Ref('dup type'), ') ', sc.Ref('Duplicate set count')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0E6608EC-6AE1-4E88-BFAB-D395F73C5BF6',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Out folder')),
      },
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0E6608EC-6AE1-4E88-BFAB-D395F73C5BF6',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C74AD5E0-828B-473A-8DE7-10FD16ABD26C',
      WFControlFlowMode: 1,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'C74AD5E0-828B-473A-8DE7-10FD16ABD26C',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'B50879F2-4528-438F-B3EC-CD4F33E1BE0E',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.date', name='Date'),

    sc.Action('is.workflow.actions.gettimebetweendates', name='Time Between Dates', params={
      WFInput: sc.Str([sc.Ref('Date')]),
      WFTimeUntilFromDate: sc.Str([sc.Ref('Vars.TimeLast')]),
      WFTimeUntilUnit: 'Seconds',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '793FDDED-696A-4B35-AC32-EF1A694CC554',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Time Between Dates')),
      },
      WFNumberValue: sc.Attach(sc.Ref('Options', aggs=[
        {
          DictionaryKey: 'ProgressSeconds',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A78120CE-F01D-484F-8915-02E3292C5C66',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Repeat Index')),
      },
      WFNumberValue: '2',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '57F003A2-3557-45A0-8F7D-8300BF2FCEDC',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Seconds elapsed')),
      },
      WFNumberValue: '0',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '79E484F8-E9A9-4FB6-92C7-29F41FB1DEAA',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Seconds elapsed')),
      },
      WFNumberValue: '80',
    }),

    sc.Action('is.workflow.actions.calculateexpression', name='Minutes elapsed', params={
      Input: sc.Str(['ceil(', sc.Ref('Seconds elapsed'), '/60)']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0D7D494B-1EF0-4C73-8B8F-F2084C88B4D5',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Minutes elapsed')),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str([sc.Ref('Minutes elapsed'), ' minute left, ']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0D7D494B-1EF0-4C73-8B8F-F2084C88B4D5',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str([sc.Ref('Minutes elapsed'), ' minutes left, ']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0D7D494B-1EF0-4C73-8B8F-F2084C88B4D5',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '79E484F8-E9A9-4FB6-92C7-29F41FB1DEAA',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'E70CACA1-CADE-4D8A-AFA1-99F72FA958F6',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Seconds elapsed')),
      },
      WFNumberValue: '1',
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str([sc.Ref('Seconds elapsed'), ' second left, ']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'E70CACA1-CADE-4D8A-AFA1-99F72FA958F6',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str([sc.Ref('Seconds elapsed'), ' seconds left, ']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'E70CACA1-CADE-4D8A-AFA1-99F72FA958F6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '79E484F8-E9A9-4FB6-92C7-29F41FB1DEAA',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '57F003A2-3557-45A0-8F7D-8300BF2FCEDC',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '57F003A2-3557-45A0-8F7D-8300BF2FCEDC',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'A78120CE-F01D-484F-8915-02E3292C5C66',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext'),

    sc.Action('is.workflow.actions.conditional', name='Time left', params={
      GroupingIdentifier: 'A78120CE-F01D-484F-8915-02E3292C5C66',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '793FDDED-696A-4B35-AC32-EF1A694CC554',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '50B45AB4-EB22-400F-88C6-759F06B5BF75',
      WFControlFlowMode: 1,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AD4456C6-8ADB-4C9A-9247-7FEDCCB46BC6',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Use finder')),
      },
    }),

    sc.Action('is.workflow.actions.file.delete', {
      WFInput: sc.Attach(sc.Ref('Chosen Item')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AD4456C6-8ADB-4C9A-9247-7FEDCCB46BC6',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.deletephotos', {
      photos: sc.Attach(sc.Ref('Chosen Item')),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AD4456C6-8ADB-4C9A-9247-7FEDCCB46BC6',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '50B45AB4-EB22-400F-88C6-759F06B5BF75',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.repeat.each', {
      GroupingIdentifier: 'E427C3BD-F21F-48A8-B778-0FA3B0396EFB',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'DD62D663-5379-46C0-93D6-8BB9E780BD76',
      WFCondition: 99,
      WFConditionalActionString: 'album',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '55D66AD6-2514-4665-911A-DBEE3CD013D8',
      WFCondition: 999,
      WFConditionalActionString: 'separate',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Chosen Item', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4E1D0FAE-10FA-4537-B67E-BC666C4AEE60',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Use finder')),
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str(['(', sc.Ref('Vars.Total count'), ' ', sc.Ref('Vars.Image count'), ' of ', sc.Ref('dup type')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4B8B25F0-0769-4609-8535-F9B52D417CAE',
      WFCondition: 101,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Out folder')),
      },
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4B8B25F0-0769-4609-8535-F9B52D417CAE',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.documentpicker.save', {
      WFAskWhereToSave: false,
      WFFolder: sc.Attach(sc.Ref('Vars.Out folder')),
      WFInput: sc.Attach(sc.Ref('Vars.Display images')),
      WFSaveFileOverwrite: true,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4E1D0FAE-10FA-4537-B67E-BC666C4AEE60',
      WFControlFlowMode: 1,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '4E1D0FAE-10FA-4537-B67E-BC666C4AEE60',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '55D66AD6-2514-4665-911A-DBEE3CD013D8',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '922C6772-262A-4E79-8166-B755BDCE5BB2',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Vars.Use finder')),
      },
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str(['Finished. ', sc.Ref('Chosen dup type')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '922C6772-262A-4E79-8166-B755BDCE5BB2',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.gettext', {
      WFTextActionText: sc.Str(['Finished. ', sc.Ref('Chosen dup type'), ' grouped into new album(s) in Photos. You can delete the images in the album(s) and it will be removed from your library. Then you can remove the album(s).']),
    }),

    sc.Action('is.workflow.actions.conditional', name='If Result', params={
      GroupingIdentifier: '922C6772-262A-4E79-8166-B755BDCE5BB2',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionCancelButtonShown: false,
      WFAlertActionMessage: sc.Str([sc.Ref('If Result')]),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'DD62D663-5379-46C0-93D6-8BB9E780BD76',
      WFControlFlowMode: 1,
    }),

    sc.Action('is.workflow.actions.alert', {
      WFAlertActionMessage: 'All finished! Have a nice day!',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'DD62D663-5379-46C0-93D6-8BB9E780BD76',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '940A3022-66DA-45BC-96BA-2A3F1569DC1C',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0EF09A1E-8531-48AA-826E-B7422B4A676A',
      WFCondition: 4,
      WFConditionalActionString: 'Yes',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('True', aggs=[
          {
            CoercionItemClass: 'WFBooleanContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

    sc.Action('is.workflow.actions.getipaddress', name='Current IP Address', params={
      WFIPAddressSourceOption: 'External',
      WFIPAddressTypeOption: 'IPv4',
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE7662ED-93B1-479F-BDBE-04D95942158D',
      WFCondition: 100,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Current IP Address')),
      },
    }),

    sc.Action('is.workflow.actions.downloadurl', name='Result ', params={
      WFURL: sc.Str(['https://routinehub.co/api/v1/shortcuts/', sc.Ref('Info', aggs=[
        {
          DictionaryKey: 'RoutineHub ID',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ]), '/versions/latest']),
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '816EE2D5-FB14-49B7-B59B-3D2F9FA9F254',
      WFCondition: 99,
      WFConditionalActionString: 'success',
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Result ', aggs=[
          {
            CoercionItemClass: 'WFStringContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BE871DE4-D998-4633-9BDD-744E3B82EDF8',
      WFCondition: 4,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Get File of Type', aggs=[
          {
            CoercionItemClass: 'WFBooleanContentItem',
            Type: 'WFCoercionVariableAggrandizement',
          },
        ])),
      },
      WFNumberValue: sc.Attach(sc.Ref('Vars.Current Version')),
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D3CC33C6-9AE9-4074-B573-A2B76345881D',
      WFCondition: 2,
      WFControlFlowMode: 0,
      WFInput: {
        Type: 'Variable',
        Variable: sc.Attach(sc.Ref('Count')),
      },
      WFNumberValue: sc.Attach(sc.Ref('Info', aggs=[
        {
          DictionaryKey: 'Change log word count',
          Type: 'WFDictionaryValueVariableAggrandizement',
        },
      ])),
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'D3CC33C6-9AE9-4074-B573-A2B76345881D',
      WFControlFlowMode: 1,
    }),

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

    sc.Action('is.workflow.actions.conditional', name='Notes processed', params={
      GroupingIdentifier: 'D3CC33C6-9AE9-4074-B573-A2B76345881D',
      WFControlFlowMode: 2,
    }),

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

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'BE871DE4-D998-4633-9BDD-744E3B82EDF8',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '816EE2D5-FB14-49B7-B59B-3D2F9FA9F254',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: 'AE7662ED-93B1-479F-BDBE-04D95942158D',
      WFControlFlowMode: 2,
    }),

    sc.Action('is.workflow.actions.nothing'),

    sc.Action('is.workflow.actions.conditional', {
      GroupingIdentifier: '0EF09A1E-8531-48AA-826E-B7422B4A676A',
      WFControlFlowMode: 2,
    }),

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
