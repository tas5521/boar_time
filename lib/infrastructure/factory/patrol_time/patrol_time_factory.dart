import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/infrastructure/model/patrol_time_model.dart';
import 'package:boar_time/domain/enums/patrol_label.dart';

class PatrolTimeFactory {
  PatrolTime create({
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
  }) {
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

  PatrolTime createFromModel(PatrolTimeModel model) {
    return PatrolTime(
      id: model.id,
      date: model.date,
      start: model.start,
      end: model.end,
      label: model.label,
      worker: model.worker,
      location: model.location,
      animal: model.animal,
      count: model.count,
      note: model.note,
    );
  }
}
