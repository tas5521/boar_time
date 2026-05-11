import 'package:auto_route/auto_route.dart';
import 'package:boar_time/icons/my_flutter_app_icons.dart';
import 'package:boar_time/presentation/navigation/auto_route/app_router.gr.dart';
import 'package:boar_time/presentation/notifier/active_tab/active_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class BottomNavigationBarPage extends HookConsumerWidget {
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const [StampingRoute(), ButcheringTimeRoute(), PatrolTimeRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) {
            tabsRouter.setActiveIndex(index);
            ref.read(activeTabProvider.notifier).setActiveTabIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.clock),
              label: '打刻',
            ),
            BottomNavigationBarItem(icon: Icon(MyFlutterApp.meat), label: '解体'),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.walking),
              label: '見回り',
            ),
          ],
        );
      },
    );
  }
}
