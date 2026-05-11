import 'package:boar_time/domain/entities/stamping_time.dart';
import 'package:boar_time/infrastructure/isar/patrol_record/patrol_record.dart';

abstract class StampingTimeUsecase {
  Future<StampingTime> getStampingTime();
  Future<StampingTime> setStartTime();
  Future<StampingTime> setEndTime();
  Future<StampingTime> setBreakStartTime();
  Future<StampingTime> setBreakEndTime();
  Future<PatrolRecord?> getActive();
  Future<void> setPatrolStart();
  Future<void> setPatrolEnd(PatrolRecord record);
}
