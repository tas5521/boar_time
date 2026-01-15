import 'dart:math';

import 'package:boar_time/view/view_parts/speech_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DurationOfDay { morning, afternoon, evening, night }

const List<String> freeMessages = [
  'どうも\n鯨偶蹄目イノシシ科の動物です',
  '猪は大和言葉でヰ（イ）と呼ばれていました\n「ヰ（イ）のシシ（肉）」が語源なんですよ',
  '牙以外の歯は一生に一度生え変わりますが、牙だけは歯根が無いので一生伸び続けます',
  '嗅覚には自信があります！',
  '目はあまり良くないほうです',
  '実は泳ぐのも得意です！',
  '猪の赤ちゃんには瓜のような縞模様があります\nだから「ウリ坊」なんですよ',
  '実は、焦げた匂いが嫌いなんです…',
  '高いハードルは越えるより潜りたいですよね！',
  '沼田場（ヌタバ）が好きです\nぬた打ちは気持ちいいですよね！',
  '猪の唾液はタンニンを中和できるんですよ\nだからドングリを食べられるんです！',
  '猪は江戸時代には山鯨とも呼ばれていました\n理由は…わかりますよね？',
  '猪肉は牡丹、鹿肉は紅葉、馬肉は桜とも呼ばれます\n物騒な表現です…',
  '猪突猛進！！！',
  '猪が書かれた花札の花は「萩」ですよ\n「牡丹」は蝶ですからね',
];

List<String> timeMessages(DurationOfDay durationOfDay) {
  switch (durationOfDay) {
    case DurationOfDay.morning:
      return [
        'おはようございます！\n今日も一日頑張りましょう！',
        'おはよう！\n今日はどんな予定ですか？',
        '良い朝ですね！\n無理せずいきましょう！',
      ];
    case DurationOfDay.afternoon:
      return [
        'こんにちは！\n調子はいかがですか？',
        'こんにちは！\n休憩も忘れずに！',
        'いい午後ですね！\n引き続き頑張りましょう！',
      ];
    case DurationOfDay.evening:
      return [
        'こんばんは！\n今日もお疲れ様でした！',
        'こんばんは！\n無理しすぎてませんか？',
        '一日頑張りましたね！\n少し休みましょう！',
      ];
    case DurationOfDay.night:
      return [
        '夜遅くまでお疲れさまです\nそろそろ休んでくださいね！',
        '遅くまで大変ですね…\nしっかり睡眠をとってください！',
        'もう夜ですね…\n身体をゆっくり休めてください！',
      ];
  }
}

DurationOfDay getCurrentDuration() {
  final hour = DateTime.now().hour;
  if (hour >= 4 && hour < 12) {
    return DurationOfDay.morning;
  } else if (hour >= 12 && hour < 18) {
    return DurationOfDay.afternoon;
  } else if (hour >= 18 && hour < 22) {
    return DurationOfDay.evening;
  } else {
    return DurationOfDay.night;
  }
}

class BoarSpeechArea extends HookWidget {
  const BoarSpeechArea({super.key});

  String get randomText {
    final list = [...timeMessages(getCurrentDuration()), ...freeMessages];
    final random = Random();
    return list[random.nextInt(list.length)];
  }

  @override
  Widget build(BuildContext context) {
    final speechText = useState(randomText);
    final controller = useAnimationController(duration: 300.ms);
    final lifecycle = useAppLifecycleState();

    useEffect(() {
      if (lifecycle == AppLifecycleState.resumed) {
        controller.value = 0;
      }
      return;
    }, [lifecycle]);

    useEffect(() {
      controller.value = 0;
      return null;
    }, []);

    void showBubble() {
      String newText;
      do {
        newText = randomText;
      } while (newText == speechText.value);
      speechText.value = newText;
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
