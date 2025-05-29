import 'package:amcostechweb/core/auth/screens/otp_screen.dart';
import 'package:amcostechweb/core/auth/screens/phone_auth_screen.dart';
import 'package:amcostechweb/core/pages/home_page.dart';
import 'package:amcostechweb/core/utils/theme/app_theme.dart';
import 'package:authentication/logic/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:authentication/repositories/firebase_auth_repository.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_cubit.dart';
import 'package:authentication/logic/user_cubit/user_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepository = FirebaseAuthRepository();
  runApp(
    MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: authRepository)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PhoneAuthCubit(authRepository)),
          BlocProvider(create: (_) => UserCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

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
