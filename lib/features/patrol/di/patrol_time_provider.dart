import 'package:boar_time/core/export/di/export_file_writer_provider.dart';
import 'package:boar_time/core/patrol_record/di/patrol_record_datasource_provider.dart';
import 'package:boar_time/features/patrol/application/patrol_time_usecase_impl.dart';
import 'package:boar_time/features/patrol/domain/repositories/patrol_time_repository.dart';
import 'package:boar_time/features/patrol/domain/usecase/patrol_time_usecase.dart';
import 'package:boar_time/features/patrol/infrastructure/services/patrol_time_export_service.dart';
import 'package:boar_time/features/patrol/infrastructure/factory/patrol_time/patrol_time_factory.dart';
import 'package:boar_time/features/patrol/infrastructure/factory/patrol_time/patrol_time_model_factory.dart';
import 'package:boar_time/features/patrol/infrastructure/repositories/patrol_time_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patrolTimeFactoryProvider = Provider<PatrolTimeFactory>(
  (_) => PatrolTimeFactory(),
);

final patrolTimeModelFactoryProvider = Provider<PatrolTimeModelFactory>(
  (_) => PatrolTimeModelFactory(),
);

final patrolTimeExportServiceProvider = Provider<PatrolTimeExportService>(
  (ref) => PatrolTimeExportService(ref.watch(exportFileWriterProvider)),
);

final patrolTimeRepositoryProvider = Provider<PatrolTimeRepository>(
  (ref) => PatrolTimeRepositoryImpl(
    ref.watch(patrolRecordDatasourceProvider),
    ref.watch(patrolTimeFactoryProvider),
    ref.watch(patrolTimeModelFactoryProvider),
    ref.watch(patrolTimeExportServiceProvider),
  ),
);

final patrolTimeUsecaseProvider = Provider<PatrolTimeUsecase>(
  (ref) => PatrolTimeUsecaseImpl(ref.watch(patrolTimeRepositoryProvider)),
);
