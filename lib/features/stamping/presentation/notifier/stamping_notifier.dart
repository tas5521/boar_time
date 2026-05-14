import 'dart:async';

import 'package:boar_time/core/first_launch/di/first_launch_provider.dart';
import 'package:boar_time/features/stamping/di/stamping_time_provider.dart';
import 'package:boar_time/features/stamping/presentation/state/stamping_time_state/stamping_time_state.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stampingTimeProvider =
    AsyncNotifierProvider<StampingTimeNotifier, StampingTimeState>(
      StampingTimeNotifier.new,
    );

class StampingTimeNotifier extends AsyncNotifier<StampingTimeState> {
  @override
  FutureOr<StampingTimeState> build() => _getStampingTime();

  Future<StampingTimeState> _getStampingTime() async {
    final usecase = ref.read(stampingTimeUsecaseProvider);
    final stampingTimeEntity = await usecase.getStampingTime();
    return StampingTimeState.fromEntity(stampingTimeEntity);
  }

  Future<bool> setStartTime() async {
    try {
      state = const AsyncValue<StampingTimeState>.loading().copyWithPrevious(
        state,
      );
      final usecase = ref.read(stampingTimeUsecaseProvider);
      final stampingTimeEntity = await usecase.setStartTime();
      final stampingTimeState = StampingTimeState.fromEntity(
        stampingTimeEntity,
      );
      state = AsyncValue.data(stampingTimeState);
      return true;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<bool> setEndTime() async {
    try {
      state = const AsyncValue<StampingTimeState>.loading().copyWithPrevious(
        state,
      );
      final usecase = ref.read(stampingTimeUsecaseProvider);
      final stampingTimeEntity = await usecase.setEndTime();
      final stampingTimeState = StampingTimeState.fromEntity(
        stampingTimeEntity,
      );
      state = AsyncValue.data(stampingTimeState);
      return true;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<bool> setBreakStart() async {
    try {
      state = const AsyncValue<StampingTimeState>.loading().copyWithPrevious(
        state,
      );
      final usecase = ref.read(stampingTimeUsecaseProvider);
      final stampingTimeEntity = await usecase.setBreakStartTime();
      final stampingTimeState = StampingTimeState.fromEntity(
        stampingTimeEntity,
      );
      state = AsyncValue.data(stampingTimeState);
      return true;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<bool> setBreakEnd() async {
    try {
      state = const AsyncValue<StampingTimeState>.loading().copyWithPrevious(
        state,
      );
      final usecase = ref.read(stampingTimeUsecaseProvider);
      final stampingTimeEntity = await usecase.setBreakEndTime();
      final stampingTimeState = StampingTimeState.fromEntity(
        stampingTimeEntity,
      );
      state = AsyncValue.data(stampingTimeState);
      return true;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<bool> setPatrolStart() async {
    try {
      final preState = state;
      state = const AsyncValue<StampingTimeState>.loading().copyWithPrevious(
        state,
      );
      final usecase = ref.read(stampingTimeUsecaseProvider);
      final active = await usecase.getActive();
      if (active == null) {
        await usecase.setPatrolStart();
        final stampingTimeState = await _getStampingTime();
        state = AsyncValue.data(stampingTimeState);
      } else {
        state = preState;
      }
      return true;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<bool> setPatrolEnd() async {
    try {
      final preState = state;
      state = const AsyncValue<StampingTimeState>.loading().copyWithPrevious(
        state,
      );
      final usecase = ref.read(stampingTimeUsecaseProvider);
      final active = await usecase.getActive();
      if (active != null) {
        await usecase.setPatrolEnd(active);
        final stampingTimeState = await _getStampingTime();
        state = AsyncValue.data(stampingTimeState);
      } else {
        state = preState;
      }
      return true;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  bool checkFirstLaunch() {
    final usecase = ref.read(firstLaunchUsecaseProvider);
    return usecase.checkFirstLaunch();
  }

  Future<bool> setFirstLaunch() {
    final usecase = ref.read(firstLaunchUsecaseProvider);
    return usecase.setFirstLaunch();
  }
}
