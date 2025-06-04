// File: packages/userdata/lib/logic/userdata_cubit.dart

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/userdata_model.dart';
import '../repositories/userdata_repository.dart';
part 'userdata_state.dart';

/// Cubit responsible for managing userdata profile data.
class UserdataCubit extends Cubit<UserdataState> {
  final UserdataRepository _userdataRepository;
  StreamSubscription<UserdataModel>? _userdataSubscription;

  UserdataCubit({required UserdataRepository userdataRepository})
    : _userdataRepository = userdataRepository,
      super(UserdataInitial());

  /// Starts listening to real-time updates for [uid].
  void subscribeToUserdata(String uid) {
    emit(UserdataLoading());

    _userdataSubscription?.cancel();
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
  Future<void> loadUserdata(String uid) async {
    emit(UserdataLoading());
    try {
      final userdata = await _userdataRepository.fetchUserdata(uid);
      emit(UserdataLoaded(userdata: userdata));
    } catch (e) {
      emit(UserdataError(message: e.toString()));
    }
  }

  /// Updates userdata fields.
  Future<void> updateUserdata(UserdataModel userdata) async {
    emit(UserdataLoading());
    try {
      await _userdataRepository.updateUserdata(userdata);
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
