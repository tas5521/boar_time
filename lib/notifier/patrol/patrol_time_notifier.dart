import 'package:boar_time/manager/work_record_manager.dart';
import 'package:boar_time/model/patrol_time_state/patrol_time_state.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patrolTimeNotifierProvider =
    NotifierProvider<PatrolTimeNotifier, AsyncValue<List<PatrolTimeState>>>(
      PatrolTimeNotifier.new,
    );

class PatrolTimeNotifier extends Notifier<AsyncValue<List<PatrolTimeState>>> {
  @override
  AsyncValue<List<PatrolTimeState>> build() {
    return const AsyncValue.loading();
  }

  Future<void> loadMonth(int year, int month) async {
    state = const AsyncValue.loading();
    try {
      final records = await _loadRecords(year, month);
      final converted = _convertRecords(year, month, records);
      state = AsyncValue.data(converted);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> upsert(int year, int month, WorkRecord rec) async {
    state = const AsyncValue.loading();
    try {
      await WorkRecordManager.upsertByDate(
        rec,
        upsertType: UpsertType.patrol,
      );
      final records = await _loadRecords(year, month);
      final converted = _convertRecords(year, month, records);
      state = AsyncValue.data(converted);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearPatrolStart(
    int year,
    int month,
    DateTime date,
  ) async {
    state = const AsyncValue.loading();
    try {
      final record = await WorkRecordManager.getByDate(date);
      if (record != null) {
        record.patrolStart = null;
        await WorkRecordManager.update(record);
      }
      final records = await _loadRecords(year, month);
      final converted = _convertRecords(year, month, records);
      state = AsyncValue.data(converted);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearPatrolEnd(
    int year,
    int month,
    DateTime date,
  ) async {
    state = const AsyncValue.loading();
    try {
      final record = await WorkRecordManager.getByDate(date);
      if (record != null) {
        record.patrolEnd = null;
        await WorkRecordManager.update(record);
      }
      final records = await _loadRecords(year, month);
      final converted = _convertRecords(year, month, records);
      state = AsyncValue.data(converted);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<WorkRecord>> _loadRecords(int year, int month) async {
    final all = await WorkRecordManager.getAll();
    return all
        .where((e) => e.date.year == year && e.date.month == month)
        .toList();
  }

  List<PatrolTimeState> _convertRecords(
    int year,
    int month,
    List<WorkRecord> records,
  ) {
    final lastDay = DateTime(year, month + 1, 0).day;
    final List<PatrolTimeState> list = [];
    Duration cumulative = Duration.zero;

    for (int day = 1; day <= lastDay; day++) {
      final date = DateTime(year, month, day);

      final rec = records.firstWhere(
        (r) =>
            r.date.year == date.year &&
            r.date.month == date.month &&
            r.date.day == date.day,
        orElse: () => WorkRecord(date: date),
      );

      var state = PatrolTimeState(
        date: date,
        start: rec.patrolStart,
        end: rec.patrolEnd,
        cumulativeDuration: Duration.zero,
      );

      cumulative += state.totalDuration;
      state = state.copyWith(cumulativeDuration: cumulative);

      list.add(state);
    }

    return list;
  }
}
