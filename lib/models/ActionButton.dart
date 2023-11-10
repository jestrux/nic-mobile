import 'package:flutter/material.dart';

class ActionButton {
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String label;
  final bool filled;
  final bool flat;
  final Color? color;
  final Color? background;
  final void Function(dynamic)? onClick;

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
    this.label, {
    this.rightIcon = Icons.keyboard_double_arrow_right,
    this.flat = true,
    this.filled = false,
    this.leftIcon,
    this.background,
    this.color,
    this.onClick,
  });

  ActionButton.add(
    this.label, {
    this.leftIcon = Icons.add,
    this.flat = true,
    this.filled = false,
    this.rightIcon,
    this.background,
    this.color,
    this.onClick,
  });

  ActionButton.filled(
    this.label, {
    this.filled = true,
    this.flat = false,
    this.leftIcon,
    this.rightIcon,
    this.background,
    this.color,
    this.onClick,
  });

  ActionButton.outlined(
    this.label, {
    this.filled = false,
    this.flat = false,
    this.leftIcon,
    this.rightIcon,
    this.background,
    this.color,
    this.onClick,
  });

  ActionButton.flat(
    this.label, {
    this.flat = true,
    this.filled = false,
    this.leftIcon,
    this.rightIcon,
    this.background,
    this.color,
    this.onClick,
  });
}
