import 'package:boar_time/model/patrol_record/patrol_record.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:boar_time/utils/migration/app_meta.dart';
import 'package:isar_community/isar.dart';

Future<void> migratePatrolData(Isar isar) async {
  final meta = await isar.appMetas.get(0);

  if (meta != null && meta.patrolMigrated) return;

  final records = await isar.workRecords
      .filter()
      .patrolStartIsNotNull()
      .findAll();

  await isar.writeTxn(() async {
    for (final record in records) {
      final patrol = PatrolRecord(
        date: record.date,
        start: record.patrolStart!,
        end: record.patrolEnd,
      );

      await isar.patrolRecords.put(patrol);

      record.patrolStart = null;
      record.patrolEnd = null;
      await isar.workRecords.put(record);
    }

    await isar.appMetas.put(AppMeta(patrolMigrated: true));
  });
}
