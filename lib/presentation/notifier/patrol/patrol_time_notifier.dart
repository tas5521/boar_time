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

  Future<void> updateData(PatrolTimeState target) async {
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
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }



  Future<void> addNewRecord({
    required DateTime date,
    required DateTime start,
    required DateTime? end,
    required PatrolLabel label,
  }) async {
    state = const AsyncValue.loading();
    try {
      final newRecord = PatrolRecord(
        date: date,
        start: start,
        end: end,
        label: label,
      );

      await PatrolRecordManager.createWithDetails(newRecord);

      // 該当年月のデータを再取得して state を更新
      final patrolTimeStateList = await _createPatrolTimeState(
        date.year,
        date.month,
      );
      state = AsyncValue.data(patrolTimeStateList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> delete({
    required int patrolId,
    required int year,
    required int month,
  }) async {
    await PatrolRecordManager.deleteIfExists(patrolId);
    final patrolTimeStateList = await _createPatrolTimeState(year, month);
    state = AsyncValue.data(patrolTimeStateList);
  }

  Future<PatrolRecord?> getDetail(int patrolId) {
    return PatrolRecordManager.getById(patrolId);
  }

  Future<void> updateDetail({
    required int patrolId,
    required String worker,
    required String location,
    required String animal,
    required int? count,
    required String note,
    required int year,
    required int month,
  }) async {
    final record = await PatrolRecordManager.getById(patrolId);
    if (record == null) return;

    record
      ..worker = worker
      ..location = location
      ..animal = animal
      ..count = count
      ..note = note;

    await PatrolRecordManager.update(record);

    final patrolTimeStateList = await _createPatrolTimeState(year, month);
    state = AsyncValue.data(patrolTimeStateList);
  }

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
