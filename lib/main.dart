import 'package:amcostechweb/core/my_app.dart';
import 'package:authentication/authentication.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:userdata/userdata.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Create a single instance of FirebaseAuthRepository to share between cubits
  final firebaseAuthRepository = FirebaseAuthRepository();
  final userdataRepository = FirebaseUserdataRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        // 1) UserCubit listens directly to FirebaseAuth (no repository here).
        BlocProvider<UserCubit>(create: (context) => UserCubit()),

        // 2) PhoneAuthCubit needs an AuthRepository (FirebaseAuthRepository).
        BlocProvider<PhoneAuthCubit>(
          create: (context) => PhoneAuthCubit(firebaseAuthRepository),
        ),

        BlocProvider<UserdataCubit>(
          create:
              (context) =>
                  UserdataCubit(userdataRepository: userdataRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
