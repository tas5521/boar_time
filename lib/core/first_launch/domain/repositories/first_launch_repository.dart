abstract interface class FirstLaunchRepository {
  bool checkFirstLaunch();
  Future<bool> setFirstLaunch();
}
