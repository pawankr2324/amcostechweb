// The entrypoint for the userdata package.
// Exposes the public APIs: cubits and repository interfaces/implementations.

library;

// Cubits & states: handles userdata cubit and userdata state logic.
export 'logic/userdata_cubit.dart';

// Repository interfaces & implementations: defines contract and Firebase-based implementation.
export 'repositories/userdata_repository.dart';

// Data Models: handles userdata models.

export 'models/userdata_model.dart';
export 'models/userdata_model_converter.dart';
export 'local/local_userdata_source.dart';
