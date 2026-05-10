import 'dart:convert';
import 'dart:io';

import 'package:boar_time/core/enums/export_format.dart';
import 'package:boar_time/infrastructure/datasource/export_datasource/export_datasource.dart';
import 'package:boar_time/infrastructure/model/job_time_model_base.dart';
import 'package:boar_time/model/patrol_label.dart';
import 'package:boar_time/presentation/state/butchering_time_state/butchering_time_state.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:boar_time/presentation/state/patrol_time_state/patrol_time_state.dart';

class ExportDatasourceImpl extends ExportDatasource {
  pw.Font? _jpFont;

  @override
  Future<File> export<T extends JobTimeModelBase>({
    required ExportFormat format,
    required List<T> data,
    required String filename,
  }) async {
    final bytes = await _createBytes(format: format, data: data);
    final ext = switch (format) {
      ExportFormat.pdf => "pdf",
      ExportFormat.csv => "csv",
      ExportFormat.xlsx => "xlsx",
    };
    return _saveAndOpen(bytes: bytes, filename: filename, extension: ext);
  }

  Future<Uint8List> _createBytes<T extends JobTimeModelBase>({
    required ExportFormat format,
    required List<T> data,
  }) async {
    await _loadFonts();
    if (data.isEmpty) {
      throw ArgumentError('出力する行が1件以上必要です。');
    }
    final baseList = List<JobTimeModelBase>.from(data);
    return switch (format) {
      ExportFormat.pdf => _exportPdf(baseList),
      ExportFormat.csv => _exportCsv(baseList),
      ExportFormat.xlsx => _exportExcel(baseList),
    };
  }

