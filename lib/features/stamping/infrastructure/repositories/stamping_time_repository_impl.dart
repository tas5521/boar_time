import 'package:boar_time/features/stamping/domain/entities/stamping_time.dart';
import 'package:boar_time/features/stamping/domain/repositories/stamping_time_repository.dart';
import 'package:boar_time/core/patrol_record/infrastructure/datasource/patrol_record_datasource.dart';
import 'package:boar_time/core/work_record/infrastructure/datasource/work_record_datasource.dart';
import 'package:boar_time/features/stamping/infrastructure/factory/stamping_time/stamping_time_factory.dart';
import 'package:boar_time/features/stamping/infrastructure/model/stamping_time_model.dart';
import 'package:boar_time/core/work_record/infrastructure/isar/work_record/work_record.dart';

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
