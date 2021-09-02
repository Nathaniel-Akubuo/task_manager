import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/services/projects_provider.dart';
import 'package:task_manager/services/user_service.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/widgets/alert_dialog.dart';
import 'package:task_manager/widgets/edit_project_dialog.dart';
import 'package:task_manager/widgets/modal_bottom_sheet.dart';

class ProjectsViewModel extends BaseViewModel {
  void showBottomSheet({action, context}) => showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (context) => ModalBottomSheet(
          action: action,
          initialText: '',
        ),
      );

  getDone(context) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: true).id;
    return FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-done')
        .orderBy('dateCreated', descending: true);
  }

  Query getUndone(context) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: true).id;
    return FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-undone')
        .orderBy('dateCreated');
  }

  void deleteProject({context, projectID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialogBox(
        title: 'DELETE?',
        content: 'Do you want to delete this project?',
        onPressed: () {
          Provider.of<ProjectsProvider>(context, listen: false)
              .deleteProject(context: context, projectID: projectID);
          navigationService.popRepeated(2);
        },
      ),
    );
  }

  void editProject(context) =>
      showDialog(context: context, builder: (context) => EditProjectDialog());
}
