import 'package:boar_time/domain/entities/butchering_time.dart';

abstract class ButcheringTimeUsecase {
  Future<List<ButcheringTime>> getButcheringTimeList(int year, int month);
  Future<void> upsert(ButcheringTime butcheringTime);
  Future<void> updateBreak(ButcheringTime butcheringTime);
}
