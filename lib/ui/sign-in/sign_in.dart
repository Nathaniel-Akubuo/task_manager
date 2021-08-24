import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/ui/sign-in/sign_in_view_model.dart';
import 'package:task_manager/widgets/custom_textfield.dart';
import 'package:task_manager/widgets/google_sign_in.dart';
import 'package:task_manager/widgets/rounded_button.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: kPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceLarge,
                      Text(
                        'Hey there! Welcome back.',
                        style: kPoppins.copyWith(fontSize: 30),
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Enter your credentials',
                        style: kPoppins.copyWith(fontWeight: FontWeight.normal),
                      ),
                      verticalSpaceLarge,
                      Form(
                        key: model.formKey,
                        child: Column(
                          children: [
                            CustomTextFormField.regular(
                              labelText: 'E-mail',
                              hintText: 'E-mail',
                              controller: model.email,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (!emailRegExp.hasMatch(value!)) {
                                  return 'Enter a valid email';
                                }
                              },
                            ),
                            verticalSpaceRegular,
                            CustomTextFormField.password(
                              labelText: 'Password',
                              hintText: 'Password',
                              controller: model.password,
                              validator: (String? value) {
                                if (value!.length < 8) {
                                  return 'Password must not be less than eight characters';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceLarge,
                      verticalSpaceLarge,
                      RoundedButton(
                          onTap: () => model.signIn(context),
                          child: Text('Log In', style: kPoppins)),
                      verticalSpaceMedium,
                      GoogleSignIn(),
                      verticalSpaceLarge,
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'New here? ',
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => model.navigateToSignUp(),
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
              ),
            ),
        viewModelBuilder: () => SignInViewModel());
  }
}
