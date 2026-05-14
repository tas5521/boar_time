import 'dart:convert';
import 'dart:typed_data';

/// Plain text / CSV helpers for exports (no job-specific types).
abstract final class ExportTextFormat {
  static String date(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String time(DateTime? t) => t == null
      ? '-'
      : '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  static String duration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  static String breakOrDash(DateTime? breakStart, DateTime? breakEnd, Duration d) {
    if (breakStart == null || breakEnd == null) return '-';
    return duration(d);
  }

  static String csvEscape(String value) {
    if (value.contains(',') ||
        value.contains('\n') ||
        value.contains('\r') ||
        value.contains('"')) {
      final escaped = value.replaceAll('"', '""');
      return '"$escaped"';
    }
    return value;
  }

  static Uint8List utf8BomCsv(String body) =>
      Uint8List.fromList(utf8.encode('\uFEFF$body'));
}
