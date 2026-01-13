import 'dart:convert';
import 'dart:io';

import 'package:boar_time/model/abstract_model/time_state_base.dart';
import 'package:boar_time/model/job_type.dart';
import 'package:boar_time/model/patrol_label.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:boar_time/model/butchering_time_state/butchering_time_state.dart';
import 'package:boar_time/model/patrol_time_state/patrol_time_state.dart';

enum ExportFormat { pdf, csv, xlsx }

class ExportManager {
  // ======================================================
  //                     Font Cache
  // ======================================================

  static pw.Font? _jpFont;

  static Future<void> _loadFonts() async {
    if (_jpFont != null) return;

    final fontData = await rootBundle.load(
      "assets/fonts/NotoSansJP-VariableFont_wght.ttf",
    );

    _jpFont = pw.Font.ttf(fontData.buffer.asByteData());
  }

  // ======================================================
  //                     Public API
  // ======================================================

  static Future<Uint8List> export({
    required JobType type,
    required ExportFormat format,
    required List<TimeStateBase> data,
  }) async {
    await _loadFonts();

    switch (format) {
      case ExportFormat.pdf:
        switch (type) {
          case JobType.butchering:
            return _exportPdfButchering(
              headers: ["日付", "出勤", "退勤", "休憩", "累計"],
              rows: _mapButcheringRows(data.cast<ButcheringTimeState>()),
            );

          case JobType.patrol:
            return _exportPdfPatrol(
              headers: ["日付", "開始", "終了", "場所", "業務内容", "獣種", "捕獲数", "備考"],
              rows: _mapPatrolRows(data.cast<PatrolTimeState>()),
            );
        }

      case ExportFormat.csv:
        return switch (type) {
          JobType.butchering => _exportButcheringCsv(
            data.cast<ButcheringTimeState>(),
          ),
          JobType.patrol => _exportPatrolCsv(data.cast<PatrolTimeState>()),
        };

      case ExportFormat.xlsx:
        return switch (type) {
          JobType.butchering => _exportButcheringExcel(
            data.cast<ButcheringTimeState>(),
          ),
          JobType.patrol => _exportPatrolExcel(data.cast<PatrolTimeState>()),
        };
    }
  }

  static Future<File> exportAndSave({
    required JobType type,
    required ExportFormat format,
    required List<TimeStateBase> data,
    required String filename,
  }) async {
    final bytes = await export(type: type, format: format, data: data);

    final ext = switch (format) {
      ExportFormat.pdf => "pdf",
      ExportFormat.csv => "csv",
      ExportFormat.xlsx => "xlsx",
    };

    return saveAndOpen(bytes: bytes, filename: filename, extension: ext);
  }

  // ======================================================
  //                     Save & Open
  // ======================================================

