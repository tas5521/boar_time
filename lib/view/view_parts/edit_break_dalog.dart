import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Future<void> showEditBreakDialog(
  BuildContext context, {
  required DateTime date,
  TimeOfDay? initialStart,
  TimeOfDay? initialEnd,
  required FutureOr<void> Function({
    required TimeOfDay breakStart,
    required TimeOfDay breakEnd,
  }) onPressed,
}) {
  final formattedDate = DateFormat('yyyy/MM/dd').format(date);

  return showDialog(
    context: context,
    builder: (_) {
      TimeOfDay start = initialStart ?? TimeOfDay(hour: 12, minute: 0);
      TimeOfDay end = initialEnd ?? TimeOfDay(hour: 13, minute: 0);

      return StatefulBuilder(
        builder: (context, setState) {
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
                      Text(
                        '休憩開始',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      TextButton(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: start,
                          );
                          if (picked != null) {
                            setState(() => start = picked);
                          }
                        },
                        child: Text(
                          start.format(context),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '休憩終了',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      TextButton(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: end,
                          );
                          if (picked != null) {
                            setState(() => end = picked);
                          }
                        },
                        child: Text(
                          end.format(context),
                          style: TextStyle(fontSize: 16.sp),
                        ),
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
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
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
