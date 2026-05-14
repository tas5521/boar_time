import 'package:boar_time/core/patrol_record/infrastructure/isar/patrol_record/patrol_record.dart';

abstract class PatrolRecordDatasource {
  Future<PatrolRecord?> getActive(DateTime date);
  Future<List<PatrolRecord>> getByDate(DateTime date);
  Future<List<PatrolRecord>> getByMonth(int year, int month);
  Future<void> create(DateTime date, DateTime start);
  Future<void> createByRecord(PatrolRecord record);
  Future<void> update(PatrolRecord record);
  Future<void> upsertById(PatrolRecord record);
  Future<bool> deleteIfExists(PatrolRecord record);
}
