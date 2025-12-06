import 'package:boar_time/model/work_record/work_record.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class WorkRecordManager {
  static Isar? _isar;

  static Future<void> initialize() async {
    if (_isar != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [WorkRecordSchema],
      directory: dir.path,
    );
  }

  static Isar get isar => _isar!;

  static Future<WorkRecord?> getByDate(DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    return await isar.workRecords
        .filter()
        .dateEqualTo(targetDate)
        .findFirst();
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

  static Future<void> delete(int id) async {
    await isar.writeTxn(() => isar.workRecords.delete(id));
  }

  static Future<void> deleteAll() async {
    await isar.writeTxn(() => isar.workRecords.clear());
  }

  static Future<void> upsertByDate(WorkRecord newRecord) async {
    final exist = await getByDate(newRecord.date);

    if (exist == null) {
      await add(newRecord);
    } else {
      exist.startTime = newRecord.startTime;
      exist.endTime = newRecord.endTime;
      exist.breakStart = newRecord.breakStart;
      exist.breakEnd = newRecord.breakEnd;
      exist.patrolStart = newRecord.patrolStart;
      exist.patrolEnd = newRecord.patrolEnd;
      await update(exist);
    }
  }
}
