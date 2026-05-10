import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/domain/factory/butchering_time_factory.dart';
import 'package:boar_time/infrastructure/model/butchering_time_model.dart';

class ButcheringTimeFactoryImpl implements ButcheringTimeFactory {
  @override
  ButcheringTime create({
    required DateTime date,
    required DateTime? startTime,
    required DateTime? endTime,
    required DateTime? breakStart,
    required DateTime? breakEnd,
  }) {
    return ButcheringTime(
      date: date,
      startTime: startTime,
      endTime: endTime,
      breakStart: breakStart,
      breakEnd: breakEnd,
    );
  }

  @override
  ButcheringTime createFromModel(ButcheringTimeModel model) {
    return ButcheringTime(
      date: model.date,
      startTime: model.startTime,
      endTime: model.endTime,
      breakStart: model.breakStart,
      breakEnd: model.breakEnd,
    );
  }
}
