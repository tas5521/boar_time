import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource.dart';
import 'package:boar_time/infrastructure/isar/work_record/work_record.dart';
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
  Future<void> upsertByDate(WorkRecord newRecord) async {
    final exist = await getByDate(newRecord.date);
    if (exist == null) {
      await _update(newRecord);
    } else {
      exist.startTime = newRecord.startTime;
      exist.endTime = newRecord.endTime;
      exist.breakStart = newRecord.breakStart;
      exist.breakEnd = newRecord.breakEnd;
      await _update(exist);
    }
  }

  Future<void> _update(WorkRecord record) async {
    await isar.writeTxn(() => isar.workRecords.put(record));
  }
}
