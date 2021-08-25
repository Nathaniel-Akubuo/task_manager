import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/services/tasks_provider.dart';
import 'package:task_manager/widgets/progress_bubble.dart';
import 'package:task_manager/widgets/project_bubble.dart';
import 'package:task_manager/widgets/to_do_bubble.dart';

import 'home_view_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context, listen: false);
    var tasks = Provider.of<TasksProvider>(context, listen: false);
    final _mediaQuery = MediaQuery.of(context).size;
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
                      Container(
                        height: _mediaQuery.height * 0.225,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ProjectBubble(
                            onTap: () {},
                            percentage: 40,
                            title: 'TRIP',
                            color: teal,
                            firstItem: 'Holiday in Norway',
                            date: '',
                          ),
                          itemCount: 3,
                        ),
                      ),
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
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold));
                            },
                          ),
                        ],
                      ),
                      verticalSpaceRegular,
                      StreamBuilder(
                        stream: model.getUndone().snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var currentItem =
                                    snapshot.data!.docs[index].data();
                                return ToDoBubble(
                                    title: currentItem['item'],
                                    onChecked: (v) => tasks.toggleDone(
                                        TaskModel.fromJson(currentItem)),
                                    onDismissed: (_) =>
                                        tasks.deleteUndone(currentItem['id']),
                                    onTap: () {},
                                    isDone: currentItem['isChecked']);
                              },
                            );
                          } else
                            return Container();
                        },
                      ),
                      Divider(color: Colors.grey),
                      verticalSpaceSmall,
                      StreamBuilder(
                        stream: model.getDone().snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var currentItem =
                                    snapshot.data!.docs[index].data();
                                return ToDoBubble(
                                    title: currentItem['item'],
                                    onChecked: (v) => tasks.toggleDone(
                                        TaskModel.fromJson(currentItem)),
                                    onDismissed: (_) =>
                                        tasks.deleteDone(currentItem['id']),
                                    onTap: () {},
                                    isChecked: currentItem['isChecked'],
                                    isDone: currentItem['isChecked']);
                              },
                            );
                          } else
                            return Container();
                        },
                      ),
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
