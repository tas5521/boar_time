import 'package:boar_time/domain/entities/patrol_time.dart';

abstract class PatrolTimeRepository {
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month);
  Future<void> upsert(PatrolTime patrolTime);
}
