import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/cubit/side_nav_cubit.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/data/side_nav_item_model.dart';

/// SideNavSubitemTile
/// ---------------------------------------------------------------------------
/// Indented child tile under an expandable parent (e.g., Campaigns → Broadcast).
/// Adapts to collapsed/expanded rail:
/// - Expanded: icon + label (+ optional badge/dot)
/// - Collapsed: icon-only with a tooltip
class SideNavSubitemTile extends StatelessWidget {
  const SideNavSubitemTile({super.key, required this.item, this.indent = 40.0});

  final SideNavItemModel item;
  final double indent;

  static const double _kTileRadius = 10.0;
  static const double _kHPad = 12.0;
  static const double _kGap = 8.0;
  static const double _kDot = 6.0;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isCollapsed = context.select((SideNavCubit c) => c.isCollapsed);

    final resolvedIndent = isCollapsed ? 0.0 : indent;

    final tile = Padding(
      padding: EdgeInsets.only(left: resolvedIndent),
      child: ListTile(
        dense: true,
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: _kHPad),
        leading: Icon(item.icon, size: 18),
        title:
            isCollapsed
                ? null
                : Row(
                  children: [
                    // Label
                    Expanded(
                      child: Text(
                        item.menuItemLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodyMedium,
                      ),
                    ),
                    // Optional badge
                    if (item.badgeText != null) ...[
                      const SizedBox(width: _kGap),
                      _BadgeChip(text: item.badgeText!),
                    ],
                    // Optional dot
                    if (item.showDot) ...[
                      const SizedBox(width: _kGap),
                      Container(
                        width: _kDot,
                        height: _kDot,
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_kTileRadius),
        ),
        onTap: () {
          // Navigation comes later.
        },
      ),
    );

    return isCollapsed
        ? Tooltip(message: item.menuItemLabel, child: tile)
        : Semantics(label: item.menuItemLabel, button: true, child: tile);
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Text(
        text,
        style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
