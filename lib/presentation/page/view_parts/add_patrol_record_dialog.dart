import 'package:boar_time/domain/enums/patrol_label.dart';
import 'package:boar_time/presentation/notifier/patrol/patrol_time_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showAddPatrolRecordDialog(
  BuildContext context,
  WidgetRef ref,
  ValueNotifier<int> year,
  ValueNotifier<int> month,
) async {
  DateTime? selectedDate;
  TimeOfDay? selectedStart;
  TimeOfDay? selectedEnd;
  PatrolLabel? selectedLabel;

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (addContext) {
      var submitting = false;

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

          final canAdd =
              selectedDate != null &&
              selectedStart != null &&
              selectedEnd != null &&
              selectedLabel != null;

          return AlertDialog(
            title: Text('新しい見回り記録を追加', style: TextStyle(fontSize: 20.sp)),
            content: AbsorbPointer(
              absorbing: submitting,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
            ),
            actions: [
              TextButton(
                onPressed: submitting
                    ? null
                    : () => Navigator.of(addContext).pop(),
                child: Text('キャンセル', style: TextStyle(fontSize: 14.sp)),
              ),
              ElevatedButton(
                onPressed: (!canAdd || submitting)
                    ? null
                    : () async {
                        setState(() => submitting = true);
                        try {
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
                              .read(
                                patrolTimeProvider((
                                  year: year.value,
                                  month: month.value,
                                )).notifier,
                              )
                              .addNewData(
                                date: selectedDate!,
                                start: newStart,
                                end: newEnd,
                                label: selectedLabel!,
                              );

                          year.value = selectedDate!.year;
                          month.value = selectedDate!.month;

                          if (addContext.mounted) {
                            Navigator.of(addContext).pop();
                          }
                        } catch (e, _) {
                          if (addContext.mounted) {
                            setState(() => submitting = false);
                            ScaffoldMessenger.of(addContext).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '追加に失敗しました: $e',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(88.w, 40.w),
                ),
                child: submitting
                    ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(
                            addContext,
                          ).colorScheme.onPrimary,
                        ),
                      )
                    : Text('追加', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          );
        },
      );
    },
  );
}
