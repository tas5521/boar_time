import 'package:boar_time/core/export/export_file_writer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final exportFileWriterProvider = Provider<ExportFileWriter>(
  (_) => ExportFileWriter(),
);
