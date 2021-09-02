import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/models/project_model.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/projects_provider.dart';
import 'package:task_manager/services/tasks_provider.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/widgets/custom_textfield.dart';
import 'package:task_manager/widgets/rounded_button.dart';

class ModalBottomSheet extends StatefulWidget {
  final String? action;
  final docID;
  final initialText;

  ModalBottomSheet({this.action, this.docID, this.initialText});

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller..text = widget.initialText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var task = Provider.of<TasksProvider>(context, listen: false);
    var projects = Provider.of<ProjectsProvider>(context, listen: false);
    var util = Provider.of<Util>(context, listen: false);
    final _mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: _mediaQuery.viewInsets.bottom * 0.7),
      child: Container(
        padding: kPadding,
        height: _mediaQuery.size.height * 0.4,
        child: Column(
          children: [
            verticalSpaceLarge,
            CustomTextFormField.regular(
              autoFocus: true,
              controller: controller,
            ),
            verticalSpaceLarge,
            RoundedButton(
              onTap: () {
                if (widget.action == 'createGroup') {
                  projects.createProject(
                    context: context,
                    projectModel: ProjectModel(
                        title: controller.text,
                        dateCreated: DateTime.now(),
                        color:
                            util.colors[Random().nextInt(util.colors.length)]),
                  );
                } else if (widget.action == 'createGroupTask') {
                  projects.addToDo(
                    context: context,
                    taskModel: TaskModel(
                        dateCreated: DateTime.now(),
                        item: controller.text,
                        isChecked: false),
                  );
                } else if (widget.action == 'addHomeTask') {
                  task.addToDo(
                      context: context,
                      taskModel: TaskModel(
                          dateCreated: DateTime.now(),
                          item: controller.text,
                          isChecked: false));
                } else if (widget.action == 'editGroupTask') {
                  projects.updateUndoneTask(
                      docID: widget.docID,
                      context: context,
                      text: controller.text);
                } else if (widget.action == 'editGroupUndone') {
                  projects.updateDoneTask(
                      context: context,
                      docID: widget.docID,
                      text: controller.text);
                } else if (widget.action == 'editProjectName') {
                  projects.updateProjectDetails(
                      context: context, text: controller.text);
                  util.title = controller.text;
                }
                navigationService.back();
              },
              child: Text(
                  widget.action == 'createGroup'
                      ? '+ CREATE NEW GROUP'
                      : widget.action == 'editProjectName'
                          ? 'SAVE'
                          : 'ADD',
                  style: kAgipo),
            )
          ],
        ),
      ),
    );
  }
}
