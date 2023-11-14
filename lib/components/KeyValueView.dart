import 'package:flutter/material.dart';
import 'package:nic/utils.dart';

enum KeyValueStatusVariant { danger, warning, success }

class KeyValueView extends StatelessWidget {
  final Map<String, dynamic> data;
  const KeyValueView({
    Key? key,
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
      children: _data
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

              return MapEntry(
                key,
                Container(
                  color: keys.indexOf(key) % 2 == 0
                      ? null
                      : colorScheme(context).onSurface.withOpacity(0.06),
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
          .toList(),
    );
  }
}
