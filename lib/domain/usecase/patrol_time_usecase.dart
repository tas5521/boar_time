import 'package:boar_time/domain/enums/export_format.dart';
import 'package:boar_time/domain/entities/patrol_time.dart';

abstract class PatrolTimeUsecase {
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
