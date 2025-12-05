import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeDisplay extends HookWidget {
  const TimeDisplay({this.fontSize = 24, super.key});

  final int fontSize;

  @override
  Widget build(BuildContext context) {
    final now = useState(DateTime.now());

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        now.value = DateTime.now();
      });
      return timer.cancel;
    }, []);

    final dt = now.value;

    const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    final weekday = weekdays[dt.weekday - 1];

    final formatted =
        "${dt.year.toString().padLeft(4, '0')}/"
        "${dt.month.toString().padLeft(2, '0')}/"
        "${dt.day.toString().padLeft(2, '0')} "
        "($weekday) "
        "${dt.hour.toString().padLeft(2, '0')}:"
        "${dt.minute.toString().padLeft(2, '0')}:"
        "${dt.second.toString().padLeft(2, '0')}";

    return Text(
      formatted,
      style: TextStyle(fontSize: fontSize.sp, fontWeight: FontWeight.bold),
    );
  }
}
