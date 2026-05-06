import 'package:boar_time/application/usecase/stamping_time_usecase_impl.dart';
import 'package:boar_time/di/isar_provider.dart';
import 'package:boar_time/domain/factory/stamping_time_factory.dart';
import 'package:boar_time/domain/repositories/patrol_record_repository.dart';
import 'package:boar_time/domain/repositories/stamping_time_repository.dart';
import 'package:boar_time/domain/repositories/work_record_repository.dart';
import 'package:boar_time/domain/usecase/stamping_time_usecase.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource_impl.dart';
import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource.dart';
import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource_impl.dart';
import 'package:boar_time/infrastructure/factory/stamping_time_factory_impl.dart';
import 'package:boar_time/infrastructure/repositories/patrol_record_repository_impl.dart';
import 'package:boar_time/infrastructure/repositories/stamping_time_repository_impl.dart';
import 'package:boar_time/infrastructure/repositories/work_record_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final workRecordDatasourceProvider = Provider<WorkRecordDatasource>((ref) {
  final isar = ref.watch(isarProvider);
  return WorkRecordDatasourceImpl(isar: isar);
});

final patrolRecordDatasourceProvider = Provider<PatrolRecordDatasource>((ref) {
  final isar = ref.watch(isarProvider);
  return PatrolRecordDatasourceImpl(isar: isar);
});

final stampingTimeFactoryProvider = Provider<StampingTimeFactory>(
  (ref) => StampingTimeFactoryImpl(),
);

final stampingTimeRepositoryProvider = Provider<StampingTimeRepository>((ref) {
  final workRecordDatasource = ref.watch(workRecordDatasourceProvider);
  final patrolRecordDatasource = ref.watch(patrolRecordDatasourceProvider);
  final stampingTimeFactory = ref.watch(stampingTimeFactoryProvider);
  return StampingTimeRepositoryImpl(
    workRecordDatasource: workRecordDatasource,
    patrolRecordDatasource: patrolRecordDatasource,
    stampingTimeFactory: stampingTimeFactory,
  );
});

final workRecordRepositoryProvider = Provider<WorkRecordRepository>((ref) {
  final workRecordDatasource = ref.watch(workRecordDatasourceProvider);
  return WorkRecordRepositoryImpl(workRecordDatasource: workRecordDatasource);
});

final patrolRecordRepositoryProvider = Provider<PatrolRecordRepository>((ref) {
  final patrolRecordDatasource = ref.watch(patrolRecordDatasourceProvider);
  return PatrolRecordRepositoryImpl(
    patrolRecordDatasource: patrolRecordDatasource,
  );
});

final stampingTimeUsecaseProvider = Provider<StampingTimeUsecase>((ref) {
  final stampingTimeRepository = ref.watch(stampingTimeRepositoryProvider);
  final workRecordRepository = ref.watch(workRecordRepositoryProvider);
  final patrolRecordRepository = ref.watch(patrolRecordRepositoryProvider);
  return StampingTimeUsecaseImpl(
    stampingTimeRepository,
    workRecordRepository,
    patrolRecordRepository,
  );
});
