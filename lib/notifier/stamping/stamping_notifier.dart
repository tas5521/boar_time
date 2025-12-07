import 'package:boar_time/model/stamping_state/stamping_state.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:boar_time/manager/work_record_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stampingNotifierProvider =
    AsyncNotifierProvider<StampingNotifier, StampingTimeState>(
      StampingNotifier.new,
    );

class StampingNotifier extends AsyncNotifier<StampingTimeState> {
  @override
  Future<StampingTimeState> build() async {
    final todayRecord = await _getOrCreateTodayRecord();
    return StampingTimeState.fromRecord(todayRecord);
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

  Future<void> fetch() async {
    final todayRecord = await _getOrCreateTodayRecord();
    final stampingTimeState = StampingTimeState.fromRecord(todayRecord);
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setStartTime() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.startTime = _nowRounded();
    await WorkRecordManager.upsertByDate(
      record,
      upsertType: UpsertType.butchering,
    );
    final stampingTimeState = StampingTimeState.fromRecord(record);
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setEndTime() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.endTime = _nowRounded();
    await WorkRecordManager.upsertByDate(
      record,
      upsertType: UpsertType.butchering,
    );
    final stampingTimeState = StampingTimeState.fromRecord(record);
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setBreakStart() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.breakStart = _nowRounded();
    await WorkRecordManager.upsertByDate(
      record,
      upsertType: UpsertType.butchering,
    );
    final stampingTimeState = StampingTimeState.fromRecord(record);
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setBreakEnd() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.breakEnd = _nowRounded();
    await WorkRecordManager.upsertByDate(
      record,
      upsertType: UpsertType.butchering,
    );
    final stampingTimeState = StampingTimeState.fromRecord(record);
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setPatrolStart() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.patrolStart = _nowRounded();
    await WorkRecordManager.upsertByDate(record, upsertType: UpsertType.patrol);
    final stampingTimeState = StampingTimeState.fromRecord(record);
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setPatrolEnd() async {
    state = AsyncValue.loading();
    final record = await _getOrCreateTodayRecord();
    record.patrolEnd = _nowRounded();
    await WorkRecordManager.upsertByDate(record, upsertType: UpsertType.patrol);
    final stampingTimeState = StampingTimeState.fromRecord(record);
    state = AsyncValue.data(stampingTimeState);
  }
}
