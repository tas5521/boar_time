import 'package:boar_time/domain/enums/export_format.dart';
import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/domain/repositories/patrol_time_repository.dart';
import 'package:boar_time/domain/usecase/patrol_time_usecase.dart';

class PatrolTimeUsecaseImpl implements PatrolTimeUsecase {
  PatrolTimeUsecaseImpl(this._patrolTimeRepository);

  final PatrolTimeRepository _patrolTimeRepository;

  @override
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month) =>
      _patrolTimeRepository.getPatrolTimeList(year, month);

  @override
  Future<void> upsert(PatrolTime patrolTime) =>
      _patrolTimeRepository.upsert(patrolTime);

  @override
  Future<void> createByEntity(PatrolTime patrolTime) =>
      _patrolTimeRepository.createByEntity(patrolTime);

  @override
  Future<void> delete(PatrolTime patrolTime) =>
      _patrolTimeRepository.delete(patrolTime);

  @override
  Future<void> export(
    List<PatrolTime> entityList,
    ExportFormat format,
    String filename,
  ) => _patrolTimeRepository.export(entityList, format, filename);
}
