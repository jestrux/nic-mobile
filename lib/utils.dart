// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/ChoiceItem.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/components/FormActions.dart';
import 'package:nic/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void devLog(value) {
  if (kDebugMode) {
    print(value);
  }
}

enum NicAlertType { success, error, noIcon }

class AlertContent extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? child;
  final NicAlertType? type;
  final String okayText;
  final Function onOkay;
  final String cancelText;
  final Function? onCancel;
  final bool noPadding;
  final bool noActions;

  const AlertContent({
    Key? key,
    this.title,
    this.description,
    this.child,
    this.type = NicAlertType.noIcon,
    this.okayText = "Okay",
    this.onOkay = Constants.randoFunction,
    this.cancelText = "Cancel",
    this.onCancel,
    this.noPadding = false,
    this.noActions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var noTitle = title == null || title!.isEmpty;

    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClickableContent(
              inkColor: Colors.transparent,
              child: Container(),
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colorScheme(context).surface,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: noPadding
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (type != NicAlertType.noIcon)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: noTitle ? 10 : 14),
                                    child: Icon(
                                      type == NicAlertType.success
                                          ? Icons.thumb_up
                                          : Icons.mood_bad,
                                    ),
                                  ),
                                noTitle
                                    ? const SizedBox(height: 10)
                                    : Padding(
                                        padding: EdgeInsets.only(
                                          top: noPadding ? 12 : 0,
                                          bottom: 8,
                                        ),
                                        child: Text(
                                          title!,
                                          // textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            // color: Constants.secondaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                if (child != null) child!,
                                if (description != null)
                                  Text(
                                    description!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: noTitle ? 18 : 16,
                                      height: 1.5,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (!noActions)
                            FormActions(
                              cancelText: cancelText,
                              okayText: okayText,
                              onOkay: onOkay,
                              onCancel: onCancel,
                              padding: noPadding ? EdgeInsets.zero : null,
                            ),
                          // const SizedBox(height: 12),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 6,
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close, size: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showAlert(
  BuildContext context, {
  String? title,
  String? description,
  Widget? child,
  NicAlertType? type = NicAlertType.noIcon,
  String okayText = "Okay",
  onOkay = Constants.randoFunction,
  String cancelText = "Cancel",
  onCancel,
  noPadding = false,
  noActions = false,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertContent(
        type: type,
        title: title,
        description: description,
        okayText: okayText,
        onOkay: onOkay,
        onCancel: onCancel,
        cancelText: cancelText,
        noPadding: noPadding,
        noActions: noActions,
        child: child,
      );
    },
  );
}

String formatDate(
  dynamic date, {
  String? format = 'yyyy-MM-dd',
  String? locale = "en",
}) {
  if (date == null) return "";

  DateTime dateTime;

  if (date is DateTime) {
    dateTime = date;
  } else if (date is String)
    dateTime = DateTime.parse(date);
  else
    return "";

  if (format == "dayM") {
    var suffix = "th";
    var digit = dateTime.day % 10;
    if ((digit > 0 && digit < 4) && (dateTime.day < 11 || dateTime.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }

    // return DateFormat("MMMM d'$suffix'", locale).format(date);
    var formattedDate = DateFormat("MMMM d'$suffix'").format(dateTime);
    if (dateTime.year != DateTime.now().year)
      formattedDate += ", ${dateTime.year}";

    return formattedDate;
  }

  return DateFormat(format).format(date);
}

ColorScheme colorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

Future<void> openUrl(String? url) async {
  if (url == null) return;

  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
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
      var choiceValue = choice;
      var choiceIcon;

      if (choice is Map) {
        choiceIcon = choice['icon'] == null ? null : Icon(choice['icon']);
        choiceLabel = choice["label"];
        choiceValue = choice["value"] ?? choice["label"];
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
            : value.toString().toLowerCase() ==
                choiceValue.toString().toLowerCase(),
        onClick: () {
          Navigator.of(context).pop(choiceValue);
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
        const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 16,
          top: 8,
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
                      const SizedBox(height: 20),
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
