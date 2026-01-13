import 'package:boar_time/model/patrol_record/patrol_record.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stamping_state.freezed.dart';

@freezed
abstract class StampingTimeState with _$StampingTimeState {
  const StampingTimeState._();

  const factory StampingTimeState({
    required DateTime date,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? breakStart,
    DateTime? breakEnd,
    DateTime? patrolStart,
    DateTime? patrolEnd,
  }) = _StampingTimeState;

  factory StampingTimeState.fromRecord(WorkRecord workRecord, List<PatrolRecord> patrolRecords) {
    final patrolRecord = patrolRecords.where((element) => element.end == null).toList().firstOrNull;
    return StampingTimeState(
      date: workRecord.date,
      startTime: workRecord.startTime,
      endTime: workRecord.endTime,
      breakStart: workRecord.breakStart,
      breakEnd: workRecord.breakEnd,
      patrolStart: patrolRecord?.start,
      patrolEnd: patrolRecord?.end,
    );
  }
}
