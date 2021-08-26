import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/ui/projects/projects_view_model.dart';
import 'package:task_manager/widgets/project_list_stream_builder.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    var util = Provider.of<Util>(context, listen: false);
    return ViewModelBuilder<ProjectsViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(util.title.toUpperCase(), style: kAgipo),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add, size: 30),
                backgroundColor: blue,
                onPressed: () => model.showBottomSheet(
                    context: context, action: 'createGroupTask'),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 15, right: 15, bottom: _mediaQuery.viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceRegular,
                    Container(
                      padding: EdgeInsets.all(10),
                      height: _mediaQuery.size.height * 0.175,
                      width: _mediaQuery.size.width,
                      decoration: BoxDecoration(
                          color: grey, borderRadius: kBorderRadius),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: _mediaQuery.size.height * 0.04,
                                width: _mediaQuery.size.width*0.09,
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
                                        color: util.color,
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          color: util.color,
                                          value: 80,
                                          width: 0.75,
                                          pointerOffset: 0.25,
                                          sizeUnit: GaugeSizeUnit.factor,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Icon(Icons.edit, color: darkGrey,)
                            ],
                          ),
                          Text(
                            util.title.toUpperCase(),
                            style: kAgipo.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            height: 30,
                            decoration: BoxDecoration(
                                color: util.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              DateFormat('MMMM dd').format(DateTime.now()),
                              style: kAgipo.copyWith(
                                color: util.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpaceLarge,
                    Container(
                      height: _mediaQuery.size.height * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: grey, borderRadius: kBorderRadius),
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ProjectListStreamBuilder(
                              stream: model.getUndone(context).snapshots(),
                              isDoneList: false,
                            ),
                            ProjectListStreamBuilder(
                              stream: model.getDone(context).snapshots(),
                              isDoneList: true,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => ProjectsViewModel());
  }
}
