import 'package:boar_time/icons/my_flutter_app_icons.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:boar_time/notifier/patrol/patrol_time_notifier.dart';
import 'package:boar_time/notifier/stamping/stamping_notifier.dart';
import 'package:boar_time/view/bottom_navigation_bar_view.dart';
import 'package:boar_time/view/view_parts/edit_time_dialog.dart';
import 'package:boar_time/view/view_parts/icon_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PatrolTimeView extends HookConsumerWidget {
  const PatrolTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeTabProvider);
    final now = DateTime.now();
    final year = useState(now.year);
    final month = useState(now.month);

    final patrolTimeState = ref.watch(patrolTimeNotifierProvider);
    final patrolList = patrolTimeState.value ?? [];

    useEffect(() {
      Future.microtask(() async {
        await ref
            .read(patrolTimeNotifierProvider.notifier)
            .loadMonth(year.value, month.value);
      });
      return null;
    }, [year.value, month.value]);

    useEffect(() {
      if (activeTab == 2) {
        Future.microtask(() async {
          await ref
              .read(patrolTimeNotifierProvider.notifier)
              .loadMonth(year.value, month.value);
        });
      }
      return null;
    }, [activeTab]);

    return Scaffold(
      appBar: AppBar(
        actions: [
          iconActionButton(
            context,
            onPressed: () async {
              await showExportDialog(
                context,
                title: '見回りの勤務表の出力',
                onExport: (format) async {
                  await ref
                      .read(patrolTimeNotifierProvider.notifier)
                      .exportAndSave(
                        format: format,
                        filename: '見回り_${year.value}_${month.value}',
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
          '見回り時間',
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
                    child: Text('開始', style: TextStyle(fontSize: 16.sp)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 52.w,
                    child: Text('終了', style: TextStyle(fontSize: 16.sp)),
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
                  columnSpacing: 30.7.w,
                  horizontalMargin: 12.w,
                  columns: const [
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                  ],
                  rows: patrolList.map((row) {
                    final formattedDate = DateFormat(
                      'yyyy/MM/dd',
                    ).format(row.date);
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
                              _fmt(row.start),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          onTap: () {
                            showEditTimeDialog(
                              context,
                              label: '見回り開始時間',
                              date: row.date,
                              initialTime: row.start != null
                                  ? TimeOfDay.fromDateTime(row.start!)
                                  : null,
                              onPressed: (selected) async {
                                final date = row.date;
                                final WorkRecord rec;
                                if (selected == null) {
                                  rec = WorkRecord(
                                    date: row.date,
                                    patrolStart: null,
                                    patrolEnd: row.end,
                                  );
                                } else {
                                  final dt = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    selected.hour,
                                    selected.minute,
                                  );
                                  rec = WorkRecord(
                                    date: row.date,
                                    patrolStart: dt,
                                    patrolEnd: row.end,
                                  );
                                }
                                await ref
                                    .read(patrolTimeNotifierProvider.notifier)
                                    .upsert(year.value, month.value, rec);
                                await ref
                                    .read(stampingNotifierProvider.notifier)
                                    .fetch();
                              },
                            );
                          },
                        ),
                        DataCell(
                          Container(
                            alignment: Alignment.center,
                            width: 52.w,
                            child: Text(
                              _fmt(row.end),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          onTap: () {
                            showEditTimeDialog(
                              context,
                              label: '見回り終了時間',
                              date: row.date,
                              initialTime: row.end != null
                                  ? TimeOfDay.fromDateTime(row.end!)
                                  : null,
                              onPressed: (selected) async {
                                final date = row.date;
                                final WorkRecord rec;
                                if (selected == null) {
                                  rec = WorkRecord(
                                    date: row.date,
                                    patrolStart: row.start,
                                    patrolEnd: null,
                                  );
                                } else {
                                  final dt = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    selected.hour,
                                    selected.minute,
                                  );
                                  rec = WorkRecord(
                                    date: row.date,
                                    patrolStart: row.start,
                                    patrolEnd: dt,
                                  );
                                }
                                await ref
                                    .read(patrolTimeNotifierProvider.notifier)
                                    .upsert(year.value, month.value, rec);
                                await ref
                                    .read(stampingNotifierProvider.notifier)
                                    .fetch();
                              },
                            );
                          },
                        ),
                        DataCell(
                          Container(
                            alignment: Alignment.center,
                            width: 60.w,
                            child: Text(
                              _fmtDuration(row.cumulativeDuration),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
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
}
