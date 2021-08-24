import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  openDrawer() => scaffoldKey?.currentState?.openDrawer();
}
