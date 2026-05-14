import 'package:boar_time/core/work_record/infrastructure/isar/work_record/work_record.dart';

abstract class WorkRecordDatasource {
  Future<WorkRecord?> getByDate(DateTime date);
  Future<List<WorkRecord>> getAll();
  Future<void> upsertByDate(WorkRecord newRecord);
}
