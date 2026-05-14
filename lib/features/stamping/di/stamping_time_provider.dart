import 'package:boar_time/core/patrol_record/di/patrol_record_datasource_provider.dart';
import 'package:boar_time/core/patrol_record/di/patrol_record_repository_provider.dart';
import 'package:boar_time/core/work_record/di/work_record_datasource_provider.dart';
import 'package:boar_time/core/work_record/di/work_record_repository_provider.dart';
import 'package:boar_time/features/stamping/application/stamping_time_usecase_impl.dart';
import 'package:boar_time/features/stamping/domain/repositories/stamping_time_repository.dart';
import 'package:boar_time/features/stamping/domain/usecase/stamping_time_usecase.dart';
import 'package:boar_time/features/stamping/infrastructure/factory/stamping_time/stamping_time_factory.dart';
import 'package:boar_time/features/stamping/infrastructure/repositories/stamping_time_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

final stampingTimeUsecaseProvider = Provider<StampingTimeUsecase>(
  (ref) => StampingTimeUsecaseImpl(
    ref.watch(stampingTimeRepositoryProvider),
    ref.watch(workRecordRepositoryProvider),
    ref.watch(patrolRecordRepositoryProvider),
  ),
);
