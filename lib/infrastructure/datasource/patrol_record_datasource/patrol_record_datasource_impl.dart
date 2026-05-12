import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource.dart';
import 'package:boar_time/infrastructure/isar/patrol_record/patrol_record.dart';
import 'package:isar_community/isar.dart';

class PatrolRecordDatasourceImpl implements PatrolRecordDatasource {
  PatrolRecordDatasourceImpl({required this.isar});

  final Isar isar;

  @override
  Future<PatrolRecord?> getActive(DateTime date) async {
    return isar.patrolRecords
        .filter()
        .dateEqualTo(date)
        .endIsNull()
        .findFirst();
  }

  @override
  Future<List<PatrolRecord>> getByDate(DateTime date) async {
    return isar.patrolRecords
        .filter()
        .dateEqualTo(date)
        .sortByStart()
        .findAll();
  }

  @override
  Future<List<PatrolRecord>> getByMonth(int year, int month) async {
    final from = DateTime(year, month, 1);
    final to = DateTime(year, month + 1, 1);

    return isar.patrolRecords
        .where()
        .dateBetween(from, to, includeUpper: false)
        .sortByStart()
        .findAll();
  }

  @override
  Future<void> create(DateTime date, DateTime start) async {
    await isar.writeTxn(() async {
      await isar.patrolRecords.put(PatrolRecord(date: date, start: start));
    });
  }

  @override
  Future<void> createByRecord(PatrolRecord record) async {
    await isar.writeTxn(() async {
      await isar.patrolRecords.put(
        PatrolRecord(
          date: record.date,
          start: record.start,
          end: record.end,
          label: record.label,
          location: record.location,
          animal: record.animal,
          count: record.count,
          note: record.note,
        ),
      );
    });
  }

  @override
  Future<void> update(PatrolRecord record) =>
      isar.writeTxn(() => isar.patrolRecords.put(record));

  @override
  Future<void> upsertById(PatrolRecord record) async {
    final exist = await isar.patrolRecords.get(record.id);
    if (exist == null) {
      await update(record);
    } else {
      exist.date = record.date;
      exist.start = record.start;
      exist.end = record.end;
      exist.label = record.label;
      exist.worker = record.worker;
      exist.location = record.location;
      exist.animal = record.animal;
      exist.count = record.count;
      exist.note = record.note;
      await update(exist);
    }
  }

  @override
  Future<bool> deleteIfExists(PatrolRecord record) =>
      isar.writeTxn(() => isar.patrolRecords.delete(record.id));
}
