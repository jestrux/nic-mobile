import 'package:flutter/material.dart';
import 'package:nic/utils.dart';

enum KeyValueType { text, date, money, status }

const Map<KeyValueType, String> KeyValueTypeMap = {
  KeyValueType.text: "text",
  KeyValueType.date: "date",
  KeyValueType.money: "money",
  KeyValueType.status: "status",
};

enum KeyValueStatusVariant { danger, warning, success }

Map<String, dynamic> KeyValueBuilder({
  required dynamic value,
  KeyValueType type = KeyValueType.text,
  KeyValueStatusVariant? statusVariant,
}) {
  return {
    "value": value,
    "type": KeyValueTypeMap[type] ?? "text",
    "variant": statusVariant,
  };
}

class KeyValueView extends StatelessWidget {
  final String? title;
  final bool? striped;
  final bool? bordered;
  final Map<String, dynamic> data;
  const KeyValueView({
    Key? key,
    this.title,
    this.striped,
    this.bordered,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 14);
    var _data = Map.from(data);
    _data.removeWhere((key, value) => value == null);
    var keys = _data.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 14,
              bottom: 4,
            ),
            child: Text(
              title!.toUpperCase(),
              style: const TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ..._data
            .map(
              (key, userValue) {
                var value = userValue;
                var type = "text";
                if (userValue is Map) {
                  value = userValue["value"];

                  if (userValue["type"] != null) {
                    type = userValue["type"];
                  }

                  if (type == "date") value = formatDate(value, format: "dayM");

                  if (type == "money") {
                    value = formatMoney(value, currency: "TZS");
                  }
                }

                Widget valueWidget = Text(
                  "$value",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                );

                if (type == "status") {
                  var variantColors = {
                    KeyValueStatusVariant.success: [Colors.green, Colors.white],
                    KeyValueStatusVariant.danger: [Colors.red, Colors.white],
                    KeyValueStatusVariant.warning: [
                      Colors.yellow.shade600,
                      Colors.black
                    ],
                  }[userValue["variant"] ?? KeyValueStatusVariant.success];

                  valueWidget = Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: variantColors![0],
                    ),
                    height: 24,
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 1.5),
                    alignment: Alignment.center,
                    child: Text(
                      "$value".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: variantColors[1],
                      ),
                    ),
                  );
                }

                var keyIndex = keys.indexOf(key);
                var isEvenRow = keyIndex % 2 == 0;
                var isStriped = (striped ?? true) && !isEvenRow;
                var isBordered = (bordered ?? false) &&
                    isEvenRow &&
                    keyIndex != keys.length - 1;

                return MapEntry(
                  key,
                  Container(
                    decoration: BoxDecoration(
                      color: !isStriped
                          ? null
                          : colorScheme(context).onSurface.withOpacity(0.06),
                      border: !isBordered
                          ? null
                          : Border(
                              bottom: BorderSide(
                                width: 1,
                                color: colorScheme(context)
                                    .onBackground
                                    .withOpacity(0.1),
                              ),
                            ),
                    ),
                    padding: padding,
                    constraints: const BoxConstraints(
                      minHeight: 36,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          key,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        valueWidget,
                      ],
                    ),
                  ),
                );
              },
            )
            .values
            .toList()
      ],
    );
  }
}
