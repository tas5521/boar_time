import 'package:boar_time/infrastructure/isar/work_record/work_record.dart';

abstract class WorkRecordDatasource {
  Future<WorkRecord?> getByDate(DateTime date);
  Future<List<WorkRecord>> getAll();
  Future<void> upsertByDate(WorkRecord newRecord);
}
