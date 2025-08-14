import 'package:amcostechweb/core/router/app_router.dart';
import 'package:amcostechweb/core/utils/responsive/responsive_layout.dart';
import 'package:amcostechweb/core/utils/theme/app_text_styles.dart';
import 'package:amcostechweb/core/utils/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:authentication/authentication.dart';

class AppSideDrawer extends StatelessWidget {
  const AppSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileDrawer(context),
      // tablet: _buildTabletDrawer(context),
      desktop: _buildMobileDrawer(context),
    );
  }
}

Widget _buildMobileDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: AppTheme.colors.primary),
          child: Text(
            'Welcome',
            style: AppTextStyles().titleLarge.copyWith(
              color: AppTheme.colors.onPrimary,
            ),
          ),
        ),

        ListTile(
          leading: const Icon(Icons.person),
          title: Text('Profile', style: AppTextStyles().bodyMedium),
          onTap: () {
            // close drawer then navigate
            Navigator.pop(context);
            context.go(AppRoutes.profile);
          },
        ),

        ListTile(
          leading: const Icon(Icons.logout),
          title: Text('Logout', style: AppTextStyles().bodyMedium),
          onTap: () {
            Navigator.pop(context);
            context.read<UserCubit>().signOut();
            context.go(AppRoutes.root);
          },
        ),
      ],
    ),
  );
}
