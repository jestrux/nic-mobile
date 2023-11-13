import 'package:flutter/material.dart';
import 'package:nic/utils.dart';

class KeyValueView extends StatelessWidget {
  final Map<String, dynamic> data;
  const KeyValueView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.all(8);
    var _data = Map.from(data);
    _data.removeWhere((key, value) => value == null);
    var keys = _data.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _data
          .map(
            (key, userValue) {
              var value = userValue;
              if (userValue is Map) {
                value = userValue["value"];
                var type = userValue["type"] ?? "text";

                if (type == "date") value = formatDate(value, format: "dayM");
              }

              return MapEntry(
                key,
                Container(
                  color: keys.indexOf(key) % 2 == 0
                      ? null
                      : colorScheme(context).onSurface.withOpacity(0.06),
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        key,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "$value",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
