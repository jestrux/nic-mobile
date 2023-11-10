import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nic/components/ChoiceItem.dart';

ColorScheme colorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

class Utils {
  static Future<dynamic> showChoicePicker(
    BuildContext context, {
    String? title,
    List<dynamic>? choices,
    dynamic value,
    bool grid = false,
    Widget Function(String choice, dynamic selected)? choicePicker,
  }) {
    Widget buildChoice(choice) {
      if (choicePicker != null) return choicePicker(choice, value);

      var choiceLabel = choice;
      var choiceIcon;

      if (choice is Map) {
        choiceIcon = choice['icon'] == null ? null : Icon(choice['icon']);
        choiceLabel = choice["label"];
      }

      return ChoiceItem(
        choiceLabel,
        leading: choiceIcon,
        // padding: const EdgeInsets.symmetric(
        //   vertical: 12,
        //   horizontal: 20,
        // ),
        selected: value == null
            ? null
            : value.toString().toLowerCase() == choice.toString().toLowerCase(),
        onClick: () {
          Navigator.of(context).pop(choice);
        },
      );
    }

    Widget buildChoices() {
      if (choices == null) return Container();

      List<Widget> choiceItems = choices.map((choice) {
        var halfWidth = (MediaQuery.of(context).size.shortestSide / 2) - 20;
        return Container(
          width: grid ? halfWidth : double.infinity,
          margin: EdgeInsets.symmetric(
            vertical: grid ? 4 : 0,
            horizontal: grid ? 4 : 0,
          ),
          child: buildChoice(choice),
        );
      }).toList();

      if (grid) return Wrap(children: choiceItems);

      return Column(children: choiceItems);
    }

    return Utils.showBottomSheet(
      context,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 20,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: buildChoices(),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  static Future<dynamic> showBottomSheet(
    BuildContext context, {
    Widget? child,
    dismissible = true,
    padding,
  }) {
    var actualPadding = padding ??
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        );
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      enableDrag: dismissible,
      isDismissible: dismissible,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Wrap(
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 560),
                    decoration: BoxDecoration(
                      color: colorScheme(context).background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: actualPadding,
                    child: Column(children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            height: 6,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: colorScheme(context)
                                  .onBackground
                                  .withOpacity(0.1),
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                      const SizedBox(height: 8),
                      child ?? Container(),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static showToast(String message, {String type = "success"}) {
    Color backgroundColor = Colors.black;
    Color textColor = Colors.white;

    if (type == "error") {
      backgroundColor = Colors.redAccent[100]!;
      textColor = Colors.black;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
