import 'dart:core';

import 'package:boar_time/domain/enums/patrol_label.dart';

class PatrolTime {
  const PatrolTime({
    this.id,
    required this.date,
    required this.start,
    this.end,
    required this.label,
    this.worker,
    this.location,
    this.animal,
    this.count,
    this.note,
  });

  final int? id;
  final DateTime date;
  final DateTime start;
  final DateTime? end;
  final PatrolLabel label;
  final String? worker;
  final String? location;
  final String? animal;
  final int? count;
  final String? note;
}
