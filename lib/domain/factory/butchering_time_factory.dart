import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/infrastructure/model/butchering_time_model.dart';

abstract class ButcheringTimeFactory {
  ButcheringTime create({
    required DateTime date,
    required DateTime? startTime,
    required DateTime? endTime,
    required DateTime? breakStart,
    required DateTime? breakEnd,
  });

  ButcheringTime createFromModel(ButcheringTimeModel model);
}
