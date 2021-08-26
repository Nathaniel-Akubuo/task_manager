import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/ui/projects/projects_view_model.dart';
import 'package:task_manager/widgets/project_to_do_bubble.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                          color: grey, borderRadius: kBorderRadius),
                      child: ListView(
                        children: [
                          verticalSpaceTiny,
                          ProjectToDoBubble(
                              onDismissed: (_) {},
                              title: 'title',
                              isChecked: true,
                              onChecked: (_){},
                              onTap: () {})
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => ProjectsViewModel());
  }
}
