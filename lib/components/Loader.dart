import 'package:flutter/material.dart';
import 'package:nic/utils.dart';

class Loader extends StatelessWidget {
  final String? message;
  final Color? loaderColor;
  final Color? textColor;
  final double? textSize;
  final double? letterSpacing;
  final double? loaderSize;
  final double? loaderStrokeWidth;
  final bool small;
  final bool inline;

  const Loader({
    Key? key,
    this.message = "Please wait...",
    this.loaderSize = 24,
    this.loaderStrokeWidth = 2.5,
    this.loaderColor,
    this.textColor = Colors.black,
    this.textSize = 14,
    this.letterSpacing = 0.2,
    this.small = false,
    this.inline = true,
  }) : super(key: key);

  const Loader.small({
    super.key,
    this.message,
    this.loaderColor,
    this.textColor,
    this.inline = false,
  })  : loaderSize = 14,
        textSize = 13,
        letterSpacing = 0.01,
        loaderStrokeWidth = 1.6,
        small = true;

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      SizedBox(
        width: loaderSize,
        height: loaderSize,
        child: CircularProgressIndicator(
          strokeWidth: loaderStrokeWidth ?? 5,
          valueColor: AlwaysStoppedAnimation<Color>(
            loaderColor ?? colorScheme(context).primary,
          ),
        ),
      ),
      if (message != null && message!.isNotEmpty)
        Padding(
          padding: inline
              ? const EdgeInsets.only(left: 10)
              : const EdgeInsets.only(top: 10),
          child: Text(
            message!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSize,
              letterSpacing: letterSpacing,
              color: textColor,
            ),
          ),
        ),
    ];

    var horizontalLoader = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );

    var verticalLoader = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );

    return Container(
      padding: small ? null : const EdgeInsets.symmetric(vertical: 16),
      child: inline ? horizontalLoader : verticalLoader,
    );
  }
}

class PlaceholderLoader extends StatelessWidget {
  final String message;
  const PlaceholderLoader({this.message = "Please wait...", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: colorScheme(context).background,
        color: colorScheme(context).surfaceVariant.withOpacity(0.25),
        border: Border.all(
          width: 0.6,
          color: colorScheme(context).outlineVariant,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Loader(
        message: message,
        inline: true,
        loaderSize: 14,
        loaderStrokeWidth: 1.65,
        loaderColor: colorScheme(context).onBackground.withOpacity(0.2),
        textSize: 14,
        textColor: colorScheme(context).onBackground.withOpacity(0.4),
      ),
    );
  }
}
