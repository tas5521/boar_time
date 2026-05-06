import 'package:boar_time/manager/isar_manager.dart';
import 'package:boar_time/presentation/navigation/auto_route/app_router.dart';
import 'package:boar_time/utils/migration/migrate_patrol_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarManager.initialize();
  await migratePatrolData(IsarManager.isar);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0), boldText: false),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: const Locale('ja'),
            supportedLocales: const [Locale('ja')],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepOrangeAccent,
              ),
            ),
            routerConfig: _appRouter.config(),
          ),
        );
      },
    );
  }
}
