import 'package:flutter/material.dart';
import 'package:nic/components/ActionCard.dart';

class PageSection extends StatelessWidget {
  final EdgeInsets? padding;
  final String? title;
  final List<Map<String, dynamic>>? actions;
  final ActionCardShape? shape;
  final MaterialColor? theme;
  final int? columns;
  const PageSection({
    Key? key,
    this.padding,
    this.title,
    this.actions,
    this.shape,
    this.theme,
    this.columns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultPadding = EdgeInsets.zero;
    // var defaultPadding = const EdgeInsets.symmetric(horizontal: 16);

    Widget buildActions({
      required List<Map<String, dynamic>> actions,
      ActionCardShape? shape,
      int? columns,
      MaterialColor? theme,
    }) {
      bool video = shape == ActionCardShape.video;
      bool rounded = shape == ActionCardShape.rounded;
      bool portrait = shape == ActionCardShape.portrait;

      var shapeMap = {
        ActionCardShape.rounded: 1 / 0.26,
        ActionCardShape.square: 1 / 1,
        ActionCardShape.portrait: 1 / 1.3,
        ActionCardShape.video: 16 / 12,
        ActionCardShape.regular: 1 / 0.32,
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
              shapeMap[shape] ?? shapeMap[ActionCardShape.regular]!,
        ),
        children: actions
            .map(
              (action) => ActionCard(
                action: action,
                themeColor: theme,
                shape: shape,
              ),
            )
            .toList(),
      );
    }

    Widget buildCardSection({
      EdgeInsets? padding,
      String? title,
      actions,
      ActionCardShape? shape,
      MaterialColor? theme,
      int? columns,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            SectionTitle(
              title: title,
              padding: padding ?? defaultPadding,
            ),
            const SizedBox(height: 4),
          ],
          buildActions(
            actions: actions,
            shape: shape,
            theme: theme,
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

  const SectionTitle({
    required this.title,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
