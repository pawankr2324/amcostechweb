import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repository.dart';

/// Firebase implementation of [AuthRepository], leveraging FirebaseAuth's built-in
/// phone verification callbacks and methods.
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  /// If [firebaseAuth] is not provided, uses the default FirebaseAuth instance.
  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> initialize() async {
    // Firebase is already initialized in `main()`
    return;
  }

  @override
  Stream<User?> authStateChanges() =>
      // Forward Firebase auth state changes.
      _firebaseAuth.authStateChanges();

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 60),
  }) {
    // Trigger Firebase phone number verification.
    return _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: timeout,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<UserCredential> signInWithCredential(PhoneAuthCredential credential) {
    // Sign in the user with the given credential.
    return _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() =>
      // Sign out the user.
      _firebaseAuth.signOut();
}
