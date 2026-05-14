import 'dart:io';

import 'package:boar_time/shared/enums/export_format.dart';
import 'package:boar_time/core/export/export_file_writer.dart';
import 'package:boar_time/core/export/export_text_format.dart';
import 'package:boar_time/features/butchering/infrastructure/model/butchering_time_model.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ButcheringTimeExportService {
  ButcheringTimeExportService(this._writer);

  final ExportFileWriter _writer;

  pw.Font? _jpFont;

  Future<File> export({
    required List<ButcheringTimeModel> data,
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

  Future<Uint8List> _exportPdf(List<ButcheringTimeModel> data) async {
    await _ensureFont();
    final headers = ['日付', '出勤', '退勤', '休憩', '累計'];
    final rows = _mapButcheringRows(data);
    final pdf = pw.Document();
    final baseStyle = pw.TextStyle(font: _jpFont, fontSize: 16);
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Table(
            border: pw.TableBorder.all(width: 0.4),
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            columnWidths: {
              for (int i = 0; i < headers.length; i++)
                i: const pw.FlexColumnWidth(1),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                children: headers
                    .map(
                      (h) => pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          h,
                          style: baseStyle.copyWith(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: baseStyle.fontSize,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    )
                    .toList(),
              ),
              for (final row in rows)
                pw.TableRow(
                  children: row
                      .map(
                        (cell) => pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 2,
                          ),
                          child: pw.Text(
                            cell,
                            style: baseStyle,
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      )
                      .toList(),
                ),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> _exportCsv(List<ButcheringTimeModel> data) async {
    final buffer = StringBuffer();
    buffer.writeln('日付,出勤,退勤,休憩,累計');
    var cumulative = Duration.zero;
    for (final e in data) {
      cumulative += _actualDuration(e);
      buffer.writeln(
        [
          ExportTextFormat.date(e.date),
          ExportTextFormat.time(e.startTime),
          ExportTextFormat.time(e.endTime),
          ExportTextFormat.breakOrDash(
            e.breakStart,
            e.breakEnd,
            _breakDuration(e),
          ),
          ExportTextFormat.duration(cumulative),
        ].map(ExportTextFormat.csvEscape).join(','),
      );
    }
    return ExportTextFormat.utf8BomCsv(buffer.toString());
  }

  Future<Uint8List> _exportExcel(List<ButcheringTimeModel> data) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    sheet.appendRow([
      TextCellValue('日付'),
      TextCellValue('出勤'),
      TextCellValue('退勤'),
      TextCellValue('休憩'),
      TextCellValue('累計'),
    ]);
    var cumulative = Duration.zero;
    for (final e in data) {
      cumulative += _actualDuration(e);
      sheet.appendRow([
        TextCellValue(ExportTextFormat.date(e.date)),
        TextCellValue(ExportTextFormat.time(e.startTime)),
        TextCellValue(ExportTextFormat.time(e.endTime)),
        TextCellValue(
          ExportTextFormat.breakOrDash(
            e.breakStart,
            e.breakEnd,
            _breakDuration(e),
          ),
        ),
        TextCellValue(ExportTextFormat.duration(cumulative)),
      ]);
    }
    return Uint8List.fromList(excel.encode()!);
  }

  static Duration _breakDuration(ButcheringTimeModel e) {
    if (e.breakStart == null || e.breakEnd == null) return Duration.zero;
    if (e.breakEnd!.isBefore(e.breakStart!)) return Duration.zero;
    return e.breakEnd!.difference(e.breakStart!);
  }

  static Duration _totalDuration(ButcheringTimeModel e) {
    if (e.startTime == null || e.endTime == null) return Duration.zero;
    if (e.endTime!.isBefore(e.startTime!)) return Duration.zero;
    return e.endTime!.difference(e.startTime!);
  }

  static Duration _actualDuration(ButcheringTimeModel e) {
    if (e.startTime == null || e.endTime == null) return Duration.zero;
    final bd = _breakDuration(e);
    final td = _totalDuration(e);
    if (td < bd) return Duration.zero;
    return td - bd;
  }

  List<List<String>> _mapButcheringRows(List<ButcheringTimeModel> list) {
    var cumulative = Duration.zero;
    return list.map((e) {
      cumulative += _actualDuration(e);
      return [
        ExportTextFormat.date(e.date),
        ExportTextFormat.time(e.startTime),
        ExportTextFormat.time(e.endTime),
        ExportTextFormat.breakOrDash(
          e.breakStart,
          e.breakEnd,
          _breakDuration(e),
        ),
        ExportTextFormat.duration(cumulative),
      ];
    }).toList();
  }
}
