import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/ui/projects/projects_view_model.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsViewModel>.reactive(
        builder: (context, model, child) => Scaffold(),
        viewModelBuilder: () => ProjectsViewModel());
  }
}
