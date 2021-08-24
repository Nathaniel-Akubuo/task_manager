import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/widgets/rounded_button.dart';

import 'google_sign_in_view_model.dart';

class GoogleSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context, listen: true);
    return ViewModelBuilder<GoogleSignInViewModel>.reactive(
        builder: (context, model, child) => RoundedButton(
              onTap: () => model.signIn(context),
              child: auth.isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(blue),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/google.png'),
                        Text(
                          'Sign in with Google',
                          style: kPoppins.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
              color: Colors.white,
            ),
        viewModelBuilder: () => GoogleSignInViewModel());
  }
}
