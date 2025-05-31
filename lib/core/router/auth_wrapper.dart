import 'package:amcostechweb/core/auth/screens/phone_auth_screen.dart';
import 'package:amcostechweb/core/pages/home_page.dart';
import 'package:authentication/logic/user_cubit/user_cubit.dart';
import 'package:authentication/logic/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
