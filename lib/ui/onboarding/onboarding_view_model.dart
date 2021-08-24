import 'package:stacked/stacked.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/constants/global_variables.dart';

class OnBoardingViewModel extends BaseViewModel {
  navigateToStartUp() {
    navigationService.navigateTo(Routes.startUp);
  }
}
