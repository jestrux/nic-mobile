import 'package:nic/components/DynamicForm.dart';
import 'package:nic/utils.dart';

formatFieldChoicesAndChilds(Map<String, dynamic> field) {
  var choices = List.from(field['choices'] ?? []).map((choice) {
    var choiceLabel = choice;
    var choiceValue = choice;

    if (choice is Map) {
      choiceLabel = choice["name"] ?? choice["label"];
      choiceValue = choice["value"] ?? choiceLabel;
    }

    return {"label": choiceLabel, "value": choiceValue};
  }).toList();

  var childs = List.from(field['childs'] ?? []);

  return {
    ...field,
    "choices": choices,
    "childs": childs,
  };
}

List<Map<String, dynamic>> processChildren(Map<String, dynamic> field) {
  Map<String, dynamic> valueMap = {};

  for (var choice in List.from(field['choices'])) {
    valueMap[choice["value"].split("_")[0]] =
        (data) => data?[field["name"]] == choice["value"];
  }

  return List.from(field['childs']).fold<List<Map<String, dynamic>>>([],
      (agg, child) {
    List<Map<String, dynamic>> childFields = [];

    child = formatFieldChoicesAndChilds(child);

    var choices = child['choices'];
    var childs = child['childs'];

    if (choices.isNotEmpty && childs.isNotEmpty) {
      childFields = processChildren(child);
    }

    // childFields = childFields.expand((element) => element).toList();

    var triggerId = child["trigger"].toString();
    var trigger = valueMap[triggerId];

    return [
      ...agg,
      {...child, "show": trigger},
      ...childFields,
    ];
  });
}

List<DynamicFormField>? processFields(
    {fields, data, noGroups, fullWidthFields}) {
  if (fields == null) return null;

  var fieldsWithChildren = List<Map<String, dynamic>>.from(fields)
      .fold<List<Map<String, dynamic>>>([], (agg, Map<String, dynamic> field) {
        field = formatFieldChoicesAndChilds(field);
        var childFields = processChildren(field);
        try {
          devLog("Children: ${childFields.map((field) => field['trigger'])}");
        } catch (e) {
          devLog("Children error: $e");
        }

        // childFields = childFields.expand((element) => element).toList();

        return [...agg, field, ...childFields];
      })
      .where((element) => element["type"] != "file")
      .toList();

  var processedFields = fieldsWithChildren.fold<List<Map<String, dynamic>>>([],
      (agg, Map<String, dynamic> field) {
    // Map<String, dynamic> field = field;
    // var field = (Map<String, dynamic>) _field;

    var desctructuredProperties = [
      "type",
      "name",
      "label",
      "choices",
      "defaultValue"
    ];

    var type = field["type"];
    var name = field["name"];
    var label = field["label"];
    var choices = field["choices"];
    var defaultValue = field["defaultValue"];

    if (type == "future_date") {
      field["min_value"] = DateTime.now();
    }
    if (type == "past_date") {
      field["max_value"] = DateTime.now();
    }

    var fieldProps = {...field};
    fieldProps
        .removeWhere((key, value) => desctructuredProperties.contains(key));
    // var dataValue = data?.[name];
    // const computedDefaultValue = dataValue ?? defaultValue;

    var fullField = {
      "__id": "id${randomId()}",
      "name": name,
      "label": label ?? name,
      "type": type,
      "choices": choices,
      // "defaultValue": computedDefaultValue,
      // "value": computedDefaultValue,
      ...fieldProps,
    };

    var group = field["group"];

    // if (!noGroups && group) {
    //     if (group?.checklist !== "None") {
    //         const existingGroup = agg.findIndex(
    //             ({ checklist }) => checklist == group.checklist
    //         );

    //         if (existingGroup != -1)
    //             agg[existingGroup].children.add(fullField);
    //         else {
    //             agg.add({
    //                 ...field.group,
    //                 type: "group",
    //                 children: [fullField],
    //             });
    //         }
    //     } else if (agg.at(-1)?.id == "None") {
    //         agg.at(-1).children.add(fullField);
    //     } else {
    //         agg.add({
    //             ...field.group,
    //             type: "group",
    //             children: [fullField],
    //         });
    //     }

    //     return agg;
    // }

    agg.add(fullField);

    return agg;
  }).toList();

  return processedFields
      .map(
        (field) => DynamicFormField(
          show: field["show"],
          name: field["name"],
          label: field["label"],
          choices: field["choices"],
          max: field["max_value"],
          min: field["min_value"],
          type: dynamicFormFieldTypeMap[field["type"]] ??
              DynamicFormFieldType.text,
        ),
      )
      .toList();
}
