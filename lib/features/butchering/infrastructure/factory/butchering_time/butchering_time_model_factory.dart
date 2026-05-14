import 'package:boar_time/features/butchering/domain/entities/butchering_time.dart';
import 'package:boar_time/features/butchering/infrastructure/model/butchering_time_model.dart';

class ButcheringTimeModelFactory {
  ButcheringTimeModel create({
    required DateTime date,
    required DateTime? startTime,
    required DateTime? endTime,
    required DateTime? breakStart,
    required DateTime? breakEnd,
  }) {
    return ButcheringTimeModel(
      date: date,
      startTime: startTime,
      endTime: endTime,
      breakStart: breakStart,
      breakEnd: breakEnd,
    );
  }

  ButcheringTimeModel createFromEntity(ButcheringTime entity) {
    return ButcheringTimeModel(
      date: entity.date,
      startTime: entity.startTime,
      endTime: entity.endTime,
      breakStart: entity.breakStart,
      breakEnd: entity.breakEnd,
    );
  }
}
