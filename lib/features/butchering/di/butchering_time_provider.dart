import 'package:boar_time/core/export/di/export_file_writer_provider.dart';
import 'package:boar_time/core/work_record/di/work_record_datasource_provider.dart';
import 'package:boar_time/features/butchering/application/butchering_time_usecase_impl.dart';
import 'package:boar_time/features/butchering/domain/repositories/butchering_time_repository.dart';
import 'package:boar_time/features/butchering/domain/usecase/butchering_time_usecase.dart';
import 'package:boar_time/features/butchering/infrastructure/services/butchering_time_export_service.dart';
import 'package:boar_time/features/butchering/infrastructure/factory/butchering_time/butchering_time_factory.dart';
import 'package:boar_time/features/butchering/infrastructure/factory/butchering_time/butchering_time_model_factory.dart';
import 'package:boar_time/features/butchering/infrastructure/repositories/butchering_time_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final butcheringTimeFactoryProvider = Provider<ButcheringTimeFactory>(
  (_) => ButcheringTimeFactory(),
);

final butcheringTimeModelFactoryProvider = Provider<ButcheringTimeModelFactory>(
  (_) => ButcheringTimeModelFactory(),
);

final butcheringTimeExportServiceProvider =
    Provider<ButcheringTimeExportService>(
      (ref) => ButcheringTimeExportService(ref.watch(exportFileWriterProvider)),
    );

final butcheringTimeRepositoryProvider = Provider<ButcheringTimeRepository>(
  (ref) => ButcheringTimeRepositoryImpl(
    ref.watch(workRecordDatasourceProvider),
    ref.watch(butcheringTimeFactoryProvider),
    ref.watch(butcheringTimeModelFactoryProvider),
    ref.watch(butcheringTimeExportServiceProvider),
  ),
);

final butcheringTimeUsecaseProvider = Provider<ButcheringTimeUsecase>(
  (ref) =>
      ButcheringTimeUsecaseImpl(ref.watch(butcheringTimeRepositoryProvider)),
);
