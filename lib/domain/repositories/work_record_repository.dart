import 'package:boar_time/infrastructure/isar/work_record/work_record.dart';

abstract interface class WorkRecordRepository {
  Future<WorkRecord?> getByDate(DateTime date);
  Future<void> upsertByDate(WorkRecord record);
}
