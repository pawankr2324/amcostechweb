// lib/core/widgets/sideNavbar/side_navbar.dart
import 'package:flutter/material.dart';

import 'package:amcostechweb/core/widgets/sideNavbar/data/side_nav_items.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/components/side_nav_container.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/components/side_nav_header.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/components/side_nav_section_list.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/components/side_nav_footer.dart';

/// SideNavbar (Step 1)
/// ---------------------------------------------------------------------------
/// Composes the side navigation in expanded layout:
/// - Container chrome (width, border, surface)
/// - Header (brand + workspace stub)
/// - Scrollable body: primary section → divider → secondary section
/// - Sticky footer
///
/// NOTE:
/// - No selection/hover states yet
/// - No routing logic yet
class SideNavbar extends StatelessWidget {
  const SideNavbar({super.key});

  static const double _kHPad = 12.0;
  static const double _kSectionSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SideNavContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SideNavHeader(),
          const SizedBox(height: 8),

          // Scrollable middle content
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Primary section
                SideNavSectionList(items: primarySideNavItems),
                const SizedBox(height: _kSectionSpacing),

                // Divider
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _kHPad),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: scheme.outlineVariant,
                  ),
                ),
                const SizedBox(height: _kSectionSpacing),

                // Secondary section
                SideNavSectionList(items: secondarySideNavItems),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Sticky footer
          const SideNavFooter(),
        ],
      ),
    );
  }
}
