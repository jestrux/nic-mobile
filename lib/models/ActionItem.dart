import 'package:flutter/material.dart';
import 'package:nic/models/ActionButton.dart';

enum ActionItemShape { regular, square, portrait, rounded, video }

class ActionItem {
  final String label;
  final String? image;
  final Color? background;
  final dynamic icon;
  final ActionItemShape? shape;
  final bool? flat;
  final String? description;
  final ActionButton? action;
  late dynamic trailing;
  final dynamic leading;
  final VoidCallback? onClick;

  ActionItem({
    required this.label,
    this.icon,
    this.image,
    this.description,
    this.shape,
    this.background,
    this.flat,
    this.action,
    this.leading,
    this.trailing,
    this.onClick,
  });
}
