import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/presentation/state/abstract_model/time_state_base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'butchering_time_state.freezed.dart';

@freezed
abstract class ButcheringTimeState
    with _$ButcheringTimeState
    implements TimeStateBase {
  const ButcheringTimeState._();

  const factory ButcheringTimeState({
    required DateTime date,
    DateTime? start,
    DateTime? end,
    DateTime? breakStart,
    DateTime? breakEnd,
    @Default(Duration.zero) Duration cumulativeDuration,
  }) = _ButcheringTimeState;

  factory ButcheringTimeState.fromEntity(ButcheringTime butcheringTime) {
    return ButcheringTimeState(
      date: butcheringTime.date,
      start: butcheringTime.startTime,
      end: butcheringTime.endTime,
      breakStart: butcheringTime.breakStart,
      breakEnd: butcheringTime.breakEnd,
    );
  }

  ButcheringTime toEntity() {
    return ButcheringTime(
      date: date,
      startTime: start,
      endTime: end,
      breakStart: breakStart,
      breakEnd: breakEnd,
    );
  }

  Duration get breakDuration {
    if (breakStart == null || breakEnd == null) return Duration.zero;
    if (breakEnd!.isBefore(breakStart!)) return Duration.zero;
    return breakEnd!.difference(breakStart!);
  }

  Duration get totalDuration {
    if (start == null || end == null) return Duration.zero;
    if (end!.isBefore(start!)) return Duration.zero;
    return end!.difference(start!);
  }

  Duration get actualDuration {
    if (start == null || end == null) return Duration.zero;
    if (totalDuration < breakDuration) return Duration.zero;
    return totalDuration - breakDuration;
  }
}
