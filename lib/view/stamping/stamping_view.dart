import 'dart:async';

import 'package:boar_time/notifier/stamping/stamping_notifier.dart';
import 'package:boar_time/view/view_parts/time_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StampingView extends HookConsumerWidget {
  const StampingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stampingNotifierProvider).value;
    final lifecycle = useAppLifecycleState();

    useEffect(() {
      if (lifecycle == AppLifecycleState.resumed) {
        ref.read(stampingNotifierProvider.notifier).fetch();
      }
      return;
    }, [lifecycle]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('打刻', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'license', child: Text('ライセンス情報')),
            ],
            onSelected: (value) {
              if (value == 'license') {
                showLicensePage(context: context, applicationName: 'InoTime');
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 40.w,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(12.w, 0.w, 0.w, 0.w),
              width: 340.w,
              child: TimeDisplay(
                onDateChanged: () async {
                  await ref.read(stampingNotifierProvider.notifier).fetch();
                },
              ),
            ),
            Column(
              spacing: 32.w,
              children: [
                Row(
                  spacing: 16.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                      '解体 出勤',
                      enabled: state != null && state.startTime == null,
                      onPressed: () async {
                        await ref
                            .read(stampingNotifierProvider.notifier)
                            .setStartTime();
                        if (!context.mounted) return;
                        await showStampCompletedDialog(
                          context,
                          message: '解体の出勤を記録しました。',
                        );
                      },
                    ),
                    customButton(
                      '解体 退勤',
                      enabled: state != null && state.endTime == null,
                      onPressed: () async {
                        await ref
                            .read(stampingNotifierProvider.notifier)
                            .setEndTime();
                        if (!context.mounted) return;
                        await showStampCompletedDialog(
                          context,
                          message: '解体の退勤を記録しました。',
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  spacing: 16.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                      '休憩 開始',
                      enabled: state != null && state.breakStart == null,
                      onPressed: () async {
                        await ref
                            .read(stampingNotifierProvider.notifier)
                            .setBreakStart();
                        if (!context.mounted) return;
                        await showStampCompletedDialog(
                          context,
                          message: '休憩開始を記録しました。',
                        );
                      },
                    ),
                    customButton(
                      '休憩 終了',
                      enabled: state != null && state.breakEnd == null,
                      onPressed: () async {
                        await ref
                            .read(stampingNotifierProvider.notifier)
                            .setBreakEnd();
                        if (!context.mounted) return;
                        await showStampCompletedDialog(
                          context,
                          message: '休憩終了を記録しました。',
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  spacing: 16.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                      '見回り 開始',
                      enabled: state != null && state.patrolStart == null,
                      onPressed: () async {
                        await ref
                            .read(stampingNotifierProvider.notifier)
                            .setPatrolStart();
                        if (!context.mounted) return;
                        await showStampCompletedDialog(
                          context,
                          message: '見回り開始を記録しました。',
                        );
                      },
                    ),
                    customButton(
                      '見回り 終了',
                      enabled: state != null && state.patrolEnd == null,
                      onPressed: () async {
                        await ref
                            .read(stampingNotifierProvider.notifier)
                            .setPatrolEnd();
                        if (!context.mounted) return;
                        await showStampCompletedDialog(
                          context,
                          message: '見回り終了を記録しました。',
                        );
                      },
                    ),
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
    required FutureOr<void> Function()? onPressed,
    required bool enabled,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
        fixedSize: Size(160.w, 80.w),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        title,
        style: TextStyle(fontSize: 20.sp, color: enabled ? null : Colors.grey),
      ),
    );
  }

  Future<void> showStampCompletedDialog(
    BuildContext context, {
    required String message,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            '打刻完了',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(message, style: TextStyle(fontSize: 16.w)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
