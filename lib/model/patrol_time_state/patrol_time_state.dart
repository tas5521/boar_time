import 'package:boar_time/model/abstract_model/time_state_base.dart';
import 'package:boar_time/model/patrol_label.dart';
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
    required PatrolLabel label,
    String? location,
    String? animal,
    int? count,
    String? note,
  }) = _PatrolTimeState;
}
