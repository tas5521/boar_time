import 'package:boar_time/infrastructure/datasource/export_datasource/export_datasource.dart';
import 'package:boar_time/infrastructure/datasource/export_datasource/export_datasource_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final exportDatasourceProvider = Provider<ExportDatasource>(
  (_) => ExportDatasourceImpl(),
);
