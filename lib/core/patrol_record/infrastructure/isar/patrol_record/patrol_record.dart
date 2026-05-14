import 'package:boar_time/core/patrol_record/domain/enums/patrol_label.dart';
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
}
