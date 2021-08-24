import 'package:stacked/stacked.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/constants/global_variables.dart';

class StartUpViewModel extends BaseViewModel {
  navigateToSignIn() => navigationService.navigateTo(Routes.signIn);

  navigateToSignUp() => navigationService.navigateTo(Routes.signUp);
}
