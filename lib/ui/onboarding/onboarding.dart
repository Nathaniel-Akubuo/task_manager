import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/ui/onboarding/onboarding_view_model.dart';
import 'package:task_manager/widgets/rounded_button.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return ViewModelBuilder<OnBoardingViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                backgroundColor: backgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                          tag: 'hero',
                          child: Image.asset('assets/pencil.png')),
                      SizedBox(
                        height: _mediaQuery.height * 0.02,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Smart Task Management',
                                  style: kPoppins.copyWith(fontSize: 30)),
                              verticalSpaceSmall,
                              Text(
                                  'This smart tool is designed to better help you manage your tasks',
                                  style: kPoppins.copyWith(
                                      fontWeight: FontWeight.normal)),
                              verticalSpaceLarge,
                              RoundedButton(
                                child: Text('Continue', style: kPoppins),
                                onTap: () => model.navigateToStartUp(),
                              ),
                              SizedBox(
                                height: _mediaQuery.height * 0.01,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => OnBoardingViewModel());
  }
}
