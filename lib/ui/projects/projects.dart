import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/ui/projects/projects_view_model.dart';
import 'package:task_manager/widgets/project_completion_gauge.dart';
import 'package:task_manager/widgets/project_list_stream_builder.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    var util = Provider.of<Util>(context, listen: false);
    return ViewModelBuilder<ProjectsViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
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
                      left: 15,
                      right: 15,
                      bottom: _mediaQuery.viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceRegular,
                      Container(
                        padding: EdgeInsets.all(10),
                        height: _mediaQuery.size.height * 0.16,
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
                                ProjectCompletionGauge(
                                  doneStream:
                                      model.getDone(context).snapshots(),
                                  undoneStream:
                                      model.getUndone(context).snapshots(),
                                  color: util.color,
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: IconButton(
                                    onPressed: () => model.showBottomSheet(
                                        action: 'editProjectName',
                                        context: context),
                                    color: darkGrey,
                                    splashColor: grey,
                                    icon: Icon(Icons.edit),
                                  ),
                                )
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
                        constraints: BoxConstraints(
                            minHeight: _mediaQuery.size.height * 0.2,
                            maxHeight: _mediaQuery.size.height * 0.515),
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
            ),
        viewModelBuilder: () => ProjectsViewModel());
  }
}
