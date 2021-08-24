// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/home/home.dart';
import '../ui/onboarding/onboarding.dart';
import '../ui/projects/projects.dart';
import '../ui/sign-in/sign_in.dart';
import '../ui/sign-up/sign_up.dart';
import '../ui/start_up/start_up.dart';

class Routes {
  static const String onBoarding = '/on-boarding';
  static const String startUp = '/start-up';
  static const String signUp = '/sign-up';
  static const String signIn = '/sign-in';
  static const String home = '/Home';
  static const String projects = '/Projects';
  static const all = <String>{
    onBoarding,
    startUp,
    signUp,
    signIn,
    home,
    projects,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.onBoarding, page: OnBoarding),
    RouteDef(Routes.startUp, page: StartUp),
    RouteDef(Routes.signUp, page: SignUp),
    RouteDef(Routes.signIn, page: SignIn),
    RouteDef(Routes.home, page: Home),
    RouteDef(Routes.projects, page: Projects),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    OnBoarding: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoarding(),
        settings: data,
      );
    },
    StartUp: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartUp(),
        settings: data,
      );
    },
    SignUp: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUp(),
        settings: data,
      );
    },
    SignIn: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignIn(),
        settings: data,
      );
    },
    Home: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Home(),
        settings: data,
      );
    },
    Projects: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Projects(),
        settings: data,
      );
    },
  };
}
