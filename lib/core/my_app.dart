import 'package:amcostechweb/core/utils/theme/app_theme.dart';
import 'package:authentication/logic/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:amcostechweb/core/pages/home_page.dart';

import 'package:authentication/logic/user_cubit/user_state.dart';
import 'package:amcostechweb/core/auth/screens/otp_screen.dart';
import 'package:amcostechweb/core/auth/screens/phone_auth_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The root widget of the app.
///
/// Applies a centralized theme (from `AppTheme`) and delegates navigation
/// to the [GoRouter] instance defined in `AppRouter.router`.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmcosTech Web',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthWrapper(),
      routes: {
        '/otp': (_) => const OTPScreen(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return const HomePage();
        }
        return const PhoneAuthScreen();
      },
    );
  }
}
