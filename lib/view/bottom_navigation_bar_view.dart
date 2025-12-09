import 'package:boar_time/icons/my_flutter_app_icons.dart';
import 'package:boar_time/view/butchering_time/butchering_time_view.dart';
import 'package:boar_time/view/patrol_time/patrol_time_view.dart';
import 'package:boar_time/view/stamping/stamping_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigationBarView extends HookConsumerWidget {
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    final pages = [
      const StampingView(),
      const ButcheringTimeView(),
      const PatrolTimeView(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex.value, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.clock), label: '打刻'),
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.meat), label: '解体'),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.walking),
            label: '見回り',
          ),
        ],
        currentIndex: currentIndex.value,
        onTap: (int index) {
          currentIndex.value = index;
          ref.read(activeTabProvider.notifier).state = index;
        },
      ),
    );
  }
}

final activeTabProvider = StateProvider<int>((ref) => 0);