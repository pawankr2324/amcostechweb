// lib/core/router/app_router.dart

import 'dart:async';
import 'package:amcostechweb/core/auth/screens/user_profile_screen.dart';
import 'package:amcostechweb/core/router/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:amcostechweb/core/auth/screens/otp_screen.dart';
import 'package:amcostechweb/core/pages/home_page.dart';
import 'package:authentication/authentication.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// 1) Route‐name constants. Add new screens here as needed.
/// ─────────────────────────────────────────────────────────────────────────────
class AppRoutes {
  AppRoutes._();

  /// “/” renders AuthWrapper (chooses PhoneAuthScreen or HomePage).
  static const String root = '/';

  /// “/otp” expects a query parameter “verificationId”.
  static const String otp = '/otp';

  /// “/home” for the HomePage (only if authenticated).
  static const String home = '/home';

  /// “/profile” for the UserProfileScreen (only if authenticated).
  static const String profile = '/profile';

  // Example for future:
  // static const String settings = '/settings';
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 2) UserChangeNotifier bridges UserCubit.stream → ChangeNotifier so GoRouter
///    re‐evaluates redirect whenever auth state changes.
/// ─────────────────────────────────────────────────────────────────────────────
class UserChangeNotifier extends ChangeNotifier {
  final UserCubit _userCubit;
  late final StreamSubscription _subscription;

  UserChangeNotifier(this._userCubit) {
    // Whenever the cubit emits a new state, call notifyListeners().
    _subscription = _userCubit.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 3) AppRouter: constructs a GoRouter with redirect logic and routes.
/// ─────────────────────────────────────────────────────────────────────────────
class AppRouter {
  final UserCubit _userCubit;
  late final UserChangeNotifier _notifier = UserChangeNotifier(_userCubit);

  AppRouter(this._userCubit);

  /// Expose the configured GoRouter instance.
  late final GoRouter router = GoRouter(
    // Whenever _notifier calls notifyListeners(), GoRouter re‐runs redirect().
    refreshListenable: _notifier,

    // Start at "/" (AuthWrapper).
    initialLocation: AppRoutes.root,

    /// Redirect logic based on authentication state.
    redirect: (BuildContext context, GoRouterState state) {
      final bool isLoggedIn = _userCubit.state is UserLoaded;

      // In v15, use state.uri.path (no query parameters)
      final String currentPath = state.uri.path;

      // Are we on the sign‐in flow? ("/" or "/otp")
      final bool onSignInFlow =
          (currentPath == AppRoutes.root || currentPath == AppRoutes.otp);

      // 1) If NOT logged in but trying to go to a protected route:
      if (!isLoggedIn && !onSignInFlow) {
        return AppRoutes.root;
      }

      // 2) If logged in but still on "/" or "/otp", send to "/home"
      if (isLoggedIn && onSignInFlow) {
        return AppRoutes.home;
      }

      // 3) Otherwise, no redirect
      return null;
    },

    /// Define all your routes here, referencing only existing screens/imports.
    routes: <GoRoute>[
      /// (1) "/" → AuthWrapper (which picks between PhoneAuthScreen & HomePage).
      GoRoute(
        path: AppRoutes.root,
        builder: (context, state) => const AuthWrapper(),
      ),

      /// (2) "/otp" → OTPScreen, passing "verificationId" from queryParameters.
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final String verificationId =
              state.uri.queryParameters['verificationId'] ?? '';
          return OTPScreen(verificationId: verificationId);
        },
      ),

      /// (3) "/home" → HomePage (protected by redirect logic).
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),

      /// (4) "/profile" → UserProfileScreen (protected).
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const UserProfileScreen(),
      ),

      // ────────────────────────────────────────────────────────────────────────
      // Example: If you later add SettingsScreen:
      //
      //  1. In AppRoutes: static const String settings = '/settings';
      //
      //  2. Here add:
      //      GoRoute(
      //        path: AppRoutes.settings,
      //        builder: (ctx, st) => const SettingsScreen(),
      //      ),
      //
      //  3. Navigate with:
      //      context.go(AppRoutes.settings);
      //
      // Import “SettingsScreen” above when you add it.
      // ────────────────────────────────────────────────────────────────────────
    ],
  );
}
