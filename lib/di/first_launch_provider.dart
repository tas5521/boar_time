import 'package:boar_time/application/usecase/first_launch_usecase_impl.dart';
import 'package:boar_time/di/shared_preferences_provider.dart';
import 'package:boar_time/domain/repositories/first_launch_repository.dart';
import 'package:boar_time/domain/usecase/first_launch_usecase.dart';
import 'package:boar_time/infrastructure/repositories/first_lauch_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firstLaunchRepositoryProvider = Provider<FirstLaunchRepository>(
  (ref) {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    return FirstLaunchRepositoryImpl(prefs: sharedPreferences);
  },
);

final firstLaunchUsecaseProvider = Provider<FirstLaunchUsecase>((
  ref,
) {
  final firstLaunchRepository = ref.watch(
    firstLaunchRepositoryProvider,
  );
  return FirstLaunchUsecaseImpl(firstLaunchRepository);
});
