import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/domain/repositories/butchering_time_repository.dart';
import 'package:boar_time/domain/usecase/butchering_time_usecase.dart';

class ButcheringTimeUsecaseImpl implements ButcheringTimeUsecase {
  ButcheringTimeUsecaseImpl({required this.butheringTimeRepository});

  final ButcheringTimeRepository butheringTimeRepository;

  @override
  Future<List<ButcheringTime>> getButcheringTimeList(
    int year,
    int month,
  ) async {
    final allButcheringTimeList = await butheringTimeRepository
        .getButcheringTimeList();
    return allButcheringTimeList
        .where((e) => e.date.year == year && e.date.month == month)
        .toList();
  }

  @override
  Future<void> upsert(ButcheringTime butcheringTime) =>
      butheringTimeRepository.upsert(butcheringTime);
}

// Future<void> exportAndSave({
//   required ExportFormat format,
//   required String filename,
// }) async {
//   final data = state.valueOrNull ?? [];
//   await ExportManager.exportAndSave(
//     type: JobType.butchering,
//     format: format,
//     data: data,
//     filename: filename,
//   );
// }
