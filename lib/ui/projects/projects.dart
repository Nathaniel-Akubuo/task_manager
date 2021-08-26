import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/ui/projects/projects_view_model.dart';
import 'package:task_manager/widgets/project_list_stream_builder.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
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
                    context: context, isCreateGroup: false),
              ),
              body: SingleChildScrollView(
                padding: kPadding,
                child: Column(
                  children: [
                    Container(
                      height: _mediaQuery.height * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: grey, borderRadius: kBorderRadius),
                      child: SingleChildScrollView(
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
                            Text('Add subtask')
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
