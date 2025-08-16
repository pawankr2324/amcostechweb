import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<SendPhoneCode>(_onSendPhoneCode);
    on<VerifySmsCode>(_onVerifySmsCode);
    on<SignInWithEmail>(_onSignInWithEmail);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onSendPhoneCode(
      SendPhoneCode event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final verificationId =
          await _repository.sendPhoneVerification(event.phoneNumber);
      emit(OtpSent(verificationId));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onVerifySmsCode(VerifySmsCode event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _repository.verifySmsCode(event.verificationId, event.smsCode);
      emit(AuthSuccess(user.user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignInWithEmail(SignInWithEmail event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _repository.signInWithEmail(
        email: event.email,
        password: event.password,
        captchaToken: event.captchaToken,
      );
      emit(AuthSuccess(user.user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignInWithGoogle(SignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _repository.signInWithGoogle();
      emit(AuthSuccess(user.user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _repository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
