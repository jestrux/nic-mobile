import 'package:flutter/material.dart';
import 'package:nic/models/ActionButton.dart';

enum ActionItemShape { regular, square, portrait, rounded, video }

class ActionItem {
  final String label;
  final String? id;
  final String? image;
  final String? resourceUrl;
  final Color? background;
  final dynamic icon;
  final ActionItemShape? shape;
  final bool? flat;
  final String? description;
  final ActionButton? action;
  final dynamic trailing;
  final dynamic leading;
  final String? value;
  final Function? onClick;

  ActionItem({
    required this.label,
    this.id,
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

  cloneWith({
    ActionItemShape? shape,
    leading,
    trailing,
    String? value,
    Function? onClick,
  }) =>
      ActionItem(
        id: id,
        label: label,
        icon: icon,
        image: image,
        resourceUrl: resourceUrl,
        description: description,
        background: background,
        flat: flat,
        action: action,
        shape: shape ?? this.shape,
        value: value ?? this.value,
        leading: leading ?? this.leading,
        trailing: trailing ?? this.trailing,
        onClick: onClick ?? this.onClick,
      );
}
