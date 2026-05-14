import 'package:auto_route/auto_route.dart';
import 'package:boar_time/app/navigation/auto_route/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      page: BottomNavigationBarRoute.page,
      children: [
        AutoRoute(page: StampingRoute.page),
        AutoRoute(page: ButcheringTimeRoute.page),
        AutoRoute(page: PatrolTimeRoute.page),
      ],
    ),
    AutoRoute(page: PatrolEditRoute.page),
  ];
}
