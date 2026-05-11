import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/infrastructure/model/patrol_time_model.dart';
import 'package:boar_time/domain/enums/patrol_label.dart';

class PatrolTimeModelFactory {
  PatrolTimeModel create({
    int? id,
    required DateTime date,
    required DateTime start,
    DateTime? end,
    required PatrolLabel label,
    String? worker,
    String? location,
    String? animal,
    int? count,
    String? note,
  }) {
    return PatrolTimeModel(
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

  PatrolTimeModel createFromEntity(PatrolTime entity) {
    return PatrolTimeModel(
      id: entity.id,
      date: entity.date,
      start: entity.start,
      end: entity.end,
      label: entity.label,
      worker: entity.worker,
      location: entity.location,
      animal: entity.animal,
      count: entity.count,
      note: entity.note,
    );
  }
}
