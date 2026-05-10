import 'dart:io';
import 'package:boar_time/core/enums/export_format.dart';
import 'package:boar_time/infrastructure/model/job_time_model_base.dart';

abstract class ExportDatasource {
  Future<File> export<T extends JobTimeModelBase>({
    required ExportFormat format,
    required List<T> data,
    required String filename,
  });
}
