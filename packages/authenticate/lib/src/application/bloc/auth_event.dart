part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SendPhoneCode extends AuthEvent {
  final String phoneNumber;
  const SendPhoneCode(this.phoneNumber);
  @override
  List<Object?> get props => [phoneNumber];
}

class VerifySmsCode extends AuthEvent {
  final String verificationId;
  final String smsCode;
  const VerifySmsCode({required this.verificationId, required this.smsCode});
  @override
  List<Object?> get props => [verificationId, smsCode];
}

class SignInWithEmail extends AuthEvent {
  final String email;
  final String password;
  final String captchaToken;
  const SignInWithEmail({required this.email, required this.password, required this.captchaToken});
  @override
  List<Object?> get props => [email, password, captchaToken];
}

class SignInWithGoogle extends AuthEvent {}

class SignOut extends AuthEvent {}
