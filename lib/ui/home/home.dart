import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/widgets/progress_bubble.dart';
import 'package:task_manager/widgets/project_bubble_builder.dart';
import 'package:task_manager/widgets/list_stream_builder.dart';

import 'home_view_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context, listen: false);
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Monday, 28',
                    style: kAgipo.copyWith(fontSize: 20, letterSpacing: 1.5),
                  ),
                  actions: [
                    Center(
                      child: IconButton(
                          icon: Icon(FontAwesomeIcons.calendarAlt, size: 18),
                          onPressed: () => auth.logout(context)),
                    ),
                    horizontalSpaceRegular
                  ],
                ),
                drawer: Drawer(),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: kPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      ProgressBubble(),
                      verticalSpaceMedium,
                      Text('Projects',
                          style: kAgipo.copyWith(
                              fontSize: 20, letterSpacing: 1.5)),
                      verticalSpaceRegular,
                      ProjectBubbleBuilder(),
                      verticalSpaceMedium,
                      Row(
                        children: [
                          Text('Tasks ',
                              style: kAgipo.copyWith(
                                  fontSize: 20,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold)),
                          StreamBuilder(
                            stream: model.count(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                    snapshot.data!.docs.length.toString(),
                                    style: kAgipo.copyWith(
                                        color: teal,
                                        fontSize: 20,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold));
                              } else
                                return Text('0',
                                    style: kAgipo.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold));
                            },
                          ),
                        ],
                      ),
                      verticalSpaceRegular,
                      UndoneListBuilder(
                          stream: model.getUndone().snapshots(),
                          isDoneList: false),
                      Divider(color: Colors.grey),
                      verticalSpaceSmall,
                      UndoneListBuilder(
                          stream: model.getDone().snapshots(),
                          isDoneList: true),
                      verticalSpaceLarge,
                      verticalSpaceLarge,
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add, size: 30),
                  backgroundColor: blue,
                  onPressed: () => model.showBottomSheet(context),
                ),
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
