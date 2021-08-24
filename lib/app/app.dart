import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/ui/home/home.dart';
import 'package:task_manager/ui/onboarding/onboarding.dart';
import 'package:task_manager/ui/projects/projects.dart';
import 'package:task_manager/ui/sign-in/sign_in.dart';
import 'package:task_manager/ui/sign-up/sign_up.dart';
import 'package:task_manager/ui/start_up/start_up.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: OnBoarding),
    MaterialRoute(page: StartUp),
    MaterialRoute(page: SignUp),
    MaterialRoute(page: SignIn),
    MaterialRoute(page: Home),
    MaterialRoute(page: Projects),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
)
class AppSetup {}
