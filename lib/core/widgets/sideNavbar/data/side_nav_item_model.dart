import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// SideNavItemModel
/// ----------------------------------------------------------------------------
/// Represents a single item in the side navigation.
/// Supports optional children for inline submenus (accordions/flyouts).
class SideNavItemModel extends Equatable {
  /// Visible label of the item (used for semantics and tooltips as well).
  final String menuItemLabel;

  /// Leading icon to display.
  final IconData icon;

  /// Route name/path to navigate to when this item (or its child) is tapped.
  /// If this item has [children], you may choose not to navigate on parent tap.
  final String route;

  /// Optional tiny dot indicator for "new/unread" status.
  final bool showDot;

  /// Optional badge text (e.g., "Beta") shown next to the label.
  /// Use null for no badge.
  final String? badgeText;

  /// Optional submenu items. If non-empty, this item is considered expandable.
  final List<SideNavItemModel>? children;

  const SideNavItemModel({
    required this.menuItemLabel,
    required this.icon,
    required this.route,
    this.showDot = false,
    this.badgeText,
    this.children,
  });

  /// Convenience: whether this item has submenu children.
  bool get hasChildren => (children != null && children!.isNotEmpty);

  @override
  List<Object?> get props => [
    menuItemLabel,
    icon,
    route,
    showDot,
    badgeText,
    // Flatten children to achieve deep equality with Equatable.
    if (children != null) ...children!,
  ];

  SideNavItemModel copyWith({
    String? menuItemLabel,
    IconData? icon,
    String? route,
    bool? showDot,
    String? badgeText,
    List<SideNavItemModel>? children,
  }) {
    return SideNavItemModel(
      menuItemLabel: menuItemLabel ?? this.menuItemLabel,
      icon: icon ?? this.icon,
      route: route ?? this.route,
      showDot: showDot ?? this.showDot,
      badgeText: badgeText ?? this.badgeText,
      children: children ?? this.children,
    );
  }
}
