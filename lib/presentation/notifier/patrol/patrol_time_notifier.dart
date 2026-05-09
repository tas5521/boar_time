import 'dart:async';

import 'package:boar_time/di/patrol_time_provider.dart';
import 'package:boar_time/manager/export_manager.dart';
import 'package:boar_time/manager/patrol_record_manager.dart';
import 'package:boar_time/model/job_type.dart';
import 'package:boar_time/model/patrol_label.dart';
import 'package:boar_time/model/patrol_record/patrol_record.dart';
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
  @override
  FutureOr<List<PatrolTimeState>> build(arg) =>
      _createPatrolTimeState(arg.year, arg.month);

  Future<List<PatrolTimeState>> _createPatrolTimeState(
    int year,
    int month,
  ) async {
    final usecase = ref.read(patrolTimeUsecaseProvider);
    final patrolTimeList = await usecase.getPatrolTimeList(year, month);
    final sorted = [...patrolTimeList]
      ..sort((a, b) => a.start.compareTo(b.start));
    return sorted.map((entity) => PatrolTimeState.fromEntity(entity)).toList();
  }

  Future<bool> updateData(PatrolTimeState target) async {
    try {
      state = const AsyncValue.loading();
      final entity = target.toEntity();
      final usecase = ref.read(patrolTimeUsecaseProvider);
      await usecase.upsert(entity);
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
      state = const AsyncValue.loading();
      final newEntity = PatrolTimeState(
        date: date,
        start: start,
        end: end,
        label: label,
      ).toEntity();
      final usecase = ref.read(patrolTimeUsecaseProvider);
      await usecase.createByEntity(newEntity);
      final patrolTimeStateList = await _createPatrolTimeState(
        date.year,
        date.month,
      );
      state = AsyncValue.data(patrolTimeStateList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<bool> delete(PatrolTimeState patrolTimeState) async {
    try {
      state = const AsyncValue.loading();
      final entity = patrolTimeState.toEntity();
      final usecase = ref.read(patrolTimeUsecaseProvider);
      await usecase.delete(entity);
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

  Future<PatrolRecord?> getDetail(int patrolId) {
    return PatrolRecordManager.getById(patrolId);
  }

  // Future<void> updateDetail({
  //   PatrolTimeState patrolTimeState,
  // }) async {

  //   final record = await PatrolRecordManager.getById(patrolId);
  //   if (record == null) return;

  //   record
  //     ..worker = worker
  //     ..location = location
  //     ..animal = animal
  //     ..count = count
  //     ..note = note;

  //   await PatrolRecordManager.update(record);

  //   final patrolTimeStateList = await _createPatrolTimeState(year, month);
  //   state = AsyncValue.data(patrolTimeStateList);
  // }

  //TODO: 後で対応
  Future<void> exportAndSave({
    required ExportFormat format,
    required String filename,
  }) async {
    final data = state.valueOrNull ?? [];
    await ExportManager.exportAndSave(
      type: JobType.patrol,
      format: format,
      data: data,
      filename: filename,
    );
  }
}
