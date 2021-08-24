import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/services/authentication.dart';

class GoogleSignInViewModel extends BaseViewModel {
  void signIn(context) async {
    await Provider.of<Authentication>(context, listen: false).googleLogin(context);
  }
}
