import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProjectCompletionGauge extends StatelessWidget {
  final doneStream;
  final undoneStream;
  final color;

  ProjectCompletionGauge({this.doneStream, this.undoneStream, this.color});

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      height: _mediaQuery.height * 0.04,
      width: _mediaQuery.width * 0.09,
      child: StreamBuilder(
        stream: doneStream,
        builder: (context, AsyncSnapshot doneSnapshot) {
          if (doneSnapshot.hasData) {
            return StreamBuilder(
              stream: undoneStream,
              builder: (context, AsyncSnapshot undoneSnapshot) {
                if (undoneSnapshot.hasData) {
                  var doneLength = doneSnapshot.data!.docs.length;
                  var undoneLength = undoneSnapshot.data!.docs.length;
                  var percentage =
                      doneLength / (undoneLength + doneLength) * 100;
                  return SfRadialGauge(
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
                  );
                } else
                  return SfRadialGauge(
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
                            value: 0,
                            width: 0.75,
                            pointerOffset: 0.25,
                            sizeUnit: GaugeSizeUnit.factor,
                          )
                        ],
                      )
                    ],
                  );
              },
            );
          } else
            return SfRadialGauge(
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
                      value: 0,
                      width: 0.75,
                      pointerOffset: 0.25,
                      sizeUnit: GaugeSizeUnit.factor,
                    )
                  ],
                )
              ],
            );
        },
      ),
    );
  }
}
