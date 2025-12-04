import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ButcheringTimeView extends HookConsumerWidget {
  const ButcheringTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final year = useState(now.year);
    final month = useState(now.month);

    // 月末の日数を取得
    final int lastDay = DateTime(year.value, month.value + 1, 0).day;

    return Scaffold(
      appBar: AppBar(
        actions: [showYearMonthPickerButton(context, year, month)],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('解体時間'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(50.0, 12.0, 12.0, 12.0),
              color: Colors.orangeAccent,
              child: Row(
                children: [
                  Text('日付', style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 54.w),
                  Text('出勤', style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 28.w),
                  Text('退勤', style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 28.w),
                  Text('休憩', style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 28.w),
                  Text('累計', style: TextStyle(fontSize: 16.sp)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowHeight: 0,
                  columnSpacing: 16.w,
                  columns: const [
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                  ],
                  rows: List.generate(lastDay, (i) {
                    final day = i + 1;
                    final date = DateTime(year.value, month.value, day);
                    final formattedDate = DateFormat('yyyy/MM/dd').format(date);
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            formattedDate,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                        DataCell(
                          Text('08:00', style: TextStyle(fontSize: 16.sp)),
                        ),
                        DataCell(
                          Text('17:00', style: TextStyle(fontSize: 16.sp)),
                        ),
                        DataCell(
                          Text('01:00', style: TextStyle(fontSize: 16.sp)),
                        ),
                        DataCell(
                          Text('08:00', style: TextStyle(fontSize: 16.sp)),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showYearMonthPickerButton(
    BuildContext context,
    ValueNotifier<int> year,
    ValueNotifier<int> month,
  ) {
    return ElevatedButton(
      onPressed: () async {
        final now = DateTime.now();
        final result = await showYearMonthPicker(context, now.year, now.month);
        if (result != null) {
          year.value = result['year']!;
          month.value = result['month']!;
        }
      },
      child: Icon(Icons.calendar_month, size: 20.w),
    );
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
}
