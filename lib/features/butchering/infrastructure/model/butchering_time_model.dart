import 'package:boar_time/core/work_record/infrastructure/isar/work_record/work_record.dart';

class ButcheringTimeModel {
  ButcheringTimeModel({
    required this.date,
    this.startTime,
    this.endTime,
    this.breakStart,
    this.breakEnd,
  });

  factory ButcheringTimeModel.fromRecord(WorkRecord workRecord) {
    return ButcheringTimeModel(
      date: workRecord.date,
      startTime: workRecord.startTime,
      endTime: workRecord.endTime,
      breakStart: workRecord.breakStart,
      breakEnd: workRecord.breakEnd,
    );
  }

  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? breakStart;
  final DateTime? breakEnd;
}
