import 'package:boar_time/domain/entities/butchering_time.dart';

abstract class ButcheringTimeRepository {
  Future<List<ButcheringTime>> getButcheringTimeList();
  Future<void> upsert(ButcheringTime butcheringTime);
}
