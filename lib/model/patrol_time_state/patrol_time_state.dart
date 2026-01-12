import 'package:boar_time/model/abstract_model/time_state_base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patrol_time_state.freezed.dart';

@freezed
abstract class PatrolTimeState with _$PatrolTimeState implements TimeStateBase {
  const PatrolTimeState._();

  const factory PatrolTimeState({
    required int id,
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
