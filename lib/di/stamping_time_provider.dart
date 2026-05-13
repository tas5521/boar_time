import 'package:boar_time/application/usecase/stamping_time_usecase_impl.dart';
import 'package:boar_time/di/isar_provider.dart';
import 'package:boar_time/domain/repositories/patrol_record_repository.dart';
import 'package:boar_time/domain/repositories/stamping_time_repository.dart';
import 'package:boar_time/domain/repositories/work_record_repository.dart';
import 'package:boar_time/domain/usecase/stamping_time_usecase.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource.dart';
import 'package:boar_time/infrastructure/datasource/patrol_record_datasource/patrol_record_datasource_impl.dart';
import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource.dart';
import 'package:boar_time/infrastructure/datasource/work_record_datasource/work_record_datasource_impl.dart';
import 'package:boar_time/infrastructure/factory/stamping_time/stamping_time_factory.dart';
import 'package:boar_time/infrastructure/repositories/patrol_record_repository_impl.dart';
import 'package:boar_time/infrastructure/repositories/stamping_time_repository_impl.dart';
import 'package:boar_time/infrastructure/repositories/work_record_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final workRecordDatasourceProvider = Provider<WorkRecordDatasource>(
  (ref) => WorkRecordDatasourceImpl(ref.watch(isarProvider)),
);

final patrolRecordDatasourceProvider = Provider<PatrolRecordDatasource>(
  (ref) => PatrolRecordDatasourceImpl(ref.watch(isarProvider)),
);

final stampingTimeFactoryProvider = Provider<StampingTimeFactory>(
  (_) => StampingTimeFactory(),
);

final stampingTimeRepositoryProvider = Provider<StampingTimeRepository>(
  (ref) => StampingTimeRepositoryImpl(
    ref.watch(workRecordDatasourceProvider),
    ref.watch(patrolRecordDatasourceProvider),
    ref.watch(stampingTimeFactoryProvider),
  ),
);

final workRecordRepositoryProvider = Provider<WorkRecordRepository>(
  (ref) => WorkRecordRepositoryImpl(ref.watch(workRecordDatasourceProvider)),
);

final patrolRecordRepositoryProvider = Provider<PatrolRecordRepository>(
  (ref) =>
      PatrolRecordRepositoryImpl(ref.watch(patrolRecordDatasourceProvider)),
);

final stampingTimeUsecaseProvider = Provider<StampingTimeUsecase>(
  (ref) => StampingTimeUsecaseImpl(
    ref.watch(stampingTimeRepositoryProvider),
    ref.watch(workRecordRepositoryProvider),
    ref.watch(patrolRecordRepositoryProvider),
  ),
);
