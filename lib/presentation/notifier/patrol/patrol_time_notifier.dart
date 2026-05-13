import 'dart:async';

import 'package:boar_time/domain/enums/export_format.dart';
import 'package:boar_time/domain/enums/patrol_label.dart';
import 'package:boar_time/di/patrol_time_provider.dart';
import 'package:boar_time/domain/usecase/patrol_time_usecase.dart';
import 'package:boar_time/presentation/state/patrol_time_state/patrol_time_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patrolTimeProvider =
    AsyncNotifierProvider.family<
      PatrolTimeNotifier,
      List<PatrolTimeState>,
      ({int year, int month})
    >(PatrolTimeNotifier.new);

class PatrolTimeNotifier
    extends
        FamilyAsyncNotifier<List<PatrolTimeState>, ({int year, int month})> {
  late final PatrolTimeUsecase _usecase;
  @override
  FutureOr<List<PatrolTimeState>> build(arg) {
    _usecase = ref.read(patrolTimeUsecaseProvider);
    return _createPatrolTimeState(arg.year, arg.month);
  }

  Future<List<PatrolTimeState>> _createPatrolTimeState(
    int year,
    int month,
  ) async {
    final patrolTimeList = await _usecase.getPatrolTimeList(year, month);
    final sorted = [...patrolTimeList]
      ..sort((a, b) => a.start.compareTo(b.start));
    return sorted.map((entity) => PatrolTimeState.fromEntity(entity)).toList();
  }

  Future<bool> updateData(PatrolTimeState target) async {
    try {
      state = AsyncValue<List<PatrolTimeState>>.loading().copyWithPrevious(
        state,
      );
      final entity = target.toEntity();
      await _usecase.upsert(entity);
      final butcheringTimeStateList = await _createPatrolTimeState(
        arg.year,
        arg.month,
      );
      state = AsyncValue.data(butcheringTimeStateList);
      return true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<void> addNewData({
    required DateTime date,
    required DateTime start,
    required DateTime end,
    required PatrolLabel label,
  }) async {
    try {
      state = AsyncValue<List<PatrolTimeState>>.loading().copyWithPrevious(
        state,
      );
      final newEntity = PatrolTimeState(
        date: date,
        start: start,
        end: end,
        label: label,
      ).toEntity();
      await _usecase.createByEntity(newEntity);
      final patrolTimeStateList = await _createPatrolTimeState(
        date.year,
        date.month,
      );
      state = AsyncValue.data(patrolTimeStateList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<bool> delete(PatrolTimeState patrolTimeState) async {
    try {
      state = AsyncValue<List<PatrolTimeState>>.loading().copyWithPrevious(
        state,
      );
      final entity = patrolTimeState.toEntity();
      await _usecase.delete(entity);
      final patrolTimeStateList = await _createPatrolTimeState(
        arg.year,
        arg.month,
      );
      state = AsyncValue.data(patrolTimeStateList);
      return true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<void> export({
    required ExportFormat format,
    required String filename,
  }) async {
    try {
      final prevState = state;
      final data = prevState.valueOrNull;
      if (data == null) return;
      state = AsyncValue<List<PatrolTimeState>>.loading().copyWithPrevious(
        state,
      );
      final entityList = data.map((state) => state.toEntity()).toList();
      await _usecase.export(entityList, format, filename);
      state = prevState;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
