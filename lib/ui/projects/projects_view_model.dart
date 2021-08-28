import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/services/user_service.dart';
import 'package:task_manager/services/util.dart';
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
        builder: (context) => ModalBottomSheet(action: action),
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

  getUndone(context) {
    var userEmail = Provider.of<UserService>(context, listen: false).email;
    var id = Provider.of<Util>(context, listen: true).id;
    return FirebaseFirestore.instance
        .collection('$userEmail-projects')
        .doc(id)
        .collection('$id-undone')
        .orderBy('dateCreated');
  }
}
