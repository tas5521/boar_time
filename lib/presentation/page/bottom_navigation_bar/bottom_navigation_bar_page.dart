import 'package:auto_route/auto_route.dart';
import 'package:boar_time/icons/my_flutter_app_icons.dart';
import 'package:boar_time/presentation/navigation/auto_route/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class BottomNavigationBarPage extends HookConsumerWidget {
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future<void> checkFirstLaunch() async {
        // TODO: SharedPreferencesはRiverpodで呼ぶ
        final prefs = await SharedPreferences.getInstance();
        final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

        if (isFirstLaunch) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: Text('ご注意', style: TextStyle(fontSize: 20.w)),
                content: Text(
                  '本アプリでは、打刻時間のデータを端末内に保存しています。\nアプリを削除するとデータは消去されますので、ご注意ください。',
                  style: TextStyle(fontSize: 16.w),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text('OK', style: TextStyle(fontSize: 14.w)),
                  ),
                ],
              ),
            );
          });

          await prefs.setBool('isFirstLaunch', false);
        }
      }

      checkFirstLaunch();
      return null;
    }, []);

    return AutoTabsScaffold(
      routes: const [StampingRoute(), ButcheringTimeRoute(), PatrolTimeRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
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


// TODO: 後で消す
// class BottomNavigationBarView extends HookConsumerWidget {
//   const BottomNavigationBarView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentIndex = useState(0);

//     final pages = [
//       const StampingView(),
//       const ButcheringTimeView(),
//       const PatrolTimeView(),
//     ];

//     useEffect(() {
//       Future<void> checkFirstLaunch() async {
//         final prefs = await SharedPreferences.getInstance();
//         final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

//         if (isFirstLaunch) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             showDialog(
//               context: context,
//               builder: (dialogContext) => AlertDialog(
//                 title: Text('ご注意', style: TextStyle(fontSize: 20.w)),
//                 content: Text(
//                   '本アプリでは、打刻時間のデータを端末内に保存しています。\nアプリを削除するとデータは消去されますので、ご注意ください。',
//                   style: TextStyle(fontSize: 16.w),
//                 ),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(dialogContext),
//                     child: Text('OK', style: TextStyle(fontSize: 14.w)),
//                   ),
//                 ],
//               ),
//             );
//           });

//           await prefs.setBool('isFirstLaunch', false);
//         }
//       }

//       checkFirstLaunch();
//       return null;
//     }, []);

//     return Scaffold(
//       body: IndexedStack(index: currentIndex.value, children: pages),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(MyFlutterApp.clock), label: '打刻'),
//           BottomNavigationBarItem(icon: Icon(MyFlutterApp.meat), label: '解体'),
//           BottomNavigationBarItem(
//             icon: Icon(MyFlutterApp.walking),
//             label: '見回り',
//           ),
//         ],
//         currentIndex: currentIndex.value,
//         onTap: (int index) {
//           currentIndex.value = index;
//           ref.read(activeTabProvider.notifier).state = index;
//         },
//       ),
//     );
//   }
// }

// final activeTabProvider = StateProvider<int>((ref) => 0);




