import 'package:boar_time/domain/enums/export_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showExportDialog(
  BuildContext context, {
  required String title,
  required void Function(ExportFormat format) onExport,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      return HookBuilder(
        builder: (hookContext) {
          final format = useState<ExportFormat>(ExportFormat.pdf);
          return AlertDialog(
            title: Text(title, style: TextStyle(fontSize: 20.sp)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio<ExportFormat>(
                      value: ExportFormat.pdf,
                      groupValue: format.value,
                      onChanged: (v) {
                        if (v != null) format.value = v;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        format.value = ExportFormat.pdf;
                      },
                      child: Text('PDF', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio<ExportFormat>(
                      value: ExportFormat.csv,
                      groupValue: format.value,
                      onChanged: (v) {
                        if (v != null) format.value = v;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        format.value = ExportFormat.csv;
                      },
                      child: Text('CSV', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio<ExportFormat>(
                      value: ExportFormat.xlsx,
                      groupValue: format.value,
                      onChanged: (v) {
                        if (v != null) format.value = v;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        format.value = ExportFormat.xlsx;
                      },
                      child: Text('Excel', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(hookContext),
                child: Text("キャンセル", style: TextStyle(fontSize: 14.sp)),
              ),
              ElevatedButton(
                onPressed: () {
                  onExport(format.value);
                  Navigator.pop(hookContext);
                },
                child: Text("出力する", style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          );
        },
      );
    },
  );
}
