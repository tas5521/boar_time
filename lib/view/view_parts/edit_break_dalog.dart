import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Future<void> showEditBreakDialog(
  BuildContext context, {
  required DateTime date,
  TimeOfDay? initialStart,
  TimeOfDay? initialEnd,
  required FutureOr<void> Function({TimeOfDay? breakStart, TimeOfDay? breakEnd})
  onPressed,
}) {
  final formattedDate = DateFormat('yyyy/MM/dd').format(date);

  return showDialog(
    context: context,
    builder: (_) {
      TimeOfDay? start = initialStart;
      TimeOfDay? end = initialEnd;

      return StatefulBuilder(
        builder: (context, setState) {
          String formatTime(TimeOfDay? t) => t?.format(context) ?? '--:--';

          return AlertDialog(
            title: const Text('休憩時間の編集'),
            content: SizedBox(
              width: 320.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '対象日：$formattedDate',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('休憩開始', style: TextStyle(fontSize: 16.sp)),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime:
                                    start ?? TimeOfDay(hour: 12, minute: 0),
                              );
                              if (picked != null) {
                                setState(() => start = picked);
                              }
                            },
                            child: Text(
                              formatTime(start),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() => start = null),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('休憩終了', style: TextStyle(fontSize: 16.sp)),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime:
                                    end ?? TimeOfDay(hour: 13, minute: 0),
                              );
                              if (picked != null) {
                                setState(() => end = picked);
                              }
                            },
                            child: Text(
                              formatTime(end),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() => end = null),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await onPressed(breakStart: start, breakEnd: end);
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('保存'),
              ),
            ],
          );
        },
      );
    },
  );
}
