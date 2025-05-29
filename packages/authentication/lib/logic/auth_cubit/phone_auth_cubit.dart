import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'phone_auth_state.dart';

/// Cubit handling the phone authentication flow.
class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final AuthRepository _authRepository;

  /// Creates a [PhoneAuthCubit] with the given [AuthRepository].
  PhoneAuthCubit(this._authRepository) : super(const PhoneAuthInitial());

  /// Starts phone verification, sending an SMS to [phoneNumber].
  Future<void> verifyPhone(String phoneNumber) async {
    emit(const PhoneAuthLoading());
    await _authRepository.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto sign-in on Android devices when SMS is detected.
        await _authRepository.signInWithCredential(credential);
        emit(const PhoneAuthSuccess());
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(PhoneAuthFailure(e.message ?? 'Verification failed'));
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(PhoneAuthCodeSent(verificationId));
      },
      codeAutoRetrievalTimeout: (_) {
        // Handle timeout if needed.
      },
    );
  }

  /// Submits the OTP entered by the user to complete sign-in.
  Future<void> submitOTP(String verificationId, String smsCode) async {
    emit(const PhoneAuthLoading());
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _authRepository.signInWithCredential(credential);
      emit(const PhoneAuthSuccess());
    } catch (e) {
      emit(PhoneAuthFailure(e.toString()));
    }
  }

  /// Signs out the current user and resets to initial state.
  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(const PhoneAuthInitial());
  }
}
