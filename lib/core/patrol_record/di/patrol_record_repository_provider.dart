import 'package:boar_time/core/patrol_record/di/patrol_record_datasource_provider.dart';
import 'package:boar_time/core/patrol_record/domain/repositories/patrol_record_repository.dart';
import 'package:boar_time/core/patrol_record/infrastructure/repositories/patrol_record_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patrolRecordRepositoryProvider = Provider<PatrolRecordRepository>(
  (ref) =>
      PatrolRecordRepositoryImpl(ref.watch(patrolRecordDatasourceProvider)),
);
