// File: lib/core/widgets/app_navbar.dart

import 'package:amcostechweb/core/router/app_router.dart';
import 'package:amcostechweb/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive/context_extensions.dart';
import '../utils/theme/app_text_styles.dart';
import '../utils/constants/assets_image.dart';
import 'package:userdata/userdata.dart';
import 'package:authentication/authentication.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _onHome(BuildContext context) => context.go(AppRoutes.home);

  void _onProfile(BuildContext context) => context.push(AppRoutes.profile);

  void _onLogout(BuildContext context) => context.read<UserCubit>().signOut();

  Widget _buildUserGreeting(BuildContext context) {
    return BlocBuilder<UserdataCubit, UserdataState>(
      builder: (ctx, state) {
        final name =
            state is UserdataLoaded
                ? (state.userdata.firstName.isNotEmpty
                    ? state.userdata.firstName
                    : 'User')
                : 'Test';
        return Text(
          'Welcome, $name',
          style: AppTextStyles().titleLarge.copyWith(color: Colors.white),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final userGreeting = _buildUserGreeting(context);

    final desktopMenu = [
      TextButton(
        onPressed: () => _onHome(context),
        child: Text('Home', style: AppTextStyles().subtitle),
      ),
      TextButton(
        onPressed: () => _onProfile(context),
        child: Text('Profile', style: AppTextStyles().subtitle),
      ),
      TextButton(
        onPressed: () => _onLogout(context),
        child: Text('Logout', style: AppTextStyles().subtitle),
      ),
    ];

    return AppBar(
      backgroundColor: AppColors().onSurface,
      leading:
          isDesktop
              ? null
              : Builder(
                builder:
                    (ctx) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
              ),
      title: Row(
        children: [
          Image.asset(AssetsImage.amcosTechLogo, height: 32),
          const SizedBox(width: 12),
          userGreeting,
        ],
      ),
      actions: isDesktop ? desktopMenu : null,
    );
  }
}
