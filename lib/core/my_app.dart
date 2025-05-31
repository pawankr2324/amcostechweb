// lib/core/my_app.dart

import 'package:amcostechweb/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amcostechweb/core/utils/theme/app_theme.dart';

import 'package:authentication/logic/user_cubit/user_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Grab the UserCubit that was provided above in main.dart
    final userCubit = context.read<UserCubit>();

    // Instantiate AppRouter with that cubit
    final goRouter = AppRouter(userCubit).router;

    return MaterialApp.router(
      title: 'AmcosTech Web',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // ─── Replace “home: AuthWrapper()” and “routes: { … }” with:
      routerConfig: goRouter,
    );
  }
}
