import 'package:boar_time/core/isar/di/isar_provider.dart';
import 'package:boar_time/core/patrol_record/infrastructure/datasource/patrol_record_datasource.dart';
import 'package:boar_time/core/patrol_record/infrastructure/datasource/patrol_record_datasource_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patrolRecordDatasourceProvider = Provider<PatrolRecordDatasource>(
  (ref) => PatrolRecordDatasourceImpl(ref.watch(isarProvider)),
);
