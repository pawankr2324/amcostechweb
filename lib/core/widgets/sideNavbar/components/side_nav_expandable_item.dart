import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/cubit/side_nav_cubit.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/data/side_nav_item_model.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/components/side_nav_subitem_tile.dart';

/// SideNavExpandableItem
/// ---------------------------------------------------------------------------
/// Parent row with a trailing chevron and an inline, animated submenu.
/// Behavior:
/// - If the rail is COLLAPSED: tapping the parent expands the rail (no submenu).
/// - If the rail is EXPANDED: tapping the parent toggles the submenu.
class SideNavExpandableItem extends StatefulWidget {
  const SideNavExpandableItem({
    super.key,
    required this.parent,
    this.initiallyExpanded = false,
    this.childrenIndent = 40.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  final SideNavItemModel parent;
  final bool initiallyExpanded;
  final double childrenIndent;
  final Duration animationDuration;
  final Curve animationCurve;

  @override
  State<SideNavExpandableItem> createState() => _SideNavExpandableItemState();
}

class _SideNavExpandableItemState extends State<SideNavExpandableItem>
    with SingleTickerProviderStateMixin {
  late bool _expanded;

  static const double _kHPad = 12.0;
  static const double _kTileRadius = 12.0;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final isCollapsed = context.select((SideNavCubit c) => c.isCollapsed);

    final children = widget.parent.children ?? const <SideNavItemModel>[];

    // Parent row
    final parentTile = ListTile(
      dense: true,
      minVerticalPadding: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: _kHPad),
      leading: Icon(widget.parent.icon),
      title:
          isCollapsed
              ? null
              : Text(
                widget.parent.menuItemLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodyMedium,
              ),
      trailing: isCollapsed ? null : _Chevron(expanded: _expanded),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_kTileRadius),
      ),
      onTap: () {
        if (isCollapsed) {
          // In collapsed mode, expand the rail first.
          context.read<SideNavCubit>().expand();
        } else {
          // In expanded mode, toggle inline submenu.
          _toggle();
        }
      },
    );

    return Column(
      children: [
        // Tooltip helps discoverability in collapsed state.
        isCollapsed
            ? Tooltip(message: widget.parent.menuItemLabel, child: parentTile)
            : Semantics(
              label: widget.parent.menuItemLabel,
              button: true,
              onTapHint: _expanded ? 'Collapse' : 'Expand',
              child: parentTile,
            ),

        // Inline submenu only when rail is expanded AND parent is expanded.
        AnimatedSize(
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          alignment: Alignment.topCenter,
          child:
              (!isCollapsed && _expanded && children.isNotEmpty)
                  ? _ChildrenColumn(
                    children: children,
                    indent: widget.childrenIndent,
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron({required this.expanded});
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Icon(
      expanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
      size: 20,
    );
  }
}

class _ChildrenColumn extends StatelessWidget {
  const _ChildrenColumn({required this.children, required this.indent});

  final List<SideNavItemModel> children;
  final double indent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < children.length; i++) ...[
          SideNavSubitemTile(item: children[i], indent: indent),
          if (i != children.length - 1) const SizedBox(height: 2),
        ],
      ],
    );
  }
}
