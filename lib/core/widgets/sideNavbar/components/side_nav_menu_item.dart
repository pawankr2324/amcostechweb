import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/cubit/side_nav_cubit.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/data/side_nav_item_model.dart';

/// SideNavMenuItem
/// ---------------------------------------------------------------------------
/// Simple (non-expandable) row that adapts to collapsed/expanded states:
/// - Expanded: icon + label
/// - Collapsed: icon-only with a tooltip
/// Routing/selection will be added in a later step.
class SideNavMenuItem extends StatelessWidget {
  const SideNavMenuItem({super.key, required this.item});

  final SideNavItemModel item;

  static const double _kHPad = 12.0;
  static const double _kTileRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final isCollapsed = context.select((SideNavCubit c) => c.isCollapsed);

    final tile = ListTile(
      dense: true,
      minVerticalPadding: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: _kHPad),
      leading: Icon(item.icon),
      title:
          isCollapsed
              ? null
              : Text(
                item.menuItemLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodyMedium,
              ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_kTileRadius),
      ),
      onTap: () {
        // Navigation comes later.
      },
    );

    // In collapsed mode, wrap with a tooltip so users can still discover labels.
    return isCollapsed
        ? Tooltip(message: item.menuItemLabel, child: tile)
        : Semantics(label: item.menuItemLabel, button: true, child: tile);
  }
}
