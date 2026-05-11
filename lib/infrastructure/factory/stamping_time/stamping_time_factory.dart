import 'package:boar_time/domain/entities/stamping_time.dart';
import 'package:boar_time/infrastructure/model/stamping_time_model.dart';

class StampingTimeFactory {
  StampingTime create({
    required DateTime date,
    required DateTime? startTime,
    required DateTime? endTime,
    required DateTime? breakStart,
    required DateTime? breakEnd,
    required DateTime? patrolStart,
    required DateTime? patrolEnd,
  }) {
    return StampingTime(
      date: date,
      startTime: startTime,
      endTime: endTime,
      breakStart: breakStart,
      breakEnd: breakEnd,
      patrolStart: patrolStart,
      patrolEnd: patrolEnd,
    );
  }

  StampingTime createFromModel(StampingTimeModel model) {
    return StampingTime(
      date: model.date,
      startTime: model.startTime,
      endTime: model.endTime,
      breakStart: model.breakStart,
      breakEnd: model.breakEnd,
      patrolStart: model.patrolStart,
      patrolEnd: model.patrolEnd,
    );
  }
}
