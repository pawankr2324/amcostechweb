import 'package:firebase_auth/firebase_auth.dart';

/// Defines the contract for authentication operations,
/// using FirebaseAuth's predefined callback types for phone verification.
abstract class AuthRepository {
  /// Initialize Firebase services. Must be called before any auth operations.
  Future<void> initialize();

  /// Stream of Firebase authentication state changes (user signed in or out).
  Stream<User?> authStateChanges();

  /// Starts phone number verification flow.
  ///
  /// Uses FirebaseAuth's callback types for handling verification steps:
  /// [verificationCompleted], [verificationFailed], [codeSent], [codeAutoRetrievalTimeout].
  ///
  /// [phoneNumber]: The phone number in international format (e.g. "+911234567890").
  /// [timeout]: Duration before auto-retrieval times out (default: 60 seconds).
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 60),
  });

  /// Signs in the user using the provided [PhoneAuthCredential].
  Future<UserCredential> signInWithCredential(PhoneAuthCredential credential);

  /// Signs out the currently authenticated user.
  Future<void> signOut();
}
