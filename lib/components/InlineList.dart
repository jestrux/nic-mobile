import 'package:flutter/material.dart';
import 'package:nic/components/EmptyState.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class InlineList extends StatelessWidget {
  final String? title;
  final ActionButton? titleAction;
  final List<ActionItem> data;
  final String? bottomLabel;
  final ActionButton? bottomAction;
  final dynamic leading;
  final bool? hasCustomActions;

  const InlineList({
    this.title,
    this.titleAction,
    required this.data,
    this.bottomLabel,
    this.bottomAction,
    this.leading,
    this.hasCustomActions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          SectionTitle(
            title: title!,
            action: titleAction,
          ),
          SizedBox(height: titleAction != null ? 0 : 4),
        ],
        Container(
          decoration: BoxDecoration(
            // color: colorScheme(context).background,
            color: colorScheme(context).surfaceVariant.withOpacity(0.25),
            border: Border.all(
              width: 0.6,
              color: colorScheme(context).outlineVariant,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data
                .asMap()
                .map(
                  (i, item) {
                    var entry = item.cloneWith(
                      onClick: item.onClick ??
                          (item.resourceUrl != null
                              ? () => openUrl(item.resourceUrl!)
                              : null),
                    );

                    List<Widget> trailingWidgets = [
                      if (entry.value != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1, right: 2),
                          child: Text(
                            entry.value!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      if (entry.onClick != null)
                        const Opacity(
                          opacity: 0.5,
                          child: Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                        )
                    ];

                    entry = entry.cloneWith(
                      leading: entry.leading == null && leading != null
                          ? leading
                          : null,
                      trailing: trailingWidgets.isNotEmpty
                          ? Row(children: trailingWidgets)
                          : null,
                    );

                    return MapEntry(
                      i,
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 0.12,
                              color: i < data.length - 1
                                  ? colorScheme(context).onBackground
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        child: ListItem.fromAction(
                          entry,
                          flat: true,
                          hasCustomActions: hasCustomActions,
                        ),
                      ),
                    );
                  },
                )
                .values
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (bottomLabel != null)
              Text(
                bottomLabel!,
                style: const TextStyle(fontSize: 12),
              ),
            const SizedBox(),
            if (bottomAction != null)
              MiniButton.fromAction(
                bottomAction!,
                onClick: () {
                  if (bottomAction!.onClick == null) return;
                  bottomAction!.onClick!("");
                },
              ),
          ],
        ),
      ],
    );
  }
}

class InlineListBuilder extends StatefulWidget {
  final String? title;
  final ActionButton? titleAction;
  final EdgeInsets? padding;
  final String? emptyStateMessage;
  final int? limit;
  final Widget Function(ActionItem item)? itemBuilder;
  final dynamic Function(ActionItem item)? iconBuilder;
  final List<Widget>? Function(ActionItem item)? actionsBuilder;
  final Future<List<Map<String, dynamic>>?> Function() future;

  const InlineListBuilder({
    required this.future,
    this.padding,
    this.title,
    this.titleAction,
    this.emptyStateMessage,
    this.itemBuilder,
    this.iconBuilder,
    this.actionsBuilder,
    this.limit,
    Key? key,
  }) : super(key: key);

  @override
  State<InlineListBuilder> createState() => _InlineListBuilderState();
}

class _InlineListBuilderState extends State<InlineListBuilder> {
  Key key = GlobalKey();
  String status = "idle";
  List<Map<String, dynamic>>? data;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      status = "loading";
    });

    var res = await widget.future();

    setState(() {
      data = res;
      status = "idle";
    });
  }

  Widget? _buildActions(ActionItem item) {
    if (widget.actionsBuilder == null) return null;

    List<Widget>? itemActions = widget.actionsBuilder!(item);

    if (itemActions == null) return null;

    return Row(
      children: itemActions
          .map(
            (action) => Padding(
              padding: const EdgeInsets.only(left: 6, right: 4),
              child: action,
            ),
          )
          .toList(),
    );
  }

  Widget buildNonContent() {
    Widget? nonContentScreen;
    if (status == "loading") {
      nonContentScreen = const PlaceholderLoader();
    } else if (data == null) {
      nonContentScreen = EmptyState(
        message: "Failed to load data...",
        action: ActionButton.flat(
          "Retry",
          onClick: (d) => fetchData(),
        ),
      );
    } else {
      nonContentScreen = EmptyState(
        message: widget.emptyStateMessage,
      );
    }

    if (widget.title == null) return nonContentScreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) SectionTitle(title: widget.title!),
        const SizedBox(height: 4),
        nonContentScreen,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (status == "loading" || data == null || data!.isEmpty) {
      return buildNonContent();
    }

    var content = data!.map((entry) {
      var item = ActionItem(
        id: entry["id"],
        label: entry["title"],
        description: entry["description"],
        onClick: entry["onClick"],
        trailing: entry["trailing"],
        extraData: entry,
      );

      return item.cloneWith(
        leading: widget.iconBuilder == null ? null : widget.iconBuilder!(item),
        trailing: _buildActions(item),
      );
    }).toList();

    bool hasLimit = widget.limit != null && content.length > widget.limit!;

    var list = widget.itemBuilder != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                (hasLimit ? content.take(widget.limit!).toList() : content)
                    .map(
                      (action) => widget.itemBuilder!(action),
                    )
                    .toList(),
          )
        : InlineList(
            hasCustomActions: widget.actionsBuilder != null,
            data: (hasLimit ? content.take(widget.limit!).toList() : content),
            title: widget.title,
            titleAction: widget.titleAction,
            bottomLabel:
                !hasLimit ? null : "+${content.length - widget.limit!} more",
            bottomAction: !hasLimit
                ? null
                : ActionButton.all(
                    "View all",
                    onClick: (p0) {
                      openGenericPage(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 40,
                          left: 16,
                          right: 16,
                        ),
                        title: widget.title,
                        child: InlineListBuilder(
                          iconBuilder: widget.iconBuilder,
                          actionsBuilder: widget.actionsBuilder,
                          future: () async {
                            return data!;
                          },
                        ),
                      );
                    },
                  ),
          );

    if (widget.padding == null) return list;

    return Padding(
      padding: widget.padding!,
      child: list,
    );
  }
}
