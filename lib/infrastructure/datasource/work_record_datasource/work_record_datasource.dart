import 'package:boar_time/model/work_record/work_record.dart';

abstract class WorkRecordDatasource {
  Future<WorkRecord?> getByDate(DateTime date);
  Future<List<WorkRecord>> getAll();
  Future<void> clearBreakStart(DateTime date);
  Future<void> clearBreakEnd(DateTime date);
  Future<void> clearPatrolStart(DateTime date);
  Future<void> clearPatrolEnd(DateTime date);
  Future<void> delete(int id);
  Future<void> deleteAll();
  Future<void> upsertByDate(WorkRecord newRecord);
}
