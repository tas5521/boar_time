import 'package:boar_time/core/isar/di/isar_provider.dart';
import 'package:boar_time/core/work_record/infrastructure/datasource/work_record_datasource.dart';
import 'package:boar_time/core/work_record/infrastructure/datasource/work_record_datasource_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final workRecordDatasourceProvider = Provider<WorkRecordDatasource>(
  (ref) => WorkRecordDatasourceImpl(ref.watch(isarProvider)),
);
