import 'package:boar_time/model/work_record/work_record.dart';
import 'package:boar_time/manager/work_record_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stampingNotifierProvider =
    NotifierProvider<StampingNotifier, AsyncValue<Null>>(StampingNotifier.new);

class StampingNotifier extends Notifier<AsyncValue<Null>> {
  @override
  AsyncValue<Null> build() {
    return const AsyncValue.data(null);
  }

  DateTime get todayDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Future<WorkRecord> _getOrCreateTodayRecord() async {
    final exist = await WorkRecordManager.getByDate(todayDate);
    if (exist != null) {
      return exist;
    }
    return WorkRecord(date: todayDate);
  }

  Future<void> setStartTime() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.startTime = DateTime.now();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setEndTime() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.endTime = DateTime.now();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setBreakStart() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.breakStart = DateTime.now();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setBreakEnd() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.breakEnd = DateTime.now();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setPatrolStart() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.patrolStart = DateTime.now();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setPatrolEnd() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.patrolEnd = DateTime.now();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }
}
