import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/infrastructure/model/butchering_time_model.dart';

abstract class ButcheringTimeModelFactory {
  ButcheringTimeModel create({
    required DateTime date,
    required DateTime? startTime,
    required DateTime? endTime,
    required DateTime? breakStart,
    required DateTime? breakEnd,
  });

  ButcheringTimeModel createFromEntity(ButcheringTime entity);
}
