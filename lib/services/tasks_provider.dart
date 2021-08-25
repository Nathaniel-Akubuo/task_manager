import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  var homeUndone = FirebaseFirestore.instance
      .collection('${preferences!.getString('email')}undoneTasks');

  var homeDone = FirebaseFirestore.instance
      .collection('${preferences!.getString('email')}doneTasks');

  void addToDo(TaskModel taskModel) => homeUndone.add(taskModel.toJson());

  deleteToDo(){
//    homeUndone.
  }
}
