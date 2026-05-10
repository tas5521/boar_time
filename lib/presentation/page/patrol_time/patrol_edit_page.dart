import 'package:auto_route/auto_route.dart';
import 'package:boar_time/model/patrol_label.dart';
import 'package:boar_time/presentation/notifier/patrol/patrol_time_notifier.dart';
import 'package:boar_time/presentation/state/patrol_time_state/patrol_time_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class PatrolEditPage extends HookWidget {
  const PatrolEditPage({
    super.key,
    required this.patrolTimeState,
    required this.patrolTimeNotifier,
  });

  final PatrolTimeState patrolTimeState;
  final PatrolTimeNotifier patrolTimeNotifier;

  @override
  Widget build(BuildContext context) {
    final workerController = useTextEditingController();
    final locationController = useTextEditingController();
    final animalController = useTextEditingController();
    final countController = useTextEditingController();
    final noteController = useTextEditingController();

    useEffect(() {
      workerController.text = patrolTimeState.worker ?? '';
      locationController.text = patrolTimeState.location ?? '';
      animalController.text = patrolTimeState.animal ?? '';
      countController.text = patrolTimeState.count != null
          ? patrolTimeState.count.toString()
          : '';
      noteController.text = patrolTimeState.note ?? '';
      return null;
    }, const []);

    Future<void> confirmDelete(
      BuildContext context,
      PatrolTimeNotifier notifier,
    ) async {
      final result = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text('削除確認', style: TextStyle(fontSize: 20.sp)),
            content: Text(
              'この見回り記録を削除します。\nこの操作は取り消せません。',
              style: TextStyle(fontSize: 16.sp),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text('キャンセル', style: TextStyle(fontSize: 14.sp)),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text('削除', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          );
        },
      );
      if (result != true) return;
      final isSuccess = await notifier.delete(patrolTimeState);
      if (isSuccess && context.mounted) {
        context.router.maybePop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          '見回り詳細',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 24.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summaryBlock(context, patrolTimeState),
            _inputBlock(
              label: '従事者名',
              controller: workerController,
              hint: '例）山田 太郎',
            ),
            _inputBlock(
              label: '見回り場所',
              controller: locationController,
              hint: '例）○○地区、△△付近など',
            ),
            _inputBlock(
              label: '捕獲した獣種',
              controller: animalController,
              hint: '例）イノシシ',
            ),
            _inputBlock(
              label: '捕獲数',
              controller: countController,
              hint: '例）1',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            _inputBlock(
              label: '備考',
              controller: noteController,
              hint: '特記事項があれば記載',
              maxLines: 5,
            ),
            SizedBox(height: 4.w),
            SizedBox(
              width: double.infinity,
              height: 64.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () async {
                  final newPatrolState = patrolTimeState.copyWith(
                    worker: workerController.text.trim(),
                    location: locationController.text.trim(),
                    animal: animalController.text.trim(),
                    count: int.tryParse(countController.text),
                    note: noteController.text.trim(),
                  );
                  final isSuccess = await patrolTimeNotifier.updateData(
                    newPatrolState,
                  );
                  if (isSuccess && context.mounted) {
                    context.router.maybePop();
                  }
                },
                child: Text(
                  '保存',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 64.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () => confirmDelete(context, patrolTimeNotifier),
                child: Text(
                  '削除',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.w),
          ],
        ),
      ),
    );
  }

  Widget _summaryBlock(BuildContext context, PatrolTimeState record) {
    String fmtDate(DateTime d) =>
        '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';

    String fmtTime(DateTime? t) => t == null
        ? ''
        : '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: EdgeInsets.only(bottom: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.w,
        children: [
          Text(
            fmtDate(record.date),
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                '見回り：',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                '${fmtTime(record.start)} 〜 ${fmtTime(record.end)}',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '業務内容：',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Text(record.label.displayName, style: TextStyle(fontSize: 16.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputBlock({
    required String label,
    String? hint,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.w,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.w,
            ),
          ),
        ),
      ],
    );
  }
}
