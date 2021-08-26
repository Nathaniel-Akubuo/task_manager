import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/widgets/rounded_button.dart';

import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HiddenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) {
          var auth = Provider.of<Authentication>(context, listen: false);
          var util = Provider.of<Util>(context, listen: true);
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Container(
              padding: EdgeInsets.all(15),
              width: util.xOffset,
              child: Column(
                children: [
                  verticalSpaceRegular,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: 80,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: grey, borderRadius: kBorderRadius),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 7.5,
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                              bottom: Radius.circular(15),
                            ),
                          ),
                        ),
                        horizontalSpaceRegular,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Inbox',
                              style: kAgipo,
                            ),
                            Text(
                              '16 tasks',
                              style: kAgipo.copyWith(
                                  fontSize: 15, color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  verticalSpaceRegular,
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 80,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: grey, borderRadius: kBorderRadius),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 7.5,
                          decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                              bottom: Radius.circular(15),
                            ),
                          ),
                        ),
                        horizontalSpaceRegular,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meeting',
                              style: kAgipo,
                            ),
                            Text(
                              '8 tasks',
                              style: kAgipo.copyWith(
                                  fontSize: 15, color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  verticalSpaceRegular,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: 80,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: grey, borderRadius: kBorderRadius),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 7.5,
                          decoration: BoxDecoration(
                            color: teal,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                              bottom: Radius.circular(15),
                            ),
                          ),
                        ),
                        horizontalSpaceRegular,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Trip',
                              style: kAgipo,
                            ),
                            Text(
                              '4 tasks',
                              style: kAgipo.copyWith(
                                  fontSize: 15, color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  verticalSpaceLarge,
                  RoundedButton(
                    onTap: (){
                      util.closeDrawer();
                      model.showBottomSheet(context: context, action: 'createGroup');
                    },
                    child: Text('+ CREATE NEW GROUP', style: kPoppins),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: InkWell(
                          onTap: () {
                           auth.logout(context);
                           util.closeDrawer();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              horizontalSpaceRegular,
                              Text('LOG OUT', style: kAgipo),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceLarge,
                  verticalSpaceLarge,
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => HomeViewModel());
  }
}
