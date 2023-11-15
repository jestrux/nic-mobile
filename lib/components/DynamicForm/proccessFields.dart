import 'package:nic/utils.dart';

processChildren(Map<String, dynamic> field) {
  var valueEntries = List.from(field['choices']).map((choice) {
    return [
      choice.value.split("_")[0],
      (data) => data[field['name']] == choice.value,
    ];
  }).toList();

  var valueMap = Map.fromEntries(valueEntries as Iterable<MapEntry>);

  return field['childs'].reduce((agg, child) {
    var childFields = [];
    if (child.choices?.length && child.childs?.length) {
      childFields = processChildren(child);
    }

    childFields = childFields.expand((element) => element).toList();

    return [
      ...agg,
      {...child, "show": valueMap[child.trigger]},
      ...childFields,
    ];
  }, []);
}

List<dynamic>? processFields({fields, data, noGroups, fullWidthFields}) {
  if (fields == null) return null;

  var processedFields = List.from(fields)
      .fold([], (agg, field) {
        var childFields = [];
        var choices = List.from(field['choices'] ?? []).map((choice) {
          var choiceLabel = choice;
          var choiceValue = choice;

          if (choice is Map) {
            choiceLabel = choice["name"] ?? choice["label"];
            choiceValue = choice["value"] ?? choiceLabel;
          }

          return {"label": choiceLabel, "value": choiceValue};
        }).toList();
        // var childs = List.from(field['childs'] ?? []);

        // if (choices.isNotEmpty && childs.isNotEmpty) {
        //   childFields = processChildren(field);
        // }

        field['choices'] = choices;

        childFields = childFields.expand((element) => element).toList();

        return [...agg, field, ...childFields];
      })
      .where((element) => element["type"] != "file")
      .toList();

  return processedFields.fold([], (agg, dynamic _field) {
    Map<String, dynamic> field = _field;
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
}
