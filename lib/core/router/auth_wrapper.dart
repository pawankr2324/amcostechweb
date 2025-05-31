// lib/core/auth/auth_wrapper.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/logic/user_cubit/user_cubit.dart';
import 'package:authentication/logic/user_cubit/user_state.dart';
import 'package:amcostechweb/core/pages/home_page.dart';
import 'package:amcostechweb/core/auth/screens/phone_auth_screen.dart';

/// AuthWrapper is now the “root” screen (path '/').
/// It decides whether to show HomePage (if authenticated)
/// or PhoneAuthScreen (if not).
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          // If user is authenticated, go to HomePage
          return const HomePage();
        }
        // Otherwise show PhoneAuthScreen
        return const PhoneAuthScreen();
      },
    );
  }
}
