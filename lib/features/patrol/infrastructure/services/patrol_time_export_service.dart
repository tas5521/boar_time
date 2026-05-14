import 'dart:io';

import 'package:boar_time/shared/enums/export_format.dart';
import 'package:boar_time/core/export/export_file_writer.dart';
import 'package:boar_time/core/export/export_text_format.dart';
import 'package:boar_time/core/patrol_record/domain/enums/patrol_label.dart';
import 'package:boar_time/features/patrol/infrastructure/model/patrol_time_model.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PatrolTimeExportService {
  PatrolTimeExportService(this._writer);

  final ExportFileWriter _writer;

  pw.Font? _jpFont;

  Future<File> export({
    required List<PatrolTimeModel> data,
    required ExportFormat format,
    required String filename,
  }) async {
    if (data.isEmpty) {
      throw ArgumentError('出力する行が1件以上必要です。');
    }
    final bytes = await switch (format) {
      ExportFormat.pdf => _exportPdf(data),
      ExportFormat.csv => _exportCsv(data),
      ExportFormat.xlsx => _exportExcel(data),
    };
    return _writer.writeAndOpen(
      bytes: bytes,
      filename: filename,
      extension: format.name,
    );
  }

  Future<void> _ensureFont() async {
    if (_jpFont != null) return;
    final fontData = await rootBundle.load(
      'assets/fonts/NotoSansJP-VariableFont_wght.ttf',
    );
    _jpFont = pw.Font.ttf(fontData.buffer.asByteData());
  }

  Future<Uint8List> _exportPdf(List<PatrolTimeModel> data) async {
    await _ensureFont();
    final headers = [
      '日付',
      '開始',
      '終了',
      '従事者名',
      '場所',
      '業務内容',
      '獣種',
      '捕獲数',
      '備考',
    ];
    final rows = _mapPatrolRows(data);
    final pdf = pw.Document();
    final baseStyle = pw.TextStyle(font: _jpFont, fontSize: 11);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(12),
        header: (context) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 6),
          child: pw.Text(
            '見回り記録',
            style: baseStyle.copyWith(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        build: (context) {
          return [
            pw.Table(
              border: pw.TableBorder.all(width: 0.3),
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: pw.FixedColumnWidth(70),
                1: pw.FixedColumnWidth(50),
                2: pw.FixedColumnWidth(50),
                3: pw.FixedColumnWidth(80),
                4: pw.FixedColumnWidth(100),
                5: pw.FixedColumnWidth(80),
                6: pw.FixedColumnWidth(80),
                7: pw.FixedColumnWidth(50),
                8: pw.FlexColumnWidth(),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  children: headers.map((h) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        h,
                        style: baseStyle.copyWith(
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
                for (final row in rows)
                  pw.TableRow(
                    children: List.generate(row.length, (index) {
                      final isLeftAlign = index == 8;
                      return pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 4,
                        ),
                        child: pw.Text(
                          row[index],
                          style: baseStyle,
                          textAlign: isLeftAlign
                              ? pw.TextAlign.left
                              : pw.TextAlign.center,
                          softWrap: true,
                        ),
                      );
                    }),
                  ),
              ],
            ),
          ];
        },
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> _exportCsv(List<PatrolTimeModel> data) async {
    final buffer = StringBuffer();
    buffer.writeln(
      ['日付', '開始', '終了', '従事者名', '場所', '業務内容', '獣種', '捕獲数', '備考'].join(','),
    );
    for (final e in data) {
      buffer.writeln(
        [
          ExportTextFormat.date(e.date),
          ExportTextFormat.time(e.start),
          ExportTextFormat.time(e.end),
          e.worker ?? '',
          e.location ?? '',
          e.label.displayName,
          e.animal ?? '',
          e.count?.toString() ?? '',
          e.note ?? '',
        ].map(ExportTextFormat.csvEscape).join(','),
      );
    }
    return ExportTextFormat.utf8BomCsv(buffer.toString());
  }

  Future<Uint8List> _exportExcel(List<PatrolTimeModel> data) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    sheet.appendRow([
      TextCellValue('日付'),
      TextCellValue('開始'),
      TextCellValue('終了'),
      TextCellValue('従事者名'),
      TextCellValue('場所'),
      TextCellValue('業務内容'),
      TextCellValue('獣種'),
      TextCellValue('捕獲数'),
      TextCellValue('備考'),
    ]);
    for (final e in data) {
      sheet.appendRow([
        TextCellValue(ExportTextFormat.date(e.date)),
        TextCellValue(ExportTextFormat.time(e.start)),
        TextCellValue(ExportTextFormat.time(e.end)),
        TextCellValue(e.worker ?? ''),
        TextCellValue(e.location ?? ''),
        TextCellValue(e.label.displayName),
        TextCellValue(e.animal ?? ''),
        TextCellValue(e.count?.toString() ?? ''),
        TextCellValue(e.note ?? ''),
      ]);
    }
    return Uint8List.fromList(excel.encode()!);
  }

  List<List<String>> _mapPatrolRows(List<PatrolTimeModel> list) {
    return list.map((e) {
      return [
        ExportTextFormat.date(e.date),
        ExportTextFormat.time(e.start),
        ExportTextFormat.time(e.end),
        e.worker ?? '-',
        e.location ?? '-',
        e.label.displayName,
        e.animal ?? '-',
        e.count?.toString() ?? '-',
        e.note ?? '-',
      ];
    }).toList();
  }
}
