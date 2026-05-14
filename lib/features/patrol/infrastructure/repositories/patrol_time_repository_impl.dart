import 'package:boar_time/shared/enums/export_format.dart';
import 'package:boar_time/features/patrol/domain/entities/patrol_time.dart';
import 'package:boar_time/features/patrol/domain/repositories/patrol_time_repository.dart';
import 'package:boar_time/core/patrol_record/infrastructure/datasource/patrol_record_datasource.dart';
import 'package:boar_time/features/patrol/infrastructure/services/patrol_time_export_service.dart';
import 'package:boar_time/features/patrol/infrastructure/factory/patrol_time/patrol_time_factory.dart';
import 'package:boar_time/features/patrol/infrastructure/factory/patrol_time/patrol_time_model_factory.dart';
import 'package:boar_time/features/patrol/infrastructure/model/patrol_time_model.dart';
import 'package:boar_time/core/patrol_record/infrastructure/isar/patrol_record/patrol_record.dart';

class PatrolTimeRepositoryImpl implements PatrolTimeRepository {
  PatrolTimeRepositoryImpl(
    this._patrolRecordDatasource,
    this._patrolTimeFactory,
    this._patrolTimeModelFactory,
    this._exportService,
  );

  final PatrolRecordDatasource _patrolRecordDatasource;
  final PatrolTimeFactory _patrolTimeFactory;
  final PatrolTimeModelFactory _patrolTimeModelFactory;
  final PatrolTimeExportService _exportService;

  @override
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month) async {
    final patrolRecords = await _patrolRecordDatasource.getByMonth(year, month);

    final modelList = patrolRecords
        .map((record) => PatrolTimeModel.fromRecord(record))
        .toList();
    final patrolTimeList = modelList
        .map((model) => _patrolTimeFactory.createFromModel(model))
        .toList();
    return patrolTimeList;
  }

  @override
  Future<void> upsert(PatrolTime patrolTime) async {
    final patrolTimeModel = _patrolTimeModelFactory.createFromEntity(
      patrolTime,
    );
    final targetRecord = _patrolRecordFromModel(patrolTimeModel);
    await _patrolRecordDatasource.upsertById(targetRecord);
  }

  @override
  Future<void> createByEntity(PatrolTime patrolTime) async {
    final patrolTimeModel = _patrolTimeModelFactory.createFromEntity(
      patrolTime,
    );
    final targetRecord = _patrolRecordFromModel(patrolTimeModel);
    await _patrolRecordDatasource.createByRecord(targetRecord);
  }

  @override
  Future<void> delete(PatrolTime patrolTime) async {
    final patrolTimeModel = _patrolTimeModelFactory.createFromEntity(
      patrolTime,
    );
    final targetRecord = _patrolRecordFromModel(patrolTimeModel);
    await _patrolRecordDatasource.deleteIfExists(targetRecord);
  }

  @override
  Future<void> export(
    List<PatrolTime> entityList,
    ExportFormat format,
    String filename,
  ) async {
    final patrolTimeModelList = entityList
        .map((entity) => _patrolTimeModelFactory.createFromEntity(entity))
        .toList();
    await _exportService.export(
      data: patrolTimeModelList,
      format: format,
      filename: filename,
    );
  }
}

PatrolRecord _patrolRecordFromModel(PatrolTimeModel m) {
  final record = PatrolRecord(
    date: m.date,
    start: m.start,
    end: m.end,
    label: m.label,
    worker: m.worker,
    location: m.location,
    animal: m.animal,
    count: m.count,
    note: m.note,
  );
  if (m.id != null) {
    record.id = m.id!;
  }
  return record;
}
