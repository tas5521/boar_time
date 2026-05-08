import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/domain/factory/patrol_time_factory.dart';
import 'package:boar_time/domain/repositories/patrol_time_repository.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource.dart';
import 'package:boar_time/infrastructure/model/patrol_time_model.dart';
import 'package:boar_time/model/patrol_record/patrol_record.dart';

class PatrolTimeRepositoryImpl implements PatrolTimeRepository {
  PatrolTimeRepositoryImpl({
    required this.patrolRecordDatasource,
    required this.patrolTimeFactory,
  });

  final PatrolRecordDatasource patrolRecordDatasource;
  final PatrolTimeFactory patrolTimeFactory;

  @override
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month) async {
    final patrolRecords = await patrolRecordDatasource.getByMonth(year, month);

    final modelList = patrolRecords
        .map((record) => PatrolTimeModel.fromRecord(record))
        .toList();
    final patrolTimeList = modelList
        .map((model) => patrolTimeFactory.createFromModel(model))
        .toList();
    return patrolTimeList;
  }

  @override
  Future<void> upsert(PatrolTime patrolTime) async {
    final targetRecord = PatrolRecord.fromEntity(patrolTime);
    await patrolRecordDatasource.upsertById(targetRecord);
  }
}
