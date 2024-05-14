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
  final Map<String, dynamic>? extraData;
  final Function? onClick;
  final String? tag;

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
    this.extraData,
    this.onClick,
    this.tag,
  });

  ActionItem cloneWith({
    ActionItemShape? shape,
    Color? background,
    leading,
    trailing,
    String? value,
    Map<String, dynamic>? extraData,
    Function? onClick,
  }) =>
      ActionItem(
        id: id,
        label: label,
        icon: icon,
        image: image,
        resourceUrl: resourceUrl,
        description: description,
        flat: flat,
        action: action,
        shape: shape ?? this.shape,
        background: background ?? this.background,
        value: value ?? this.value,
        leading: leading ?? this.leading,
        trailing: trailing ?? this.trailing,
        extraData: extraData ?? this.extraData,
        tag: tag,
        onClick: onClick ?? this.onClick,
      );
}
