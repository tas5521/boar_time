import 'package:boar_time/core/enums/export_format.dart';
import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/domain/repositories/patrol_time_repository.dart';
import 'package:boar_time/domain/usecase/patrol_time_usecase.dart';
import 'package:boar_time/presentation/state/patrol_time_state/patrol_time_state.dart';

class PatrolTimeUsecaseImpl implements PatrolTimeUsecase {
  PatrolTimeUsecaseImpl({required this.patrolTimeRepository});

  final PatrolTimeRepository patrolTimeRepository;

  @override
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month) =>
      patrolTimeRepository.getPatrolTimeList(year, month);

  @override
  Future<void> upsert(PatrolTime patrolTime) =>
      patrolTimeRepository.upsert(patrolTime);

  @override
  Future<void> createByEntity(PatrolTime patrolTime) =>
      patrolTimeRepository.createByEntity(patrolTime);

  @override
  Future<void> delete(PatrolTime patrolTime) =>
      patrolTimeRepository.delete(patrolTime);

  @override
  Future<void> export(
    List<PatrolTimeState> stateList,
    ExportFormat format,
    String filename,
  ) async {
    final entityList = stateList.map((state) => state.toEntity()).toList();
    await patrolTimeRepository.export(entityList, format, filename);
  }
}
