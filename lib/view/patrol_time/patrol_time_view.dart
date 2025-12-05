import 'package:boar_time/view/view_parts/edit_time_dialog.dart';
import 'package:boar_time/view/view_parts/iconActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PatrolTimeView extends HookConsumerWidget {
  const PatrolTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final year = useState(now.year);
    final month = useState(now.month);
    final int lastDay = DateTime(year.value, month.value + 1, 0).day;
    return Scaffold(
      appBar: AppBar(
        actions: [
          iconActionButton(
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
            icon: Icon(Icons.calendar_month, size: 24.w),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('見回り時間', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  SizedBox(width: 75.w),
                  Text('開始', style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 49.w),
                  Text('終了', style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 47.w),
                  Text('累計', style: TextStyle(fontSize: 16.sp)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowHeight: 0,
                  columnSpacing: 36.w,
                  columns: const [
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
                            showEditTimeDialog(
                              context,
                              label: '見回り開始時間',
                              date: date,
                              onPressed: (_) {},
                            );
                          },
                        ),
                        DataCell(
                          Text('17:00', style: TextStyle(fontSize: 16.sp)),
                          onTap: () {
                            showEditTimeDialog(
                              context,
                              label: '見回り終了時間',
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
