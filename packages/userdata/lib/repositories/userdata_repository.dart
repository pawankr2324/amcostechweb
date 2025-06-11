// File: packages/userdata/lib/repositories/userdata_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userdata/local/local_userdata_source.dart';
import 'package:userdata/models/userdata_model.dart';
import 'package:userdata/models/userdata_model_converter.dart';

/// Abstract repository defining userdata-related data operations,
/// now including a local cache lookup.
abstract class UserdataRepository {
  /// Fetches the [UserdataModel] for the given [uid], from Firestore.
  Future<UserdataModel> fetchUserdata(String uid);

  /// Creates a new userdata document in Firestore.
  Future<void> createUserdata(UserdataModel userdata);

  /// Updates existing userdata fields in Firestore.
  Future<void> updateUserdata(UserdataModel userdata);

  /// Listens to real-time changes on the userdata document in Firestore.
  Stream<UserdataModel> userdataStream(String uid);

  /// Retrieves the last-cached [UserdataModel] from SharedPreferences,
  /// or `null` if none is stored.
  Future<UserdataModel?> getCachedUserData();
}

/// Firestore-backed implementation of [UserdataRepository],
/// with local JSON caching after each read/stream.
class FirebaseUserdataRepository implements UserdataRepository {
  final FirebaseFirestore _firestore;
  final LocalUserDataSource _local;

  FirebaseUserdataRepository({
    FirebaseFirestore? firestore,
    LocalUserDataSource? localDataSource,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _local = localDataSource ?? LocalUserDataSource();

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  @override
  Future<UserdataModel?> getCachedUserData() => _local.getCachedUserData();

  @override
  Future<UserdataModel> fetchUserdata(String uid) async {
    final doc = await _usersCollection.doc(uid).get();
    if (!doc.exists) {
      throw StateError('Userdata document for $uid does not exist.');
    }
    final user = userdataModelFromSnapshot(doc);
    await _local.cacheUserData(user);
    return user;
  }

  @override
  Future<void> createUserdata(UserdataModel userdata) async {
    final docRef = _usersCollection.doc(userdata.uid);
    final snap = await docRef.get();
    if (snap.exists) {
      throw StateError('Userdata document for ${userdata.uid} already exists.');
    }
    final data = userdataModelToDocument(userdata);
    await docRef.set(data);
    // Cache right away after creation
    await _local.cacheUserData(userdata);
  }

  @override
  Future<void> updateUserdata(UserdataModel userdata) async {
    final docRef = _usersCollection.doc(userdata.uid);
    final snap = await docRef.get();
    if (!snap.exists) {
      throw StateError(
        'Cannot update: userdata document for ${userdata.uid} does not exist.',
      );
    }
    final data = userdataModelToDocument(userdata);
    await docRef.set(data, SetOptions(merge: true));
    // Refresh cache after update
    await _local.cacheUserData(userdata);
  }

  @override
  Stream<UserdataModel> userdataStream(String uid) async* {
    // 1) Emit any cached value immediately
    final cached = await _local.getCachedUserData();
    if (cached != null) yield cached;

    // 2) Then forward live Firestore updates, re-caching each
    await for (final snap in _usersCollection.doc(uid).snapshots()) {
      final user = userdataModelFromSnapshot(snap);
      await _local.cacheUserData(user);
      yield user;
    }
  }
}
