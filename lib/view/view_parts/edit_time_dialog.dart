import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Future<void> showEditTimeDialog(
  BuildContext context, {
  required String label,
  required DateTime date,
  TimeOfDay? initialTime,
  required FutureOr<void> Function(TimeOfDay selectedTime) onPressed,
  FutureOr<void> Function()? onDelete,
}) {
  final formattedDate = DateFormat('yyyy/MM/dd').format(date);

  return showDialog(
    context: context,
    builder: (context) {
      TimeOfDay selectedTime = initialTime ?? TimeOfDay.now();
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('$label の修正'),
            content: SizedBox(
              width: 300.w,
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
                  Text(
                    '選択した時間： ${selectedTime.format(context)}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 12.w),
                  ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (picked != null) {
                        setState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                    child: const Text('時間を選択する'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (onDelete != null) {
                    await onDelete();
                  }
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('削除', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await onPressed(selectedTime);
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
