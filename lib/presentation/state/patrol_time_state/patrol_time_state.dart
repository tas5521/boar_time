import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/model/patrol_label.dart';
import 'package:boar_time/presentation/state/abstract_model/time_state_base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patrol_time_state.freezed.dart';

@freezed
abstract class PatrolTimeState with _$PatrolTimeState implements TimeStateBase {
  const PatrolTimeState._();

  const factory PatrolTimeState({
    required int id,
    required DateTime date,
    required DateTime start,
    DateTime? end,
    required PatrolLabel label,
    String? worker,
    String? location,
    String? animal,
    int? count,
    String? note,
  }) = _PatrolTimeState;

  factory PatrolTimeState.fromEntity(PatrolTime patrolTime) {
    return PatrolTimeState(
      id: patrolTime.id,
      date: patrolTime.date,
      start: patrolTime.start,
      end: patrolTime.end,
      label: patrolTime.label,
      worker: patrolTime.worker,
      location: patrolTime.location,
      animal: patrolTime.animal,
      count: patrolTime.count,
      note: patrolTime.note,
    );
  }

  PatrolTime toEntity() {
    return PatrolTime(
      id: id,
      date: date,
      start: start,
      end: end,
      label: label,
      worker: worker,
      location: location,
      animal: animal,
      count: count,
      note: note,
    );
  }
}
