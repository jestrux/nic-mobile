import 'package:flutter/material.dart';
import 'package:nic/constants.dart';

enum IconButtonWithBorderVariant { small, large, xlarge, radio, superImposed }

enum IconButtonWithBorderColorVariant { white, blue }

class IconButtonWithBorder extends StatelessWidget {
  final bool filled;
  final List<BoxShadow>? boxShadow;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? color;
  final IconData icon;
  final double contentPadding;
  final double iconSize;
  final Function onClick;
  final IconButtonWithBorderVariant variant;
  final IconButtonWithBorderColorVariant colorVariant;
  const IconButtonWithBorder({
    required this.icon,
    this.filled = false,
    this.boxShadow,
    this.backgroundColor,
    this.color,
    this.borderColor,
    this.variant = IconButtonWithBorderVariant.small,
    this.colorVariant = IconButtonWithBorderColorVariant.blue,
    this.contentPadding = 4,
    this.iconSize = 16,
    this.onClick = Constants.randoFunction,
  });

  @override
  Widget build(BuildContext context) {
    var bgColor = filled ? Colors.white : Colors.transparent;
    List<BoxShadow> shadow = [];
    double padding = contentPadding;
    double sizeOfIcon = iconSize;
    // var iconColor = filled ? Constants.primaryColor : Colors.white;
    var iconColor = Constants.primaryColor;
    double borderWidth = 1;
    Color defaultBgColor =
        colorVariant == IconButtonWithBorderColorVariant.white
            ? Colors.white
            : Constants.primaryColor;
    Color defaultColor = colorVariant == IconButtonWithBorderColorVariant.white
        ? Constants.primaryColor
        : Colors.white;
    Color derivedBorderColor = defaultBgColor.withOpacity(0.6);

    if (variant == IconButtonWithBorderVariant.radio) {
      sizeOfIcon = 14;
      padding = 2.5;
      borderWidth = 1.5;
    }

    if (variant == IconButtonWithBorderVariant.large) {
      bgColor = defaultBgColor;
      shadow = [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1.5),
        ),
      ];
      padding = 8;
      sizeOfIcon = 22;
      iconColor = defaultColor;
    }

    if (variant == IconButtonWithBorderVariant.xlarge) {
      bgColor = defaultBgColor;
      shadow = [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          spreadRadius: 3,
          blurRadius: 3,
          offset: const Offset(0, 3),
        ),
      ];
      padding = 10;
      sizeOfIcon = 28;
      iconColor = Constants.primaryColor;
    }

    if (variant == IconButtonWithBorderVariant.superImposed) {
      derivedBorderColor = Colors.transparent;
      iconColor = Colors.black;
    }

    if (onClick == null && variant != IconButtonWithBorderVariant.radio) {
      shadow = [];
      bgColor = Colors.white.withOpacity(0.1);
      iconColor = Colors.white.withOpacity(0.2);
      derivedBorderColor = Colors.white.withOpacity(0.1);

      if (colorVariant == IconButtonWithBorderColorVariant.blue) {
        bgColor = defaultBgColor.withOpacity(0.2);
        iconColor = Colors.white.withOpacity(0.5);
        derivedBorderColor = Colors.white.withOpacity(0.1);
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor ?? bgColor,
        boxShadow: boxShadow ?? shadow,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? derivedBorderColor,
              width: borderWidth,
            ),
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              100.0,
            ),
            onTap: () => onClick(),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Icon(
                icon,
                size: sizeOfIcon,
                color: color ?? iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
