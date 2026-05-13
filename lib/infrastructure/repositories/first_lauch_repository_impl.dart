import 'package:boar_time/domain/repositories/first_launch_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchRepositoryImpl implements FirstLaunchRepository {
  FirstLaunchRepositoryImpl({required this.prefs});

  final SharedPreferences prefs;

  @override
  bool checkFirstLaunch() => prefs.getBool('isFirstLaunch') ?? true;

  @override
  Future<bool> setFirstLaunch() => prefs.setBool('isFirstLaunch', false);
}
