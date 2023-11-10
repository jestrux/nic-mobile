import 'package:flutter/material.dart';
import 'package:nic/components/ActionCard.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';

class PageSection extends StatelessWidget {
  final EdgeInsets? padding;
  final String? title;
  final ActionButton? titleAction;
  final List<ActionItem>? actions;
  final ActionItemShape? shape;
  final int? columns;
  const PageSection({
    Key? key,
    this.padding,
    this.title,
    this.titleAction,
    this.actions,
    this.shape,
    this.columns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultPadding = EdgeInsets.zero;
    // var defaultPadding = const EdgeInsets.symmetric(horizontal: 16);

    Widget buildActions({
      required List<ActionItem> actions,
      ActionItemShape? shape,
      int? columns,
    }) {
      bool video = shape == ActionItemShape.video;
      bool rounded = shape == ActionItemShape.rounded;

      var shapeMap = {
        ActionItemShape.rounded: 1 / 0.26,
        ActionItemShape.square: 1 / 1,
        ActionItemShape.portrait: 1 / 1.4,
        ActionItemShape.video: 16 / 12,
        ActionItemShape.regular: 1 / 0.32,
      };

      return GridView(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: padding ?? defaultPadding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: rounded
              ? 6
              : video
                  ? 10
                  : 8,
          mainAxisSpacing: video ? 10 : 8,
          crossAxisCount: columns ?? 2,
          childAspectRatio:
              shapeMap[shape] ?? shapeMap[ActionItemShape.regular]!,
        ),
        children: actions
            .map(
              (action) => ActionCard(action: action),
            )
            .toList(),
      );
    }

    Widget buildCardSection({
      EdgeInsets? padding,
      String? title,
      actions,
      ActionItemShape? shape,
      int? columns,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            SectionTitle(
              title: title,
              action: titleAction,
              padding: padding ?? defaultPadding,
            ),
            SizedBox(height: titleAction != null ? 0 : 4),
          ],
          buildActions(
            actions: actions,
            shape: shape,
            columns: columns,
          ),
        ],
      );
    }

    return buildCardSection(
      padding: padding,
      title: title,
      actions: actions,
      shape: shape,
      columns: columns,
    );
  }
}

class SectionTitle extends StatelessWidget {
  final EdgeInsets? padding;
  final String title;
  final ActionButton? action;

  const SectionTitle({
    required this.title,
    this.padding,
    this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Spacer(),
          if (action != null) MiniButton(action: action!),
        ],
      ),
    );
  }
}
