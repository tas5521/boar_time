import 'package:boar_time/shared/enums/export_format.dart';
import 'package:boar_time/features/butchering/domain/entities/butchering_time.dart';

abstract interface class ButcheringTimeRepository {
  Future<List<ButcheringTime>> getButcheringTimeList();
  Future<void> upsert(ButcheringTime butcheringTime);
  Future<void> export(
    List<ButcheringTime> entityList,
    ExportFormat format,
    String filename,
  );
}
