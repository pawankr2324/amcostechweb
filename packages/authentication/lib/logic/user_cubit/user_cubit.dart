import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_state.dart';

/// Cubit to observe Firebase authentication state and emit [UserState] updates.
class UserCubit extends Cubit<UserState> {
  final FirebaseAuth _firebaseAuth;

  /// Creates [UserCubit] that listens to [FirebaseAuth] changes.
  UserCubit({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      super(const UserInitial()) {
    // Listen to Firebase auth state changes and update state accordingly.
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(const UserEmpty());
      }
    });
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
