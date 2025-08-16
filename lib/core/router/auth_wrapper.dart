// File: lib/core/router/auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication/authentication.dart';
import 'package:userdata/userdata.dart'; // ← userdata export
import 'package:amcostechweb/core/presentation/home/home_page.dart';
import 'package:amcostechweb/core/presentation/auth/screens/phone_auth_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, authState) {
        if (authState is UserLoaded) {
          // start caching + streaming profile data
          final uid = authState.user.uid;
          context.read<UserdataCubit>().subscribeToUserdata(uid);
        }
      },
      builder: (context, authState) {
        if (authState is UserLoaded) {
          // user is signed in
          return const HomePage();
        }
        // not signed in yet
        return const PhoneAuthScreen();
      },
    );
  }
}
