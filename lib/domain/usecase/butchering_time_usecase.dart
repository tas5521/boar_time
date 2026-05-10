import 'package:boar_time/core/enums/export_format.dart';
import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/presentation/state/butchering_time_state/butchering_time_state.dart';

abstract class ButcheringTimeUsecase {
  Future<List<ButcheringTime>> getButcheringTimeList(int year, int month);
  Future<void> upsert(ButcheringTime butcheringTime);
  Future<void> export(
    List<ButcheringTimeState> stateList,
    ExportFormat format,
    String filename,
  );
}
