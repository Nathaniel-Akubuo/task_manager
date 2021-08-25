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
    taskModel.id = homeUndone.doc().id;
    homeUndone.doc().set(taskModel.toJson());
  }

  toggleDone(TaskModel taskModel) {
    if (taskModel.isChecked) {
      taskModel.isChecked = false;
      deleteDone(taskModel.id);
      homeUndone.add(taskModel.toJson());
    } else {
      deleteUndone(taskModel.id);
      taskModel.isChecked = true;
      homeDone.add(taskModel.toJson());
    }
  }

  deleteUndone(id) => homeUndone.doc(id).delete();

  deleteDone(id) => homeUndone.doc(id).delete();
}
