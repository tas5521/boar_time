import 'package:freezed_annotation/freezed_annotation.dart';

part 'butchering_time_state.freezed.dart';

@freezed
class ButcheringTimeState with _$ButcheringTimeState {
  const ButcheringTimeState._();

  const factory ButcheringTimeState({
    required DateTime date,
    DateTime? start,
    DateTime? end,
    DateTime? breakStart,
    DateTime? breakEnd,
    @Default(Duration.zero) Duration cumulativeDuration,
  }) = _ButcheringTimeState;

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
