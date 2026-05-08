import 'package:boar_time/domain/entities/patrol_time.dart';
import 'package:boar_time/domain/repositories/patrol_time_repository.dart';
import 'package:boar_time/domain/usecase/patrol_time_usecase.dart';

class PatrolTimeUsecaseImpl implements PatrolTimeUsecase {
  PatrolTimeUsecaseImpl({required this.patrolTimeRepository});

  final PatrolTimeRepository patrolTimeRepository;

  @override
  Future<List<PatrolTime>> getPatrolTimeList(int year, int month) =>
      patrolTimeRepository.getPatrolTimeList(year, month);

  @override
  Future<void> upsert(PatrolTime patrolTime) =>
      patrolTimeRepository.upsert(patrolTime);
}

// TODO: 後でチェック。いらなかったら消す
// Future<void> exportAndSave({
//   required ExportFormat format,
//   required String filename,
// }) async {
//   final data = state.valueOrNull ?? [];
//   await ExportManager.exportAndSave(
//     type: JobType.patrol,
//     format: format,
//     data: data,
//     filename: filename,
//   );
// }
