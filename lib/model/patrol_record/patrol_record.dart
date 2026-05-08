import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/model/patrol_label.dart';
import 'package:isar_community/isar.dart';

part 'patrol_record.g.dart';

@collection
class PatrolRecord {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;

  late DateTime start;
  DateTime? end;

  String? worker; // 従事者名
  String? location; // 見回り場所
  String? animal; // 捕獲獣種
  int? count; // 捕獲数
  String? note; // 備考

  @enumerated
  late PatrolLabel label;

  PatrolRecord({
    required this.date,
    required this.start,
    this.end,
    this.worker,
    this.location,
    this.animal,
    this.count,
    this.note,
    this.label = PatrolLabel.none,
  });

  factory PatrolRecord.fromEntity(PatrolTime patrolTime) {
    final record = PatrolRecord(
      date: patrolTime.date,
      start: patrolTime.start,
      end: patrolTime.end,
      label: patrolTime.label,
      worker: patrolTime.worker,
      location: patrolTime.location,
      animal: patrolTime.animal,
      count: patrolTime.count,
      note: patrolTime.note,
    );
    record.id = patrolTime.id;
    return record;
  }
}
