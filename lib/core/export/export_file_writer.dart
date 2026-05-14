import 'dart:io';
import 'dart:typed_data';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

/// Writes bytes to app documents and opens the file. No knowledge of job types.
class ExportFileWriter {
  Future<File> writeAndOpen({
    required Uint8List bytes,
    required String filename,
    required String extension,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$filename.$extension';
    final file = File(path);
    await file.writeAsBytes(bytes, flush: true);
    await OpenFilex.open(path);
    return file;
  }
}
