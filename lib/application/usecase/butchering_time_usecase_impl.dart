import 'package:boar_time/domain/enums/export_format.dart';
import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/domain/repositories/butchering_time_repository.dart';
import 'package:boar_time/domain/usecase/butchering_time_usecase.dart';

class ButcheringTimeUsecaseImpl implements ButcheringTimeUsecase {
  ButcheringTimeUsecaseImpl(this._butcheringTimeRepository);

  final ButcheringTimeRepository _butcheringTimeRepository;

  @override
  Future<List<ButcheringTime>> getButcheringTimeList(
    int year,
    int month,
  ) async {
    final allButcheringTimeList = await _butcheringTimeRepository
        .getButcheringTimeList();
    return allButcheringTimeList
        .where((e) => e.date.year == year && e.date.month == month)
        .toList();
  }

  @override
  Future<void> upsert(ButcheringTime butcheringTime) =>
      _butcheringTimeRepository.upsert(butcheringTime);

  @override
  Future<void> export(
    List<ButcheringTime> entityList,
    ExportFormat format,
    String filename,
  ) => _butcheringTimeRepository.export(entityList, format, filename);
}
