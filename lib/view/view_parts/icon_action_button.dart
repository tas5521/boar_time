import 'package:boar_time/manager/export_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget iconActionButton(
  BuildContext context, {
  required Future<void> Function() onPressed,
  required Icon icon,
}) {
  return IconButton(onPressed: onPressed, icon: icon);
}

Future<Map<String, int>?> showYearMonthPicker(
  BuildContext context,
  int initialYear,
  int initialMonth,
) {
  final years = List.generate(100, (i) => 2025 + i);
  final months = List.generate(12, (i) => i + 1);

  int selectedYear = initialYear;
  int selectedMonth = initialMonth;

  final yearController = FixedExtentScrollController(
    initialItem: years.indexOf(initialYear),
  );
  final monthController = FixedExtentScrollController(
    initialItem: initialMonth - 1,
  );

  return showDialog<Map<String, int>>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("年月を選択"),
        content: SizedBox(
          height: 200.w,
          child: Row(
            children: [
              Expanded(
                child: CupertinoPicker(
                  scrollController: yearController,
                  itemExtent: 36,
                  onSelectedItemChanged: (index) {
                    selectedYear = years[index];
                  },
                  children: years
                      .map((y) => Center(child: Text("$y年")))
                      .toList(),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: monthController,
                  itemExtent: 36,
                  onSelectedItemChanged: (index) {
                    selectedMonth = months[index];
                  },
                  children: months
                      .map((m) => Center(child: Text("$m月")))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("キャンセル"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, {
                "year": selectedYear,
                "month": selectedMonth,
              });
            },
            child: const Text("決定"),
          ),
        ],
      );
    },
  );
}

Future<void> showExportDialog(
  BuildContext context, {
  required String title,
  required void Function(ExportFormat format) onExport,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      return HookBuilder(
        builder: (context) {
          final format = useState<ExportFormat>(ExportFormat.pdf);

          return AlertDialog(
            title: Text(title),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    const Text('PDF'),
                  ],
                ),
                SizedBox(width: 24.w),
                Row(
                  children: [
                    Radio<ExportFormat>(
                      value: ExportFormat.csv,
                      groupValue: format.value,
                      onChanged: (v) {
                        if (v != null) format.value = v;
                      },
                    ),
                    const Text('CSV'),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("キャンセル"),
              ),
              ElevatedButton(
                onPressed: () {
                  onExport(format.value);
                  Navigator.pop(context);
                },
                child: const Text("出力する"),
              ),
            ],
          );
        },
      );
    },
  );
}
