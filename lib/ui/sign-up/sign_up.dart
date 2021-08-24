import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/ui/sign-up/sign_up_view_model.dart';
import 'package:task_manager/widgets/custom_textfield.dart';
import 'package:task_manager/widgets/google_sign_in.dart';
import 'package:task_manager/widgets/rounded_button.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  padding: kPadding,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      Text(
                        'Welcome! Good to have you.',
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
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: model.email,
                              validator: (String? value) {
                                if (!emailRegExp.hasMatch(value!)) {
                                  return 'Enter a valid e-mail address';
                                }
                              },
                            ),
                            verticalSpaceRegular,
                            CustomTextFormField.password(
                              labelText: 'Password',
                              hintText: 'Password',
                              controller: model.password,
                              textInputAction: TextInputAction.next,
                              validator: (String? value) {
                                if (value!.length < 8) {
                                  return 'Password must not be less than 8 characters';
                                }
                              },
                            ),
                            verticalSpaceRegular,
                            CustomTextFormField.password(
                              labelText: 'Confirm password',
                              hintText: 'Confirm password',
                              validator: (String? value) {
                                if (value! != model.password.text) {
                                  print(model.password.text);
                                  return 'Your passwords do not match';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceLarge,
                      verticalSpaceLarge,
                      RoundedButton(
                        onTap: () => model.signUp(context),
                        child: Text('Register', style: kPoppins.copyWith(fontWeight: FontWeight.normal)),
                      ),
                      verticalSpaceMedium,
                      GoogleSignIn(),
                      verticalSpaceLarge,
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
              ),
            ),
        viewModelBuilder: () => SignUpViewModel());
  }
}
