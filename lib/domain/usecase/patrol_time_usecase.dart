import 'package:boar_time/core/enums/export_format.dart';
import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/presentation/state/patrol_time_state/patrol_time_state.dart';

abstract class PatrolTimeUsecase {
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month);
  Future<void> upsert(PatrolTime patrolTime);
  Future<void> createByEntity(PatrolTime patrolTime);
  Future<void> delete(PatrolTime patrolTime);
  Future<void> export(
    List<PatrolTimeState> stateList,
    ExportFormat format,
    String filename,
  );
}
