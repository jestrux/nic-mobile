import 'package:flutter/material.dart';

class ActionButton {
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String label;
  final bool filled;
  final bool flat;
  final Color? color;
  final Color? background;
  final VoidCallback? onClick;

  const ActionButton({
    required this.label,
    this.leftIcon,
    this.rightIcon,
    this.filled = false,
    this.flat = false,
    this.background,
    this.color,
    this.onClick,
  });

  ActionButton.all(
    this.label, [
    this.rightIcon = Icons.keyboard_double_arrow_right,
    this.filled = false,
    this.flat = false,
    this.leftIcon,
    this.background,
    this.color,
    this.onClick,
  ]);

  ActionButton.add(
    this.label, [
    this.leftIcon = Icons.add,
    this.filled = false,
    this.flat = false,
    this.rightIcon,
    this.background,
    this.color,
    this.onClick,
  ]);
}
