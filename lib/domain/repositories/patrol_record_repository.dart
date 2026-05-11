import 'package:boar_time/infrastructure/isar/patrol_record/patrol_record.dart';

abstract class PatrolRecordRepository {
  Future<PatrolRecord?> getActive(DateTime date);
  Future<void> create(DateTime date, DateTime start);
  Future<void> update(PatrolRecord record);
}
