import 'package:boar_time/core/first_launch/domain/repositories/first_launch_repository.dart';
import 'package:boar_time/core/first_launch/domain/usecase/first_launch_usecase.dart';

class FirstLaunchUsecaseImpl implements FirstLaunchUsecase {
  FirstLaunchUsecaseImpl(this._firstLaunchRepository);

  final FirstLaunchRepository _firstLaunchRepository;

  @override
  bool checkFirstLaunch() => _firstLaunchRepository.checkFirstLaunch();

  @override
  Future<bool> setFirstLaunch() => _firstLaunchRepository.setFirstLaunch();
}
