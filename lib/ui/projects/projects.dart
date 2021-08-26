import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/ui/projects/projects_view_model.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var util = Provider.of<Util>(context, listen: false);
    return ViewModelBuilder<ProjectsViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(util.title.toUpperCase(), style: kAgipo),
              ),
            ),
        viewModelBuilder: () => ProjectsViewModel());
  }
}
