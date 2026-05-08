import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/infrastructure/model/patrol_time_model.dart';
import 'package:boar_time/model/patrol_label.dart';

abstract class PatrolTimeFactory {
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
  });

  PatrolTime createFromModel(PatrolTimeModel model);
}
