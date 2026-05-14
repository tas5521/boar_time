import 'dart:core';

class ButcheringTime {
  const ButcheringTime({
    required this.date,
    this.startTime,
    this.endTime,
    this.breakStart,
    this.breakEnd,
  });

  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? breakStart;
  final DateTime? breakEnd;
}
