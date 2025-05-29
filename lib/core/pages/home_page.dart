// File: lib/core/pages/home.dart

import 'package:amcostechweb/core/utils/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/logic/user_cubit/user_cubit.dart';
import 'package:authentication/logic/user_cubit/user_state.dart';
import 'package:amcostechweb/core/utils/theme/app_theme.dart';

/// The main landing page after a successful login.
///
/// Shows a responsive layout with an AppBar and navigation drawer,
/// and placeholder content in the body.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold with AppBar and Drawer
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: AppTheme.textStyles.titleLarge),
        elevation: 0,
        backgroundColor: AppTheme.colors.primary,
      ),
      drawer: _buildDrawer(context),
      // Body switches between layouts based on screen size
      body: ResponsiveLayout(
        mobile: _buildMobileBody(context),
        tablet: _buildTabletBody(context),
        desktop: _buildDesktopBody(context),
      ),
    );
  }

  /// Builds the navigation drawer with Profile and Logout options.
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppTheme.colors.primary),
            child: Text(
              'Menu',
              style: AppTheme.textStyles.titleLarge.copyWith(
                color: AppTheme.colors.onPrimary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text('Profile', style: AppTheme.textStyles.bodyMedium),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('Logout', style: AppTheme.textStyles.bodyMedium),
            onTap: () {
              // Trigger sign-out in UserCubit
              context.read<UserCubit>().signOut();
              // Navigate back to login
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }

  /// Mobile layout: full-width, padded column.
  Widget _buildMobileBody(BuildContext context) {
    final userName = _extractUserName(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome, $userName!', style: AppTheme.textStyles.titleLarge),
          const SizedBox(height: 24),
          Expanded(
            child: Center(
              child: Text(
                'Your main content goes here.',
                style: AppTheme.textStyles.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tablet layout: center within a max width.
  Widget _buildTabletBody(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: _buildMobileBody(context),
      ),
    );
  }

  /// Desktop layout: center within a wider max width.
  Widget _buildDesktopBody(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: _buildMobileBody(context),
      ),
    );
  }

  /// Reads the current user from [UserCubit] and returns a display name.
  String _extractUserName(BuildContext context) {
    final state = context.watch<UserCubit>().state;
    if (state is UserLoaded) {
      // Prefer displayName, fallback to phoneNumber
      return state.user.displayName ?? state.user.phoneNumber ?? 'User';
    }
    return 'User';
  }
}