  Future<File> _saveAndOpen({
    required Uint8List bytes,
    required String filename,
    required String extension,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = "${dir.path}/$filename.$extension";
    final file = File(path);
    await file.writeAsBytes(bytes, flush: true);
    await OpenFilex.open(path);
    return file;
  }

  Future<void> _loadFonts() async {
    if (_jpFont != null) return;
    final fontData = await rootBundle.load(
      "assets/fonts/NotoSansJP-VariableFont_wght.ttf",
    );
    _jpFont = pw.Font.ttf(fontData.buffer.asByteData());
  }

  Future<Uint8List> _exportPdf(List<JobTimeModelBase> data) async {
    switch (data.first) {
      case ButcheringTimeState():
        final headers = ["日付", "出勤", "退勤", "休憩", "累計"];
        final rows = _mapButcheringRows(data.cast<ButcheringTimeState>());
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
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
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

      case PatrolTimeState():
        final headers = [
          "日付",
          "開始",
          "終了",
          "従事者名",
          "場所",
          "業務内容",
          "獣種",
          "捕獲数",
          "備考",
        ];
        final rows = _mapPatrolRows(data.cast<PatrolTimeState>());
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
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
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
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
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

      default:
        throw ArgumentError(
          'ButcheringTimeModelまたはPatrolTimeModelのリストのみ出力できます。',
        );
    }
  }

  Future<Uint8List> _exportCsv(List<JobTimeModelBase> data) async {
    switch (data.first) {
      case ButcheringTimeState():
        final buffer = StringBuffer();
        buffer.writeln("日付,出勤,退勤,休憩,累計");
        for (final e in data.cast<ButcheringTimeState>()) {
          buffer.writeln(
            [
              _fmtDate(e.date),
              _fmtTime(e.start),
              _fmtTime(e.end),
              _fmtBreakDuration(e.breakStart, e.breakEnd, e.breakDuration),
              _fmtDuration(e.cumulativeDuration),
            ].map(_csvEscape).join(","),
          );
        }
        return Uint8List.fromList(utf8.encode('\uFEFF${buffer.toString()}'));

      case PatrolTimeState():
        final buffer = StringBuffer();
        buffer.writeln(
          ["日付", "開始", "終了", "従事者名", "場所", "業務内容", "獣種", "捕獲数", "備考"].join(","),
        );
        for (final e in data.cast<PatrolTimeState>()) {
          buffer.writeln(
            [
              _fmtDate(e.date),
              _fmtTime(e.start),
              _fmtTime(e.end),
              e.worker ?? '',
              e.location ?? '',
              e.label.displayName,
              e.animal ?? '',
              e.count?.toString() ?? '',
              e.note ?? '',
            ].map(_csvEscape).join(","),
          );
        }
        return Uint8List.fromList(utf8.encode('\uFEFF${buffer.toString()}'));

      default:
        throw ArgumentError(
          'ButcheringTimeModelまたはPatrolTimeModelのリストのみ出力できます。',
        );
    }
  }

  Future<Uint8List> _exportExcel(List<JobTimeModelBase> data) async {
    switch (data.first) {
      case ButcheringTimeState():
        final excel = Excel.createExcel();
        final sheet = excel['Sheet1'];
        sheet.appendRow([
          TextCellValue("日付"),
          TextCellValue("出勤"),
          TextCellValue("退勤"),
          TextCellValue("休憩"),
          TextCellValue("累計"),
        ]);
        for (final e in data.cast<ButcheringTimeState>()) {
          sheet.appendRow([
            TextCellValue(_fmtDate(e.date)),
            TextCellValue(_fmtTime(e.start)),
            TextCellValue(_fmtTime(e.end)),
            TextCellValue(
              _fmtBreakDuration(e.breakStart, e.breakEnd, e.breakDuration),
            ),
            TextCellValue(_fmtDuration(e.cumulativeDuration)),
          ]);
        }
        return Uint8List.fromList(excel.encode()!);

      case PatrolTimeState():
        final excel = Excel.createExcel();
        final sheet = excel['Sheet1'];
        sheet.appendRow([
          TextCellValue("日付"),
          TextCellValue("開始"),
          TextCellValue("終了"),
          TextCellValue("従事者名"),
          TextCellValue("場所"),
          TextCellValue("業務内容"),
          TextCellValue("獣種"),
          TextCellValue("捕獲数"),
          TextCellValue("備考"),
        ]);
        for (final e in data.cast<PatrolTimeState>()) {
          sheet.appendRow([
            TextCellValue(_fmtDate(e.date)),
            TextCellValue(_fmtTime(e.start)),
            TextCellValue(_fmtTime(e.end)),
            TextCellValue(e.worker ?? ""),
            TextCellValue(e.location ?? ""),
            TextCellValue(e.label.displayName),
            TextCellValue(e.animal ?? ""),
            TextCellValue(e.count?.toString() ?? ""),
            TextCellValue(e.note ?? ""),
          ]);
        }
        return Uint8List.fromList(excel.encode()!);

      default:
        throw ArgumentError(
          'ButcheringTimeModelまたはPatrolTimeModelのリストのみ出力できます。',
        );
    }
  }

  List<List<String>> _mapButcheringRows(List<ButcheringTimeState> list) {
    return list.map((e) {
      return [
        _fmtDate(e.date),
        _fmtTime(e.start),
        _fmtTime(e.end),
        _fmtBreakDuration(e.breakStart, e.breakEnd, e.breakDuration),
        _fmtDuration(e.cumulativeDuration),
      ];
    }).toList();
  }

  List<List<String>> _mapPatrolRows(List<PatrolTimeState> list) {
    return list.map((e) {
      return [
        _fmtDate(e.date),
        _fmtTime(e.start),
        _fmtTime(e.end),
        e.worker ?? "-",
        e.location ?? "-",
        e.label.displayName,
        e.animal ?? "-",
        e.count?.toString() ?? "-",
        e.note ?? "-",
      ];
    }).toList();
  }

  String _fmtDate(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  String _fmtTime(DateTime? t) => t == null
      ? "-"
      : "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  String _fmtBreakDuration(DateTime? bs, DateTime? be, Duration d) {
    if (bs == null || be == null) return "-";
    return _fmtDuration(d);
  }

  String _fmtDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}";
  }

  String _csvEscape(String value) {
    if (value.contains(',') ||
        value.contains('\n') ||
        value.contains('\r') ||
        value.contains('"')) {
      final escaped = value.replaceAll('"', '""');
      return '"$escaped"';
    }
    return value;
  }
}
