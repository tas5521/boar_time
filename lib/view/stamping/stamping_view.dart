import 'dart:async';

import 'package:boar_time/view/view_parts/time_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StampingView extends HookConsumerWidget {
  const StampingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('打刻', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 40.w,
          children: [
            SizedBox(width: 360.w, child: const TimeDisplay(fontSize: 24)),
            Column(
              spacing: 32.w,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  spacing: 16.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton('解体 出勤', onPressed: () {}),
                    customButton('解体 退勤', onPressed: () {}),
                  ],
                ),
                Row(
                  spacing: 16.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton('休憩 開始', onPressed: () {}),
                    customButton('休憩 終了', onPressed: () {}),
                  ],
                ),
                Row(
                  spacing: 16.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton('見回り 開始', onPressed: () {}),
                    customButton('見回り 終了', onPressed: () {}),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(
    String title, {
    required FutureOr<void> Function() onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
        fixedSize: Size(160.w, 80.w),
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(fontSize: 20.sp)),
    );
  }
}
