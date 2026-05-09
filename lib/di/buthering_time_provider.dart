import 'package:boar_time/application/usecase/butchering_time_usecase_impl.dart';
import 'package:boar_time/di/stamping_time_provider.dart';
import 'package:boar_time/domain/factory/batchering_time_factory.dart';
import 'package:boar_time/domain/factory/batchering_time_model_factory.dart';
import 'package:boar_time/domain/repositories/butchering_time_repository.dart';
import 'package:boar_time/domain/usecase/butchering_time_usecase.dart';
import 'package:boar_time/infrastructure/factory/butchering_time_factory_impl.dart';
import 'package:boar_time/infrastructure/factory/butchering_time_model_factory_impl.dart';
import 'package:boar_time/infrastructure/repositories/butchering_time_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final butcheringTimeFactoryProvider = Provider<ButcheringTimeFactory>(
  (ref) => ButcheringTimeFactoryImpl(),
);

final butcheringTimeModelFactoryProvider = Provider<ButcheringTimeModelFactory>(
  (ref) => ButcheringTimeModelFactoryImpl(),
);

final butcheringTimeRepositoryProvider = Provider<ButcheringTimeRepository>((
  ref,
) {
  final workRecordDatasource = ref.watch(workRecordDatasourceProvider);
  final butcheringTimeFactory = ref.watch(butcheringTimeFactoryProvider);
  final butcheringTimeModelFactory = ref.watch(
    butcheringTimeModelFactoryProvider,
  );
  return ButcheringTimeRepositoryImpl(
    workRecordDatasource: workRecordDatasource,
    butcheringTimeFactory: butcheringTimeFactory,
    butcheringTimeModelFactory: butcheringTimeModelFactory,
  );
});

final butcheringTimeUsecaseProvider = Provider<ButcheringTimeUsecase>((ref) {
  final butcheringTimeRepository = ref.watch(butcheringTimeRepositoryProvider);
  return ButcheringTimeUsecaseImpl(
    butcheringTimeRepository: butcheringTimeRepository,
  );
});
