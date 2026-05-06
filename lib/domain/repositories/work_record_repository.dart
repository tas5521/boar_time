import 'package:boar_time/model/job_type.dart';
import 'package:boar_time/model/work_record/work_record.dart';

abstract class WorkRecordRepository {
  Future<WorkRecord?> getByDate(DateTime date);
  Future<void> upsertByDate(WorkRecord record, {required JobType type});
}
