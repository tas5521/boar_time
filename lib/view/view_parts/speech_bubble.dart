import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Speech {
  morning,
  afternoon,
  evening,
  night;

  /// 各時間帯のメッセージ候補をまとめる
  List<String> get messages {
    switch (this) {
      case Speech.morning:
        return [
          'おはようございます！\n今日も一日頑張りましょう！',
          'おはよう！\n今日はどんな予定ですか？',
          '良い朝ですね！\n無理せずいきましょう！',
        ];
      case Speech.afternoon:
        return [
          'こんにちは！\n調子はいかがですか？',
          'こんにちは！\n休憩も忘れずに！',
          'いい午後ですね！\n引き続き頑張りましょう！',
        ];
      case Speech.evening:
        return [
          'こんばんは！\n今日もお疲れ様でした！',
          'こんばんは！\n無理しすぎてませんか？',
          '一日頑張りましたね！\n少し休みましょう！',
        ];
      case Speech.night:
        return [
          '夜遅くまでお疲れさまです\nそろそろ休んでくださいね！',
          '遅くまで大変ですね…\nしっかり睡眠をとってください！',
          'もう夜ですね…\n身体をゆっくり休めてください！',
        ];
    }
  }

  String get randomText {
    final list = messages;
    final random = Random();
    return list[random.nextInt(list.length)];
  }

  static Speech fromNow() {
    final hour = DateTime.now().hour;

    if (hour >= 4 && hour < 12) {
      return Speech.morning;
    } else if (hour >= 12 && hour < 18) {
      return Speech.afternoon;
    } else if (hour >= 18 && hour < 22) {
      return Speech.evening;
    } else {
      return Speech.night;
    }
  }
}

class SpeechBubble extends StatelessWidget {
  const SpeechBubble({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.radius = 12.0,
    this.nipWidth = 14.0,
    this.nipHeight = 14.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    this.elevation = 0,
    this.maxWidth,
  });

  final Widget child;
  final Color color;
  final double radius;
  final double nipWidth;
  final double nipHeight;
  final EdgeInsets padding;
  final double elevation;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth ?? 220.w),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius.r),
                boxShadow: elevation > 0
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: elevation,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: child,
            ),
          ),
          CustomPaint(
            size: Size(nipWidth.w, nipHeight.w),
            painter: _RightTrianglePainter(color),
          ),
        ],
      ),
    );
  }
}

class _RightTrianglePainter extends CustomPainter {
  _RightTrianglePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RightTrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
