import 'dart:math';

import 'package:boar_time/view/view_parts/speech_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Speech {
  morning,
  afternoon,
  evening,
  night;

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

class BoarSpeechArea extends HookWidget {
  const BoarSpeechArea({super.key});

  @override
  Widget build(BuildContext context) {
    final speechText = useState(Speech.fromNow().randomText);
    final controller = useAnimationController(duration: 300.ms);

    useEffect(() {
      controller.value = 0;
      return null;
    }, []);

    void showBubble() {
      speechText.value = Speech.fromNow().randomText;
      controller.forward(from: 0);
    }

    return Row(
      children: [
        FadeTransition(
          opacity: controller,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.3, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: controller, curve: Curves.easeOut),
                ),
            child: SpeechBubble(
              color: Colors.grey.shade200,
              child: Text(speechText.value, style: TextStyle(fontSize: 16.w)),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: showBubble,
          child: Image.asset(
            'assets/images/contents/boar.png',
            width: 80.w,
            height: 80.w,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
