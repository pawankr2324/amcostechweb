// File: lib/core/auth/user_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/logic/user_cubit/user_cubit.dart';
import 'package:authentication/logic/user_cubit/user_state.dart';
import 'package:amcostechweb/core/utils/theme/app_theme.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UserCubit>().state;

    // Show loading until user is loaded
    if (state is! UserLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final user = state.user;
    final initials = _getInitials(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppTheme.textStyles.titleLarge),
        backgroundColor: AppTheme.colors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.colors.accent,
              child: Text(
                initials,
                style: AppTheme.textStyles.avatar.copyWith(
                  color: AppTheme.colors.onAccent,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('UID: ${user.uid}', style: AppTheme.textStyles.subtitle),
            const SizedBox(height: 8),
            Text(
              'Phone: ${user.phoneNumber ?? 'N/A'}',
              style: AppTheme.textStyles.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.colors.primary,
              ),
              onPressed: () {
                context.read<UserCubit>().signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  /// Extracts initials from the user's display name or phone/UID.
  String _getInitials(user) {
    final name = user.displayName ?? user.phoneNumber ?? user.uid;
    final parts = name.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }
}
