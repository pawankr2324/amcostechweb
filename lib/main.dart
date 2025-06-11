import 'package:amcostechweb/core/my_app.dart';
import 'package:authentication/authentication.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:userdata/userdata.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 2️⃣ Auth repo as before
  final firebaseAuthRepository = FirebaseAuthRepository();

  // 3️⃣ Local cache layer
  final localDs = LocalUserDataSource();

  // 4️⃣ Userdata repo wired with cache
  final userdataRepository = FirebaseUserdataRepository(
    localDataSource: localDs,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        // Auth cubit
        BlocProvider<UserCubit>(create: (_) => UserCubit()),

        // Phone‐auth cubit
        BlocProvider<PhoneAuthCubit>(
          create: (_) => PhoneAuthCubit(firebaseAuthRepository),
        ),

        // Userdata cubit (now seeded from cache + live updates)
        BlocProvider<UserdataCubit>(
          create: (_) => UserdataCubit(userdataRepository: userdataRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
