import 'package:boar_time/manager/patrol_record_manager.dart';
import 'package:boar_time/model/job_type.dart';
import 'package:boar_time/model/patrol_record/patrol_record.dart';
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
    final workRecord = await _getOrCreateTodayRecord();
    final patrolRecords = await _getTodayPatrolRecords();
    return StampingTimeState.fromRecord(workRecord, patrolRecords);
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

  Future<List<PatrolRecord>> _getTodayPatrolRecords() async {
    return await PatrolRecordManager.getByDate(todayDate);
  }

  Future<void> fetch() async {
    final workRecord = await _getOrCreateTodayRecord();
    final patrolRecords = await _getTodayPatrolRecords();
    final stampingTimeState = StampingTimeState.fromRecord(
      workRecord,
      patrolRecords,
    );
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setStartTime() async {
    state = AsyncValue.loading();
    final workRecord = await _getOrCreateTodayRecord();
    workRecord.startTime = _nowRounded();
    await WorkRecordManager.upsertByDate(
      workRecord,
      type: JobType.butchering,
    );
    final patrolRecords = await _getTodayPatrolRecords();
    final stampingTimeState = StampingTimeState.fromRecord(
      workRecord,
      patrolRecords,
    );
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setEndTime() async {
    state = AsyncValue.loading();
    final workRecord = await _getOrCreateTodayRecord();
    workRecord.endTime = _nowRounded();
    await WorkRecordManager.upsertByDate(
      workRecord,
      type: JobType.butchering,
    );
    final patrolRecords = await _getTodayPatrolRecords();
    final stampingTimeState = StampingTimeState.fromRecord(
      workRecord,
      patrolRecords,
    );
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setBreakStart() async {
    state = AsyncValue.loading();
    final workRecord = await _getOrCreateTodayRecord();
    workRecord.breakStart = _nowRounded();
    await WorkRecordManager.upsertByDate(
      workRecord,
      type: JobType.butchering,
    );
    final patrolRecords = await _getTodayPatrolRecords();
    final stampingTimeState = StampingTimeState.fromRecord(
      workRecord,
      patrolRecords,
    );
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setBreakEnd() async {
    state = AsyncValue.loading();
    final workRecord = await _getOrCreateTodayRecord();
    workRecord.breakEnd = _nowRounded();
    await WorkRecordManager.upsertByDate(
      workRecord,
      type: JobType.butchering,
    );
    final patrolRecords = await _getTodayPatrolRecords();
    final stampingTimeState = StampingTimeState.fromRecord(
      workRecord,
      patrolRecords,
    );
    state = AsyncValue.data(stampingTimeState);
  }

  Future<void> setPatrolStart() async {
    final preState = state;
    state = AsyncValue.loading();
    final today = todayDate;
    final active = await PatrolRecordManager.getActive(today);
    if (active == null) {
      await PatrolRecordManager.create(today, _nowRounded());
      await fetch();
    } else {
      state = preState;
    }
  }

  Future<void> setPatrolEnd() async {
    final preState = state;
    state = AsyncValue.loading();
    final active = await PatrolRecordManager.getActive(todayDate);

    if (active != null) {
      active.end = _nowRounded();
      await PatrolRecordManager.update(active);
      await fetch();
    } else {
      state = preState;
    }
  }
}
