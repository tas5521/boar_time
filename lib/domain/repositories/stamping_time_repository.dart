import 'package:boar_time/domain/entities/stamping_time.dart';

abstract interface class StampingTimeRepository {
  Future<StampingTime> getStampingTime(DateTime today);
}
