// lib/core/widgets/sideNavbar/components/side_nav_section_list.dart
import 'package:flutter/material.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/data/side_nav_item_model.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/components/side_nav_menu_item.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/components/side_nav_expandable_item.dart';

/// SideNavSectionList
/// ----------------------------------------------------------------------------
/// Renders a vertical section of side-nav items with consistent padding.
/// If an item has children, it renders an expandable parent with an inline
/// submenu; otherwise it renders a simple menu tile.
class SideNavSectionList extends StatelessWidget {
  const SideNavSectionList({
    super.key,
    required this.items,
    this.horizontalPadding = 12.0,
    this.itemSpacing = 2.0,
  });

  /// Items to render in this section (order matters).
  final List<SideNavItemModel> items;

  /// Left/right padding around the section.
  final double horizontalPadding;

  /// Vertical spacing between tiles.
  final double itemSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            items[i].hasChildren
                ? SideNavExpandableItem(parent: items[i])
                : SideNavMenuItem(item: items[i]),
            if (i != items.length - 1) SizedBox(height: itemSpacing),
          ],
        ],
      ),
    );
  }
}
