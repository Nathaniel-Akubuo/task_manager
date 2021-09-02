import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/models/project_model.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/widgets/project_drawer_bubble.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpaceRegular,
                    StreamBuilder(
                        stream: model.getProjects().snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.data != null &&
                              snapshot.data!.size != 0) {
                            List<ProjectModel> list = [];
                            for (int i = 0;
                                i <
                                    (snapshot.data!.docs.length < 3
                                        ? snapshot.data!.docs.length
                                        : 3);
                                i++) {
                              list.add(ProjectModel.fromJson(
                                  snapshot.data!.docs[i].data()));
                            }
                            return Column(
                              children: list
                                  .map((currentItem) => ProjectDrawerBubble(
                                        title: currentItem.title,
                                        count: currentItem.totalItems ?? 0,
                                        color: currentItem.color,
                                        onTap: () {
                                          util.title = currentItem.title;
                                          util.id = currentItem.id;
                                          util.color = currentItem.color;
                                          util.closeDrawer();
                                          return navigationService
                                              .navigateTo(Routes.projects);
                                        },
                                      ))
                                  .toList(),
                            );
                          } else
                            return Container();
                        }),
                    verticalSpaceLarge,
                    RoundedButton(
                      onTap: () {
                        util.closeDrawer();
                        model.showBottomSheet(
                            context: context, action: 'createGroup');
                      },
                      child: Text('+ CREATE NEW GROUP', style: kPoppins),
                    ),
                    verticalSpaceLarge,
                    verticalSpaceLarge,
                    verticalSpaceLarge,
                    verticalSpaceLarge,
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: InkWell(
                          splashColor: darkGrey,
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => auth
                              .logout(context)
                              .then((value) => util.closeDrawer()),
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
                    verticalSpaceLarge,
                    verticalSpaceLarge,
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => HomeViewModel());
  }
}
