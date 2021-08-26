import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';

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
            child: SfCircularChart(
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
                    xValueMapper: (ToDoData item, _) => item.title,
                    yValueMapper: (ToDoData item, _) => item.rate,
                    pointColorMapper: (ToDoData item, _) => item.color,
                    maximumValue: 100)
              ],
            ),
          ),
          horizontalSpaceRegular,
          Expanded(
            flex: 2,
            child: Container(
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: blue),
                            ),
                            horizontalSpaceTiny,
                            Text(
                              'Inbox',
                              style: kAgipo.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '70%',
                        style: kAgipo.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: darkGrey),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: orange),
                            ),
                            horizontalSpaceTiny,
                            Text(
                              'Meetings',
                              style: kAgipo.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '40%',
                        style: kAgipo.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: darkGrey),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: teal),
                            ),
                            horizontalSpaceTiny,
                            Text(
                              'Trip',
                              style: kAgipo.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      horizontalSpaceRegular,
                      Text(
                        '80%',
                        style: kAgipo.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: darkGrey),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      decoration:
          BoxDecoration(color: grey, borderRadius: BorderRadius.circular(15)),
    );
  }
}
