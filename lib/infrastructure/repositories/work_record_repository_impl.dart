import 'package:boar_time/domain/repositories/work_record_repository.dart';
import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource.dart';
import 'package:boar_time/model/job_type.dart';
import 'package:boar_time/model/work_record/work_record.dart';

class WorkRecordRepositoryImpl implements WorkRecordRepository {
  WorkRecordRepositoryImpl({required this.workRecordDatasource});

  WorkRecordDatasource workRecordDatasource;

  @override
  Future<WorkRecord?> getByDate(DateTime date) =>
      workRecordDatasource.getByDate(date);

  @override
  Future<void> upsertByDate(WorkRecord record, {required JobType type}) =>
      workRecordDatasource.upsertByDate(record, type: type);
}
