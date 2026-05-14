import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Future<void> showEditTimeDialog(
  BuildContext context, {
  required String label,
  required DateTime date,
  TimeOfDay? initialTime,
  required FutureOr<void> Function(TimeOfDay? selectedTime) onPressed,
  bool showClearTimeButton = false,
}) {
  final formattedDate = DateFormat('yyyy/MM/dd').format(date);

  return showDialog(
    context: context,
    builder: (context) {
      TimeOfDay? selectedTime = initialTime;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('$labelの修正', style: TextStyle(fontSize: 20.sp)),
            content: SizedBox(
              width: 300.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '対象日：$formattedDate',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.w),
                  Container(
                    margin: EdgeInsets.only(left: 50.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '選択した時間： ${selectedTime != null ? selectedTime?.format(context) : "--:--"}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 12.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: selectedTime ?? TimeOfDay.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedTime = picked;
                            });
                          }
                        },
                        child: Text(
                          '時間を選択する',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                      if (showClearTimeButton) SizedBox(width: 20.w),
                      if (showClearTimeButton)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedTime = null;
                            });
                          },
                          child: Text(
                            '削除',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red,
                            ),
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
                child: Text('キャンセル', style: TextStyle(fontSize: 14.sp)),
              ),
              ElevatedButton(
                onPressed: () async {
                  await onPressed(selectedTime);
                  if (context.mounted) Navigator.pop(context);
                },
                child: Text('保存', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          );
        },
      );
    },
  );
}
