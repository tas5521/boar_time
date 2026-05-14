import 'package:boar_time/core/work_record/di/work_record_datasource_provider.dart';
import 'package:boar_time/core/work_record/domain/repositories/work_record_repository.dart';
import 'package:boar_time/core/work_record/infrastructure/repositories/work_record_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final workRecordRepositoryProvider = Provider<WorkRecordRepository>(
  (ref) => WorkRecordRepositoryImpl(ref.watch(workRecordDatasourceProvider)),
);
