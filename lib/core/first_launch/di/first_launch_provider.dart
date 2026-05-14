import 'package:boar_time/core/shared_preferences/di/shared_preferences_provider.dart';
import 'package:boar_time/core/first_launch/application/first_launch_usecase_impl.dart';
import 'package:boar_time/core/first_launch/domain/repositories/first_launch_repository.dart';
import 'package:boar_time/core/first_launch/domain/usecase/first_launch_usecase.dart';
import 'package:boar_time/core/first_launch/infrastructure/repositories/first_launch_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firstLaunchRepositoryProvider = Provider<FirstLaunchRepository>(
  (ref) => FirstLaunchRepositoryImpl(ref.watch(sharedPreferencesProvider)),
);

final firstLaunchUsecaseProvider = Provider<FirstLaunchUsecase>(
  (ref) => FirstLaunchUsecaseImpl(ref.watch(firstLaunchRepositoryProvider)),
);
