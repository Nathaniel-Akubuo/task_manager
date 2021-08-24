import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/services/authentication.dart';

class SignUpViewModel extends BaseViewModel {
  var _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();

  void signUp(context) {
    if (_formKey.currentState!.validate()) {
      Provider.of<Authentication>(context, listen: false).signUp(
          email: _email.text, password: _password.text, context: context);
    }
  }

  navigateToSignIn() => navigationService.navigateTo(Routes.signIn);

  get formKey => _formKey;

  get email => _email;

  get password => _password;
}
