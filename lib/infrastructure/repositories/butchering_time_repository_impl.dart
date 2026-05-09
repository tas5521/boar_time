import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/domain/factory/batchering_time_factory.dart';
import 'package:boar_time/domain/factory/batchering_time_model_factory.dart';
import 'package:boar_time/domain/repositories/butchering_time_repository.dart';
import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource.dart';
import 'package:boar_time/infrastructure/model/butchering_time_model.dart';
import 'package:boar_time/model/work_record/work_record.dart';

class ButcheringTimeRepositoryImpl implements ButcheringTimeRepository {
  ButcheringTimeRepositoryImpl({
    required this.workRecordDatasource,
    required this.butcheringTimeFactory,
    required this.butcheringTimeModelFactory,
  });

  final WorkRecordDatasource workRecordDatasource;
  final ButcheringTimeFactory butcheringTimeFactory;
  final ButcheringTimeModelFactory butcheringTimeModelFactory;

  @override
  Future<List<ButcheringTime>> getButcheringTimeList() async {
    final workRecords = await workRecordDatasource.getAll();
    final modelList = workRecords
        .map((record) => ButcheringTimeModel.fromRecord(record))
        .toList();
    final butcheringTimeList = modelList
        .map((model) => butcheringTimeFactory.createFromModel(model))
        .toList();
    return butcheringTimeList;
  }

  @override
  Future<void> upsert(ButcheringTime butcheringTime) async {
    final butcheringTimeModel = butcheringTimeModelFactory.createFromEntity(
      butcheringTime,
    );
    final targetRecord = WorkRecord.fromModel(butcheringTimeModel);
    await workRecordDatasource.upsertByDate(targetRecord);
  }
}
