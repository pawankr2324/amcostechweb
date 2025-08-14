import 'package:amcostechweb/core/utils/constants/assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/cubit/side_nav_cubit.dart';

/// SideNavHeader
/// ---------------------------------------------------------------------------
/// Header for the side navigation:
/// - Brand row (logo + optional title)
/// - Compact collapse/expand toggle "nub" that sits on the right border
/// - Workspace selector stub (hidden when collapsed)
class SideNavHeader extends StatelessWidget {
  const SideNavHeader({
    super.key,
    this.title = 'AMCOS TECH',
    this.workspaceName = 'Workspace',
    this.brandLogo = AssetsImage.amcosTechLogo,
  });

  final String title;
  final String workspaceName;
  final String brandLogo;

  static const double _kHPad = 12.0;
  static const double _kVPad = 12.0;
  static const double _kHeaderGap = 10.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isCollapsed = context.select((SideNavCubit c) => c.isCollapsed);

    return Padding(
      padding: const EdgeInsets.fromLTRB(_kHPad, _kVPad, _kHPad, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand row with an overhanging toggle button on the right edge.
          SizedBox(
            height: 32, // enough to vertically center avatar + toggle
            child: Stack(
              clipBehavior:
                  Clip.none, // allow the toggle to hang past the border
              children: [
                // Brand at the left
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: scheme.primary,
                        child: Image.asset(brandLogo),
                      ),
                      if (!isCollapsed) ...[
                        const SizedBox(width: 8),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Toggle "nub" on the right border, slightly offset outward
                Positioned(
                  right: -20, // overhang beyond the rail's right border
                  top: 0,
                  bottom: 0,
                  child: _BorderNubToggle(isCollapsed: isCollapsed),
                ),
              ],
            ),
          ),

          // Workspace selector (hidden when collapsed)
          if (!isCollapsed) ...[
            const SizedBox(height: _kHeaderGap),
            Semantics(
              label: 'Workspace selector',
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock_outline, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        workspaceName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BorderNubToggle extends StatelessWidget {
  const _BorderNubToggle({required this.isCollapsed});
  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: isCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.read<SideNavCubit>().toggle(),
          customBorder: const CircleBorder(),
          child: Container(
            width: 24, // compact size
            height: 24, // compact size
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              shape: BoxShape.circle,
              // border: Border.all(color: scheme.outlineVariant),
              boxShadow: [
                // subtle lift so it feels like a handle on the edge
                BoxShadow(
                  color: scheme.shadow.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              isCollapsed ? Icons.chevron_right : Icons.chevron_left,
              size: 18, // smaller icon to match the compact nub
              color: scheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
