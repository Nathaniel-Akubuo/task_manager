import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/widgets/modal_bottom_sheet.dart';

class HomeViewModel extends BaseViewModel {
  void showBottomSheet({isCreateGroup, context}) => showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (context) => ModalBottomSheet(isCreateGroup: isCreateGroup),
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
}
