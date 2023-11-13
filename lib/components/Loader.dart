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

  const Loader({
    Key? key,
    this.message = "LOADING...",
    this.loaderSize = 45,
    this.loaderStrokeWidth = 3,
    this.loaderColor,
    this.textColor = Colors.black,
    this.textSize = 18,
    this.letterSpacing = 1.3,
  }) : super(key: key);

  const Loader.small({
    super.key,
    this.message = "Please wait...",
    this.loaderSize = 30,
    this.loaderStrokeWidth = 3,
    this.loaderColor,
    this.textColor = Colors.black,
    this.textSize = 14,
    this.letterSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    var messageWidgets = message == null || message!.isEmpty
        ? []
        : [
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Text(
                message!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize,
                  letterSpacing: letterSpacing,
                ),
              ),
            ),
          ];
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
        ...messageWidgets
      ],
    );
  }
}
