import 'package:boar_time/application/usecase/patrol_time_usecase_impl.dart';
import 'package:boar_time/di/export_datasource_provider.dart';
import 'package:boar_time/di/stamping_time_provider.dart';
import 'package:boar_time/domain/repositories/patrol_time_repository.dart';
import 'package:boar_time/domain/usecase/patrol_time_usecase.dart';
import 'package:boar_time/infrastructure/factory/patrol_time/patrol_time_model_factory.dart';
import 'package:boar_time/infrastructure/factory/patrol_time/patrol_time_factory.dart';
import 'package:boar_time/infrastructure/repositories/patrol_time_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patrolTimeFactoryProvider = Provider<PatrolTimeFactory>(
  (_) => PatrolTimeFactory(),
);

final patrolTimeModelFactoryProvider = Provider<PatrolTimeModelFactory>(
  (_) => PatrolTimeModelFactory(),
);

final patrolTimeRepositoryProvider = Provider<PatrolTimeRepository>((ref) {
  final patrolRecordDatasource = ref.watch(patrolRecordDatasourceProvider);
  final patrolTimeFactory = ref.watch(patrolTimeFactoryProvider);
  final patrolTimeModelFactory = ref.watch(patrolTimeModelFactoryProvider);
  final exportDatasource = ref.watch(exportDatasourceProvider);
  return PatrolTimeRepositoryImpl(
    patrolRecordDatasource: patrolRecordDatasource,
    patrolTimeFactory: patrolTimeFactory,
    patrolTimeModelFactory: patrolTimeModelFactory,
    exportDatasource: exportDatasource,
  );
});

final patrolTimeUsecaseProvider = Provider<PatrolTimeUsecase>((ref) {
  final patrolTimeRepository = ref.watch(patrolTimeRepositoryProvider);
  return PatrolTimeUsecaseImpl(patrolTimeRepository: patrolTimeRepository);
});
