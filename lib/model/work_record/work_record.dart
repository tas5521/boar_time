import 'package:isar_community/isar.dart';

part 'work_record.g.dart';

@collection
class WorkRecord {
  Id id = Isar.autoIncrement;
  @Index()
  late DateTime date; // 対象日（必須）
  DateTime? startTime; // 出勤時間
  DateTime? endTime; // 退勤時間
  DateTime? breakStart; // 休憩開始
  DateTime? breakEnd; // 休憩終了

  // 既存データ用（今後は使わない）
  DateTime? patrolStart; // 見回り開始
  DateTime? patrolEnd; // 見回り終了

  WorkRecord({
    required this.date,
    this.startTime,
    this.endTime,
    this.breakStart,
    this.breakEnd,
    this.patrolStart,
    this.patrolEnd,
  });
}
