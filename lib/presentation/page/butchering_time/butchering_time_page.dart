import 'package:auto_route/auto_route.dart';
import 'package:boar_time/icons/my_flutter_app_icons.dart';
import 'package:boar_time/model/job_type.dart';
import 'package:boar_time/presentation/notifier/active_tab/active_tab_notifier.dart';
import 'package:boar_time/presentation/notifier/butchering/butchering_time_notifier.dart';
import 'package:boar_time/presentation/page/view_parts/edit_break_dalog.dart';
import 'package:boar_time/presentation/page/view_parts/edit_time_dialog.dart';
import 'package:boar_time/presentation/page/view_parts/icon_action_button.dart';
import 'package:boar_time/presentation/state/butchering_time_state/butchering_time_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ButcheringTimePage extends HookConsumerWidget {
  const ButcheringTimePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final year = useState(now.year);
    final month = useState(now.month);
    final lastDay = DateTime(
      year.value,
      month.value + 1,
      1,
    ).subtract(const Duration(days: 1)).day;

    final butcheringTimeState = ref.watch(
      butcheringTimeProvider((year: year.value, month: month.value)),
    );

    useEffect(() {
      ref.invalidate(
        butcheringTimeProvider((year: year.value, month: month.value)),
      );
      return null;
    }, [year.value, month.value]);

    ref.listen(activeTabProvider, (_, next) {
      if (next == 1) {
        ref.invalidate(butcheringTimeProvider);
      }
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          iconActionButton(
            context,
            onPressed: () async {
              await showExportDialog(
                context,
                title: '解体の勤務表の出力',
                onExport: (format) async {
                  //TODO: 仮置き。exportAndSaveは別のnotifierで行うことにする
                  await ref
                      .read(
                        butcheringTimeProvider((
                          year: year.value,
                          month: month.value,
                        )).notifier,
                      )
                      .exportAndSave(
                        format: format,
                        filename: '解体_${year.value}_${month.value}',
                      );
                },
              );
            },
            icon: Icon(MyFlutterApp.doc, size: 24.w),
          ),
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
        title: Text(
          '解体記録',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(12.0.w, 12.0.w, 12.0.w, 12.0.w),
              color: Colors.orangeAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100.w,
                    child: Text('日付', style: TextStyle(fontSize: 16.sp)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 52.w,
                    child: Text('出勤', style: TextStyle(fontSize: 16.sp)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 52.w,
                    child: Text('退勤', style: TextStyle(fontSize: 16.sp)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 52.w,
                    child: Text('休憩', style: TextStyle(fontSize: 16.sp)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(2.w, 0.w, 0.w, 0.w),
                    alignment: Alignment.center,
                    width: 52.w,
                    child: Text('累計', style: TextStyle(fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowHeight: 0,
                  columnSpacing: 10.w,
                  horizontalMargin: 12.w,
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
                    final row = butcheringTimeState.value?.firstWhere(
                      (r) =>
                          r.date.year == date.year &&
                          r.date.month == date.month &&
                          r.date.day == date.day,
                      orElse: () => ButcheringTimeState(
                        date: date,
                        start: null,
                        end: null,
                        breakStart: null,
                        breakEnd: null,
                        cumulativeDuration: Duration.zero,
                      ),
                    );
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            alignment: Alignment.center,
                            width: 100.w,
                            child: Text(
                              formattedDate,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            alignment: Alignment.center,
                            width: 52.w,
                            child: Text(
                              _fmt(row?.start),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          onTap: () {
                            showEditTimeDialog(
                              context,
                              label: '出勤時間',
                              date: row!.date,
                              type: JobType.butchering,
                              initialTime: row.start != null
                                  ? TimeOfDay.fromDateTime(row.start!)
                                  : null,
                              onPressed: (selected) async {
                                final DateTime? newStartDate;
                                if (selected != null) {
                                  newStartDate = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    selected.hour,
                                    selected.minute,
                                  );
                                } else {
                                  newStartDate = null;
                                }
                                await ref
                                    .read(
                                      butcheringTimeProvider((
                                        year: year.value,
                                        month: month.value,
                                      )).notifier,
                                    )
                                    .updateStartTime(
                                      row.date,
                                      newDate: newStartDate,
                                    );
                              },
                            );
                          },
                        ),
                        DataCell(
                          Container(
                            alignment: Alignment.center,
                            width: 52.w,
                            child: Text(
                              _fmt(row?.end),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          onTap: () {
                            showEditTimeDialog(
                              context,
                              label: '退勤時間',
                              date: row!.date,
                              type: JobType.butchering,
                              initialTime: row.end != null
                                  ? TimeOfDay.fromDateTime(row.end!)
                                  : null,
                              onPressed: (selected) async {
                                final DateTime? newEndDate;
                                if (selected != null) {
                                  newEndDate = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    selected.hour,
                                    selected.minute,
                                  );
                                } else {
                                  newEndDate = null;
                                }
                                await ref
                                    .read(
                                      butcheringTimeProvider((
                                        year: year.value,
                                        month: month.value,
                                      )).notifier,
                                    )
                                    .updateEndTime(
                                      row.date,
                                      newDate: newEndDate,
                                    );
                              },
                            );
                          },
                        ),
                        DataCell(
                          Container(
                            alignment: Alignment.center,
                            width: 52.w,
                            child: Text(
                              _fmtBreak(row),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          onTap: row == null
                              ? null
                              : () {
                                  showEditBreakDialog(
                                    context,
                                    ref,
                                    date: row.date,
                                    initialStart: row.breakStart != null
                                        ? TimeOfDay.fromDateTime(
                                            row.breakStart!,
                                          )
                                        : null,
                                    initialEnd: row.breakEnd != null
                                        ? TimeOfDay.fromDateTime(row.breakEnd!)
                                        : null,
                                    onPressed: ({breakStart, breakEnd}) async {
                                      final start = breakStart != null
                                          ? DateTime(
                                              row.date.year,
                                              row.date.month,
                                              row.date.day,
                                              breakStart.hour,
                                              breakStart.minute,
                                            )
                                          : null;
                                      final end = breakEnd != null
                                          ? DateTime(
                                              row.date.year,
                                              row.date.month,
                                              row.date.day,
                                              breakEnd.hour,
                                              breakEnd.minute,
                                            )
                                          : null;
                                      await ref
                                          .read(
                                            butcheringTimeProvider((
                                              year: year.value,
                                              month: month.value,
                                            )).notifier,
                                          )
                                          .updateBreak(row.date, start, end);
                                    },
                                  );
                                },
                        ),
                        DataCell(
                          Container(
                            alignment: Alignment.center,
                            width: 60.w,
                            child: Text(
                              _fmtDuration(
                                row?.cumulativeDuration ?? Duration.zero,
                              ),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
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

  String _fmt(DateTime? dt) {
    if (dt == null) return '--:--';
    return DateFormat('HH:mm').format(dt);
  }

  String _fmtDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _fmtBreak(ButcheringTimeState? row) {
    if (row == null || row.breakStart == null || row.breakEnd == null) {
      return "--:--";
    }

    final h = row.breakDuration.inHours;
    final m = row.breakDuration.inMinutes % 60;

    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}";
  }
}
