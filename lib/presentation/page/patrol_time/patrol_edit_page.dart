import 'package:auto_route/auto_route.dart';
import 'package:boar_time/model/patrol_label.dart';
import 'package:boar_time/model/patrol_record/patrol_record.dart';
import 'package:boar_time/presentation/notifier/patrol/patrol_time_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class PatrolEditPage extends HookConsumerWidget {
  final int patrolId;
  final int year;
  final int month;

  const PatrolEditPage({
    super.key,
    required this.patrolId,
    required this.year,
    required this.month,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workerController = useTextEditingController();
    final locationController = useTextEditingController();
    final animalController = useTextEditingController();
    final countController = useTextEditingController();
    final noteController = useTextEditingController();

    final recordState = useState<PatrolRecord?>(null);

    final loading = useState(true);

    final notifier = ref.read(
      patrolTimeProvider((year: year, month: month)).notifier,
    );

    useEffect(() {
      Future<void> load() async {
        final record = await notifier.getDetail(patrolId);
        if (record != null) {
          recordState.value = record;
          workerController.text = record.worker ?? '';
          locationController.text = record.location ?? '';
          animalController.text = record.animal ?? '';
          countController.text = record.count != null
              ? record.count.toString()
              : '';
          noteController.text = record.note ?? '';
        }
        loading.value = false;
      }

      load();
      return null;
    }, const []);

    Future<void> save() async {
      await notifier.updateDetail(
        patrolId: patrolId,
        worker: workerController.text.trim(),
        location: locationController.text.trim(),
        animal: animalController.text.trim(),
        count: int.tryParse(countController.text),
        note: noteController.text.trim(),
        year: year,
        month: month,
      );
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

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

      await notifier.delete(patrolId: patrolId, year: year, month: month);

      if (context.mounted) {
        Navigator.of(context).pop();
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
      body: loading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                spacing: 24.w,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recordState.value != null)
                    _summaryBlock(context, recordState.value!),
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
                      onPressed: save,
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
                      onPressed: () => confirmDelete(context, notifier),
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

  Widget _summaryBlock(BuildContext context, PatrolRecord record) {
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
