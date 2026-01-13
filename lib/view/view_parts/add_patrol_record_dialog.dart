import 'package:boar_time/model/patrol_label.dart';
import 'package:boar_time/notifier/patrol/patrol_time_notifier.dart';
import 'package:boar_time/notifier/stamping/stamping_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showAddPatrolRecordDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  DateTime? selectedDate;
  TimeOfDay? selectedStart;
  TimeOfDay? selectedEnd;
  PatrolLabel? selectedLabel;

  await showDialog(
    context: context,
    builder: (addContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          String formatDate(DateTime? date) {
            if (date == null) return '--/--/--';
            return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
          }

          String formatTime(TimeOfDay? time) {
            if (time == null) return '--:--';
            return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
          }

          // すべてのデータが入力されているか
          final canAdd =
              selectedDate != null &&
              selectedStart != null &&
              selectedEnd != null &&
              selectedLabel != null;

          return AlertDialog(
            title: Text('新しい見回り記録を追加', style: TextStyle(fontSize: 20.sp)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 日付
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('日付を選択', style: TextStyle(fontSize: 16.sp)),
                        Text(
                          formatDate(selectedDate),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final now = DateTime.now();
                      final date = await showDatePicker(
                        context: addContext,
                        initialDate: selectedDate ?? now,
                        firstDate: DateTime(now.year - 5),
                        lastDate: DateTime(now.year + 5),
                      );
                      if (date != null) {
                        setState(() => selectedDate = date);
                      }
                    },
                  ),
                  // 開始時刻
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('開始時刻を選択', style: TextStyle(fontSize: 16.sp)),
                        Text(
                          formatTime(selectedStart),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: addContext,
                        initialTime: selectedStart ?? TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() => selectedStart = time);
                      }
                    },
                  ),
                  // 終了時刻
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('終了時刻を選択', style: TextStyle(fontSize: 16.sp)),
                        Text(
                          formatTime(selectedEnd),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: addContext,
                        initialTime: selectedEnd ?? TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() => selectedEnd = time);
                      }
                    },
                  ),
                  // 業務内容
                  SizedBox(
                    width: 194.w,
                    child: DropdownButton<PatrolLabel>(
                      value: selectedLabel,
                      hint: Text('業務内容を選択', style: TextStyle(fontSize: 16.sp)),
                      isExpanded: true,
                      items: PatrolLabel.values.map((label) {
                        return DropdownMenuItem(
                          value: label,
                          child: Text(label.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedLabel = value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(addContext).pop(),
                child: Text('キャンセル', style: TextStyle(fontSize: 14.sp)),
              ),
              ElevatedButton(
                onPressed: canAdd
                    ? () async {
                        final newStart = DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedStart!.hour,
                          selectedStart!.minute,
                        );

                        final newEnd = DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedEnd!.hour,
                          selectedEnd!.minute,
                        );

                        await ref
                            .read(patrolTimeNotifierProvider.notifier)
                            .addNewRecord(
                              date: selectedDate!,
                              start: newStart,
                              end: newEnd,
                              label: selectedLabel!,
                            );

                        await ref
                            .read(stampingNotifierProvider.notifier)
                            .fetch();

                        if (!addContext.mounted) return;
                        Navigator.of(addContext).pop();
                      }
                    : null,
                child: Text('追加', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          );
        },
      );
    },
  );
}
