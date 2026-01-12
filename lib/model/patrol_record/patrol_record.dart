import 'package:isar_community/isar.dart';

part 'patrol_record.g.dart';

@collection
class PatrolRecord {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;
  late DateTime start;
  DateTime? end;

  PatrolRecord({
    required this.date,
    required this.start,
    this.end,
  });
}
