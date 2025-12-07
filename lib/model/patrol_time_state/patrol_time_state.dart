import 'package:freezed_annotation/freezed_annotation.dart';

part 'patrol_time_state.freezed.dart';

@freezed
class PatrolTimeState with _$PatrolTimeState {
  const PatrolTimeState._();

  const factory PatrolTimeState({
    required DateTime date,
    DateTime? start,
    DateTime? end,
    @Default(Duration.zero) Duration cumulativeDuration,
  }) = _PatrolTimeState;

  Duration get totalDuration {
    if (start == null || end == null) return Duration.zero;
    if (end!.isBefore(start!)) return Duration.zero;
    return end!.difference(start!);
  }
}
