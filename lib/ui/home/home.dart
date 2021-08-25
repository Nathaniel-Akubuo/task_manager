import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/ui/home/drawer.dart';
import 'package:task_manager/widgets/progress_bubble.dart';
import 'package:task_manager/widgets/project_bubble_builder.dart';
import 'package:task_manager/widgets/list_stream_builder.dart';

import 'home_view_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context, listen: false);
    var util = Provider.of<Util>(context, listen: true);
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Stack(
                children: [
                  HiddenDrawer(),
                  GestureDetector(
                    onTap: util.isDrawerOpen() ? util.closeDrawer : null,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      transform:
                          Matrix4.translationValues(util.xOffset, util.yOffset, 0)
                            ..scale(util.scale),
                      child: ClipRRect(
                        borderRadius: util.isDrawerOpen()
                            ? BorderRadius.circular(15)
                            : BorderRadius.zero,
                        child: Scaffold(
                          appBar: AppBar(
                            leading: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                onPressed: util.isDrawerOpen()
                                    ? util.closeDrawer
                                    : util.openDrawer),
                            title: Text(
                              'Monday, 28',
                              style: kAgipo,
                            ),
                            actions: [
                              Center(
                                child: IconButton(
                                    icon: Icon(FontAwesomeIcons.calendarAlt,
                                        size: 18),
                                    onPressed: () => auth.logout(context)),
                              ),
                              horizontalSpaceRegular
                            ],
                          ),
                          body: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            padding: kPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpaceMedium,
                                ProgressBubble(),
                                verticalSpaceMedium,
                                Text('Projects', style: kAgipo),
                                verticalSpaceRegular,
                                ProjectBubbleBuilder(),
                                verticalSpaceMedium,
                                Text(
                                  'Tasks',
                                  style: kAgipo,
                                ),
                                verticalSpaceRegular,
                                UndoneListBuilder(
                                    stream: model.getUndone().snapshots(),
                                    isDoneList: false),
                                Divider(color: Colors.grey),
                                verticalSpaceSmall,
                                Theme(
                                  data: Theme.of(context)
                                      .copyWith(dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    onExpansionChanged: (_) =>
                                        setState(() => isExpanded = !isExpanded),
                                    title: Row(
                                      children: [
                                        StreamBuilder(
                                          stream: model.getDone().snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.docs.length
                                                    .toString(),
                                                style: kAgipo.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                              );
                                            } else
                                              return Text(
                                                '0',
                                                style: kAgipo.copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                              );
                                          },
                                        ),
                                        Text(
                                          ' item(s) ticked',
                                          style: kAgipo.copyWith(
                                              color: Colors.grey, fontSize: 15),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    tilePadding: EdgeInsets.all(0),
                                    trailing: isExpanded
                                        ? Icon(Icons.keyboard_arrow_up,
                                            color: Colors.grey)
                                        : Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey,
                                          ),
                                    children: [
                                      UndoneListBuilder(
                                          stream: model.getDone().snapshots(),
                                          isDoneList: true),
                                    ],
                                  ),
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
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
