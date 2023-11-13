import 'package:flutter/material.dart';
import 'package:nic/models/ActionButton.dart';

enum ActionItemShape { regular, square, portrait, rounded, video }

class ActionItem {
  final String label;
  final String? image;
  final String? resourceUrl;
  final Color? background;
  final dynamic icon;
  late ActionItemShape? shape;
  final bool? flat;
  final String? description;
  final ActionButton? action;
  late dynamic trailing;
  late dynamic leading;
  String? value;
  late void Function(dynamic)? onClick;

  ActionItem({
    required this.label,
    this.icon,
    this.image,
    this.resourceUrl,
    this.description,
    this.shape,
    this.background,
    this.flat,
    this.action,
    this.leading,
    this.trailing,
    this.value,
    this.onClick,
  });
}
