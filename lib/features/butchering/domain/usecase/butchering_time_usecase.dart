import 'package:boar_time/shared/enums/export_format.dart';
import 'package:boar_time/features/butchering/domain/entities/butchering_time.dart';

abstract interface class ButcheringTimeUsecase {
  Future<List<ButcheringTime>> getButcheringTimeList(int year, int month);
  Future<void> upsert(ButcheringTime butcheringTime);
  Future<void> export(
    List<ButcheringTime> entityList,
    ExportFormat format,
    String filename,
  );
}
