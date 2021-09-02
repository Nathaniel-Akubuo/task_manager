import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/services/user_service.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/widgets/modal_bottom_sheet.dart';

class HomeViewModel extends BaseViewModel {
  void showBottomSheet({action, context}) => showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (context) => ModalBottomSheet(action: action, initialText: '',),
      );

  getUndone() {
    return FirebaseFirestore.instance
        .collection('${preferences!.getString('email')}-tasks-undone')
        .orderBy('dateCreated');
  }

  getDone() {
    return FirebaseFirestore.instance
        .collection('${preferences!.getString('email')}-tasks-done')
        .orderBy('dateCreated', descending: true);
  }

  getProjects() {
    return FirebaseFirestore.instance
        .collection('${preferences!.getString('email')}-projects')
        .orderBy('dateCreated', descending: true);
  }

  getProjectDone(context) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: true);
    return FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-done')
        .orderBy('dateCreated', descending: true);
  }

  getProjectUndone(context) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var util = Provider.of<Util>(context, listen: true);
    return FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(util.id)
        .collection('${util.title}-done')
        .orderBy('dateCreated', descending: true);
  }
}
