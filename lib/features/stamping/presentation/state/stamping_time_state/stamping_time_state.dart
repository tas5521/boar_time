import 'package:boar_time/features/stamping/domain/entities/stamping_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stamping_time_state.freezed.dart';

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

  factory StampingTimeState.fromEntity(StampingTime stampingTime) {
    return StampingTimeState(
      date: stampingTime.date,
      startTime: stampingTime.startTime,
      endTime: stampingTime.endTime,
      breakStart: stampingTime.breakStart,
      breakEnd: stampingTime.breakEnd,
      patrolStart: stampingTime.patrolStart,
      patrolEnd: stampingTime.patrolEnd,
    );
  }
}
