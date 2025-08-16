import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<String> sendPhoneVerification(String phoneNumber);
  Future<UserCredential> verifySmsCode(String verificationId, String smsCode);
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
    required String captchaToken,
  });
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
}
