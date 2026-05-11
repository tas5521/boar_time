import 'package:boar_time/domain/enums/export_format.dart';
import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/domain/repositories/patrol_time_repository.dart';
import 'package:boar_time/infrastructure/datasource/export_datasource/export_datasource.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource.dart';
import 'package:boar_time/infrastructure/factory/patrol_time/patrol_time_factory.dart';
import 'package:boar_time/infrastructure/factory/patrol_time/patrol_time_model_factory.dart';
import 'package:boar_time/infrastructure/model/patrol_time_model.dart';
import 'package:boar_time/infrastructure/isar/patrol_record/patrol_record.dart';

class PatrolTimeRepositoryImpl implements PatrolTimeRepository {
  PatrolTimeRepositoryImpl({
    required this.patrolRecordDatasource,
    required this.patrolTimeFactory,
    required this.patrolTimeModelFactory,
    required this.exportDatasource,
  });

  final PatrolRecordDatasource patrolRecordDatasource;
  final PatrolTimeFactory patrolTimeFactory;
  final PatrolTimeModelFactory patrolTimeModelFactory;
  final ExportDatasource exportDatasource;

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
    final patrolTimeModel = patrolTimeModelFactory.createFromEntity(patrolTime);
    final targetRecord = PatrolRecord.fromModel(patrolTimeModel);
    await patrolRecordDatasource.upsertById(targetRecord);
  }

  @override
  Future<void> createByEntity(PatrolTime patrolTime) async {
    final patrolTimeModel = patrolTimeModelFactory.createFromEntity(patrolTime);
    final targetRecord = PatrolRecord.fromModel(patrolTimeModel);
    await patrolRecordDatasource.createByRecord(targetRecord);
  }

  @override
  Future<void> delete(PatrolTime patrolTime) async {
    final patrolTimeModel = patrolTimeModelFactory.createFromEntity(patrolTime);
    final targetRecord = PatrolRecord.fromModel(patrolTimeModel);
    await patrolRecordDatasource.deleteIfExists(targetRecord);
  }

  @override
  Future<void> export(
    List<PatrolTime> entityList,
    ExportFormat format,
    String filename,
  ) async {
    final patrolTimeModelList = entityList
        .map((entity) => patrolTimeModelFactory.createFromEntity(entity))
        .toList();
    await exportDatasource.export(
      format: format,
      data: patrolTimeModelList,
      filename: filename,
    );
  }
}