  static Future<File> saveAndOpen({
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

  // ======================================================
  //                    PDF - Butchering
  // ======================================================

  static Future<Uint8List> _exportPdfButchering({
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
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
              // Header row
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

              // Data rows
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

  // ======================================================
  //                    PDF - Patrol
  // ======================================================

  static Future<Uint8List> _exportPdfPatrol({
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final pdf = pw.Document();

    final baseStyle = pw.TextStyle(font: _jpFont, fontSize: 11);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(12),

        /// 各ページ共通のヘッダー（任意）
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
                0: pw.FixedColumnWidth(70), // 日付
                1: pw.FixedColumnWidth(50), // 開始
                2: pw.FixedColumnWidth(50), // 終了
                3: pw.FixedColumnWidth(100), // 場所
                4: pw.FixedColumnWidth(80), // 業務内容
                5: pw.FixedColumnWidth(80), // 獣種
                6: pw.FixedColumnWidth(50), // 捕獲数
                7: pw.FlexColumnWidth(), // 備考
              },

              children: [
                /// ===== Header Row（自動で各ページに繰り返される）=====
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

                /// ===== Data Rows =====
                for (final row in rows)
                  pw.TableRow(
                    children: List.generate(row.length, (index) {
                      final isLeftAlign = index == 3 || index == 7;

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

  // ======================================================
  //              CSV - Butchering
  // ======================================================

  static Future<Uint8List> _exportButcheringCsv(
    List<ButcheringTimeState> list,
  ) async {
    final buffer = StringBuffer();
    buffer.writeln("日付,出勤,退勤,休憩,累計");

    for (final e in list) {
      buffer.writeln(
        [
          _fmtDate(e.date),
          _fmtTime(e.start),
          _fmtTime(e.end),
          _fmtBreakDuration(e.breakStart, e.breakEnd, e.breakDuration),
          _fmtDuration(e.cumulativeDuration),
        ].join(","),
      );
    }

    return Uint8List.fromList(utf8.encode(buffer.toString()));
  }

  // ======================================================
  //              CSV - Patrol
  // ======================================================

  static Future<Uint8List> _exportPatrolCsv(List<PatrolTimeState> list) async {
    final buffer = StringBuffer();
    buffer.writeln("日付,開始,終了,場所,業務内容,獣種,捕獲数,備考");

    for (final e in list) {
      buffer.writeln(
        [
          _fmtDate(e.date),
          _fmtTime(e.start),
          _fmtTime(e.end),
          e.location ?? "",
          e.label.displayName,
          e.animal ?? "",
          e.count?.toString() ?? "",
          e.note ?? "",
        ].join(","),
      );
    }

    return Uint8List.fromList(utf8.encode(buffer.toString()));
  }

  // ======================================================
  //              Excel - Butchering
  // ======================================================

  static Future<Uint8List> _exportButcheringExcel(
    List<ButcheringTimeState> list,
  ) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    // Header
    sheet.appendRow([
      TextCellValue("日付"),
      TextCellValue("出勤"),
      TextCellValue("退勤"),
      TextCellValue("休憩"),
      TextCellValue("累計"),
    ]);

    for (final e in list) {
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
  }

  // ======================================================
  //              Excel - Patrol
  // ======================================================

  static Future<Uint8List> _exportPatrolExcel(
    List<PatrolTimeState> list,
  ) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    sheet.appendRow([
      TextCellValue("日付"),
      TextCellValue("開始"),
      TextCellValue("終了"),
      TextCellValue("場所"),
      TextCellValue("業務内容"),
      TextCellValue("獣種"),
      TextCellValue("捕獲数"),
      TextCellValue("備考"),
    ]);

    for (final e in list) {
      sheet.appendRow([
        TextCellValue(_fmtDate(e.date)),
        TextCellValue(_fmtTime(e.start)),
        TextCellValue(_fmtTime(e.end)),
        TextCellValue(e.location ?? ""),
        TextCellValue(e.label.displayName),
        TextCellValue(e.animal ?? ""),
        TextCellValue(e.count?.toString() ?? ""),
        TextCellValue(e.note ?? ""),
      ]);
    }

    return Uint8List.fromList(excel.encode()!);
  }

  // ======================================================
  //                 Table Mapping
  // ======================================================

  static List<List<String>> _mapButcheringRows(List<ButcheringTimeState> list) {
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

  static List<List<String>> _mapPatrolRows(List<PatrolTimeState> list) {
    return list.map((e) {
      return [
        _fmtDate(e.date),
        _fmtTime(e.start),
        _fmtTime(e.end),
        e.location ?? "-",
        e.label.displayName,
        e.animal ?? "-",
        e.count?.toString() ?? "-",
        e.note ?? "-",
      ];
    }).toList();
  }

  // ======================================================
  //                 Format Helpers
  // ======================================================

  static String _fmtDate(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  static String _fmtTime(DateTime? t) => t == null
      ? "-"
      : "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  static String _fmtBreakDuration(DateTime? bs, DateTime? be, Duration d) {
    if (bs == null || be == null) return "-";
    return _fmtDuration(d);
  }

  static String _fmtDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}";
  }
}
