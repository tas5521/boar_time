import 'package:boar_time/manager/export_manager.dart';
import 'package:boar_time/manager/patrol_record_manager.dart';
import 'package:boar_time/model/job_type.dart';
import 'package:boar_time/model/patrol_record/patrol_record.dart';
import 'package:boar_time/model/patrol_time_state/patrol_time_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patrolTimeNotifierProvider =
    NotifierProvider<PatrolTimeNotifier, AsyncValue<List<PatrolTimeState>>>(
      PatrolTimeNotifier.new,
    );

class PatrolTimeNotifier extends Notifier<AsyncValue<List<PatrolTimeState>>> {
  @override
  AsyncValue<List<PatrolTimeState>> build() {
    return const AsyncValue.loading();
  }

  Future<void> loadMonth(int year, int month) async {
    state = const AsyncValue.loading();
    try {
      final records = await _loadRecords(year, month);
      final converted = _convertRecords(records);
      state = AsyncValue.data(converted);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> upsert({
    int? recordId,
    required DateTime date,
    DateTime? start,
    DateTime? end,
    required int year,
    required int month,
  }) async {
    state = const AsyncValue.loading();
    try {
      if (recordId == null) {
        // 新規作成
        if (start != null) {
          await PatrolRecordManager.create(date, start);
        }
      } else {
        // 更新
        final record = PatrolRecord(date: date, start: start!, end: end);
        record.id = recordId;

        await PatrolRecordManager.update(record);
      }

      final records = await _loadRecords(year, month);
      state = AsyncValue.data(_convertRecords(records));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<PatrolRecord>> _loadRecords(int year, int month) async {
    return PatrolRecordManager.getByMonth(year, month);
  }

  List<PatrolTimeState> _convertRecords(List<PatrolRecord> records) {
    final sorted = [...records]..sort((a, b) => a.start.compareTo(b.start));

    Duration cumulative = Duration.zero;

    return sorted.map((rec) {
      final base = PatrolTimeState(
        id: rec.id,
        date: rec.date,
        start: rec.start,
        end: rec.end,
        cumulativeDuration: Duration.zero,
      );

      cumulative += base.totalDuration;

      return base.copyWith(cumulativeDuration: cumulative);
    }).toList();
  }

  Future<void> exportAndSave({
    required ExportFormat format,
    required String filename,
  }) async {
    final data = state.valueOrNull ?? [];
    await ExportManager.exportAndSave(
      type: JobType.patrol,
      format: format,
      data: data,
      filename: filename,
    );
  }
}
