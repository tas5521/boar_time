import 'package:boar_time/domain/enums/export_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showExportDialog(
  BuildContext context, {
  required String title,
  required Future<void> Function(ExportFormat format) onExport,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return HookBuilder(
        builder: (hookContext) {
          final format = useState<ExportFormat>(ExportFormat.pdf);
          final exporting = useState(false);

          Future<void> runExport() async {
            if (exporting.value) return;
            exporting.value = true;
            try {
              await onExport(format.value);
              if (hookContext.mounted) {
                Navigator.pop(hookContext);
              }
            } catch (e, _) {
              if (hookContext.mounted) {
                exporting.value = false;
                ScaffoldMessenger.of(hookContext).showSnackBar(
                  SnackBar(
                    content: Text(
                      '出力に失敗しました: $e',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                );
              }
            }
          }

          return AlertDialog(
            title: Text(title, style: TextStyle(fontSize: 20.sp)),
            content: AbsorbPointer(
              absorbing: exporting.value,
              child: RadioGroup<ExportFormat>(
                groupValue: format.value,
                onChanged: (ExportFormat? v) {
                  if (v != null) format.value = v;
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<ExportFormat>(value: ExportFormat.pdf),
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
                        Radio<ExportFormat>(value: ExportFormat.csv),
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
                        Radio<ExportFormat>(value: ExportFormat.xlsx),
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
              ),
            ),
            actions: [
              TextButton(
                onPressed: exporting.value
                    ? null
                    : () => Navigator.pop(hookContext),
                child: Text('キャンセル', style: TextStyle(fontSize: 14.sp)),
              ),
              ElevatedButton(
                onPressed: exporting.value ? null : runExport,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(108.w, 40.w),
                ),
                child: exporting.value
                    ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(
                            hookContext,
                          ).colorScheme.onPrimary,
                        ),
                      )
                    : Text('出力する', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          );
        },
      );
    },
  );
}
