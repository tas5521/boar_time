import 'package:boar_time/domain/entities/stamping_time.dart';
import 'package:boar_time/domain/repositories/stamping_time_repository.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource.dart';
import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource.dart';
import 'package:boar_time/infrastructure/factory/stamping_time/stamping_time_factory.dart';
import 'package:boar_time/infrastructure/model/stamping_time_model.dart';
import 'package:boar_time/infrastructure/isar/work_record/work_record.dart';

class StampingTimeRepositoryImpl implements StampingTimeRepository {
  StampingTimeRepositoryImpl(
    this._workRecordDatasource,
    this._patrolRecordDatasource,
    this._stampingTimeFactory,
  );

  final WorkRecordDatasource _workRecordDatasource;
  final PatrolRecordDatasource _patrolRecordDatasource;
  final StampingTimeFactory _stampingTimeFactory;

  @override
  Future<StampingTime> getStampingTime(DateTime today) async {
    final existing = await _workRecordDatasource.getByDate(today);
    final workRecord = existing ?? WorkRecord(date: today);
    final patrolRecords = await _patrolRecordDatasource.getByDate(today);
    final model = StampingTimeModel.fromRecords(workRecord, patrolRecords);
    final stampingTime = _stampingTimeFactory.createFromModel(model);
    return stampingTime;
  }
}
