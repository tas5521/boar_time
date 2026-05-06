import 'package:boar_time/model/patrol_record/patrol_record.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:boar_time/utils/migration/app_meta.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

//TODO: 後で消す
class IsarManager {
  static Isar? _isar;

  static Future<void> initialize() async {
    if (_isar != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      AppMetaSchema,
      WorkRecordSchema,
      PatrolRecordSchema,
    ], directory: dir.path);
  }

  static Isar get isar => _isar!;
}
