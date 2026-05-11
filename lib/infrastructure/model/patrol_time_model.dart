import 'package:boar_time/infrastructure/model/job_time_model_base.dart';
import 'package:boar_time/domain/enums/patrol_label.dart';
import 'package:boar_time/infrastructure/isar/patrol_record/patrol_record.dart';

class PatrolTimeModel implements JobTimeModelBase {
  PatrolTimeModel({
    this.id,
    required this.date,
    required this.start,
    this.end,
    this.worker,
    this.location,
    this.animal,
    this.count,
    this.note,
    required this.label,
  });

  factory PatrolTimeModel.fromRecord(PatrolRecord patrolRecord) {
    return PatrolTimeModel(
      id: patrolRecord.id,
      date: patrolRecord.date,
      start: patrolRecord.start,
      end: patrolRecord.end,
      label: patrolRecord.label,
      worker: patrolRecord.worker,
      location: patrolRecord.location,
      animal: patrolRecord.animal,
      count: patrolRecord.count,
      note: patrolRecord.note,
    );
  }

  final int? id;
  final DateTime date;
  final DateTime start;
  final DateTime? end;
  final PatrolLabel label;
  final String? worker;
  final String? location;
  final String? animal;
  final int? count;
  final String? note;
}
