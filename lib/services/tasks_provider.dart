import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  var homeUndone = FirebaseFirestore.instance
      .collection('${preferences!.getString('email')}-tasks-undone');

  var homeDone = FirebaseFirestore.instance
      .collection('${preferences!.getString('email')}-tasks-done');

  void addToDo(TaskModel taskModel) {
    var doc = homeUndone.doc();
    taskModel.id = doc.id;
    doc.set(taskModel.toJson());
  }

  toggleDone(TaskModel taskModel) {
    if (taskModel.isChecked) {
      taskModel.isChecked = false;
      deleteDone(taskModel.id);
      homeUndone.doc(taskModel.id).set(taskModel.toJson());
    } else if (!taskModel.isChecked) {
      deleteUndone(taskModel.id);
      taskModel.isChecked = true;
      homeDone.doc(taskModel.id).set(taskModel.toJson());
    }
  }

  deleteUndone(id) => homeUndone.doc(id).delete();

  deleteDone(id) => homeDone.doc(id).delete();
}
