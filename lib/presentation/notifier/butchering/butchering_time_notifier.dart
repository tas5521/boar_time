import 'dart:async';

import 'package:boar_time/core/enums/export_format.dart';
import 'package:boar_time/di/buthering_time_provider.dart';
import 'package:boar_time/domain/entities/butchering_time.dart';
import 'package:boar_time/presentation/state/butchering_time_state/butchering_time_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final butcheringTimeProvider =
    AsyncNotifierProvider.family<
      ButcheringTimeNotifier,
      List<ButcheringTimeState>,
      ({int year, int month})
    >(ButcheringTimeNotifier.new);

class ButcheringTimeNotifier
    extends
        FamilyAsyncNotifier<
          List<ButcheringTimeState>,
          ({int year, int month})
        > {
  @override
  FutureOr<List<ButcheringTimeState>> build(arg) =>
      _createButcheringTimeState(arg.year, arg.month);

  Future<List<ButcheringTimeState>> _createButcheringTimeState(
    int year,
    int month,
  ) async {
    final usecase = ref.read(butcheringTimeUsecaseProvider);
    final butcheringTimeList = await usecase.getButcheringTimeList(year, month);
    final lastDay = DateTime(
      year,
      month + 1,
      1,
    ).subtract(const Duration(days: 1)).day;

    final List<ButcheringTimeState> list = [];
    Duration cumulative = Duration.zero;

    for (int day = 1; day <= lastDay; day++) {
      final date = DateTime(year, month, day);

      final targetButcheringTime = butcheringTimeList.firstWhere(
        (butcheringTime) =>
            butcheringTime.date.year == date.year &&
            butcheringTime.date.month == date.month &&
            butcheringTime.date.day == date.day,
        orElse: () => ButcheringTime(date: date),
      );

      var state = ButcheringTimeState(
        date: date,
        start: targetButcheringTime.startTime,
        end: targetButcheringTime.endTime,
        breakStart: targetButcheringTime.breakStart,
        breakEnd: targetButcheringTime.breakEnd,
        cumulativeDuration: Duration.zero,
      );

      cumulative += state.actualDuration;
      state = state.copyWith(cumulativeDuration: cumulative);

      list.add(state);
    }

    return list;
  }

  Future<void> updateData(ButcheringTimeState target) async {
    try {
      state = const AsyncValue.loading();
      final entity = target.toEntity();
      final usecase = ref.read(butcheringTimeUsecaseProvider);
      await usecase.upsert(entity);
      final butcheringTimeStateList = await _createButcheringTimeState(
        arg.year,
        arg.month,
      );
      state = AsyncValue.data(butcheringTimeStateList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> export({
    required ExportFormat format,
    required String filename,
  }) async {
    try {
      final prevState = state;
      state = const AsyncValue.loading();
      final data = state.value!;
      final usecase = ref.read(butcheringTimeUsecaseProvider);
      await usecase.export(data, format, filename);
      state = prevState;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
