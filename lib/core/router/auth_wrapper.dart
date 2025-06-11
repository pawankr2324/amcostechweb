import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/authentication.dart';
import 'package:amcostechweb/core/pages/home_page.dart';
import 'package:amcostechweb/core/auth/screens/phone_auth_screen.dart';

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
