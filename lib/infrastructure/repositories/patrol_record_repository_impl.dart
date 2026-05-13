import 'package:boar_time/domain/repositories/patrol_record_repository.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource.dart';
import 'package:boar_time/infrastructure/isar/patrol_record/patrol_record.dart';

class PatrolRecordRepositoryImpl implements PatrolRecordRepository {
  PatrolRecordRepositoryImpl(this._patrolRecordDatasource);

  final PatrolRecordDatasource _patrolRecordDatasource;

  @override
  Future<PatrolRecord?> getActive(DateTime date) =>
      _patrolRecordDatasource.getActive(date);

  @override
  Future<void> create(DateTime date, DateTime start) =>
      _patrolRecordDatasource.create(date, start);

  @override
  Future<void> update(PatrolRecord record) =>
      _patrolRecordDatasource.update(record);
}
