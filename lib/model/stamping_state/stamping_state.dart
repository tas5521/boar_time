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

  factory StampingTimeState.fromRecord(WorkRecord record) {
    return StampingTimeState(
      date: record.date,
      startTime: record.startTime,
      endTime: record.endTime,
      breakStart: record.breakStart,
      breakEnd: record.breakEnd,
      patrolStart: record.patrolStart,
      patrolEnd: record.patrolEnd,
    );
  }
}
