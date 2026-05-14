import 'package:boar_time/shared/enums/export_format.dart';
import 'package:boar_time/features/patrol/domain/entities/patrol_time.dart';

abstract interface class PatrolTimeRepository {
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month);
  Future<void> upsert(PatrolTime patrolTime);
  Future<void> createByEntity(PatrolTime patrolTime);
  Future<void> delete(PatrolTime patrolTime);
  Future<void> export(
    List<PatrolTime> entityList,
    ExportFormat format,
    String filename,
  );
}
