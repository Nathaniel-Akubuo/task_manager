import 'package:flutter/cupertino.dart';
import 'package:task_manager/constants/global_variables.dart';

class UserService extends ChangeNotifier {
  get email => preferences!.getString('email');

  set email(value) {
    preferences!.setString('email', value);
    notifyListeners();
  }

  get signedInWithGoogle => preferences!.getBool('signedInWithGoogle');

  set signedInWithGoogle(value) {
    preferences!.setBool('signedInWithGoogle', value);
    notifyListeners();
  }

  get isAuthenticated => preferences!.getBool('isAuthenticated');

  set isAuthenticated(value) {
    preferences!.setBool('isAuthenticated', value);
    notifyListeners();
  }
}
