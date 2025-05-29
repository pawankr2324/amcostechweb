// The entrypoint for the authentication package.
// Exposes the public APIs: cubits and repository interfaces/implementations.

//library authentication;

// Cubits & states: handles authentication and user state logic.
export 'logic/auth_cubit/phone_auth_cubit.dart';
export 'logic/auth_cubit/phone_auth_state.dart';
export 'logic/user_cubit/user_cubit.dart';
export 'logic/user_cubit/user_state.dart';

// Repository interfaces & implementations: defines contract and Firebase-based implementation.
export 'repositories/auth_repository.dart';
export 'repositories/firebase_auth_repository.dart';
