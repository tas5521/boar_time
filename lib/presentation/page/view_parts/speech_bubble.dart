import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
