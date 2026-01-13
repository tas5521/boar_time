import 'package:isar_community/isar.dart';

part 'app_meta.g.dart';

@collection
class AppMeta {
  Id id = 0; // 常に1件
  bool patrolMigrated;

  AppMeta({this.patrolMigrated = false});
}
