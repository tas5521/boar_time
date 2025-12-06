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

  DateTime _nowRounded() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
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
    record.startTime = _nowRounded();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setEndTime() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.endTime = _nowRounded();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setBreakStart() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.breakStart = _nowRounded();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setBreakEnd() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.breakEnd = _nowRounded();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setPatrolStart() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.patrolStart = _nowRounded();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }

  Future<void> setPatrolEnd() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.patrolEnd = _nowRounded();
    await WorkRecordManager.upsertByDate(record);
    state = AsyncValue.data(null);
  }
}
