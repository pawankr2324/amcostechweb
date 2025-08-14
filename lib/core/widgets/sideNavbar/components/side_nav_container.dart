import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amcostechweb/core/widgets/sideNavbar/cubit/side_nav_cubit.dart';

/// SideNavContainer
/// ---------------------------------------------------------------------------
/// Outer chrome for the side navigation:
/// - Applies SafeArea
/// - Animates width between expanded and collapsed based on SideNavCubit
/// - Uses theme surface color
/// - Draws a subtle right border
class SideNavContainer extends StatelessWidget {
  const SideNavContainer({super.key, required this.child});

  final Widget child;

  static const double _kExpandedWidth = 280.0;
  static const double _kCollapsedWidth = 72.0;
  static const Duration _kAnimDuration = Duration(milliseconds: 200);
  static const Curve _kAnimCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Read collapsed/expanded state from the cubit without rebuilding ancestors.
    final isCollapsed = context.select((SideNavCubit c) => c.isCollapsed);

    return SafeArea(
      child: Material(
        color: scheme.surface,
        elevation: 0,
        child: AnimatedContainer(
          duration: _kAnimDuration,
          curve: _kAnimCurve,
          width: isCollapsed ? _kCollapsedWidth : _kExpandedWidth,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: scheme.outlineVariant, width: 1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
