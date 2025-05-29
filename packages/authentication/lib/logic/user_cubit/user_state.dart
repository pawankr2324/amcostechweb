import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Base class for user authentication states.
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// State emitted initially or while loading user info.
class UserInitial extends UserState {
  const UserInitial();
}

/// State emitted when a user is authenticated.
/// Contains [user] with FirebaseAuth details.
class UserLoaded extends UserState {
  final User user;
  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

/// State emitted when no user is authenticated.
class UserEmpty extends UserState {
  const UserEmpty();
}
