import 'package:equatable/equatable.dart';

/// Base class for phone authentication states.
abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any authentication action.
class PhoneAuthInitial extends PhoneAuthState {
  const PhoneAuthInitial();
}

/// Loading state during verification or sign-in operations.
class PhoneAuthLoading extends PhoneAuthState {
  const PhoneAuthLoading();
}

/// State emitted when SMS code has been sent.
/// [verificationId] is used to create credentials in the next step.
class PhoneAuthCodeSent extends PhoneAuthState {
  final String verificationId;
  const PhoneAuthCodeSent(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

/// State emitted upon successful authentication.
class PhoneAuthSuccess extends PhoneAuthState {
  const PhoneAuthSuccess();
}

/// State emitted when an error occurs.
/// [message] describes the failure reason.
class PhoneAuthFailure extends PhoneAuthState {
  final String message;
  const PhoneAuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
