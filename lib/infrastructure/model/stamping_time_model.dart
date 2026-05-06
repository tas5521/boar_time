import 'package:boar_time/model/patrol_record/patrol_record.dart';
import 'package:boar_time/model/work_record/work_record.dart';

class StampingTimeModel {
  StampingTimeModel({
    required this.date,
    this.startTime,
    this.endTime,
    this.breakStart,
    this.breakEnd,
    this.patrolStart,
    this.patrolEnd,
  });

  factory StampingTimeModel.fromRecords(
    WorkRecord workRecord,
    List<PatrolRecord> patrolRecords,
  ) {
    final patrolRecord = patrolRecords
        .where((element) => element.end == null)
        .toList()
        .firstOrNull;
    return StampingTimeModel(
      date: workRecord.date,
      startTime: workRecord.startTime,
      endTime: workRecord.endTime,
      breakStart: workRecord.breakStart,
      breakEnd: workRecord.breakEnd,
      patrolStart: patrolRecord?.start,
      patrolEnd: patrolRecord?.end,
    );
  }

  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? breakStart;
  final DateTime? breakEnd;
  final DateTime? patrolStart;
  final DateTime? patrolEnd;
}
