import 'package:boar_time/model/work_record/work_record.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

enum UpsertType { butchering, patrol }

class WorkRecordManager {
  static Isar? _isar;

  static Future<void> initialize() async {
    if (_isar != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([WorkRecordSchema], directory: dir.path);
  }

  static Isar get isar => _isar!;

  static Future<WorkRecord?> getByDate(DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    return await isar.workRecords.filter().dateEqualTo(targetDate).findFirst();
  }

  static Future<List<WorkRecord>> getAll() async {
    return await isar.workRecords.where().findAll();
  }

  static Future<int> add(WorkRecord record) async {
    return await isar.writeTxn(() => isar.workRecords.put(record));
  }

  static Future<void> update(WorkRecord record) async {
    await isar.writeTxn(() => isar.workRecords.put(record));
  }

  static Future<void> clearButcheringStartTime(DateTime date) async {
    final record = await getByDate(date);
    if (record != null) {
      record.startTime = null;
      await update(record);
    }
  }

  static Future<void> clearButcheringEndTime(DateTime date) async {
    final record = await getByDate(date);
    if (record != null) {
      record.endTime = null;
      await update(record);
    }
  }

  static Future<void> clearBreakStart(DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    final record = await getByDate(targetDate);
    if (record != null) {
      record.breakStart = null;
      await update(record);
    }
  }

  static Future<void> clearBreakEnd(DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    final record = await getByDate(targetDate);
    if (record != null) {
      record.breakEnd = null;
      await update(record);
    }
  }

  static Future<void> clearPatrolStart(DateTime date) async {
    final record = await getByDate(date);
    if (record != null) {
      record.patrolStart = null;
      await update(record);
    }
  }

  static Future<void> clearPatrolEnd(DateTime date) async {
    final record = await getByDate(date);
    if (record != null) {
      record.patrolEnd = null;
      await update(record);
    }
  }

  static Future<void> delete(int id) async {
    await isar.writeTxn(() => isar.workRecords.delete(id));
  }

  static Future<void> deleteAll() async {
    await isar.writeTxn(() => isar.workRecords.clear());
  }

  static Future<void> upsertByDate(
    WorkRecord newRecord, {
    required UpsertType upsertType,
  }) async {
    final exist = await getByDate(newRecord.date);
    if (exist == null) {
      await add(newRecord);
    } else {
      switch (upsertType) {
        case UpsertType.butchering:
          exist.startTime = newRecord.startTime;
          exist.endTime = newRecord.endTime;
          exist.breakStart = newRecord.breakStart;
          exist.breakEnd = newRecord.breakEnd;
        case UpsertType.patrol:
          exist.patrolStart = newRecord.patrolStart;
          exist.patrolEnd = newRecord.patrolEnd;
      }
      await update(exist);
    }
  }

  static Future<void> updateBreak(
    DateTime date,
    DateTime? breakStart,
    DateTime? breakEnd,
  ) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    final record = await getByDate(targetDate);
    if (record == null) {
      await add(
        WorkRecord(
          date: targetDate,
          breakStart: breakStart,
          breakEnd: breakEnd,
        ),
      );
    } else {
      record.breakStart = breakStart;
      record.breakEnd = breakEnd;
      await update(record);
    }
  }
}
