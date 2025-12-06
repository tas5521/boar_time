import 'package:boar_time/manager/work_record_manager.dart';
import 'package:boar_time/model/butchering_time_state/butchering_time_state.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final butcheringTimeNotifierProvider =
    NotifierProvider<
      ButcheringTimeNotifier,
      AsyncValue<List<ButcheringTimeState>>
    >(ButcheringTimeNotifier.new);

class ButcheringTimeNotifier
    extends Notifier<AsyncValue<List<ButcheringTimeState>>> {
  @override
  AsyncValue<List<ButcheringTimeState>> build() {
    return const AsyncValue.loading();
  }

  Future<void> loadMonth(int year, int month) async {
    state = const AsyncValue.loading();
    try {
      final records = await _loadRecords(year, month);
      final converted = _convertRecords(year, month, records);
      state = AsyncValue.data(converted);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<WorkRecord>> _loadRecords(int year, int month) async {
    final all = await WorkRecordManager.getAll();
    return all
        .where((e) => e.date.year == year && e.date.month == month)
        .toList();
  }

  List<ButcheringTimeState> _convertRecords(
    int year,
    int month,
    List<WorkRecord> records,
  ) {
    final lastDay = DateTime(year, month + 1, 0).day;
    final List<ButcheringTimeState> list = [];
    Duration cumulative = Duration.zero;

    for (int day = 1; day <= lastDay; day++) {
      final date = DateTime(year, month, day);

      final rec = records.firstWhere(
        (e) =>
            e.date.year == date.year &&
            e.date.month == date.month &&
            e.date.day == date.day,
        orElse: () => WorkRecord(date: date),
      );

      var state = ButcheringTimeState(
        date: date,
        start: rec.startTime,
        end: rec.endTime,
        breakStart: rec.breakStart,
        breakEnd: rec.breakEnd,
        cumulativeDuration: Duration.zero,
      );

      cumulative += state.actualDuration;

      state = state.copyWith(cumulativeDuration: cumulative);

      list.add(state);
    }

    return list;
  }
}
