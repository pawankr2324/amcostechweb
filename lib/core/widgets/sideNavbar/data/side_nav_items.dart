import 'package:flutter/material.dart';

import 'side_nav_item_model.dart';

/// Primary side-nav items (order matters).
final primarySideNavItems = <SideNavItemModel>[
  const SideNavItemModel(
    menuItemLabel: "Home",
    icon: Icons.home_outlined,
    route: "/",
  ),

  // Campaigns with submenu
  SideNavItemModel(
    menuItemLabel: "Campaigns",
    icon: Icons.campaign_outlined,
    route: "/campaigns", // parent route (can be navigable or just an expander)
    children: const [
      SideNavItemModel(
        menuItemLabel: "Broadcast",
        icon: Icons.wifi_tethering_outlined,
        route: "/campaigns/broadcast",
      ),
      SideNavItemModel(
        menuItemLabel: "Automated",
        icon: Icons.auto_awesome_motion,
        route: "/campaigns/automated",
        badgeText: "Beta",
      ),
      SideNavItemModel(
        menuItemLabel: "Guide",
        icon: Icons.menu_book_outlined,
        route: "/campaigns/guide",
      ),
    ],
  ),

  const SideNavItemModel(
    menuItemLabel: "Templates",
    icon: Icons.insert_drive_file_outlined,
    route: "/",
  ),
  const SideNavItemModel(
    menuItemLabel: "Bot Studio",
    icon: Icons.smart_toy_outlined,
    route: "/",
  ),
  const SideNavItemModel(
    menuItemLabel: "Agent Assist",
    icon: Icons.support_agent,
    route: "/",
  ),
  const SideNavItemModel(
    menuItemLabel: "Personalize",
    icon: Icons.tune_outlined,
    route: "/",
  ),
];

/// Secondary side-nav items (order matters).
final secondarySideNavItems = <SideNavItemModel>[
  const SideNavItemModel(
    menuItemLabel: "Channels",
    icon: Icons.apps_outlined,
    route: "/",
  ),
  const SideNavItemModel(
    menuItemLabel: "Integrations",
    icon: Icons.extension_outlined,
    route: "/",
  ),
  const SideNavItemModel(
    menuItemLabel: "Events",
    icon: Icons.event_outlined,
    route: "/",
  ),
  const SideNavItemModel(
    menuItemLabel: "Extensions",
    icon: Icons.open_in_new_outlined,
    route: "/",
  ),
  const SideNavItemModel(
    menuItemLabel: "Agent Assist",
    icon: Icons.support_agent,
    route: "/",
  ),
  const SideNavItemModel(
    menuItemLabel: "Personalize",
    icon: Icons.tune_outlined,
    route: "/",
  ),
];
