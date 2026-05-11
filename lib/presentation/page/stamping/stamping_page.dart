import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:boar_time/presentation/notifier/active_tab/active_tab_notifier.dart';
import 'package:boar_time/presentation/notifier/stamping/stamping_notifier.dart';
import 'package:boar_time/presentation/page/view_parts/boar_speech_area.dart';
import 'package:boar_time/presentation/page/view_parts/time_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class StampingPage extends HookConsumerWidget {
  const StampingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stampingTimeProvider);
    final lifecycle = useAppLifecycleState();

    useEffect(() {
      if (lifecycle == AppLifecycleState.resumed) {
        ref.invalidate(stampingTimeProvider);
      }
      return;
    }, [lifecycle]);

    ref.listen(activeTabProvider, (_, next) {
      if (next == 0) {
        ref.invalidate(stampingTimeProvider);
      }
    });

    useEffect(() {
      final isFirstLaunch = ref
          .read(stampingTimeProvider.notifier)
          .checkFirstLaunch();
      if (isFirstLaunch) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: Text('ご注意', style: TextStyle(fontSize: 20.w)),
              content: Text(
                '本アプリでは、打刻時間のデータを端末内に保存しています。\nアプリを削除するとデータは消去されますので、ご注意ください。',
                style: TextStyle(fontSize: 16.w),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    final isSuccess = await ref
                        .read(stampingTimeProvider.notifier)
                        .setFirstLaunch();
                    if (isSuccess && dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                    }
                  },
                  child: Text('OK', style: TextStyle(fontSize: 14.w)),
                ),
              ],
            ),
          );
        });
      }
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          '打刻',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'license',
                child: Text('ライセンス情報', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
            onSelected: (value) {
              if (value == 'license') {
                showLicensePage(context: context, applicationName: 'Wild Boar');
              }
            },
          ),
        ],
      ),
      body: state.when(
        data: (data) => Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            spacing: 40.w,
            children: [
              Container(
                margin: EdgeInsets.only(left: 4.w),
                width: 340.w,
                child: TimeDisplay(
                  onDateChanged: () {
                    ref.invalidate(stampingTimeProvider);
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
                        enabled: data.startTime == null,
                        onPressed: () async {
                          final isSuccess = await ref
                              .read(stampingTimeProvider.notifier)
                              .setStartTime();
                          if (!isSuccess || !context.mounted) return;
                          await showStampCompletedDialog(
                            context,
                            message: '解体の出勤を記録しました。',
                          );
                        },
                      ),
                      customButton(
                        '解体 退勤',
                        enabled: data.endTime == null,
                        onPressed: () async {
                          final isSuccess = await ref
                              .read(stampingTimeProvider.notifier)
                              .setEndTime();
                          if (!isSuccess || !context.mounted) return;
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
                        enabled: data.breakStart == null,
                        onPressed: () async {
                          final isSuccess = await ref
                              .read(stampingTimeProvider.notifier)
                              .setBreakStart();
                          if (!isSuccess || !context.mounted) return;
                          await showStampCompletedDialog(
                            context,
                            message: '休憩開始を記録しました。',
                          );
                        },
                      ),
                      customButton(
                        '休憩 終了',
                        enabled: data.breakEnd == null,
                        onPressed: () async {
                          final isSuccess = await ref
                              .read(stampingTimeProvider.notifier)
                              .setBreakEnd();
                          if (!isSuccess || !context.mounted) return;
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
                        enabled:
                            data.patrolStart == null && data.patrolEnd == null,
                        onPressed: () async {
                          final isSuccess = await ref
                              .read(stampingTimeProvider.notifier)
                              .setPatrolStart();
                          if (!isSuccess || !context.mounted) return;
                          await showStampCompletedDialog(
                            context,
                            message: '見回り開始を記録しました。',
                          );
                        },
                      ),
                      customButton(
                        '見回り 終了',
                        enabled:
                            data.patrolStart != null && data.patrolEnd == null,
                        onPressed: () async {
                          final isSuccess = await ref
                              .read(stampingTimeProvider.notifier)
                              .setPatrolEnd();
                          if (!isSuccess || !context.mounted) return;
                          await showStampCompletedDialog(
                            context,
                            message: '見回り終了を記録しました。',
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      BoarSpeechArea(),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.sp,
                  color: Theme.of(context).colorScheme.error,
                ),
                SizedBox(height: 16.w),
                Text(
                  '打刻データを読み込めませんでした。',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.w),
                Text(
                  kDebugMode
                      ? error.toString()
                      : '通信やストレージの不調の可能性があります。しばらくしてから再度お試しください。',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
                SizedBox(height: 24.w),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(stampingTimeProvider);
                  },
                  child: Text('再読み込み', style: TextStyle(fontSize: 16.sp)),
                ),
              ],
            ),
          ),
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
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            '打刻完了',
            style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold),
          ),
          content: Text(message, style: TextStyle(fontSize: 16.w)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('OK', style: TextStyle(fontSize: 14.w)),
            ),
          ],
        );
      },
    );
  }
}
