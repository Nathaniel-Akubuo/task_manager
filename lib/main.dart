import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/services/projects_provider.dart';
import 'package:task_manager/services/tasks_provider.dart';
import 'package:task_manager/services/user_service.dart';
import 'package:task_manager/services/util.dart';

import 'app/app.router.dart';
import 'constants/colors.dart';
import 'constants/global_variables.dart';

bool? isFirstRun;
bool? isAuthenticated;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  preferences = await SharedPreferences.getInstance();
  isFirstRun = preferences!.getBool('isFirstRun');
  isAuthenticated = preferences!.getBool('isAuthenticated');
  preferences!.setBool('isFirstRun', false);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TasksProvider()),
        ChangeNotifierProvider(create: (context) => Authentication()),
        ChangeNotifierProvider(create: (context) => UserService()),
        ChangeNotifierProvider(create: (context) => ProjectsProvider()),
        ChangeNotifierProvider(create: (context) => Util()),
      ],
      child: MaterialApp(
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          canvasColor: backgroundColor,
          unselectedWidgetColor: darkGrey,
          checkboxTheme: CheckboxThemeData(shape: CircleBorder()),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white, size: 25),
          ),
        ),
        debugShowCheckedModeBanner: false,
//        initialRoute: Routes.home,
        initialRoute: isFirstRun == null
            ? Routes.onBoarding
            : isAuthenticated == null
                ? Routes.signUp
                : isAuthenticated!
                    ? Routes.home
                    : Routes.signIn,
      ),
    );
  }
}
