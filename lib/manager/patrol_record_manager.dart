import 'package:boar_time/manager/isar_manager.dart';
import 'package:boar_time/model/patrol_record/patrol_record.dart';
import 'package:isar_community/isar.dart';

class PatrolRecordManager {
  static Isar get isar => IsarManager.isar;

  static Future<PatrolRecord?> getActive(DateTime date) async {
    return isar.patrolRecords
        .filter()
        .dateEqualTo(date)
        .endIsNull()
        .findFirst();
  }

  static Future<List<PatrolRecord>> getByDate(DateTime date) async {
    return isar.patrolRecords
        .filter()
        .dateEqualTo(date)
        .sortByStart()
        .findAll();
  }

  static Future<List<PatrolRecord>> getByMonth(int year, int month) async {
    final from = DateTime(year, month, 1);
    final to = DateTime(year, month + 1, 1);

    return isar.patrolRecords
        .where()
        .dateBetween(from, to, includeUpper: false)
        .sortByStart()
        .findAll();
  }

  static Future<void> create(DateTime date, DateTime start) async {
    await isar.writeTxn(() async {
      await isar.patrolRecords.put(PatrolRecord(date: date, start: start));
    });
  }

  static Future<void> update(PatrolRecord record) async {
    await isar.writeTxn(() async {
      await isar.patrolRecords.put(record);
    });
  }
}
