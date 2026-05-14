import 'package:boar_time/core/work_record/infrastructure/datasource/work_record_datasource.dart';
import 'package:boar_time/core/work_record/domain/repositories/work_record_repository.dart';
import 'package:boar_time/core/work_record/infrastructure/isar/work_record/work_record.dart';

class WorkRecordRepositoryImpl implements WorkRecordRepository {
  WorkRecordRepositoryImpl(this._workRecordDatasource);

  final WorkRecordDatasource _workRecordDatasource;

  @override
  Future<WorkRecord?> getByDate(DateTime date) =>
      _workRecordDatasource.getByDate(date);

  @override
  Future<void> upsertByDate(WorkRecord record) =>
      _workRecordDatasource.upsertByDate(record);
}
