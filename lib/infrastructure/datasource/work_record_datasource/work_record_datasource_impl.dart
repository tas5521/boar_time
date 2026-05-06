import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:boar_time/model/job_type.dart';
import 'package:isar_community/isar.dart';

class WorkRecordDatasourceImpl implements WorkRecordDatasource {
  WorkRecordDatasourceImpl({required this.isar});

  final Isar isar;

  @override
  Future<WorkRecord?> getByDate(DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    return await isar.workRecords.filter().dateEqualTo(targetDate).findFirst();
  }

  @override
  Future<List<WorkRecord>> getAll() async {
    return await isar.workRecords.where().findAll();
  }

  @override
  Future<int> add(WorkRecord record) async {
    return await isar.writeTxn(() => isar.workRecords.put(record));
  }

  @override
  Future<void> update(WorkRecord record) async {
    await isar.writeTxn(() => isar.workRecords.put(record));
  }

  @override
  Future<void> clearBreakStart(DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    final record = await getByDate(targetDate);
    if (record != null) {
      record.breakStart = null;
      await update(record);
    }
  }

  @override
  Future<void> clearBreakEnd(DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    final record = await getByDate(targetDate);
    if (record != null) {
      record.breakEnd = null;
      await update(record);
    }
  }

  @override
  Future<void> clearPatrolStart(DateTime date) async {
    final record = await getByDate(date);
    if (record != null) {
      record.patrolStart = null;
      await update(record);
    }
  }

  @override
  Future<void> clearPatrolEnd(DateTime date) async {
    final record = await getByDate(date);
    if (record != null) {
      record.patrolEnd = null;
      await update(record);
    }
  }

  @override
  Future<void> delete(int id) async {
    await isar.writeTxn(() => isar.workRecords.delete(id));
  }

  @override
  Future<void> deleteAll() async {
    await isar.writeTxn(() => isar.workRecords.clear());
  }

  @override
  Future<void> upsertByDate(
    WorkRecord newRecord, {
    required JobType type,
  }) async {
    final exist = await getByDate(newRecord.date);
    if (exist == null) {
      await add(newRecord);
    } else {
      switch (type) {
        case JobType.butchering:
          exist.startTime = newRecord.startTime;
          exist.endTime = newRecord.endTime;
          exist.breakStart = newRecord.breakStart;
          exist.breakEnd = newRecord.breakEnd;
        case JobType.patrol:
          exist.patrolStart = newRecord.patrolStart;
          exist.patrolEnd = newRecord.patrolEnd;
      }
      await update(exist);
    }
  }

  @override
  Future<void> updateBreak(
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
