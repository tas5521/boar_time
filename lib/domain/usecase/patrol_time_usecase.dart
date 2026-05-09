import 'package:boar_time/domain/entities/patrol_time.dart';

abstract class PatrolTimeUsecase {
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month);
  Future<void> upsert(PatrolTime patrolTime);
  Future<void> createByEntity(PatrolTime patrolTime);
}
