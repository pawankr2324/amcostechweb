// lib/core/widgets/sideNavbar/components/side_nav_footer.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/cubit/side_nav_cubit.dart';

/// SideNavFooter
/// ---------------------------------------------------------------------------
/// Sticky footer for the side navigation.
/// - Expanded: shows "Manage Project" (icon + label)
/// - Collapsed: shows icon-only with a tooltip
class SideNavFooter extends StatelessWidget {
  const SideNavFooter({super.key});

  static const double _kHPad = 12.0;
  static const double _kVPad = 12.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isCollapsed = context.select((SideNavCubit c) => c.isCollapsed);

    return Container(
      padding: const EdgeInsets.fromLTRB(_kHPad, 8, _kHPad, _kVPad),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant, width: 1)),
      ),
      child:
          isCollapsed
              // Collapsed: icon-only with tooltip (centered)
              ? Center(
                child: Tooltip(
                  message: 'Manage Project',
                  child: InkWell(
                    onTap: () {
                      // TODO: wire action later
                    },
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.settings_suggest_outlined,
                        size: 22,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                ),
              )
              // Expanded: icon + label button (left-aligned)
              : TextButton.icon(
                onPressed: () {
                  // TODO: wire action later
                },
                icon: const Icon(Icons.settings_suggest_outlined),
                label: Text(
                  'Manage Project',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  foregroundColor: scheme.onSurface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
    );
  }
}
