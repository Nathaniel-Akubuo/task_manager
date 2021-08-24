import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/services/user_service.dart';

class Authentication extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future googleLogin(context) async {
    var userService = Provider.of<UserService>(context, listen: false);
    try {
      isLoading = true;
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        _user = googleUser;
        final googleAuth = await googleUser.authentication;
        final credentials = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await FirebaseAuth.instance
            .signInWithCredential(credentials)
            .then((value) {
          userService.email = value.user!.email;
          userService.isAuthenticated = true;
          userService.signedInWithGoogle = true;
          navigationService.replaceWith(Routes.home);
          isLoading = false;
          notifyListeners();
        });
      }
    } catch (error) {
      print('Google sign in error: $error');
      isLoading = false;
    }
  }

  Future signUp({context, email, password}) async {
    var userService = Provider.of<UserService>(context, listen: false);
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          userService.email = email;
          userService.isAuthenticated = true;
          userService.signedInWithGoogle = false;
          navigationService.replaceWith(Routes.home);
          notifyListeners();
        },
      );
    } catch (error) {
      print('Sign up error: $error');
    }
  }

  Future signIn({context, email, password}) async {
    var userService = Provider.of<UserService>(context, listen: false);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          userService.email = email;
          userService.isAuthenticated = true;
          userService.signedInWithGoogle = false;
          navigationService.replaceWith(Routes.home);
          notifyListeners();
        },
      );
    } catch (error) {
      print('Sign in error: $error');
    }
  }

  Future logout(context) async {
    var userService = Provider.of<UserService>(context, listen: false);
    try {
      userService.isAuthenticated = false;
      userService.signedInWithGoogle
          ? _googleSignIn
              .disconnect()
              .then((value) => FirebaseAuth.instance.signOut())
          : FirebaseAuth.instance.signOut();
      navigationService.replaceWith(Routes.signIn);
      notifyListeners();
    } catch (error) {
      print('Logout Error: $error');
    }
  }
}
