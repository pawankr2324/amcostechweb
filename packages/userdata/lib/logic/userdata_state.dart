// File: packages/userdata/lib/logic/userdata_state.dart

part of 'userdata_cubit.dart';

/// Base class for userdata state.
abstract class UserdataState extends Equatable {
  const UserdataState();

  @override
  List<Object?> get props => [];
}

/// Initial state, before any action.
class UserdataInitial extends UserdataState {
  const UserdataInitial();
}

/// Indicates data is being loaded or updated.
class UserdataLoading extends UserdataState {
  const UserdataLoading();
}

/// Indicates userdata successfully loaded.
/// Contains the latest [UserdataModel].
class UserdataLoaded extends UserdataState {
  final UserdataModel userdata;

  const UserdataLoaded({required this.userdata});

  @override
  List<Object?> get props => [userdata];
}

/// Indicates an error occurred; contains an error [message].
class UserdataError extends UserdataState {
  final String message;

  const UserdataError({required this.message});

  @override
  List<Object?> get props => [message];
}
