import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/services/authentication.dart';

class SignInViewModel extends BaseViewModel {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  void signIn(context) async {
    if (_formKey.currentState!.validate()) {
      await Provider.of<Authentication>(context, listen: false).signIn(
          context: context, email: _email.text, password: _password.text);
    }
  }

  navigateToSignUp() => navigationService.navigateTo(Routes.signUp);

  get formKey => _formKey;

  get email => _email;

  get password => _password;
}
