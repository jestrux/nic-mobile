// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/ChoiceItem.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/components/FormActions.dart';
import 'package:nic/components/FormButton.dart';
import 'package:nic/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void devLog(value) {
  if (kDebugMode) {
    print(value);
  }
}

String randomId([int? len]) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len ?? 6, (index) => r.nextInt(33) + 89));
}

enum AlertType { success, error, custom }

class AlertContent extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? child;
  final AlertType? type;
  final String okayText;
  final Function onOkay;
  final String cancelText;
  final Function? onCancel;

  const AlertContent({
    Key? key,
    this.title,
    this.message,
    this.child,
    this.type = AlertType.custom,
    this.okayText = "Okay",
    this.onOkay = Constants.randoFunction,
    this.cancelText = "Cancel",
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var noTitle = title == null || title!.isEmpty;
    var isCustom = type == AlertType.custom;

    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Stack(
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
                  constraints: const BoxConstraints(minHeight: 80),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: isCustom ? 12 : 32,
                    horizontal: isCustom ? 0 : 32,
                  ),
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
                            width: double.infinity,
                            padding: isCustom
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (!isCustom)
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      color: type == AlertType.success
                                          ? Colors.green
                                          : Colors.red.shade900,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    margin: EdgeInsets.only(
                                      bottom: noTitle ? 10 : 8,
                                    ),
                                    child: Icon(
                                      type == AlertType.success
                                          ? Icons.check
                                          : Icons.priority_high,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                noTitle
                                    ? const SizedBox(height: 10)
                                    : Padding(
                                        padding: EdgeInsets.only(
                                          top: isCustom ? 24 : 0,
                                          bottom: 8,
                                        ),
                                        child: Text(
                                          title!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                if (message != null)
                                  Opacity(
                                    opacity: noTitle ? 1 : 0.85,
                                    child: Text(
                                      message!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: noTitle ? 16 : 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                if (child != null) child!,
                                if (!isCustom)
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 100,
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(top: 12),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: FormButton.filled(
                                        okayText,
                                        small: true,
                                        onClick: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
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

Future<dynamic> openAlert({
  String? title,
  String? message,
  Widget? child,
  AlertType? type = AlertType.custom,
  String okayText = "Okay",
  onOkay = Constants.randoFunction,
  String cancelText = "Cancel",
  onCancel,
}) {
  return showDialog(
    context: Constants.globalAppKey.currentContext!,
    builder: (BuildContext context) {
      return AlertContent(
        type: type,
        title: title,
        message: message,
        okayText: okayText,
        onOkay: onOkay,
        onCancel: onCancel,
        cancelText: cancelText,
        child: child,
      );
    },
  );
}

void openErrorAlert({
  String? title = "Something went wrong!",
  required String message,
}) {
  openAlert(
    type: AlertType.error,
    title: title,
    message: message,
  );
}

void openSuccessAlert({
  String? title = "Success",
  required String message,
}) {
  openAlert(
    type: AlertType.success,
    title: title,
    message: message,
  );
}

String formatMoney(dynamic number, {String? currency}) {
  var num = number.toString();
  currency = currency == null ? "" : "$currency ";

  if (num.isEmpty) return "${currency}0";

  return "$currency${NumberFormat('#,###,###').format(double.parse(num))}";
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

  if (["dayM", "dayMY"].contains(format)) {
    var suffix = "th";
    var digit = dateTime.day % 10;
    if ((digit > 0 && digit < 4) && (dateTime.day < 11 || dateTime.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }

    // return DateFormat("MMMM d'$suffix'", locale).format(date);
    var formattedDate = DateFormat("MMMM d'$suffix'").format(dateTime);
    if (dateTime.year != DateTime.now().year || format == "dayMY")
      formattedDate += ", ${dateTime.year}";

    return formattedDate;
  }

  return DateFormat(format).format(date);
}

Future<DateTime?> selectDate({
  value,
  minDate,
  maxDate,
}) async {
  var context = Constants.globalAppKey.currentContext!;
  var now = DateTime.now();
  var firstDateEver = DateTime(1970, now.month, now.day, now.hour, now.minute);

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: value ?? minDate ?? firstDateEver,
    firstDate: minDate ?? firstDateEver,
    lastDate:
        maxDate ?? DateTime(2100, now.month, now.day, now.hour, now.minute),
  );

  return picked;
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

class ChoicePickerContent extends StatefulWidget {
  final bool confirm;
  final List<dynamic> choices;
  final dynamic value;
  final ChoicePickerMode? mode;
  final Function onSelect;

  const ChoicePickerContent({
    Key? key,
    this.confirm = false,
    required this.choices,
    this.value,
    this.mode,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<ChoicePickerContent> createState() => ChoicePickerContentState();
}

class ChoicePickerContentState extends State<ChoicePickerContent> {
  dynamic value;

  @override
  void initState() {
    value = widget.value;

    super.initState();
  }

  Widget buildChoice(choice) {
    if (widget.mode == ChoicePickerMode.dialog) {
      return RadioListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 12,
        ),
        title: Text(
          choice["label"],
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        value: choice["value"],
        groupValue: value,
        onChanged: (v) {
          setState(() {
            value = choice["value"];
          });
        },
      );
    }

    return ChoiceItem(
      choice["label"],
      leading: choice["icon"],
      selected: value == null
          ? widget.confirm
              ? false
              : null
          : value.toString().toLowerCase() ==
              choice["value"].toString().toLowerCase(),
      onClick: () {
        if (widget.confirm) {
          setState(() {
            value = choice["value"];
          });
        } else {
          widget.onSelect(choice["value"]);
        }
      },
    );
  }

  Widget buildChoices(List<dynamic> choices) {
    List<Widget> choiceItems = choices.map((choice) {
      return Container(
        child: buildChoice(choice),
      );
    }).toList();

    return Column(children: choiceItems);
  }

  @override
  Widget build(BuildContext context) {
    Widget? actionButtons = !widget.confirm
        ? null
        : FormActions(
            okayText: "Continue",
            onOkay: () {
              if (value == null) return showToast("Please select one");

              widget.onSelect(value);
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
          );

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          buildChoices(widget.choices),
          if (actionButtons != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: actionButtons,
            ),
        ],
      ),
    );
  }
}

enum ChoicePickerMode { regular, dialog, alert, menu }

Future<dynamic> showChoicePicker({
  String? title,
  required List<dynamic> choices,
  dynamic value,
  bool grid = false,
  bool? confirm,
  Offset? clickPosition,
  ChoicePickerMode mode = ChoicePickerMode.regular,
  Widget Function(String choice, dynamic selected)? choicePicker,
}) {
  var choicePickerContentKey = GlobalKey<ChoicePickerContentState>();
  var context = Constants.globalAppKey.currentContext!;
  var formattedChoices = choices.map((choice) {
    var choiceLabel = choice;
    var choiceValue = choice;
    dynamic choiceIcon;

    if (choice is Map) {
      choiceIcon = choice['icon'] == null ? null : Icon(choice['icon']);
      choiceLabel = choice["label"];
      choiceValue = choice["value"] ?? choice["label"];
    }

    return {"icon": choiceIcon, "label": choiceLabel, "value": choiceValue};
  }).toList();

  Widget choicePickerContent = ChoicePickerContent(
    key: choicePickerContentKey,
    choices: formattedChoices,
    value: value,
    confirm: confirm ?? false,
    mode: mode,
    onSelect: (value) {
      Navigator.of(context).pop(value);
    },
  );

  var menuPosition = const RelativeRect.fromLTRB(0, 0, 0, 0);

  if (clickPosition != null) {
    final screenSize = MediaQuery.of(context).size;
    menuPosition = RelativeRect.fromLTRB(
      screenSize.width - clickPosition.dx - 20,
      clickPosition.dy,
      20,
      0,
    );
  }

  if (mode == ChoicePickerMode.menu) {
    return showMenu(
      context: context,
      position: menuPosition,
      items: formattedChoices
          .map((choice) => PopupMenuItem(
                value: choice["value"],
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        choice["label"],
                      ),
                    ),
                    if (value == choice["value"])
                      const Opacity(
                        opacity: 0.8,
                        child: Icon(Icons.check, size: 16),
                      ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  if (mode == ChoicePickerMode.alert) {
    return openAlert(
      title: title,
      child: choicePickerContent,
    );
  }

  if (mode == ChoicePickerMode.dialog) {
    void handler([bool cancel = false]) {
      Navigator.pop(
        context,
        cancel ? null : choicePickerContentKey.currentState?.value,
      );
    }

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: title == null
            ? null
            : Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
        titlePadding: const EdgeInsets.only(
          top: 20,
          bottom: 14,
          left: 22,
          right: 20,
        ),
        contentPadding: EdgeInsets.zero,
        actionsPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        content: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                width: 1,
                color: colorScheme(context).outlineVariant,
              ),
            ),
          ),
          constraints: const BoxConstraints(
            maxHeight: 180,
          ),
          child: SingleChildScrollView(
            child: choicePickerContent,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => handler(true),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => handler(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  return openBottomSheet(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(
              bottom: 6,
              left: 20,
              right: 20,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: choicePickerContent,
        ),
        // const SizedBox(height: 10)
      ],
    ),
  );
}

Future<dynamic> openBottomSheet({
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
    context: Constants.globalAppKey.currentContext!,
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

showToast(String message, {String type = "success"}) {
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
