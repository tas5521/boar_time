import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    builder: (dialogContext) {
      return AlertDialog(
        title: Text("年月を選択", style: TextStyle(fontSize: 20.sp)),
        content: SizedBox(
          height: 200.sp,
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
                      .map(
                        (y) => Center(
                          child: Text("$y年", style: TextStyle(fontSize: 16.sp)),
                        ),
                      )
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
                      .map(
                        (m) => Center(
                          child: Text("$m月", style: TextStyle(fontSize: 16.sp)),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("キャンセル", style: TextStyle(fontSize: 14.sp)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext, {
                "year": selectedYear,
                "month": selectedMonth,
              });
            },
            child: Text("決定", style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      );
    },
  );
}