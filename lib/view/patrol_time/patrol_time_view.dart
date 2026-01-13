import 'package:boar_time/icons/my_flutter_app_icons.dart';
import 'package:boar_time/model/job_type.dart';
import 'package:boar_time/model/patrol_label.dart';
import 'package:boar_time/notifier/patrol/patrol_time_notifier.dart';
import 'package:boar_time/notifier/stamping/stamping_notifier.dart';
import 'package:boar_time/view/bottom_navigation_bar_view.dart';
import 'package:boar_time/view/patrol_time/patrol_edit_page.dart';
import 'package:boar_time/view/view_parts/add_patrol_record_dialog.dart';
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
            icon: Icon(Icons.add, size: 24.w),
            onPressed: () => showAddPatrolRecordDialog(context, ref),
          ),

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
              padding: EdgeInsets.fromLTRB(12.0.w, 12.0.w, 6.0.w, 12.0.w),
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
                    alignment: Alignment.center,
                    width: 88.w,
                    child: Text('業務内容', style: TextStyle(fontSize: 16.sp)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 52.w,
                    child: Text('詳細', style: TextStyle(fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: patrolList.isEmpty
                  ? Center(
                      child: Text(
                        '${year.value}年${month.value}月は見回りの記録がありません',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SingleChildScrollView(
                      child: DataTable(
                        headingRowHeight: 0,
                        columnSpacing: 4.w,
                        horizontalMargin: 12.w,
                        columns: const [
                          DataColumn(label: SizedBox()),
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
                                    type: JobType.patrol,
                                    initialTime: row.start != null
                                        ? TimeOfDay.fromDateTime(row.start!)
                                        : null,
                                    onPressed: (selected) async {
                                      final dt = selected == null
                                          ? null
                                          : DateTime(
                                              row.date.year,
                                              row.date.month,
                                              row.date.day,
                                              selected.hour,
                                              selected.minute,
                                            );
                                      await ref
                                          .read(
                                            patrolTimeNotifierProvider.notifier,
                                          )
                                          .upsert(
                                            recordId: row.id,
                                            date: row.date,
                                            start: dt,
                                            end: row.end,
                                            label: row.label,
                                            location: row.location,
                                            animal: row.animal,
                                            count: row.count,
                                            note: row.note,
                                            year: year.value,
                                            month: month.value,
                                          );
                                      await ref
                                          .read(
                                            stampingNotifierProvider.notifier,
                                          )
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
                                    type: JobType.patrol,
                                    initialTime: row.end != null
                                        ? TimeOfDay.fromDateTime(row.end!)
                                        : null,
                                    onPressed: (selected) async {
                                      final dt = selected == null
                                          ? null
                                          : DateTime(
                                              row.date.year,
                                              row.date.month,
                                              row.date.day,
                                              selected.hour,
                                              selected.minute,
                                            );
                                      await ref
                                          .read(
                                            patrolTimeNotifierProvider.notifier,
                                          )
                                          .upsert(
                                            recordId: row.id,
                                            date: row.date,
                                            start: row.start,
                                            end: dt,
                                            label: row.label,
                                            location: row.location,
                                            animal: row.animal,
                                            count: row.count,
                                            note: row.note,
                                            year: year.value,
                                            month: month.value,
                                          );
                                      await ref
                                          .read(
                                            stampingNotifierProvider.notifier,
                                          )
                                          .fetch();
                                    },
                                  );
                                },
                              ),
                              DataCell(
                                SizedBox(
                                  width: 88.w,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<PatrolLabel>(
                                      value: row.label,
                                      isDense: true,
                                      isExpanded: true,
                                      icon: const SizedBox.shrink(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                      dropdownColor: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                      items: PatrolLabel.values
                                          .map(
                                            (label) =>
                                                DropdownMenuItem<PatrolLabel>(
                                                  value: label,
                                                  child: Center(
                                                    child: Text(
                                                      label.displayName,
                                                    ),
                                                  ),
                                                ),
                                          )
                                          .toList(),
                                      onChanged: (value) async {
                                        if (value == null) return;
                                        await ref
                                            .read(
                                              patrolTimeNotifierProvider
                                                  .notifier,
                                            )
                                            .updateLabel(
                                              patrolId: row.id,
                                              label: value,
                                              year: year.value,
                                              month: month.value,
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: 52.w,
                                  child: IconButton(
                                    icon: const Icon(Icons.edit),
                                    iconSize: 20.sp,
                                    tooltip: '編集',
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => PatrolEditPage(
                                            patrolId: row.id,
                                            year: year.value,
                                            month: month.value,
                                          ),
                                        ),
                                      );
                                    },
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
}
