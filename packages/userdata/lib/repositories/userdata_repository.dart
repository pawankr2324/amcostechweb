// File: packages/userdata/lib/repositories/userdata_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/userdata_model.dart';
import '../models/userdata_model_converter.dart';

/// Abstract repository defining userdata‐related data operations.
/// Note: Deletion is restricted and should be handled via backend requests only.
abstract class UserdataRepository {
  /// Fetches the [UserdataModel] for the given [uid].
  Future<UserdataModel> fetchUserdata(String uid);

  /// Creates a new userdata document in Firestore.
  /// Usually called right after user signs up.
  Future<void> createUserdata(UserdataModel userdata);

  /// Updates existing fields of the userdata document.
  Future<void> updateUserdata(UserdataModel userdata);

  /// Listens to real‐time changes on the userdata document.
  Stream<UserdataModel> userdataStream(String uid);
}

/// Firestore‐backed implementation of [UserdataRepository].
class FirebaseUserdataRepository implements UserdataRepository {
  final FirebaseFirestore _firestore;

  FirebaseUserdataRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Reference to the `users` collection.
  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  @override
  Future<UserdataModel> fetchUserdata(String uid) async {
    final docSnapshot = await _usersCollection.doc(uid).get();
    if (!docSnapshot.exists) {
      throw StateError('Userdata document for $uid does not exist.');
    }
    return userdataModelFromSnapshot(docSnapshot);
  }

  @override
  Future<void> createUserdata(UserdataModel userdata) async {
    final docRef = _usersCollection.doc(userdata.uid);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      throw StateError('Userdata document for ${userdata.uid} already exists.');
    }
    final data = userdataModelToDocument(userdata);
    return docRef.set(data);
  }

  @override
  Future<void> updateUserdata(UserdataModel userdata) async {
    final docRef = _usersCollection.doc(userdata.uid);
    final snapshot = await docRef.get();
    if (!snapshot.exists) {
      throw StateError(
        'Cannot update: userdata document for ${userdata.uid} does not exist.',
      );
    }
    final data = userdataModelToDocument(userdata);
    // Merge: only overwrite defined fields without wiping out missing optional fields
    return docRef.set(data, SetOptions(merge: true));
  }

  @override
  Stream<UserdataModel> userdataStream(String uid) {
    final docRef = _usersCollection.doc(uid);
    return docRef.snapshots().map(
      (snapshot) => userdataModelFromSnapshot(snapshot),
    );
  }
}
