import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/widgets/project_bubble.dart';
import 'package:task_manager/widgets/to_do_bubble.dart';

import 'home_view_model.dart';

class ToDoData {
  var title;
  var rate;
  var color;

  ToDoData(this.title, this.rate, this.color);
}

class Home extends StatelessWidget {
  List<ToDoData> data = [
    ToDoData('Inbox', 70, teal),
    ToDoData('Meeting', 40, orange),
    ToDoData('Trip', 80, blue),
  ];

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context, listen: false);
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: _mediaQuery.height * 0.225,
                        width: double.infinity,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SfCircularChart(
                                  series: <CircularSeries>[
                                    RadialBarSeries<ToDoData, String>(
                                        cornerStyle: CornerStyle.bothCurve,
                                        trackColor: Color(0xff35373D),
                                        trackBorderWidth: 7,
                                        trackBorderColor: grey,
                                        dataSource: data,
                                        radius: '${_mediaQuery.width * 0.2}',
                                        xValueMapper: (ToDoData item, _) =>
                                            item.title,
                                        yValueMapper: (ToDoData item, _) =>
                                            item.rate,
                                        pointColorMapper: (ToDoData item, _) =>
                                            item.color,
                                        maximumValue: 100)
                                  ],
                                ),
                              ),
                              horizontalSpaceMedium,
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: blue),
                                            ),
                                            horizontalSpaceTiny,
                                            Text(
                                              'Inbox',
                                              style: kAgipo.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      horizontalSpaceRegular,
                                      Text(
                                        '70%',
                                        style: kAgipo.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: lighterGrey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: orange),
                                            ),
                                            horizontalSpaceTiny,
                                            Text(
                                              'Meetings',
                                              style: kAgipo.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      horizontalSpaceRegular,
                                      Text(
                                        '40%',
                                        style: kAgipo.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: lighterGrey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: teal),
                                            ),
                                            horizontalSpaceTiny,
                                            Text(
                                              'Trip',
                                              style: kAgipo.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                        ),
                                      ),
                                      horizontalSpaceRegular,
                                      Text(
                                        '80%',
                                        style: kAgipo.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: lighterGrey),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(15)),
                      ),
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
                          itemBuilder: (context, index) => ProjectBubble(),
                          itemCount: 3,
                        ),
                      ),
                      verticalSpaceMedium,
                      Text('Tasks',
                          style: kAgipo.copyWith(
                              fontSize: 20, letterSpacing: 1.5)),
                      verticalSpaceRegular,
                      ToDoBubble(
                          title: 'Take the coat to dry cleaning',
                          onChecked: (v) {},
                          onDismissed: (d) {},
                          keyValue: 'keyValue',
                          onTap: () {},
                          isDone: false),
                      ToDoBubble(
                          title: "Help with Sam's project",
                          onChecked: (v) {},
                          onDismissed: (d) {},
                          keyValue: 'keyValue',
                          onTap: () {},
                          isDone: false),
                      ToDoBubble(
                          title: "Fix Mom's bike",
                          onChecked: (v) {},
                          onDismissed: (d) {},
                          keyValue: 'keyValue',
                          onTap: () {},
                          isDone: false),
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
                  onPressed: () {},
                ),
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
