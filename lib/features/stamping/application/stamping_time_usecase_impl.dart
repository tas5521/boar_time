import 'package:boar_time/features/stamping/domain/entities/stamping_time.dart';
import 'package:boar_time/core/patrol_record/domain/repositories/patrol_record_repository.dart';
import 'package:boar_time/features/stamping/domain/repositories/stamping_time_repository.dart';
import 'package:boar_time/core/work_record/domain/repositories/work_record_repository.dart';
import 'package:boar_time/features/stamping/domain/usecase/stamping_time_usecase.dart';
import 'package:boar_time/core/patrol_record/infrastructure/isar/patrol_record/patrol_record.dart';
import 'package:boar_time/core/work_record/infrastructure/isar/work_record/work_record.dart';

class StampingTimeUsecaseImpl implements StampingTimeUsecase {
  StampingTimeUsecaseImpl(
    this._stampingTimeRepository,
    this._workRecordRepository,
    this._patrolRecordRepository,
  );

  final StampingTimeRepository _stampingTimeRepository;
  final WorkRecordRepository _workRecordRepository;
  final PatrolRecordRepository _patrolRecordRepository;

  @override
  Future<StampingTime> getStampingTime() =>
      _stampingTimeRepository.getStampingTime(_today);

  @override
  Future<StampingTime> setStartTime() async {
    final today = _today;
    final now = _now;
    final existing = await _workRecordRepository.getByDate(today);
    final workRecord = existing ?? WorkRecord(date: today);
    workRecord.startTime = now;
    await _workRecordRepository.upsertByDate(workRecord);
    return _stampingTimeRepository.getStampingTime(today);
  }

  @override
  Future<StampingTime> setEndTime() async {
    final today = _today;
    final now = _now;
    final existing = await _workRecordRepository.getByDate(today);
    final workRecord = existing ?? WorkRecord(date: today);
    workRecord.endTime = now;
    await _workRecordRepository.upsertByDate(workRecord);
    return _stampingTimeRepository.getStampingTime(today);
  }

  @override
  Future<StampingTime> setBreakStartTime() async {
    final today = _today;
    final now = _now;
    final existing = await _workRecordRepository.getByDate(today);
    final workRecord = existing ?? WorkRecord(date: today);
    workRecord.breakStart = now;
    await _workRecordRepository.upsertByDate(workRecord);
    return _stampingTimeRepository.getStampingTime(today);
  }

  @override
  Future<StampingTime> setBreakEndTime() async {
    final today = _today;
    final now = _now;
    final existing = await _workRecordRepository.getByDate(today);
    final workRecord = existing ?? WorkRecord(date: today);
    workRecord.breakEnd = now;
    await _workRecordRepository.upsertByDate(workRecord);
    return _stampingTimeRepository.getStampingTime(today);
  }

  @override
  Future<PatrolRecord?> getActive() =>
      _patrolRecordRepository.getActive(_today);

  @override
  Future<void> setPatrolStart() => _patrolRecordRepository.create(_today, _now);

  @override
  Future<void> setPatrolEnd(PatrolRecord record) async {
    record.end = _now;
    return _patrolRecordRepository.update(record);
  }

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime get _now {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }
}
