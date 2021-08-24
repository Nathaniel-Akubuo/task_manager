import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/ui/start_up/start_up_view_model.dart';
import 'package:task_manager/widgets/rounded_button.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return ViewModelBuilder<StartUpViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                backgroundColor: backgroundColor,
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Hero(
                          tag: 'hero', child: Image.asset('assets/pencil.png')),
                      SizedBox(
                        height: _mediaQuery.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sign In',
                                style: kPoppins.copyWith(fontSize: 30)),
                            verticalSpaceSmall,
                            Text('This will back up your data to the cloud',
                                style: kPoppins.copyWith(
                                    fontWeight: FontWeight.normal)),
                            verticalSpaceLarge,
                            RoundedButton(
                              onTap: () => model.navigateToSignUp(),
                              child: Text('Sign Up', style: kPoppins.copyWith(fontWeight: FontWeight.normal)),
                            ),
                            SizedBox(
                              height: _mediaQuery.height * 0.03,
                            ),
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Already a user? ',
                                  children: [
                                    TextSpan(
                                      text: 'Sign In',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap =
                                            () => model.navigateToSignIn(),
                                      style: kPoppins.copyWith(color: blue),
                                    )
                                  ],
                                  style: kPoppins.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      verticalSpaceLarge
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => StartUpViewModel());
  }
}
