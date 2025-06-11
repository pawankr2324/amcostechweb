// File: packages/userdata/lib/logic/userdata_cubit.dart

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/userdata_model.dart';
import '../repositories/userdata_repository.dart';
part 'userdata_state.dart';

class UserdataCubit extends Cubit<UserdataState> {
  final UserdataRepository _userdataRepository;
  StreamSubscription<UserdataModel>? _userdataSubscription;

  UserdataCubit({required UserdataRepository userdataRepository})
    : _userdataRepository = userdataRepository,
      super(UserdataInitial());

  /// Starts listening to real‐time updates for [uid],
  /// but first emits any locally cached data.
  Future<void> subscribeToUserdata(String uid) async {
    emit(UserdataLoading());

    // 1) Emit cached data (if any) immediately:
    final cached = await _userdataRepository.getCachedUserData();
    if (cached != null) {
      emit(UserdataLoaded(userdata: cached));
    }

    // 2) Listen to live Firestore updates:
    await _userdataSubscription?.cancel();
    _userdataSubscription = _userdataRepository
        .userdataStream(uid)
        .listen(
          (userdataModel) {
            emit(UserdataLoaded(userdata: userdataModel));
          },
          onError: (error) {
            emit(UserdataError(message: error.toString()));
          },
        );
  }

  /// Fetches the userdata once (no real-time subscription).
  /// Since the repository now caches on fetch, this also updates local data.
  Future<void> loadUserdata(String uid) async {
    emit(UserdataLoading());
    try {
      final userdata = await _userdataRepository.fetchUserdata(uid);
      emit(UserdataLoaded(userdata: userdata));
    } catch (e) {
      emit(UserdataError(message: e.toString()));
    }
  }

  /// Updates userdata fields in Firestore (and cache).
  Future<void> updateUserdata(UserdataModel userdata) async {
    emit(UserdataLoading());
    try {
      await _userdataRepository.updateUserdata(userdata);
      // fetch again to get the fresh copy (cached by repo)
      final updated = await _userdataRepository.fetchUserdata(userdata.uid);
      emit(UserdataLoaded(userdata: updated));
    } catch (e) {
      emit(UserdataError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _userdataSubscription?.cancel();
    return super.close();
  }
}
