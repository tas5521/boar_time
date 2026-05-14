import 'package:boar_time/shared/enums/export_format.dart';
import 'package:boar_time/features/butchering/domain/entities/butchering_time.dart';
import 'package:boar_time/features/butchering/domain/repositories/butchering_time_repository.dart';
import 'package:boar_time/core/work_record/infrastructure/datasource/work_record_datasource.dart';
import 'package:boar_time/features/butchering/infrastructure/services/butchering_time_export_service.dart';
import 'package:boar_time/features/butchering/infrastructure/factory/butchering_time/butchering_time_factory.dart';
import 'package:boar_time/features/butchering/infrastructure/factory/butchering_time/butchering_time_model_factory.dart';
import 'package:boar_time/features/butchering/infrastructure/model/butchering_time_model.dart';
import 'package:boar_time/core/work_record/infrastructure/isar/work_record/work_record.dart';

class ButcheringTimeRepositoryImpl implements ButcheringTimeRepository {
  ButcheringTimeRepositoryImpl(
    this._workRecordDatasource,
    this._butcheringTimeFactory,
    this._butcheringTimeModelFactory,
    this._exportService,
  );

  final WorkRecordDatasource _workRecordDatasource;
  final ButcheringTimeFactory _butcheringTimeFactory;
  final ButcheringTimeModelFactory _butcheringTimeModelFactory;
  final ButcheringTimeExportService _exportService;

  @override
  Future<List<ButcheringTime>> getButcheringTimeList() async {
    final workRecords = await _workRecordDatasource.getAll();
    final modelList = workRecords
        .map((record) => ButcheringTimeModel.fromRecord(record))
        .toList();
    final butcheringTimeList = modelList
        .map((model) => _butcheringTimeFactory.createFromModel(model))
        .toList();
    return butcheringTimeList;
  }

  @override
  Future<void> upsert(ButcheringTime butcheringTime) async {
    final butcheringTimeModel = _butcheringTimeModelFactory.createFromEntity(
      butcheringTime,
    );
    final targetRecord = WorkRecord(
      date: butcheringTimeModel.date,
      startTime: butcheringTimeModel.startTime,
      endTime: butcheringTimeModel.endTime,
      breakStart: butcheringTimeModel.breakStart,
      breakEnd: butcheringTimeModel.breakEnd,
    );
    await _workRecordDatasource.upsertByDate(targetRecord);
  }

  @override
  Future<void> export(
    List<ButcheringTime> entityList,
    ExportFormat format,
    String filename,
  ) async {
    final butcheringTimeModelList = entityList
        .map((entity) => _butcheringTimeModelFactory.createFromEntity(entity))
        .toList();
    await _exportService.export(
      data: butcheringTimeModelList,
      format: format,
      filename: filename,
    );
  }
}
