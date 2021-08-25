import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';

class ProjectBubble extends StatelessWidget {
  final double percentage;
  final String title;
  final Color color;
  final String? firstItem;
  final String date;
  final onTap;

  ProjectBubble(
      {required this.percentage,
      required this.title,
      required this.color,
      this.firstItem,
      required this.date,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: _mediaQuery.height * 0.225,
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: 30,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      showLabels: false,
                      showTicks: false,
                      startAngle: 270,
                      endAngle: 270,
                      axisLineStyle: AxisLineStyle(
                        thickness: 0.05,
                        color: color,
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: <GaugePointer>[
                        RangePointer(
                          color: color,
                          value: percentage,
                          width: 0.75,
                          pointerOffset: 0.25,
                          sizeUnit: GaugeSizeUnit.factor,
                        )
                      ],
                    )
                  ],
                ),
              ),
              verticalSpaceTiny,
              Text(
                title,
                style: kAgipo.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey),
              ),
              verticalSpaceTiny,
              Expanded(
                child: Text(
                  firstItem!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kAgipo.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 30,
                decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  DateFormat('MMMM dd').format(DateTime.now()),
                  style: kAgipo.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          decoration:
              BoxDecoration(color: grey, borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
