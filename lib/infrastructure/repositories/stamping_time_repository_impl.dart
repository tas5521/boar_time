import 'package:boar_time/domain/entities/stamping_time.dart';
import 'package:boar_time/domain/factory/stamping_time_factory.dart';
import 'package:boar_time/domain/repositories/stamping_time_repository.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource.dart';
import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource.dart';
import 'package:boar_time/infrastructure/model/stamping_time_model.dart';
import 'package:boar_time/model/work_record/work_record.dart';

class StampingTimeRepositoryImpl implements StampingTimeRepository {
  StampingTimeRepositoryImpl({
    required this.workRecordDatasource,
    required this.patrolRecordDatasource,
    required this.stampingTimeFactory,
  });

  final WorkRecordDatasource workRecordDatasource;
  final PatrolRecordDatasource patrolRecordDatasource;
  final StampingTimeFactory stampingTimeFactory;

  @override
  Future<StampingTime> getStampingTime(DateTime today) async {
    final existing = await workRecordDatasource.getByDate(today);
    final workRecord = existing ?? WorkRecord(date: today);
    final patrolRecords = await patrolRecordDatasource.getByDate(today);
    final model = StampingTimeModel.fromRecords(workRecord, patrolRecords);
    final stampingTime = stampingTimeFactory.createFromModel(model);
    return stampingTime;
  }
}


//   // TODO: これいる？要確認
//   Future<void> fetch() async {
//     state = AsyncValue.loading();
//     final workRecord = await _getOrCreateTodayRecord();
//     final patrolRecords = await _getTodayPatrolRecords();
//     final stampingTimeState = StampingTimeState.fromRecord(
//       workRecord,
//       patrolRecords,
//     );
//     state = AsyncValue.data(stampingTimeState);
//   }






//   Future<void> setEndTime() async {
//     state = AsyncValue.loading();
//     final workRecord = await _getOrCreateTodayRecord();
//     workRecord.endTime = _nowRounded();
//     await WorkRecordManager.upsertByDate(workRecord, type: JobType.butchering);
//     final patrolRecords = await _getTodayPatrolRecords();
//     final stampingTimeState = StampingTimeState.fromRecord(
//       workRecord,
//       patrolRecords,
//     );
//     state = AsyncValue.data(stampingTimeState);
//   }

//   Future<void> setBreakStart() async {
//     state = AsyncValue.loading();
//     final workRecord = await _getOrCreateTodayRecord();
//     workRecord.breakStart = _nowRounded();
//     await WorkRecordManager.upsertByDate(workRecord, type: JobType.butchering);
//     final patrolRecords = await _getTodayPatrolRecords();
//     final stampingTimeState = StampingTimeState.fromRecord(
//       workRecord,
//       patrolRecords,
//     );
//     state = AsyncValue.data(stampingTimeState);
//   }

//   Future<void> setBreakEnd() async {
//     state = AsyncValue.loading();
//     final workRecord = await _getOrCreateTodayRecord();
//     workRecord.breakEnd = _nowRounded();
//     await WorkRecordManager.upsertByDate(workRecord, type: JobType.butchering);
//     final patrolRecords = await _getTodayPatrolRecords();
//     final stampingTimeState = StampingTimeState.fromRecord(
//       workRecord,
//       patrolRecords,
//     );
//     state = AsyncValue.data(stampingTimeState);
//   }

//   Future<void> setPatrolStart() async {
//     final preState = state;
//     state = AsyncValue.loading();
//     final today = todayDate;
//     final active = await PatrolRecordManager.getActive(today);
//     if (active == null) {
//       await PatrolRecordManager.create(today, _nowRounded());
//       await fetch();
//     } else {
//       state = preState;
//     }
//   }

//   Future<void> setPatrolEnd() async {
//     final preState = state;
//     state = AsyncValue.loading();
//     final active = await PatrolRecordManager.getActive(todayDate);

//     if (active != null) {
//       active.end = _nowRounded();
//       await PatrolRecordManager.update(active);
//       await fetch();
//     } else {
//       state = preState;
//     }
//   }
// }
