import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/models/project_model.dart';

final List<ToDoData> data = [
  ToDoData('Inbox', 70, teal),
  ToDoData('Meeting', 40, orange),
  ToDoData('Trip', 80, blue),
];

class ToDoData {
  var title;
  var rate;
  var color;

  ToDoData(this.title, this.rate, this.color);
}

class ProgressBubble extends StatelessWidget {
  final stream;

  ProgressBubble({this.stream});

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: _mediaQuery.height * 0.225,
      width: _mediaQuery.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: StreamBuilder(
              stream: stream,
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.data != null && snapshot.data!.size > 0) {
                  List<ProjectModel> projects = [];
                  var list = snapshot.data!.docs;

                  list.length > 2
                      ? list.removeRange(3, list.length)
                      : list.remove(null);
                  list.forEach((element) =>
                      projects.add(ProjectModel.fromJson(element.data())));
                  return SfCircularChart(
                    series: <CircularSeries>[
                      RadialBarSeries<ProjectModel, String>(
                          gap: '4',
                          cornerStyle: CornerStyle.bothCurve,
                          trackColor: Color(0xff35373D),
                          trackBorderWidth: 4,
                          strokeWidth: 200,
                          trackBorderColor: grey,
                          dataSource: projects,
                          radius: '${_mediaQuery.width * 0.2}',
                          xValueMapper: (ProjectModel item, _) => item.title,
                          yValueMapper: (ProjectModel item, _) =>
                              item.count ?? 0,
                          pointColorMapper: (ProjectModel item, _) =>
                              item.color,
                          maximumValue: 100)
                    ],
                  );
                } else
                  return SfCircularChart(
                    series: <CircularSeries>[
                      RadialBarSeries<ToDoData, String>(
                          gap: '4',
                          cornerStyle: CornerStyle.bothCurve,
                          trackColor: Color(0xff35373D),
                          trackBorderWidth: 4,
                          strokeWidth: 200,
                          trackBorderColor: grey,
                          dataSource: data,
                          radius: '${_mediaQuery.width * 0.2}',
                          xValueMapper: (ToDoData item, _) => '',
                          yValueMapper: (ToDoData item, _) => 0,
                          pointColorMapper: (ToDoData item, _) => item.color,
                          maximumValue: 100)
                    ],
                  );
              },
            ),
          ),
          horizontalSpaceRegular,
          Expanded(
            flex: 2,
            child: Container(
              height: 110,
              child: StreamBuilder(
                stream: stream,
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    List<ProjectModel> list = [];
                    for (int i = 0; i < 3; i++) {
                      list.add(
                          ProjectModel.fromJson(snapshot.data!.docs[i].data()));
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: list
                          .map((currentItem) => buildColoredDots(
                              context: context,
                              color: currentItem.color,
                              title: currentItem.title,
                              count: currentItem.count ?? 0))
                          .toList(),
                    );
                  } else
                    return Container();
                },
              ),
            ),
          )
        ],
      ),
      decoration:
          BoxDecoration(color: grey, borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget buildColoredDots({context, color, title, count}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
              horizontalSpaceTiny,
              Text(
                title,
                style:
                    kAgipo.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
        ),
        Text(
          '${count.toStringAsFixed(0)}%',
          style: kAgipo.copyWith(
              fontWeight: FontWeight.bold, fontSize: 13, color: darkGrey),
        )
      ],
    );
  }
}
