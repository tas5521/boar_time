import 'package:boar_time/view/view_parts/edit_time_dialog.dart';
import 'package:boar_time/view/view_parts/show_year_month_picker.dart';
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
        actions: [
          showYearMonthPickerButton(
            context,
            onPressed: () async {
              final now = DateTime.now();
              final result = await showYearMonthPicker(
                context,
                now.year,
                now.month,
              );
              if (result != null) {
                year.value = result['year']!;
                month.value = result['month']!;
              }
            },
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          '解体時間',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                          onTap: () {
                            // TODO: Isar実装後、時間の初期値の取り方を修正
                            final existingTime = TimeOfDay(hour: 8, minute: 0);
                            showEditTimeDialog(
                              context,
                              label: '出勤時間',
                              date: date,
                              onPressed: (_) {},
                              initialTime: existingTime,
                            );
                          },
                        ),
                        DataCell(
                          Text('17:00', style: TextStyle(fontSize: 16.sp)),
                          onTap: () {
                            showEditTimeDialog(
                              context,
                              label: '退勤時間',
                              date: date,
                              onPressed: (_) {},
                            );
                          },
                        ),
                        DataCell(
                          Text('01:00', style: TextStyle(fontSize: 16.sp)),
                          onTap: () {
                            showEditTimeDialog(
                              context,
                              label: '休憩時間',
                              date: date,
                              onPressed: (_) {},
                            );
                          },
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
}
