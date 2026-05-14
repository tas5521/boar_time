import 'package:boar_time/core/first_launch/domain/repositories/first_launch_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchRepositoryImpl implements FirstLaunchRepository {
  FirstLaunchRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  bool checkFirstLaunch() => _prefs.getBool('isFirstLaunch') ?? true;

  @override
  Future<bool> setFirstLaunch() => _prefs.setBool('isFirstLaunch', false);
}
