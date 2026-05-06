import 'package:boar_time/domain/entities/stamping_time.dart';
import 'package:boar_time/infrastructure/model/stamping_time_model.dart';

abstract class StampingTimeFactory {
  StampingTime create({
    required DateTime date,
    required DateTime? startTime,
    required DateTime? endTime,
    required DateTime? breakStart,
    required DateTime? breakEnd,
    required DateTime? patrolStart,
    required DateTime? patrolEnd,
  });

  StampingTime createFromModel(StampingTimeModel model);
}
