import 'package:boar_time/di/isar_provider.dart';
import 'package:boar_time/model/patrol_record/patrol_record.dart';
import 'package:boar_time/model/work_record/work_record.dart';
import 'package:boar_time/presentation/navigation/auto_route/app_router.dart';
import 'package:boar_time/utils/migration/app_meta.dart';
import 'package:boar_time/utils/migration/migrate_patrol_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await initializeIsar();
  await migratePatrolData(isar);
  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isar)],
      child: MyApp(),
    ),
  );
}

Future<Isar> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([
    AppMetaSchema,
    WorkRecordSchema,
    PatrolRecordSchema,
  ], directory: dir.path);
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
