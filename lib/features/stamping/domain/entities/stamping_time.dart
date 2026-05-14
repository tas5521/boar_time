import 'dart:core';

class StampingTime {
  const StampingTime({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.breakStart,
    required this.breakEnd,
    required this.patrolStart,
    required this.patrolEnd,
  });

  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? breakStart;
  final DateTime? breakEnd;
  final DateTime? patrolStart;
  final DateTime? patrolEnd;
}
