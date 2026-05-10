import 'package:boar_time/application/usecase/butchering_time_usecase_impl.dart';
import 'package:boar_time/di/export_datasource_provider.dart';
import 'package:boar_time/di/stamping_time_provider.dart';
import 'package:boar_time/domain/repositories/butchering_time_repository.dart';
import 'package:boar_time/domain/usecase/butchering_time_usecase.dart';
import 'package:boar_time/infrastructure/factory/butchering_time/butchering_time_factory_impl.dart';
import 'package:boar_time/infrastructure/factory/butchering_time/butchering_time_model_factory_impl.dart';
import 'package:boar_time/infrastructure/repositories/butchering_time_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final butcheringTimeFactoryProvider = Provider<ButcheringTimeFactory>(
  (_) => ButcheringTimeFactory(),
);

final butcheringTimeModelFactoryProvider = Provider<ButcheringTimeModelFactory>(
  (_) => ButcheringTimeModelFactory(),
);

final butcheringTimeRepositoryProvider = Provider<ButcheringTimeRepository>((
  ref,
) {
  final workRecordDatasource = ref.watch(workRecordDatasourceProvider);
  final butcheringTimeFactory = ref.watch(butcheringTimeFactoryProvider);
  final butcheringTimeModelFactory = ref.watch(
    butcheringTimeModelFactoryProvider,
  );
  final exportDatasource = ref.watch(exportDatasourceProvider);
  return ButcheringTimeRepositoryImpl(
    workRecordDatasource: workRecordDatasource,
    butcheringTimeFactory: butcheringTimeFactory,
    butcheringTimeModelFactory: butcheringTimeModelFactory,
    exportDatasource: exportDatasource,
  );
});

final butcheringTimeUsecaseProvider = Provider<ButcheringTimeUsecase>((ref) {
  final butcheringTimeRepository = ref.watch(butcheringTimeRepositoryProvider);
  return ButcheringTimeUsecaseImpl(
    butcheringTimeRepository: butcheringTimeRepository,
  );
});
